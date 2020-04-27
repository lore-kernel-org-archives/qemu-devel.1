Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C67C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD3220656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXUhGINC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD3220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT44n-0005qj-Vd
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 09:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jT43p-0005GG-FV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jT43p-0007Ia-1p
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:44:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53627
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jT43o-0007CK-L5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587995075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZYR2y/yicfvFtKzLPLvMWGq9FziotJqAfju1kzgzNg=;
 b=NXUhGINCGEuw1koJNeR8ZtZP83FyPEmxVd2ZUiYRsNLjFyw6ayCvq9SmnxnqqDqjNuwj9A
 pxOM9bf5DVTp3BUsn0lYB4M35zA6XfZ447Meshebu7HQ0wm4v8T7cyKbvSzeOhlS3VJSP3
 AFSl5wsJBoIm5pHhnC45IGUzVONJ8uI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-gq-hycKSOfSRFJic7ckMow-1; Mon, 27 Apr 2020 09:44:34 -0400
X-MC-Unique: gq-hycKSOfSRFJic7ckMow-1
Received: by mail-wm1-f72.google.com with SMTP id h6so7165036wmi.7
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 06:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ZYR2y/yicfvFtKzLPLvMWGq9FziotJqAfju1kzgzNg=;
 b=qE9KvPkhShFU1yX5eAJABsbzh+4T4LuXjou7elhHW2NcDvETpOPnZExfdTai3/1yrU
 536Ix37PcWf06udG7mKaYQyoe/HfvETEM0Vnq26eibi3lZEW7XwVM0At3vZxThyjuOAG
 0kToFlO+mffU8B79uvw9Os75eSu0fWNvy0bpxowmAVioW2jeLWej2I1SCH5q9nPei63d
 45An31gbhQIB9aFA7HkrzMOR2RQy2R4PeCiOTBOLWDmoVbReFYqVrmP6FUp3N3Lzvi+Y
 5dBMn19ypFClwZvX7Gc45hyBvZgsqg9y53e/0QPIQa4BN0k43P6KDz6U9Cat07e5rmrZ
 +UJQ==
X-Gm-Message-State: AGi0PuZlax/OT11NRndCrH+QaliFG33yJdTtnpVPmSydzrrURvv5bvo3
 pKYP5UjURw+CZVCAD5hH++DF47GCw9d1e9OpZ/rVOZ+x5q2tfMAl793y+QkT1pZgNs9GGLlx8k4
 xAzs4vNnP1g9rx6o=
X-Received: by 2002:a1c:5fc4:: with SMTP id
 t187mr27563168wmb.181.1587995070532; 
 Mon, 27 Apr 2020 06:44:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypKuAAcyYrixslEbDAmsFuFhtftHQpiuRU8TwzFFsg2kzB/fRnxnPPC5wxQxs/fep8D0izx6JA==
X-Received: by 2002:a1c:5fc4:: with SMTP id
 t187mr27563148wmb.181.1587995070259; 
 Mon, 27 Apr 2020 06:44:30 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id u12sm16594318wmu.25.2020.04.27.06.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 06:44:29 -0700 (PDT)
Subject: Re: qdev unrealize error handling WTF?!?
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87k121hzva.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7dcd7cb0-bf36-4980-194f-d2c3a65ba6ed@redhat.com>
Date: Mon, 27 Apr 2020 15:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87k121hzva.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:33:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/04/20 14:33, Markus Armbruster wrote:
> [1] a device on dev->child_bus fails to
> unrealize, or [3] @dev itself fails to unrealize.  We hold on to the
> first failure, and continue to unrealize.  device_set_realized() fails
> when any of these fail.
> 
> Issue #1: What if some, but not all fail?  How can this possibly work?
> 
> Issue #2: Even if all fail, and therefore both the device and the ones
> on ->child_bus all remain realized, there are side effects at [2] and
> [4].
> 
> Any better ideas than &error_abort?

I don't think we have unrealizes that fail, so removing the argument and
&error_abort is the best idea.

Paolo


