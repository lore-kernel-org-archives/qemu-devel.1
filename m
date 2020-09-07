Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51659C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892B62078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNKqfe0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892B62078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJ3s-0003Y1-In
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFJ2u-0002P2-UX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:27:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFJ2s-0007A2-U1
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:27:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so14731751wmj.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+SEjsQ1ZKI1Le1enhl+Fr5icxpVJ1KdQn6dqzD47ekg=;
 b=BNKqfe0Z8ujzTQXvhkm78ILQB9sjIsMq9x+dJN59ew56367PJ6pxiyecEcf2TueczR
 9lI5EP6NuXLRNxdqqJ/SgrRbh3ZKR6/taemk8wdkFK+WRS01oTLTsaYUfVrnkVgskOVS
 K7smXydhKG7Pc7AH76TeNyma7t5fjx3qW96cT+R/XDXZu70pGhIGEyXWtOb7V9UjeqmL
 Txv6Q4OzgReuH8hRAiiVtTS4EPk3l2OLQqLo3qyMpoy4GqikalBLUMQFrU89Ys7y91e9
 1e3x0ZYj3CmnEo+eZYTeFaJ/zKQKjOPEPCARHOAtiniGfrfUlqqAJm7HSEf3wrUGggWz
 tbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+SEjsQ1ZKI1Le1enhl+Fr5icxpVJ1KdQn6dqzD47ekg=;
 b=Id0aYjmxn3IXl+FhXuF9IcYwWPxTjl2bfOBjjUnzLqolTH8IEvHOJ9JIIKYoYfAEsM
 5Nnz2wCm9I2wYbuCyX/7rPcfrSZVLP3dAYyzFGXhaSPT2CsRmLBYRzuY8sY0td4Ttutw
 5VTDZyVI0O6NT6ccVOBo2fB/rEXkV0neY/qs4/o+w4oCkEP/AdmlrxKviAjig3bCgWb+
 1cOfrahX3zGtJkowrvB5QYUuzfsCbFyg6Dm+Df9e7pzN1GgTqVeXur/Z9IjQccayVgFr
 7kwWeX3t5g/V7eW1ZdLKZgVO4hnBDF7Ql6TsJoFNWUUcDo93sJvoK5wV3oko7zZBC43R
 cdlA==
X-Gm-Message-State: AOAM532He4kEhTePrlmJGCxM1lIKpuC3hXSpwDc35OOrBaD2qzseyNvK
 sHitRxsKCtY3eix8dniSDff3cQ==
X-Google-Smtp-Source: ABdhPJwna3nglsJ5RDKVKmY5fpl2glX8tbdfJ4Mfke/ploe1RE83j4GZsP8T09cha/ZFxqwifzohag==
X-Received: by 2002:a1c:e917:: with SMTP id q23mr20587248wmc.125.1599492421250; 
 Mon, 07 Sep 2020 08:27:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm29246936wrm.57.2020.09.07.08.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 08:27:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 796E11FF7E;
 Mon,  7 Sep 2020 16:26:59 +0100 (BST)
References: <159903454714.28509.7439453309116734374.stgit@pasha-ThinkPad-X280>
 <159903457617.28509.2649326029575134141.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH v3 05/15] iotests: update snapshot test for new output
 format
In-reply-to: <159903457617.28509.2649326029575134141.stgit@pasha-ThinkPad-X280>
Date: Mon, 07 Sep 2020 16:26:59 +0100
Message-ID: <87k0x5r4jg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
>
> This patch updates iotests that verify qemu monitor output.
> New output format for snapshot listing include ICOUNT column.

I was curious if the monitor should still function during replay. In my
setup:

  ./qemu-system-aarch64 -cpu cortex-a53 -display none -serial mon:stdio -ma=
chine virt -kernel zephyr.elf -net none -icount shift=3D6,align=3Doff,sleep=
=3Doff,rr=3Dreplay,rrfile=3Drecord.out -drive file=3Drecord.qcow2,if=3Dnone=
,snapshot,id=3Drr -s -S
  *** Booting Zephyr OS build zephyr-v2.3.0-1183-ge5628ad0faf3  ***
  Hello World! qemu_cortex_a53
  qemu-system-aarch64: Missing character write event in the replay log

although technically the C-a shouldn't be a character that ever makes it
to the guest.=20

>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  tests/qemu-iotests/267.out |   48 ++++++++++++++++++++++----------------=
------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
> index 215902b3ad..27471ffae8 100644
> --- a/tests/qemu-iotests/267.out
> +++ b/tests/qemu-iotests/267.out
> @@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
> @@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
>  Internal snapshots on overlay:
>  Snapshot list:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> -1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  Internal snapshots on backing file:
>=20=20
>  =3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=3D
> @@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more informati=
on
>  (qemu) savevm snap0
>  (qemu) info snapshots
>  List of snapshots present on all disks:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> ---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +--        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  (qemu) loadvm snap0
>  (qemu) quit
>=20=20
>  Internal snapshots on overlay:
>  Snapshot list:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> -1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  Internal snapshots on backing file:
>  Snapshot list:
> -ID        TAG                 VM SIZE                DATE       VM CLOCK
> -1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> +ID        TAG               VM SIZE                DATE     VM CLOCK    =
 ICOUNT
> +1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000=20=
=20=20=20=20=20=20=20=20=20=20
>  *** done


--=20
Alex Benn=C3=A9e

