Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF5AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FE020738
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhEWfYzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FE020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Bf-0001Ys-SU
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX59V-0008M3-Qv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX59P-0007kI-Iy
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603728914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0R/tTslo4LV6mB7M85RlLE+zPutvrVYQwOVA/buK/S8=;
 b=UhEWfYzpg9x7ZKSILuJBNVhCnRKxB2ZeZ8mS5/Kktb3D/u4xQFpt9RCv3BhfR5zv1oMK+v
 NBMkA1IrTFydKa493KDnNy8GB78XmciVuL/WIv5EpqDGo7s5cQk1UYLwZuJbkECfdW78Bc
 30/HJOA11LHtr5Modvz4Y4ceJAEz/R0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-237M73grNre8PJv1Pxl3hQ-1; Mon, 26 Oct 2020 12:15:11 -0400
X-MC-Unique: 237M73grNre8PJv1Pxl3hQ-1
Received: by mail-wr1-f71.google.com with SMTP id q15so8779233wrw.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 09:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0R/tTslo4LV6mB7M85RlLE+zPutvrVYQwOVA/buK/S8=;
 b=DzNObMsXLs9uqz8iY4nNPre78B2yzLtkywYGGDRg37F+JtTGPzfMrZcTU5sgqXkMuQ
 Bvf6J9PbfGAFi0qlf1SWMtZRKg/H0Zpr987StKdvgnpoS2SAlLe747iNcPquj7l5N0K9
 jXZXk1r/hHK1nXmAUvQC11TlAHMGlfjO5XgnYSk3t/K6OPsfoVFTIbpPKRhIM3sv5eaP
 koqWooMekkCw6m5XAqneX7/LYvmLIsZw7G8qB4m1xe2v7BYjfqWexdABGEDAmWqTx5RJ
 vQeohsOcVvnQCKxEAf5XGK30BFlLzXmk0o+kgCGNlB8SsCkhm1Zbyd50cOxWrV8hMxdg
 iICQ==
X-Gm-Message-State: AOAM532w5NMAVYIHi1z5KPxyH3yOFsKpK1x+Oab3ccsQMXS+8UxHnvok
 vOSaDfk9m5Gz0NRVReFCSqz9/esdNK1Fw1VaWRAPpNaoVNe88qJaOFBTunujkrzZwIyt9UI4dcn
 P3Qp5LjThLDHcK74=
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr13949687wmj.9.1603728909640; 
 Mon, 26 Oct 2020 09:15:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGa+ehFhwtmo2F2MQmb3sqTXTb2Zy3UlMZnUBzbv21HiH3dOK0I7CO2Iub+/m9SVHGqCt0JA==
X-Received: by 2002:a7b:cd8f:: with SMTP id y15mr13949663wmj.9.1603728909453; 
 Mon, 26 Oct 2020 09:15:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v189sm21027471wmg.14.2020.10.26.09.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 09:15:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: Joelle van Dyne <j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
 <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
 <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
 <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
 <77ef9338-de8c-82a8-7ca0-f8d708f8d1da@redhat.com>
 <CA+E+eSBedWZL2hw_RKCSLn2bxomhdbTvYd9YSatX5RnGB5r-KQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bf42269-3373-1f7b-1741-d1357d426af4@redhat.com>
Date: Mon, 26 Oct 2020 17:15:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CA+E+eSBedWZL2hw_RKCSLn2bxomhdbTvYd9YSatX5RnGB5r-KQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 16:33, Joelle van Dyne wrote:
> Just to be clear, you're in favor of removing the
> --enable-cross-compile option? I can do that if others agree but I'm
> not sure what the downside of adding this extra option is?

For me the downside is that it's not clear that --cross-prefix=foo-
implies --enable-cross-compile.

Paolo

> -j
> 
> On Mon, Oct 26, 2020 at 12:54 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 25/10/20 20:24, Joelle van Dyne wrote:
>>> As the patch stands --cross-prefix="" works but I like having the
>>> --enable-cross-compile option because it's more clear of the intention
>>> (in logs and such). I've been struggling to come up with a concise
>>> modification to the help text for --cross-prefix that explains that
>>> empty PREFIX is allowed and why you would want to do that.
>>
>> --cross-prefix=PREFIX enable cross compilation, using PREFIX
>>                       in front of compile tools
>>
>> Paolo
>>
> 


