Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE530C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9403F214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oulD5rqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9403F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir020-0007Pi-LP
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ir010-0006W0-8d
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ir00y-0005Rq-93
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:44:21 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ir00x-0005Nc-U3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:44:20 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so9734326wmc.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 05:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FQFfo9viNmXyky02pGXY5z3GJAhI7QUcEauk9apOOf0=;
 b=oulD5rqTNKKNXk+Gzbe+tbK9C25oY4Njnrh55aqCn8ZEUm0L3Gp4X3rqdkCgQvVi7+
 qvOqpdDwoG0y8iW7Fq2CD7XauPP+W13dKnZVswAiRyHBBwH9j+SvTmtfv5TeHoUaSrS3
 nwFTYXv3TE79JXfen311yFWvsJqz4hZSKMpp4ofjHbq78M3FNgvi6Yeq5cSVML4gakz1
 KLdv481MTqpXHMOFpt7QLf54t+KjPwBenVUDsShXXxr11OrIPntqQofHHsKNReUVKPdm
 A5+Ve9x4ah87eH7OOIKYdVRQA2bQ5LW9vwZAogUTH/od1qDINZYDv3IZhquij7UAB0+G
 eHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FQFfo9viNmXyky02pGXY5z3GJAhI7QUcEauk9apOOf0=;
 b=c5Fow+jhFKbwwGHYwBHC/fEdtF+wnwKCfS4aI2YZ0I6Ah4JwCmQoch0z1vmFF2isZQ
 gnIqIDz4yhSQ184Wc/icK4ZrVfmoBpPNwbuupKaj5b4qmBaxlQzer0esRhDlq7zvR9Ek
 5cuxnsUGv+MpQxYmsyIARMaoTg1DzURMYcETC+UqbOO+cb7MuRYh2eesLcNQFyvv407J
 tKhQoiHMIqXRjVeyqMO6o+1D4xUUJvV1Mkf+O3dcphWhX9ASj0T2YUvWdk2awDcwtXyC
 mS/IFKfOiOQg1cGMR6pgz7toTtMVsGAH7ke5XIc446/zP2/U3rJD7OJS1Li4NkpXTjxY
 4MMQ==
X-Gm-Message-State: APjAAAWGN4wnIXY5PsVDgedixryO3316M0nSxx9XIuSB976aaH46+qqY
 ghtKy5jEhmgIsHjMcxGH9kSkPg==
X-Google-Smtp-Source: APXvYqzRtDk4v+xr15q6czX8tokDFwOQKncw6HJBcIzRfGezWNah7JynW/JZ5b6iWVzInGjplym83w==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr5928041wme.163.1578923058327; 
 Mon, 13 Jan 2020 05:44:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s16sm15144166wrn.78.2020.01.13.05.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 05:44:17 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 592CE1FF87;
 Mon, 13 Jan 2020 13:44:16 +0000 (GMT)
References: <157887973843.5281.117317310678495552.malonedeb@gac.canonical.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1859384 <1859384@bugs.launchpad.net>
Subject: Re: [Bug 1859384] [NEW] arm gic: interrupt model never 1 on
 non-mpcore and race condition in gic_acknowledge_irq
In-reply-to: <157887973843.5281.117317310678495552.malonedeb@gac.canonical.com>
Date: Mon, 13 Jan 2020 13:44:16 +0000
Message-ID: <87k15vo4i7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


Alex Longwall <1859384@bugs.launchpad.net> writes:

> Public bug reported:
>
> For a 1-N interrupt (any SPI on the GICv2), as mandated by the TRM, only
> one CPU can acknowledge the IRQ until it becomes inactive.
>
> The TRM also mandates that SGIs and PPIs follow the N-N model and that
> SPIs follow the 1-N model.
>
> However this is not currently the case with QEMU. I have locally (no
> minimal test case) seen e.g. uart interrupts being acknowledged twice
> before having been deactivated (expected: irqId on one CPU and 1023 on
> the other instead).

You might find there is enough in kvm-unit-tests GIC tests already to
build a test case for what you are seeing.

