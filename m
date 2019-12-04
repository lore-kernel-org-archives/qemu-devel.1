Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFFC2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4782F20661
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQCAsSDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4782F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icT9q-0001wy-E8
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 06:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1icRUM-0008BJ-Nm
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1icRUA-0004fJ-Sz
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:02:22 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1icRU8-0004Lz-RB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 05:02:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id y23so4446656wma.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 02:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=sJcDA8Mb9A5K8UCPt4+UsrvBo+pWiwJcG2V9zjVJwH8=;
 b=OQCAsSDAcKjwHCc/+FdEAXgJSOJm0JWrsbolJVW0KQQab8+aSYtmzGvffSoit5TYad
 E3uhHSC2n1ybey8BxPDUJsJOQRQAGHaK701IYjIpRM540VLqBjTFhvXSOSu/G9GMvYha
 Ztv/6rKPVMzrW2vYg1W1L6RaAUhSzROBZl/Kg+EquygcveSB4UPABSWJLYXVtHfctitZ
 KxZUmp2M2/chhd/zYwe0namAtf2Zq4uXaJTKX3A0lzhOSyhORRyT5b1ov/McyN4glgGr
 XM2G4EwyEwlL6xDqbEtL6ghRMZt3P5yhuc9rIt8PVC92w1gpQVxJf0N3T9Cwu9MsLFIy
 q/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=sJcDA8Mb9A5K8UCPt4+UsrvBo+pWiwJcG2V9zjVJwH8=;
 b=mpu9ZKf00hTRW5kCtI9UaoE6tC6byHzSQgImwxdqQxK+2yrhHKuSVSQV19BpJyU3xl
 qj5O4Pqa8/BqlLd5GjLXuSLPcBLNo2PDtWYAj3KxqRMfH1DC4arGMGrIIkof+8zv0O/X
 6wQKdTwEA/RI5LlrxeYEbNdLRdCPHKDNaR6IMox0IAehbVFxTWBshwk53pP7fTLmAseY
 F6i//TYOE0AvKbkVUB4htFIU1EVVvAl6iBkc6HRzN3yZZBIv17dMgu5eXxNTnDlmhHea
 hFFGrzlfCIbgTLVpYNJnMv26JXrJzxxrEv1oTPrDapDMxRoGY1YJFZ+653x1H7Q/nKwT
 Mplg==
X-Gm-Message-State: APjAAAWgzubf5MvqemWPnaSi+WBzLiLKMA7p9n2z9irCZznYzH7tywi7
 CpI6MSFI07EinEzodxQuQnkj2CXaE2SJC0GcDtU=
X-Google-Smtp-Source: APXvYqxA4pHVovhLWg6gyZBJadAASAJylU00UBt2M5jyiiMFgk6oqYy/pz+N3KoUYR9vWqh/a7zhnl5ulbbb467NSx4=
X-Received: by 2002:a1c:9d8d:: with SMTP id
 g135mr36179374wme.114.1575453731990; 
 Wed, 04 Dec 2019 02:02:11 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Dec 2019 14:02:00 +0400
Message-ID: <CAJ+F1CL8VZx-cJkuPj8=YfEWnnDj0F6JVVwfbThy4gtjZ7MAdA@mail.gmail.com>
Subject: [ANNOUNCE] libslirp 4.1.0 is now available
To: slirp@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

We are pleased to announce the availability of libslirp 4.1.0
release.

You can grab the tarball & read the changelog from the gitlab release page =
here:

    https://gitlab.freedesktop.org/slirp/libslirp/releases

Highlights include:

 * new slirp_new() API, more flexible than slirp_init()
 * various new options needed for slirp4netns
 * tcp_emu() is now disabled by default. tcp_emu() is known to have
caused several CVEs, and not useful today in most cases. The feature
can be still enabled by setting SlirpConfig.enable_emu to true.
 * bug fixes & cleanups

Once the library installed, you may compile QEMU >=3D 4.0 with
--enable-slirp=3Dsystem to link against it.

podman/slirp4netns should link with the system library soon
(https://github.com/rootless-containers/slirp4netns/pull/162)

Thank you to everyone involved!

--=20
Marc-Andr=C3=A9 Lureau

