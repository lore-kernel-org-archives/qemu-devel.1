Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7FFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065A3206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCKBB9vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065A3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqC6j-0001Wg-BI
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqC68-00016f-Ab
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:58:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqC65-0001tP-AO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:58:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so4047236wmc.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hR8bxGN9QY6Smfj7rXAcaqUgQQM7wXM9keSx8bnDu7c=;
 b=RCKBB9vqsTEEoRKxI0xdqQciK4z5T9PXIGJdKlD3rmZfc0jawrnsX7eIZze602GhBs
 ihxIG96y0/XSTxEZ4lTRYRy4TVZQHjTCDWed5YwWANg2AzZqIy2u0mh/IfH0MqTLZIKE
 2rRD5Sn5K1w+i3MsGTmETmbwCYN+SUJ4/3O6GSCxGB5FLeO7DUlCimtxugrIDlO5i4+S
 Ee4HrJVm4DHmed6OwtWHb3qV58Py0kIzbPgad78TcWoEu7fz6yGkNErOVVSy3/DOrEQX
 li8XP7Hm4u59C5N6jOQvqct4dDgQ/502wqiRjCVmjmZNafQQHErZhWVeqwFW2sIGzgNV
 mb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hR8bxGN9QY6Smfj7rXAcaqUgQQM7wXM9keSx8bnDu7c=;
 b=rVOqC4LINwL54U5NZuU/ws0r5h/ZGjsNVmX6z+l1Z1tPCJ8lXBbiWz1rFMBXqAfyfJ
 KFFZ+s0Ku+B0Q5AeaJwQRSkODhJ+E4/DjtjFJewQ367sbnx2Q2/NwlhuIRU68gZOKEbJ
 f94DbF+q3PR03ibReCNKu6h5XgyBcqwD35+iVdAIXu+jLIaCFl1GqArV71jTfMxOtrj+
 UIKxKQQMEADQxysiLQx+P6H8kJLLivMSPA4Z4QezSPA7CUkkLZZ4iiQ02J8dA0aVUgm0
 Fq3es1gFrh9ZkXN2aUoBMpOvl7E468H8s7Q3nOSaKoL7Z3R0jJ3aynvVuJPefjNvj7sD
 0bEA==
X-Gm-Message-State: AOAM532eKJbeCMhz0Sa0daCiulGksnrU5uc5zYk4rwL5ti417MN/1vSv
 VSf9PFJYm7vAU/C5g1EHj523p0XYzcpJncnKVfM=
X-Google-Smtp-Source: ABdhPJyBZDl5TZ3MOsbSv1fI0ArLKaHKS2VipvqtjJzLdKZvkqnNZ0Fihkmrz0Hw7jVHptN58uyr5pYlhX00WziSLZ0=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr19835654wml.36.1593507511720; 
 Tue, 30 Jun 2020 01:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
 <CALTWKrUOjwi9xG7vXCQ9sXStFaPh782ytwwPbztAp_PNuHFHYA@mail.gmail.com>
In-Reply-To: <CALTWKrUOjwi9xG7vXCQ9sXStFaPh782ytwwPbztAp_PNuHFHYA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 10:58:18 +0200
Message-ID: <CAHiYmc7tYYWb6AMQeFtCOQFXWbzB4+jGx1Zia+uvDd8ej+rieg@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 09:19 Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Tue, Jun 30, 2020 at 6:34 AM Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.co=
m> wrote:
> >
> > Dne 29. 06. 20 v 12:25 Ahmed Karaman napsal(a):
> > > Hi,
> > >
> > > The second report of the TCG Continuous Benchmarking series builds
> > > upon the QEMU performance metrics calculated in the previous report.
> > > This report presents a method to dissect the number of instructions
> > > executed by a QEMU invocation into three main phases:
> > > - Code Generation
> > > - JIT Execution
> > > - Helpers Execution
> > > It devises a Python script that automates this process.
> > >
> > > After that, the report presents an experiment for comparing the
> > > output of running the script on 17 different targets. Many conclusion=
s
> > > can be drawn from the results and two of them are discussed in the
> > > analysis section.
> > >
> > > Report link:
> > > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QE=
MU-Into-Three-Main-Parts/
> > >
> > > Previous reports:
> > > Report 1 - Measuring Basic Performance Metrics of QEMU:
> > > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> > >
> > > Best regards,
> > > Ahmed Karaman
> >
> > Hello Ahmed,
> >
> > very nice reading, both reports so far. One thing that could be better =
displayed is the system you used this to generate. This would come handy es=
pecially later when you move from examples to actual reports. I think it'd =
make sense to add a section with a clear definition of the machine as well =
as the operation system, qemu version and eventually other deps (like compi=
ler, flags, ...). For this report something like:
> >
> > architecture: x86_64
> > cpu_codename: Kaby Lake
> > cpu: i7-8650U
> > ram: 32GB DDR4
> > os: Fedora 32
> > qemu: 470dd165d152ff7ceac61c7b71c2b89220b3aad7
> > compiler: gcc-10.1.1-1.fc32.x86_64
> > flags: --target-list=3D"x86_64-softmmu,ppc64-softmmu,aarch64-softmmu,s3=
90x-softmmu,riscv64-softmmu" --disable-werror --disable-sparse --enable-sdl=
 --enable-kvm  --enable-vhost-net --enable-vhost-net --enable-attr  --enabl=
