Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAEDC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88DC21897
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5wtk+oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88DC21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQoC-0006Gh-Qy
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQnK-0005YJ-Fr
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQnH-0001eG-FQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602143814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tgFYYn0xylUARznVgI294k0oqH9AsmHLrx6KUieeBg=;
 b=K5wtk+oVNqFugQgsmkDya1hQGRz48leCLnT/MQQrbvH0J2Ex/b/OYpRiLRQnktMxdvBIe6
 aoMTxYbyRHJsCV9x7JwVo6Tu+0/f5yEV6g+CfpkLDjmLUc4KLyHeC260/2HzMTGJb1b7jC
 4FKIVj8YO8j4mNWsmafOEjZXfueCsn4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-lMP9tlv-Pd2XEnuXaBQA_w-1; Thu, 08 Oct 2020 03:56:53 -0400
X-MC-Unique: lMP9tlv-Pd2XEnuXaBQA_w-1
Received: by mail-wr1-f72.google.com with SMTP id v5so3579325wrr.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/tgFYYn0xylUARznVgI294k0oqH9AsmHLrx6KUieeBg=;
 b=rF73rQKt4PHiOMISNKJLNSUHvOiTvSnjIEWjHhaujgpdlxVJ0uX08Hqe7n9ez7jcW9
 6ApltkUkDaCWoPBPPlnT/pDhqHdAkobrsnORcBZrm01t+Yd1hYm5o4SdX1KVDZH1CN5e
 i4Al6EipHCHL7m8oWQJ2AHm1KeDSb1JGb+wh9Erbav/vZsp/YyWSsuYtGKmE1YpnzKgY
 Julu1cQQYd8z60wPZWF0f2oDrOTwYt3X200IBSi2cbjkyqL9+zKDUno5vPbWX96PAtIR
 FF69FGUbprVfOwsEOTgtbmltftEEvZKjlqndKZ/sFMqngTtQEtSLUV73BUkK7nb67lnA
 nYmQ==
X-Gm-Message-State: AOAM5338MPFcMvODxJPDVTNXmnnj1S53GbNtGpVI5OqXu2/KpUlJNazo
 KaLWWi3orGymK7nCcpziGGuyQGfNGnH7ALPAR/2IC1u7C4Pw0YKRDH/EPyVI6tnodRsMvEPeerH
 yjOjpI+/6B6Q3nCA=
X-Received: by 2002:adf:f191:: with SMTP id h17mr6312822wro.73.1602143811687; 
 Thu, 08 Oct 2020 00:56:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmsun2k8s0gOXjO2YXJL2ECZlBT55WwfnJNHfpW59akidOIy/jFUTBeg2SQ7nZKCJxST7tKQ==
X-Received: by 2002:adf:f191:: with SMTP id h17mr6312802wro.73.1602143811463; 
 Thu, 08 Oct 2020 00:56:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id c16sm6372311wrx.31.2020.10.08.00.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:56:50 -0700 (PDT)
Subject: Re: [PATCH 2/2] exec: split out non-softmmu-specific parts
To: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
References: <20201006091922.331832-1-pbonzini@redhat.com>
 <20201006091922.331832-3-pbonzini@redhat.com>
 <cb553da1-9cd1-1933-d678-8580a3c0d8f3@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <027d0f5c-d5c4-911b-b349-f63895fc164d@redhat.com>
Date: Thu, 8 Oct 2020 09:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cb553da1-9cd1-1933-d678-8580a3c0d8f3@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 09:47, Claudio Fontana wrote:
> On 10/6/20 11:19 AM, Paolo Bonzini wrote:
>> Over the years, most parts of exec.c that were not specific to softmmu
>> have been moved to accel/tcg; what's left is mostly the low-level part
>> of the memory API, which includes RAMBlock and AddressSpaceDispatch.
>> However exec.c also hosts 4-500 lines of code for the target specific
>> parts of the CPU QOM object, plus a few functions for user-mode
>> emulation that do not have a better place (they are not TCG-specific so
>> accel/tcg/user-exec.c is not a good place either).
>>
>> Move these parts to a new file, so that exec.c can be moved to
>> softmmu/physmem.c.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Hi Paolo,
> 
> the comment does not talk about cpu.c, which is now created in the top source directory.
> What is the role of this new module?

It's actually in the commit message: "4-500 lines of code for the target
specific parts of the CPU QOM object, plus a few functions for user-mode
emulation that do not have a better place".

It's basically sitting between hw/core/cpu.c and target/*/cpu.c.  Hence
the non-descriptive name. :)

> Also, could we find a more descriptive file name than cpu.c?
> Do you plan further renaming of this new module functions?
> 
> Or its this basically a "leftovers" file for which we did not find a proper role yet?

The user-mode parts are, but most of it is implementing the QOM CPU
object.  We can move those functions to hw/core/cpu.c and make that file
target-dependent, I wouldn't object to that.  But since there are some
opportunities for simplification, I'd rather do that in a separate patch
and keep the pure code-movement in this one.

Paolo


