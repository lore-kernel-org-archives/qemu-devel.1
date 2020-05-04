Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9483CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB1020721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="se7VE3br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB1020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbcZ-0002OP-9K
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVbXg-000098-9Z; Mon, 04 May 2020 09:53:56 -0400
Received: from mout.web.de ([212.227.15.14]:54939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVbXf-0004xo-1O; Mon, 04 May 2020 09:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588600432;
 bh=cjcvMI4USjrbP7LyoIsomUKUaoIowIzzBNKmAbHUITw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=se7VE3brAhak7pI/3FXxZ9ACucgZ3BUOIe4WqIkyWVwoVxe5A7zj5muySN/SDxfX9
 zfJJrHGoaAuZjbVIblCjA4uriB6+DX4K1vv/CYVIftUkXKylVP+HauW88uChmUtR41
 UYNXLgdUC7ELRqORZY5rjjjBiJhc1ReLk8VnOPV4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5lnT-1j42rT0DJj-017DRh; Mon, 04
 May 2020 15:53:52 +0200
Date: Mon, 4 May 2020 15:53:43 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Ramesh B <rmsh.b4@gmail.com>
Subject: Re: [Query] VM CPU scheduling
Message-ID: <20200504155343.69c94423@luklap>
In-Reply-To: <CAJvkk904hhJ0q54KAkYE-azEmg5gkt_-HVSyLnACKsV9=TmzQg@mail.gmail.com>
References: <CAJvkk904hhJ0q54KAkYE-azEmg5gkt_-HVSyLnACKsV9=TmzQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W.Qwx4dw6WvMshy5d84+F5M";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:7tQbeFvVnkOVgOIoK63zNKyZmE9YmbKdIFNIglltEDtR9E2jZ1u
 iPbuaxseHyhAV+lxZiYr2kgm37aaiT+/e3R1wwkfhUEQMPWWI4R8DUt7BwX2u2Pvri3Ld+4
 vvZgOe6KuEgLH/E6ForeyxVTKydY/eH1jk120Pj4udSDluqpGQXWQwKeBNbzTMvzoNpXmQ1
 MkgxHM/czB3sWbLaYXXGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGhsA98opII=:oO6IRmftnNTb2zMk+oDPLN
 ptnY5CHz2AMiKN95db8ragzjcDftre42fJk90wEqmwPT0tsKtuX0lULLYZb94cX5I3nAFNHTa
 uasnfEOhIrhcKbk7sD2git9QPND9hIhVJsQmKQ95daIN/CMXPnX/l1um/iacfaQDC3r6UbJA6
 Iz+ustAHxwMwAE/nZ+g610Lmk0K+bGbvPfB2o6DvYuEqsg8bc4+4F3zeZ/Wh6a7OGLr5pjaVG
 ynBxHroyOFlSDwJoqeJjpkLeYywUljYyUu6ES4AXxjOCARQKLntYjHIaqq5XMbLtj4wg6BEkZ
 PisTuuFuBU3Jx7F5jFGmpEbYZ2DntXueud2EsIfpHtV+fE7BY//btoZ9CWLRsjJLW2g7ckL4F
 1fkKv4MfHGLYYrKl6ZkeVKIBKU7WDClkyGvthqaMfKB9m1U/2DzCC8xBu0ZLCNpoTg9X1F2P2
 dxd439s6ge11wu/uF+fjc55OsvZnywyDiE/GXBqbaruxPjJseV83MhzqdEgFRKHk7jOHtxGJo
 FpzXpmuJJr9W6K3nWsO0/mEVBbtmbgFQa5QmhdpcACDbFEMv/4oVa8KjAdC/6nN8J9BIEkjKO
 +BbYnYXKxAPprlCNunn/xwlfeCjQs9OYATcAhcAsfhtyhJX2V23MRaEgxIF4esniPhZRWDiTm
 YePCjbGXUEMW40JHGWsLsNZ/W6uCk4xlc3VC1s+WuTjqFzc2lf34YqZwZAbEAdG/+/fS4+/p6
 QoqS6fkmyB05/WiJmQSnj0pVdb1OfxI+ukBgObAbEzbo/U7QkpNo+CFuGxAWuQVnNhqG1y/jp
 0Dm//UB4C6efmqE8lESX+fkcyzvS6CI7ks0YJ2caNkTmPTPwPgVFl8TtMbq1OImGqf5h+FntV
 dg2BYD5RUV+VRWxAYk02B44RWUm9E3D9qfyNWNxaHitJLJrvNRT0NyX2ze7MzQwmeK4bCW+6Z
 vqzAIjIN5cm5+3ythniNVw3M01u4Hng1DDlW0YFAKBMr4QP1wHzFPxDkUc4u2zBCf2rAV0LLb
 LojFRnDeZNnMKbdqGpjnalpSfdopCK0qiamn8U8sC4EDmqFTmnlWiEs7xmQKbtFtL0y62X0DF
 1UP4QpLb5jg8y3KkaHHCIm3feFHxBerkGrj5bDaQf2xwc/gaH2z2cl/rwgDy5XqKIJRV8boNH
 cGiB+m7lNJ9absuufLnQic84sWI/wVqizqBtuM4FEamDPUEzUQGDcMA4WbmCc5OfqE2lMUVOr
 uXnGRV/MFx09+j302
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 09:53:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/W.Qwx4dw6WvMshy5d84+F5M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 3 May 2020 17:04:10 +0530
Ramesh B <rmsh.b4@gmail.com> wrote:

> Hi All,
>=20
> I started recently using QEMU for OS virtualization.
> Want to know/understand about scheduling.
>=20
> Environment:
> Host OS: Ubuntu 18.4 + KVM enable
> QEMU: 4.2
> Workstation/Desktop: x86_64
>=20
> Would like to understand,
>=20
> 1. How CPU scheduling works.
> 2. Tools/commands to monitor.
> 3. Tuning parameter/API
>=20
> Could you please suggest good reference or books or pointers.
>=20
> Thanks,
> Babu

Hi,
With qemu/KVM the VM just runs as a normal process under linux, so you can =
use all the tools and interfaces to manage processes for qemu as well.
Keywords: top, nice, cgroups, cpuset, numactl

Regards,
Lukas Straub

--Sig_/W.Qwx4dw6WvMshy5d84+F5M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6wHmcACgkQNasLKJxd
slhAgBAAifeX5Wdy1W2jNO1GCnH7te39y7cIf7uCH6XRnbhTY3n075dCSsR1eKLF
TDJvB+5LbWqsqS/z6x/r6+jsKRM8fmvPSAsH8N28vbcRN/VG1STMSOHL8GRk/13s
kEVHq7SB61gHR6pNj7pNvWXzdLeYnO9PQDdn5bUWcA9QFLPeax8DpLqxWp+7CG5q
UckhwPN1jVguvULSwnqbIVGnE/Z7DH+4VwfaCmW59vR1xvEJrAJlLdK51KGtYNcH
jovAIdMfp+UsYUb0SZh1JlVOH/vI0/9TjV90bw6OrXv9ahzFin528jNXYdnQoZ7C
pm5MuvE6eO+fyoq4lxrJUZVOIZJPIIemLUjDQiVTmq63rDzGyy80Bdyu6Rt+T9FZ
sgunRe2ZlVsjLZ/X+3GEaoGIhHr/sHre737P9ryC7zFEDxQgqU4DkIv2GbRuvLDK
9m9ebnIS80XEx+E2HId05cd8XQfVHo0+6rThGwv4IRxcXpi8OjG50rzBiobfBiHS
lcaHlL7rV+iz37sq9n0S3YbKtf+w8IQ2MjgD1yTqrm4hhfQ8agK2VBj2VfeNA+AK
sxXQBoRUj8oF8ZtYScYl7yVoUBg2HdDcuC8WJaxXBADeWpL0Shp3bFarbCZjmUEm
GAqcQAPRQCcY34vWCAh4Yvi+xxYTqGT/Ah4tb59tjSgS712/C98=
=ORlJ
-----END PGP SIGNATURE-----

--Sig_/W.Qwx4dw6WvMshy5d84+F5M--