e-kvm  --enable-fdt   --enable-vnc --enable-seccomp --block-drv-rw-whitelis=
t=3D"vmdk,null-aio,quorum,null-co,blkverify,file,nbd,raw,blkdebug,host_devi=
ce,qed,nbd,iscsi,gluster,rbd,qcow2,throttle,copy-on-read" --python=3D/usr/b=
in/python3 --enable-linux-io-uring
> >
> > would do. Maybe it'd be even a good idea to create a script to report t=
his basic set of information and add it after each of the perf scripts so p=
eople don't forget to double-check the conditions, but others might disagre=
e so take this only as a suggestion.
> >
> > Regards,
> > Luk=C3=A1=C5=A1
> >
> > PS: Automated cpu codenames, hosts OSes and such could be tricky, but o=
ne can use other libraries or just best-effort-approach with fallback to "u=
nknown" to let people filling it manually or adding their branch to your sc=
ript.
> >
> > Regards,
> > Luk=C3=A1=C5=A1
> >
> Thanks Mr. Luk=C3=A1=C5=A1, I'm really glad you found both reports intere=
sting.
>
> Both reports are based on QEMU version 5.0.0, this wasn't mentioned in
> the reports so thanks for the reminder. I'll add a short note about
> that.
>
> The used QEMU build is a very basic GCC build (created by just running
> ../configure in the build directory without any flags).
>
> Regarding the detailed machine information (CPU, RAM ... etc), The two
> reports introduce some concepts and methodologies that will produce
> consistent results on whichever machine they are executed on. So I
> think it's unnecessary to mention the detailed system information used
> in the reports for now.
>

Ahmed, I don't entirely agree with you on this topic.

I think you treated Mr. Lukas comments in an overly lax way.

Yes, the results will be stable (within a small fraction of a percent)
on a particular given system (which is proved in "Stability
Experiment" section of Report 1). That is great! Although it sounds
elementary, this is not easy to achieve, so I am glad you did it.

However, we know that the results for hosts of different architectures
will be different - we expect that.

32-bit Intel host will also most likely produce significantly
different results than 64-bit Intel hosts. By the way, 64-bit targets
in QEMU linux-user mode are not supported on 32-bit hosts (although
nothing stops the user to start corresponding instances of QEMU on a
32-bit host, but the results are unpredictable.

Let's focus now on Intel 64-bit hosts only. Richard, can you perhaps
enlighten us on whether QEMU (from the point of view of TCG target)
behaves differently on different Intel 64-bit hosts, and to what
degree?

I currently work remotely, but once I am be physically at my office I
will have a variety of hosts at the company, and would be happy to do
the comparison between them, wrt what you presented in Report 2.

In conclusion, I think a basic description of your test bed is missing
in your reports. And, for final reports (which we call "nightly
reports") a detailed system description, as Mr Lukas outlined, is,
also in my opinion, necessary.

Thanks, Mr. Lukas, for bringing this to our attention!

Yours,
Aleksandar




> Best regards,
> Ahmed Karaman

