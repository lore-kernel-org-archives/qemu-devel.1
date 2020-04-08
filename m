Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385D9C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D2520769
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nevbn0od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D2520769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6Rc-0007Zq-5P
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 04:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jM6DX-0000U3-Bj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jM64N-0001Sj-B3
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:28:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jM64L-0001RO-Qq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586334499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHglZpjSW4Myq7g0U/mPi9zfj2n4SzDKjvVBcETEuOo=;
 b=Nevbn0odse4JObliMN+keCqJQrd0TqQnzOJDElsgISoV/k4VjJ3hijpdURZPchsfH7G7It
 aeqJ8dQu9kEHrtrtAQSgWUm5177Qwh7dVeRN4DqzIHAFmoieAmC55cIgGemk1drgRQjJPC
 NeYZHeTf7c1w7bYbbgMbZ+Lj+fysyvE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-4mMacskONZWrU7mzEPIe8g-1; Wed, 08 Apr 2020 04:28:12 -0400
X-MC-Unique: 4mMacskONZWrU7mzEPIe8g-1
Received: by mail-wr1-f71.google.com with SMTP id y1so3614000wrp.5
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 01:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GHglZpjSW4Myq7g0U/mPi9zfj2n4SzDKjvVBcETEuOo=;
 b=Icbwi0JpyBqyI5D+h0B1dmOu16CEPeYi2Tx/VREn5wPe0r8VrrikhUJmEVbO12uaPO
 fSL9PDlyG3b2eHOs2kSiORMaLMGyeuZY9fSf50a4m7OYHsIFemmnGGiyzI8dxK1gtpV+
 eF4OrWS+iTnnQBdYPFORTTELuCk3+/VK2Mi9gms/P2OnAy/LbaQZUrll/+W/d18JxzKo
 a55Lveu1EBhIuJPQfUghZonnjZYAHav3R3N4iVFlirsLZgzgdcZpCMA+jKH5Miqoos5l
 XGqBY9MUPYuPbQ7Mh/2KkzKdMQ4NiMHP0jg2XHD0jbiWZqrML08+9NQoTsP0A8wj8cEg
 LszA==
X-Gm-Message-State: AGi0PuaBl8PzaRqgHXri0uoWEwmnnA/qRf5OfZIBJezxHc/9ciB2ifJU
 AEVJEHI9moZK3yPX1gtXUV6oBMOgSghcK/jYkYRUDnOH3gtJcRTxMIaergIH/zrelxabpnrghqH
 1hqJhQyYCt198Yc0=
X-Received: by 2002:adf:a350:: with SMTP id d16mr7485860wrb.277.1586334491409; 
 Wed, 08 Apr 2020 01:28:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEwANJpYcXhYEXwhxo+Rw1ae/lqPVgRuKMguJdb96Nb7+c9B16orSjEKxLkmYI3MYvdluUvQ==
X-Received: by 2002:adf:a350:: with SMTP id d16mr7485846wrb.277.1586334491218; 
 Wed, 08 Apr 2020 01:28:11 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id n131sm5935605wmf.35.2020.04.08.01.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 01:28:10 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] hvf: use standard CR0 and CR4 register definitions
To: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>
References: <cover.1585607927.git.dirty@apple.com>
 <9ba0495405a1cd1e6c272a1e67d54dfda09494e1.1585607927.git.dirty@apple.com>
 <20200405175845.GC74346@SPB-NB-133.local>
 <47A5AD5B-50BF-4E7B-BE64-64B97E820E8A@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8ca2869-0dbb-1be7-6d55-bf9e34afed33@redhat.com>
Date: Wed, 8 Apr 2020 10:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <47A5AD5B-50BF-4E7B-BE64-64B97E820E8A@apple.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/04/20 08:09, Cameron Esfahani wrote:
>>>
>>>     if (efer & MSR_EFER_LME) {
>>> -        if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
>>> +        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
>>>             enter_long_mode(vcpu, cr0, efer);
>>>         }
>>> -        if (/*(old_cr0 & CR0_PG) &&*/ !(cr0 & CR0_PG)) {
>>> +        if (!(cr0 & CR0_PG_MASK)) {
>> IMO the patch should only change CR0_PG to CR0_PG_MASK without removal
>> of the commented condition.
>>
>> In the next patch you're improving how long mode exit is done and
>> replacement of the comment with an implementation fits better there.
>>
> The reason I removed that code was because checkpatch.pl scolded me for a patch with code commented out.
> 
> I assumed that I'd get a similar warning from patchew.org about some erroneous coding styles.
> 
> So I thought the easiest thing would be to remove that code as well.
> 
> But I'll defer to you or Paolo: should I remove that commented code with this patch?

checkpatch errors are not absolutely a no-no, especially if the code is
pre-existing and/or it goes away later in the patch.  In this case,
since you have already written the patch it's okay to keep it as is.

Paolo


