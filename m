Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA4120897
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Fj2o1ndf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA4120897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG68a-0002mk-O9
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kG67w-00025I-PE
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:51:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1kG67u-0000AY-L0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:51:32 -0400
Received: by mail-pf1-x443.google.com with SMTP id x123so3095574pfc.7
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=PM6b8NvEPBftJFD5nS5xU2vW5iS1qMZHydV4wpfZ2Ks=;
 b=Fj2o1ndfPnbw9g1z+lZCzE4jUvVrW0FXm4YWYZjtxjis9MV9d2M8ve7BWMXFsLqZy/
 heK9GoUmX/DMCMvEWVHZJc5UMDUfZj7bIThIEV40+FBjCBm/6Pv9HBTOq8X4fIAgUDFn
 n9X3K8oOjp3UBuKDIcoce58cnXjFd6QIkvvoUOKXmvdMvWSG8ljka6a8UBlJOVNtH43V
 N9avig1JNbaqKiDDt+cS4btehzWKPxg0MBvnHddhNyOx+ouw3NAtREaVZNNiRYVlY97S
 OVjrJ/eWfLQbMsOI7tOztv5mCF2axoSILHflvFof3OtrE0J/E6PbhE3sswKLLGdw+O36
 gf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=PM6b8NvEPBftJFD5nS5xU2vW5iS1qMZHydV4wpfZ2Ks=;
 b=AMk6zO3sgRfzhrnsu/1lctEBj11Nha8tm5z5b7awSUdOkJODfceVfXfAk8lvqjm5GH
 MKHVJyGhGIryOoM5JspN5AH9GQwHSo3DHmDFSaSof5vvI/PJU3Hg/mzplfmK7RrjzIKj
 dkew82nlmMb50aI6yGB4x0NRcxql6SjDpA39mLp9XTuHGhXzLAjPQ1GluVz6hOW28vrK
 q0MphBiEouuRRZuboqGbVqft4W7xrU9PwG4eIyztJ2c9PFb1f7M/s1dIlLcABGwoIij0
 DNG8mLMsKdCBarA2iSlZHOJfnODFDkRCt3K2eSH9SxzTL9nOHRwzcz7ZtglMRV/1fz7q
 GkTg==
X-Gm-Message-State: AOAM5326cUHt92S+kMN4M0LvaCeYJEEL9Rtt96I/H5kYpfEnTVD8yyqS
 7vRuWejEtxrm+IvNnUNzCIXmGw==
X-Google-Smtp-Source: ABdhPJx3H+tDCjsvCpsPJ5n+D++fl/UlP2tqDT6Hqstd4QxfvzasrR26Egq+rOysnGLEY3pJxzzSfg==
X-Received: by 2002:a17:902:d201:b029:d0:cbe1:e7a4 with SMTP id
 t1-20020a170902d201b02900d0cbe1e7a4mr2346068ply.21.1599681088198; 
 Wed, 09 Sep 2020 12:51:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id l9sm3152769pgg.29.2020.09.09.12.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 12:51:27 -0700 (PDT)
Date: Wed, 09 Sep 2020 12:51:27 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Sep 2020 12:51:26 PDT (-0700)
Subject: Re: [PATCH v5 06/11] riscv: Initial commit of OpenTitan machine
In-Reply-To: <CAFEAcA9RcbWeM=hhUNH=Exdp_QT4s0GcCJdrpcvWkv2ea+o7cQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-13d2ebf6-70bc-4130-9e11-6fa4391c64db@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=palmer@dabbelt.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 09 Sep 2020 12:00:07 PDT (-0700), Peter Maydell wrote:
> On Wed, 9 Sep 2020 at 19:00, Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Tue, Sep 8, 2020 at 7:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>> > ...shouldn't the riscv64-softmmu config have CONFIG_OPENTITAN too?
>> > The usual principle is that the 64-bit executable can run the
>> > 32-bit boards too.
>>
>> I didn't know that was the general case. I'll send a patch to enable this.
>
> Somebody on IRC suggested that the riscv code currently
> assumes that #ifdef TARGET_RISCV64 implies a 64-bit CPU,
> ie that the 32-bit CPUs don't actually behave correctly
> if built into the qemu-system-riscv64 process, so you might
> want to check that things seem to work when you enable it...

IIRC there's a whole bunch of that floating around the RISC-V port, so just
tossing a 32-bit CPU into qemu-system-riscv64 is going to result in garbage.
At the time we originally did the port we though we weren't goin to have
mixed-XLEN systems, but the ISA now allows for it so in theory we should go fix
all that.

I don't think anyone has looked into doing it, though, as there isn't much
interest in mixed-XLEN systems (though oddly enough there was a glibc post
yesterday about them).

