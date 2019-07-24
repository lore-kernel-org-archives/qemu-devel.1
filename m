Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34523C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E6522387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6522387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFhx-0000ei-9A
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqFhl-0000BP-NZ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqFhk-0005pT-Ns
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:45:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqFhk-0005pA-Gb
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:45:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so46588655wre.12
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 04:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QSTAylvuTRUhhyqE4NEKUwenv/llqXrHd7y86+rsQbo=;
 b=jzmJdcvLUjoCYQDuFXsRF0JnKPQ9WGq1ZY/xXLuNtm2VHm/+lFmS3bhnGSPBSpbi8q
 ftzZRCtMNrXaLpHSa77p9q+WLVrt2GSdnlCbvTkbRfmsvvSzY1j7UkKwqDbhWAS6GlFP
 HRXjQ9tTXqV7I75qaNiqoux0CH1IJoy2KRYd/BDk+5vxmIBR5IeGrij6WfpHq6o5C6nR
 AZZN/Vikvyo4galR/R4LK+KnpNDT3BcFGasZ13QdDLFnJAe0i6vmjB7NnrRu/3lPDltO
 e1hY5eHgukNV+bLpNBGi+yyIcmSGxZTjWlJm5WRVvaTnskvHctDv5nYy6n4bBtD+JHte
 /wQw==
X-Gm-Message-State: APjAAAWwD77GzCzumQ4sqOezkVPpACBSUWqmj6CPA4P4VXHTFBasAxLE
 O7x3zPgvhAcyN8BuNrWLx25keg==
X-Google-Smtp-Source: APXvYqxlvzs4ZZBEWW50zoS3e/EjclIZYXOz6PoGiakoZwaaaDsX/pzlFHV0FDAfggqRtMsJ/DcT4Q==
X-Received: by 2002:adf:df90:: with SMTP id z16mr40642708wrl.331.1563968707419; 
 Wed, 24 Jul 2019 04:45:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id e7sm42840727wmd.0.2019.07.24.04.45.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 04:45:06 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <156390240449.12764.14466682904037881386@c4a48874b076>
 <d4992f3d-489a-644e-093f-dfbff27bdda8@redhat.com>
 <25cbf95c-cf79-0cd8-497f-511a868d588a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <59190d95-c7c4-a06c-252e-8676ea034c5a@redhat.com>
Date: Wed, 24 Jul 2019 13:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <25cbf95c-cf79-0cd8-497f-511a868d588a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Refresh APT cache before
 installing new packages on Debian
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
Cc: fam@euphon.net, Laurent Vivier <lvivier@redhat.com>, alex.bennee@linaro.org,
 Xiao Guangrong <xiaoguangrong@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 13:25, Thomas Huth wrote:
> Was the test running on a machine with heavy load? In that case, the
> test thread just might have been suspended for too long...
> We might need to set the "wiggle" parameter there to a higher value
> (like 5 seconds maybe)?
> Or maybe we should fence the check_time() related tests with "if
> (g_test_slow())" to make sure that they are not run on CI systems anymore...

There were 4 stuck FreeBSD test VMs on the patchew machine.  I've fixed
that, and I will switch the tester to run in a systemd scope so that
timeouts clean up all processes properly.

Paolo