>
> I have narrowed the issue down to the following:
>
> 1) arm_gic_common_reset resets all irq_state[id] fields to 0. This means
> all IRQ will use the N-N model, and if s->revision !=3D REV_11MPCORE, then
> there's no way to set any interrupt to 1-N.
>
> If ""fixed"" locally with a hackjob, I still have the following trace:
>
> pl011_irq_state 534130.800 pid=3D2424 level=3D0x1
> gic_set_irq 2.900 pid=3D2424 irq=3D0x21 level=3D0x1 cpumask=3D0xff target=
=3D0xff
> gic_update_set_irq 3.300 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
> gic_update_set_irq 4.200 pid=3D2424 cpu=3D0x1 name=3Dirq level=3D0x1
> gic_acknowledge_irq 539.400 pid=3D2424 s=3Dcpu cpu=3D0x1 irq=3D0x21
> gic_update_set_irq 269.800 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
> gic_cpu_read 4.100 pid=3D2424 s=3Dcpu cpu=3D0x1 addr=3D0xc val=3D0x21
> gic_acknowledge_irq 15.600 pid=3D2424 s=3Dcpu cpu=3D0x0 irq=3D0x21
> gic_cpu_read 265.000 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0xc val=3D0x21
> pl011_write 1594.700 pid=3D2424 addr=3D0x44 value=3D0x50
> pl011_irq_state 2.000 pid=3D2424 level=3D0x0
> gic_set_irq 1.300 pid=3D2424 irq=3D0x21 level=3D0x0 cpumask=3D0xff target=
=3D0xff
> pl011_write 30.700 pid=3D2424 addr=3D0x38 value=3D0x0
> pl011_irq_state 1.200 pid=3D2424 level=3D0x0
> gic_cpu_write 110.600 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x10 val=3D0x21
> gic_cpu_write 193.400 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x1000 val=3D0x=
21
> pl011_irq_state 1169.500 pid=3D2424 level=3D0x0
>
> This is because:
>
> 2) gic_acknowledge_irq calls gic_clear_pending which uses
> GIC_DIST_CLEAR_PENDING but this usually has no effect on level-sensitive
> interrupts.
>
> With this often being a no-op (ie. assuming ispendr was not written to),
> any 1-n level-sensitive interrupt is still improperly pending on all the
> other cores.
>
> (Also, I don't really know how the qemu thread model works, there might
> be race conditions in the acknowledgment logic if gic_acknowledge_irq is
> called by multiple threads, too.)

All updates to the GIC internals should be protected by the BQL which
applies to all mmio emulated devices.

