Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8168C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 04:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C822086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 04:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMV2q1Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C822086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huUr3-00029C-O4
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 00:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1huUqL-0001ds-S8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 00:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1huUqK-0007uT-Ok
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 00:43:33 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>)
 id 1huUqK-0007u5-Hp; Mon, 05 Aug 2019 00:43:32 -0400
Received: by mail-ot1-x32b.google.com with SMTP id r6so83964067oti.3;
 Sun, 04 Aug 2019 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aK93g3QL2dG+tUnUCxSDwKdK7PX56Wj5Ql2kuCgjTrk=;
 b=jMV2q1Blsr4UTQXxW1YRj4f+Zx/EIWZCku8acGTtlCoXl3O8rPmCK3UUg2qz/Td+64
 sh/O6TZFB311Ry0lDnxjsaw+GE3C5v1xgjVU+k4FZXluHYyDYC/r88v4JcOZRXlE7Ibs
 u6nWqEj4zyi69Ri0W/rnK2BIwTg1xtUFBffgsKa6ah1B9b4EW5qk4DK2wSn/WhOKVg+p
 Q+f1IYZIu9DDFIH8h/RSDIZZinrizhOHh0DicIMNabgJg8VOp8KosXW0VI9CJcTMRqhQ
 Dsngp1Fzioxxsq3UO4zPzrCSgHYMhFDKyHY8ljlP0QcM5XksLOwj/L/SREG8Y/edaV40
 eFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aK93g3QL2dG+tUnUCxSDwKdK7PX56Wj5Ql2kuCgjTrk=;
 b=O8WMfN85jfcZAEKM8w9Btu6UcJlHjdp6XlXiF2EOiK+KTS+dMiNNXmHwALcl9vW1qc
 +Gso6tnSva3OvlRSCGAwxWnAkhqijlTS4m0HLEeckZNJeVeyWNFs+Ok/UwVIZf0ONyav
 KIykCDzgrItrUKzhRZVfkrMX8609a2vDBKgcD4h83qh/jCxqL2xhqMiQw/6gIhGJDnI7
 XJIPPwkvj74q0A7IWw5K1+YbFUTLwxsZ4uInfB3G8MraW1YP4KSuzaMe48mOjRZLXBaG
 QEdkZQVFJXXCmfjSP5o/TTmV7k0wvX1cmR3oN6At7YEtE7hZjaWRMvstZf4trnSR6loB
 30lg==
X-Gm-Message-State: APjAAAVRhIYhCDkqQSMewAKyTiqv1wkUhrR89X9haBt2XGbPCAFv0WC4
 /YvDoIwB00YDUnDqv2HbryDXKIS5uOhtacx8OMc=
X-Google-Smtp-Source: APXvYqzUGR8aDXlzPn+LyFfu12DSc+UPCc2fvUteUxO5x8MA56t41rMrh54svV9yfkSaTCNTE8sW9J9xhsFHStqdZW8=
X-Received: by 2002:a05:6830:1291:: with SMTP id
 z17mr48407542otp.194.1564980211666; 
 Sun, 04 Aug 2019 21:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <7f455f0d.730d.16c5fdc21af.Coremail.hope2hope@163.com>
In-Reply-To: <7f455f0d.730d.16c5fdc21af.Coremail.hope2hope@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 5 Aug 2019 12:42:55 +0800
Message-ID: <CAKXe6SKMS__GaxTL4rkTBFpCpRkRS_bHoJx8=6w6WktFr5K9XQ@mail.gmail.com>
To: ddm <hope2hope@163.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] How to configure QEMU to support APIC
 virtualization
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ddm <hope2hope@163.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=885=E6=97=A5=E5=91=A8=
=E4=B8=80 =E4=B8=8A=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A

> Hi guys,
>
>
> I have tried via modprobe kvmintel enable_apicv=3DY  to adjust KVM
> parameter, but it doesn't effect,  and
> cat /sys/module/kvm_intel/parameters/enable_apicv always return "N".
> I don't know how to configure KVM or QEMU to support APIC virtualizaion
> feature?
>
>
AFAICT APICv is hardware feature, but I still don't know accurately after
which CPU support it.
You may refer the code about 'enable_apicv' related code in kvm to see how
to detect this capability.

Thanks,
Li Qiang


>
> My host infos are as follows:
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                1
> On-line CPU(s) list:   0
> Thread(s) per core:    1
> Core(s) per socket:    1
> Socket(s):             1
> NUMA node(s):          1
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 142
> Model name:            Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
> Stepping:              10
> CPU MHz:               2112.001
> BogoMIPS:              4224.00
> Virtualization:        VT-x
> Hypervisor vendor:     VMware
> Virtualization type:   full
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              256K
> L3 cache:              8192K
> NUMA node0 CPU(s):     0
> Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb
> rdtscp lm constant_tsc arch_perfmon nopl xtopology tsc_reliable nonstop_t=
sc
> cpuid pni pclmulqdq vmx ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe
> popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm ab=
m
> 3dnowprefetch cpuid_fault invpcid_single pti ssbd ibrs ibpb stibp
> tpr_shadow vnmi ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2
> invpcid rtm rdseed adx smap xsaveopt arat flush_l1d arch_capabilities
>
>
> Could you tell me how to configure it?
>
>
> Thanks!
>
>
