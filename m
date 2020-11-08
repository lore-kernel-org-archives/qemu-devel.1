Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36882C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C512C206D8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHI2pBVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kboEa-0001SQ-Qi
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 12:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kboDT-0000bL-R3
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kboDS-0002Gd-88
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 12:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604855457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S3aF/Y0QDWP2EqeSfB4ysIVPA73IFu/evid3JJ/zeI=;
 b=eHI2pBVagNP9LJ5qcmrwhGuNIVo2pPpsDFXpSuKjpYioiwCTERWpf1/98J2QC1qZsW9po7
 FtobCBelMrFu3L8geJb2alZi+RkbprI5k33y/0lXBEHRgh7dvUwAnZ2fA+GtF7ENeI7iF+
 AeF4k969Z6jFxcHKahqIbEmHOSei1pY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-F1gh9VoTOripzbwGMaZ6zw-1; Sun, 08 Nov 2020 12:10:54 -0500
X-MC-Unique: F1gh9VoTOripzbwGMaZ6zw-1
Received: by mail-wr1-f72.google.com with SMTP id t17so3181944wrm.13
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1S3aF/Y0QDWP2EqeSfB4ysIVPA73IFu/evid3JJ/zeI=;
 b=E9Zo+bm84c25fr5KUtBn9z0UH6ZKu/4AHCwlNgCQAnsOSH80B7dRrs3DKfgYSnFgTW
 r+Uk9AzM5yM/rsvH58Cm4ChryJATzFPlkogaOBgof4TfhzQ51t6YrBcH5/VyiI3YPWnH
 NmPTXZcTaUFsuR0ta59/zfvvruHfqd4q/Vvgc60/fFH7IucgUjZ8uKIOCStW/22wBHlm
 oBKR0rn2BaE+jResmWpXsgMbSWeR8Rk3ybm6Mx2v7MxbRrZwnIFzlSWIFTvfyB+ZJvJ7
 hFvgfiwIjuDUDcJGPXvvzJtTemMe27jwoj1o4m0hHK52afNTBO8z/hmb69BIfBpsvDGx
 6YVQ==
X-Gm-Message-State: AOAM530pJjbEd0usgaJUVkIiAXiFotHmUU5drqFG6yLkWe9I3zqhtewx
 5nJWw3oFzx6D6ofWkSNL1oYKwrsDJdxVT8HifoFKEBX9pKmFPqc8QdYxCAssUOjPQOObq2mnOSN
 R57/LczAwqVCF4YQ=
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr10107241wms.130.1604855452890; 
 Sun, 08 Nov 2020 09:10:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwLPgBBLcp/ONe8DdfUPvGq3yiMzueyg92zDMaxCisConkBWnxKNu/67Dh2pBewrNvO6Oo9w==
X-Received: by 2002:a1c:2c43:: with SMTP id s64mr10107225wms.130.1604855452761; 
 Sun, 08 Nov 2020 09:10:52 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id v9sm10240943wrp.11.2020.11.08.09.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 09:10:52 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v2] hw/i386/acpi-build: Fix maybe-uninitialized
 error when ACPI hotplug off
To: Ani Sinha <ani@anisinha.ca>
References: <20201107194045.438027-1-philmd@redhat.com>
 <CAARzgwxCXmCZsVWKFX6Fp=SBBj0BvY5=ntLwLZva2NZywD48Lw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <752f4cfa-9213-299d-474c-fbccf312009d@redhat.com>
Date: Sun, 8 Nov 2020 18:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAARzgwxCXmCZsVWKFX6Fp=SBBj0BvY5=ntLwLZva2NZywD48Lw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:02:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/20 4:58 AM, Ani Sinha wrote:
> On Sun, Nov 8, 2020 at 1:10 AM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> GCC 9.3.0 thinks that 'method' can be left uninitialized. This code
>> is already in the "if (bsel || pcihp_bridge_en)" block statement,
>> but it isn't smart enough to figure it out.
>>
>> Restrict the code to be used only in the "if (bsel || pcihp_bridge_en)"
>> block statement to fix (on Ubuntu):
>>
>>   ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
>>   ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
>>   in this function [-Werror=maybe-uninitialized]
>>     496 |         aml_append(parent_scope, method);
>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   cc1: all warnings being treated as errors
> 
> OK I looked at the patch closely and it makes sense. Can you please
> run a "make check" to make sure we have not broken anything?

Yes I did...


