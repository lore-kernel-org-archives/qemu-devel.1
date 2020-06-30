Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722E9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACD3206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5JcKAvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACD3206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqAZ2-0006H4-FI
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 03:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqAY3-0005Uk-5n
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:19:19 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:40640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqAY0-0003OQ-A6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 03:19:18 -0400
Received: by mail-lj1-x22b.google.com with SMTP id n23so21254036ljh.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SP/ka/8zRYuk89NaQgbv6lVPyXrNAIiWFFzQhWByUVc=;
 b=S5JcKAvJ/wfj1gz1rIC2oMANREqsJ6G1ZiGKzwv9g8390xzhlsG4QRQauhPDowas/Z
 gRhBkbuqFnT4ojPnAExZZz9XvO/TALYCd7rTEkfUg7xE9K8b2/uA4oNQNnAW14A2NiMj
 WsvFw1ruhbrN5E2VNs55LuUHXY45Z7QjgiCfUDqFpmw3XM/cZaIDasDLNvK/TQSCNyAH
 BgDyiSmR35m/dmekDnuBS567JeoagUsC4XMmNufQuOYuoZbdFnJ8jnuLIDS0wPXKIFz7
 Jclz+TgcpiVEP6O3AFLPtEJanP2iZhdTXgobHDJFK6f3oyKuy0lI1euIbhd2JDCQXM8H
 2i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SP/ka/8zRYuk89NaQgbv6lVPyXrNAIiWFFzQhWByUVc=;
 b=rUAcjTVXY3Gv5DpzsHvNyvG1ugY08BZLwAsW/FTl7AtvczyBUPunNz5mTK3kS+x1x6
 w41Hsr1geC4ndF5aGkWANi05QX9hkQ2LDkR9n9FXRRiYvrBets3M4YkMX9Hr+9nliBhd
 3ANekSv9+X19+TbTpySvKO3yjSJ+aGsWK95MI5gy8CrEYqmCzfHSsuPLPWz4ym2bjHLq
 tGutPb7aIathJ8G/gUMFuqobRzeAFpEki94n+Vn0QB5IGABHj8XWahR51yN/4hyMKEjV
 Rk8I8AHymDjwz/3p0sT/mrBJvhnHVTfdf6/sWDDe09oyJ3qao4D2c7vby6LeAlXi9Alo
 g7zA==
X-Gm-Message-State: AOAM533QGkL8W8cy6DD4p7RBk4A8IaSk4JNk4T/U/LCag3t8CwPLSeDa
 cuXYmhrEob/LscaeuagC+d2I1NiJVJdSY5FWgr0=
X-Google-Smtp-Source: ABdhPJzbb5AVeWV7QWTlB1qfx3KhFBWwecZncCcCKkhQPxNJQp8o06SGjbUQVLuX2/tpBh5P7sRRvKIOIV2OqRFyqVc=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr9858770ljj.3.1593501553618;
 Tue, 30 Jun 2020 00:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
In-Reply-To: <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 30 Jun 2020 09:18:34 +0200
Message-ID: <CALTWKrUOjwi9xG7vXCQ9sXStFaPh782ytwwPbztAp_PNuHFHYA@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 6:34 AM Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=
 wrote:
>
> Dne 29. 06. 20 v 12:25 Ahmed Karaman napsal(a):
> > Hi,
> >
> > The second report of the TCG Continuous Benchmarking series builds
> > upon the QEMU performance metrics calculated in the previous report.
> > This report presents a method to dissect the number of instructions
> > executed by a QEMU invocation into three main phases:
> > - Code Generation
> > - JIT Execution
> > - Helpers Execution
> > It devises a Python script that automates this process.
> >
> > After that, the report presents an experiment for comparing the
> > output of running the script on 17 different targets. Many conclusions
> > can be drawn from the results and two of them are discussed in the
> > analysis section.
> >
> > Report link:
> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU=
-Into-Three-Main-Parts/
> >
> > Previous reports:
> > Report 1 - Measuring Basic Performance Metrics of QEMU:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> >
> > Best regards,
> > Ahmed Karaman
>
> Hello Ahmed,
>
> very nice reading, both reports so far. One thing that could be better di=
splayed is the system you used this to generate. This would come handy espe=
cially later when you move from examples to actual reports. I think it'd ma=
ke sense to add a section with a clear definition of the machine as well as=
 the operation system, qemu version and eventually other deps (like compile=
r, flags, ...). For this report something like:
>
> architecture: x86_64
> cpu_codename: Kaby Lake
> cpu: i7-8650U
> ram: 32GB DDR4
> os: Fedora 32
> qemu: 470dd165d152ff7ceac61c7b71c2b89220b3aad7
> compiler: gcc-10.1.1-1.fc32.x86_64
> flags: --target-list=3D"x86_64-softmmu,ppc64-softmmu,aarch64-softmmu,s390=
x-softmmu,riscv64-softmmu" --disable-werror --disable-sparse --enable-sdl -=
-enable-kvm  --enable-vhost-net --enable-vhost-net --enable-attr  --enable-=
kvm  --enable-fdt   --enable-vnc --enable-seccomp --block-drv-rw-whitelist=
=3D"vmdk,null-aio,quorum,null-co,blkverify,file,nbd,raw,blkdebug,host_devic=
e,qed,nbd,iscsi,gluster,rbd,qcow2,throttle,copy-on-read" --python=3D/usr/bi=
n/python3 --enable-linux-io-uring
>
> would do. Maybe it'd be even a good idea to create a script to report thi=
s basic set of information and add it after each of the perf scripts so peo=
ple don't forget to double-check the conditions, but others might disagree =
so take this only as a suggestion.
>
> Regards,
> Luk=C3=A1=C5=A1
>
> PS: Automated cpu codenames, hosts OSes and such could be tricky, but one=
 can use other libraries or just best-effort-approach with fallback to "unk=
nown" to let people filling it manually or adding their branch to your scri=
pt.
>
> Regards,
> Luk=C3=A1=C5=A1
>
Thanks Mr. Luk=C3=A1=C5=A1, I'm really glad you found both reports interest=
ing.

Both reports are based on QEMU version 5.0.0, this wasn't mentioned in
the reports so thanks for the reminder. I'll add a short note about
that.

The used QEMU build is a very basic GCC build (created by just running
../configure in the build directory without any flags).

Regarding the detailed machine information (CPU, RAM ... etc), The two
reports introduce some concepts and methodologies that will produce
consistent results on whichever machine they are executed on. So I
think it's unnecessary to mention the detailed system information used
in the reports for now.

Best regards,
Ahmed Karaman

