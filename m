Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C5CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D82E20740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Efj3qIJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D82E20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZoZ-0005wl-P6
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYZnQ-0004sI-DS
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:38:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYZnO-0003Pb-GU
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:38:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id z72so15212959wmc.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uIxiGN9mXSYGxmBdjXw3pxY7SgUErzPsd8MDQrUyD5I=;
 b=Efj3qIJE5RL9S7oEQ0hR7sUXEsDumndx04AH5VgG7t22RFS5AJ1zBVUrs8rBmIH4OC
 GrHJU5oF1GOEKkSeTp9ewMEeZxLB2NtDXGgG1O9AMS4v9EPss6UB6epdovKThQBvNZbv
 EtK/gnvRshFoaB31mCflpodP1Bcz4qEdOe2YPR6Vb5PZCKzP/mFUk3U8ZOphrNqXHH3z
 GuX4vInkKxooJYVoLlG56ikPPl0MOxsahI0iejnsgRTpIgV5l/bf8G4eaHuXan9+TAnx
 pBX+bEz1hbGZMS+UY5mKjjzVOm4kO0xsZjoG9ZweiHeiRhlRsvVqRTKbWfZJyKI2KkmZ
 AADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uIxiGN9mXSYGxmBdjXw3pxY7SgUErzPsd8MDQrUyD5I=;
 b=ckZPDxRTT+XHfXVztxVOAqinKIInCdunYaYVnhNXuT1x8/cWUCoRFwrhpntQBiK/09
 lzxhWsoelUFnFHCcublsF7cK9EvzYLHi+wbKlEj4MdEeQY28LvI5n/tGGdvlao+DYHav
 Br75FbKObzZ48XtDX16c2WIvTUkH6+pb0f4NmaWOqRmyeztq/n7qliBevrbP4XK4WeAm
 qCauV5imsWu+30PSS5W5SrQaZZVtf5yNvZKyvacryf1teZi1x1R29x6mFzqDawWZbfJ4
 KLQHL0bEb+Cc5ANtIy10kFXIqr85IcReWW4fW1Khc1IKhqHFyvPc6u6xDI1ds1s7+HTq
 JNlQ==
X-Gm-Message-State: AGi0PuZm97y+DkZheTaYRnxSw9LIwY58LsANDfhWt/bEwHDb5OwodCMc
 efjRrdpjcL/BQZiOrPIO6viJ8Q==
X-Google-Smtp-Source: APiQypKljemAaKbxoOpo8YvD612QSVpf7piftnMfiAlbBc8MsL2JAPJ9zkFeSnnjIR/IgvtVq1fU8w==
X-Received: by 2002:a05:600c:1:: with SMTP id
 g1mr37888087wmc.142.1589308704880; 
 Tue, 12 May 2020 11:38:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q9sm8615865wmb.34.2020.05.12.11.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 11:38:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5D4D1FF7E;
 Tue, 12 May 2020 19:38:22 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-75-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
In-reply-to: <20200326193156.4322-75-robert.foley@linaro.org>
Date: Tue, 12 May 2020 19:38:22 +0100
Message-ID: <878shxf17l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> This yields sizable scalability improvements, as the below results show.
>
> Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)
>
> Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
> "make -j N", where N is the number of cores in the guest.
>
<snip>

So my numbers running a aarch64 guest running pigz with an x86_64 host
the gains start to tail off past -smp 12 but still seem to be showing
some gain up to -smp 16 (the host has 24 cores):

  ./aarch64-softmmu/qemu-system-aarch64 -machine virt,graphics=3Don,gic-ver=
sion=3D3,virtualization=3Don -cpu cortex-a53 -serial mon:stdio -nic user,mo=
del=3Dvirtio-net-pci,hostfwd=3Dtcp::2222-:22 -device virtio-scsi-pci -devic=
e scsi-hd,drive=3Dhd0 -blockdev driver=3Draw,node-name=3Dhd0,discard=3Dunma=
p,file.driver=3Dhost_device,file.filename=3D/dev/zvol/hackpool-0/debian-bus=
ter-arm64 -kernel ../../../linux.git/builds/arm64.nopreempt/arch/arm64/boot=
/Image -append "console=3DttyAMA0 root=3D/dev/sda2 systemd.unit=3Dbenchmark=
-pigz.service" -display none -m 4096 -snapshot -smp $SMP

  | Command                     | Mean [s]         |    Min...Max [s] |
  |-----------------------------+------------------+------------------|
  | =3D$QEMU $QEMU_ARGS  -smp 4=3D  | 146.738 =C2=B1 62.272 | 43.861...246.=
139 |
  | =3D$QEMU $QEMU_ARGS  -smp 5=3D  | 33.984 =C2=B1 13.370  |  29.501...72.=
032 |
  | =3D$QEMU $QEMU_ARGS  -smp 6=3D  | 26.128 =C2=B1 0.189   |  25.837...26.=
475 |
  | =3D$QEMU $QEMU_ARGS  -smp 7=3D  | 23.459 =C2=B1 0.090   |  23.252...23.=
560 |
  | =3D$QEMU $QEMU_ARGS  -smp 8=3D  | 21.579 =C2=B1 0.117   |  21.418...21.=
764 |
  | =3D$QEMU $QEMU_ARGS  -smp 9=3D  | 20.163 =C2=B1 0.142   |  19.938...20.=
387 |
  | =3D$QEMU $QEMU_ARGS  -smp 10=3D | 19.028 =C2=B1 0.106   |  18.877...19.=
183 |
  | =3D$QEMU $QEMU_ARGS  -smp 11=3D | 18.166 =C2=B1 0.093   |  18.081...18.=
386 |
  | =3D$QEMU $QEMU_ARGS  -smp 12=3D | 17.464 =C2=B1 0.067   |  17.383...17.=
614 |
  | =3D$QEMU $QEMU_ARGS  -smp 13=3D | 16.928 =C2=B1 0.104   |  16.754...17.=
158 |
  | =3D$QEMU $QEMU_ARGS  -smp 14=3D | 16.615 =C2=B1 0.188   |  16.486...17.=
105 |
  | =3D$QEMU $QEMU_ARGS  -smp 15=3D | 16.344 =C2=B1 0.176   |  16.094...16.=
680 |
  | =3D$QEMU $QEMU_ARGS  -smp 16=3D | 16.085 =C2=B1 0.215   |  15.869...16.=
623 |

--=20
Alex Benn=C3=A9e