>
> Option used:
> -nographic -machine virt,virtualization=3Don,accel=3Dtcg,gic-version=3D2 =
-cpu cortex-a57 -smp 4 -m 1024
> -kernel whatever.elf -d unimp,guest_errors -semihosting-config enable,tar=
get=3Dnative
> -chardev stdio,id=3Duart -serial chardev:uart -monitor none
> -trace gic_update_set_irq -trace gic_acknowledge_irq -trace pl011_irq_sta=
te -trace pl011_write -trace gic_cpu_read -trace gic_cpu_write
> -trace gic_set_irq
>
> Commit used: dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d "Merge remote-
> tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' into
> staging"
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
>
> ** Tags: arm gic
>
> ** Description changed:
>
>   For a 1-N interrupt (any SPI on the GICv2), as mandated by the TRM, only
>   one CPU can acknowledge the IRQ until it becomes inactive.
>=20=20=20
>   The TRM also mandates that SGIs and PPIs follow the N-N model and that
>   SPIs follow the 1-N model.
>=20=20=20
>   However this is not currently the case with QEMU. I have locally (no
>   minimal test case) seen e.g. uart interrupts being acknowledged twice
>   before having been deactivated (expected: irqId on one CPU and 1023 on
>   the other instead).
>=20=20=20
>   I have narrowed the issue down to the following:
>=20=20=20
>   1) arm_gic_common_reset resets all irq_state[id] fields to 0. This means
>   all IRQ will use the N-N model, and if s->revision !=3D REV_11MPCORE, t=
hen
>   there's no way to set any interrupt to 1-N.
>=20=20=20
>   **If fixed locally** with a hackjob, I still have the following trace:
>=20=20=20
>   pl011_irq_state 534130.800 pid=3D2424 level=3D0x1
>   gic_set_irq 2.900 pid=3D2424 irq=3D0x21 level=3D0x1 cpumask=3D0xff targ=
et=3D0xff
>   gic_update_set_irq 3.300 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
>   gic_update_set_irq 4.200 pid=3D2424 cpu=3D0x1 name=3Dirq level=3D0x1
>   gic_acknowledge_irq 539.400 pid=3D2424 s=3Dcpu cpu=3D0x1 irq=3D0x21
>   gic_update_set_irq 269.800 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
>   gic_cpu_read 4.100 pid=3D2424 s=3Dcpu cpu=3D0x1 addr=3D0xc val=3D0x21
>   gic_acknowledge_irq 15.600 pid=3D2424 s=3Dcpu cpu=3D0x0 irq=3D0x21
>   gic_cpu_read 265.000 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0xc val=3D0x21
>   pl011_write 1594.700 pid=3D2424 addr=3D0x44 value=3D0x50
>   pl011_irq_state 2.000 pid=3D2424 level=3D0x0
>   gic_set_irq 1.300 pid=3D2424 irq=3D0x21 level=3D0x0 cpumask=3D0xff targ=
et=3D0xff
>   pl011_write 30.700 pid=3D2424 addr=3D0x38 value=3D0x0
>   pl011_irq_state 1.200 pid=3D2424 level=3D0x0
>   gic_cpu_write 110.600 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x10 val=3D0x=
21
>   gic_cpu_write 193.400 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x1000 val=3D=
0x21
>   pl011_irq_state 1169.500 pid=3D2424 level=3D0x0
>=20=20=20
>   This is because:
>=20=20=20
>   2) gic_acknowledge_irq calls gic_clear_pending which uses
>   GIC_DIST_CLEAR_PENDING but this usually has no effect on level-sensitive
>   interrupts.
>=20=20=20
>   With this often being a no-op (ie. assuming ispendr was not written to),
>   any 1-n level-sensitive interrupt is still improperly pending on all the
>   other cores.
>=20=20=20
>   (Also, I don't really know how the qemu thread model works, there might
>   be race conditions in the acknowledgment logic if gic_acknowledge_irq is
>   called by multiple threads, too.)
> +=20
> + Option used:
> + -nographic -machine virt,virtualization=3Don,accel=3Dtcg,gic-version=3D=
2 -cpu cortex-a57 -smp 4 -m 1024
> + -kernel whatever.elf -d unimp,guest_errors -semihosting-config enable,t=
arget=3Dnative
> + -chardev stdio,id=3Duart -serial chardev:uart -monitor none
> + -trace gic_update_set_irq -trace gic_acknowledge_irq -trace pl011_irq_s=
tate -trace pl011_write -trace gic_cpu_read -trace gic_cpu_write
> + -trace gic_set_irq
> +=20
> + Commit used: dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d "Merge remote-
> + tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' into
> + staging"
>
> ** Description changed:
>
>   For a 1-N interrupt (any SPI on the GICv2), as mandated by the TRM, only
>   one CPU can acknowledge the IRQ until it becomes inactive.
>=20=20=20
>   The TRM also mandates that SGIs and PPIs follow the N-N model and that
>   SPIs follow the 1-N model.
>=20=20=20
>   However this is not currently the case with QEMU. I have locally (no
>   minimal test case) seen e.g. uart interrupts being acknowledged twice
>   before having been deactivated (expected: irqId on one CPU and 1023 on
>   the other instead).
>=20=20=20
>   I have narrowed the issue down to the following:
>=20=20=20
>   1) arm_gic_common_reset resets all irq_state[id] fields to 0. This means
>   all IRQ will use the N-N model, and if s->revision !=3D REV_11MPCORE, t=
hen
>   there's no way to set any interrupt to 1-N.
>=20=20=20
> - **If fixed locally** with a hackjob, I still have the following trace:
> + If ""fixed"" locally with a hackjob, I still have the following trace:
>=20=20=20
>   pl011_irq_state 534130.800 pid=3D2424 level=3D0x1
>   gic_set_irq 2.900 pid=3D2424 irq=3D0x21 level=3D0x1 cpumask=3D0xff targ=
et=3D0xff
>   gic_update_set_irq 3.300 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
>   gic_update_set_irq 4.200 pid=3D2424 cpu=3D0x1 name=3Dirq level=3D0x1
>   gic_acknowledge_irq 539.400 pid=3D2424 s=3Dcpu cpu=3D0x1 irq=3D0x21
>   gic_update_set_irq 269.800 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
>   gic_cpu_read 4.100 pid=3D2424 s=3Dcpu cpu=3D0x1 addr=3D0xc val=3D0x21
>   gic_acknowledge_irq 15.600 pid=3D2424 s=3Dcpu cpu=3D0x0 irq=3D0x21
>   gic_cpu_read 265.000 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0xc val=3D0x21
>   pl011_write 1594.700 pid=3D2424 addr=3D0x44 value=3D0x50
>   pl011_irq_state 2.000 pid=3D2424 level=3D0x0
>   gic_set_irq 1.300 pid=3D2424 irq=3D0x21 level=3D0x0 cpumask=3D0xff targ=
et=3D0xff
>   pl011_write 30.700 pid=3D2424 addr=3D0x38 value=3D0x0
>   pl011_irq_state 1.200 pid=3D2424 level=3D0x0
>   gic_cpu_write 110.600 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x10 val=3D0x=
21
>   gic_cpu_write 193.400 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x1000 val=3D=
0x21
>   pl011_irq_state 1169.500 pid=3D2424 level=3D0x0
>=20=20=20
>   This is because:
>=20=20=20
>   2) gic_acknowledge_irq calls gic_clear_pending which uses
>   GIC_DIST_CLEAR_PENDING but this usually has no effect on level-sensitive
>   interrupts.
>=20=20=20
>   With this often being a no-op (ie. assuming ispendr was not written to),
>   any 1-n level-sensitive interrupt is still improperly pending on all the
>   other cores.
>=20=20=20
>   (Also, I don't really know how the qemu thread model works, there might
>   be race conditions in the acknowledgment logic if gic_acknowledge_irq is
>   called by multiple threads, too.)
>=20=20=20
>   Option used:
>   -nographic -machine virt,virtualization=3Don,accel=3Dtcg,gic-version=3D=
2 -cpu cortex-a57 -smp 4 -m 1024
>   -kernel whatever.elf -d unimp,guest_errors -semihosting-config enable,t=
arget=3Dnative
>   -chardev stdio,id=3Duart -serial chardev:uart -monitor none
>   -trace gic_update_set_irq -trace gic_acknowledge_irq -trace pl011_irq_s=
tate -trace pl011_write -trace gic_cpu_read -trace gic_cpu_write
>   -trace gic_set_irq
>=20=20=20
>   Commit used: dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d "Merge remote-
>   tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' into
>   staging"


--=20
Alex Benn=C3=A9e

