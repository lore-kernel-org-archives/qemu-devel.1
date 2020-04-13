Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00522C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 13:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5452073E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 13:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jNuXjJ5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5452073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNzM7-0001oO-Mg
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 09:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jNzEv-0000Lp-G5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 09:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jNzEu-0005h5-Al
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 09:35:05 -0400
Received: from mout.web.de ([212.227.15.14]:50613)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jNzEt-0005gN-Uo
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 09:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586784884;
 bh=6Dz7vt/XYDiHRdeNO5sVTTQk8elRnnC7Lfqid7JrTQw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jNuXjJ5amdj+l6bAGCTatJ2Oh9KPD4t9fPFw4g3x0NrHwDHSa7jkmbVk+QgEoaov9
 zMWf9wKoHF2AbPoPWfTnLdWx5MLnCTf3Xh99705K7YLgX+7Imnrx5WTQZXbP8bt7uW
 t/q+14KO2H55oGqUBhF3aWuq9EGTo4UBoV/jHAY8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.48]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3gLx-1j6jUw48mX-00rELy; Mon, 13
 Apr 2020 15:34:44 +0200
Date: Mon, 13 Apr 2020 15:34:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: <qemu-devel@nongnu.org>
Subject: Re: colo: qemu 4.2.0 vs. qemu 5.0.0-rc2 performance regression
Message-ID: <20200413153432.224e46b6@luklap>
In-Reply-To: <20200411191655.0365532d@luklap>
References: <20200411191655.0365532d@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/H2h0iHQoMXXnrPUoCtN==M2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:eDwC6OQRQc3rckhSomsI/dl/iU9k9Rolo59uOmdInPtD+GeG/nP
 OwEXKs/33TCqU8Xs6X3RbSh4QaLwk8qKx8AS/Y7THG75OfQzlaOyXu2ASalD6GXw+SRtQ+V
 buqfNh7CsGxeqpC+ekspZw/J9Nbzaefg5IUJL9FSstFHdIUsFBjTRfFne+dS5rDbDdNookU
 OFO8uQhkaEKCAF0lUEE9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JLT20WH9H2o=:rg/dBF1NzIISwpdWd5NaOn
 dXV6Gq4x7c+mplgn4DyCqKWvzJ6oASpBcq1Dxp+EJgHttDhPEAps+ViAZR6eLtl766T9PPwcN
 zN8ufPZ8HHr8bS44GiSoYghEipMAUDbQylx08D5PjIaUjrXG0roNDyu71d7lLuUa3OwzZ/HEN
 61SGbq4sj9cvciZef9mSuxPBf00N3Yki9otiJCw+l/Ywrp16/mpqo5AJw8dXmFDvvTYs6Niri
 KwqRmj9MSaXfqBRHw0JYWjIB+hBrZVC/JSugItnE1An5xpYEGj6HAD8gxAtjtNPgyqdVm9kr3
 0T6WHLelkZaOLxpkez7/fh4dfS8iRQotjl6BfkSPe8iUF0bK6O6R3oJMLei1c0gw9GzZg+/wq
 jGE7eB1iz0v20K7cOIhQU7zKCWCoLz0j7ZImGM1WrKoXrr2CTeQHNgppFJuhMtV1Ca4jZhRI+
 tQHf8y0pzYy/GXZ4EK/Hb5JiW7y+pdxivNl4wuyLS3sT0950ULbi7Lgb7gBkCjHVPfigo1VAR
 hCkCP+tSHbqA0X2DVAMtHidLZ6PJ73wvHZ2L0bsvVsakC90TGT/4HzTa3olEHEUWNoPsm70aB
 Y48pfjo7kgETAkCfYD9DObRmuWUsqUtFmKwRb1+RjSDM0yeBoiwyu1LFGQEvQO2P6s4x6DJ1C
 +Ry0eTw3TthOUa8hHv+YGT5emQB8cWCfpwTOZokOTuTln1DLUauENu0Bfoeulbffp4IKX52Ci
 xKPimPig0pnfWRy+RzyxJmFxl2wH9x+EXwhLwi9ufLX+w9yCIQRVaOrF/VOii54TttreZZbUg
 MBGE1gPN7kigZgU1LXbAGoo4gZ5bxZ6RGi/o3Qiy/9LBdNDtK2dCAfHm3YUB9IZyfw8NagEJ3
 kL75JwNdZB6zBTQmjGGV32Ucjpovz7Kl0Z3r8zNqzTDWHtbKZ2VKwd4vjM77es8lS576bmtsQ
 a+dvgly4lTDz5m4cNKzt58DVoIyQhDKTXqdyYObgT+ErGfdkkVhiuGk4gnQt8NqkpeiO/RXy+
 A5XW9tj5BiEHl42l6+i7GEHkICqCDZNcnFPF6xkXW2XMyB49EwHnjyCqFVTDijuXjshYV3T83
 Mhhk4e1aGJy4rwcQsaD0N4dPaDPiRXG1Ht1uQx2uzlLLeSj81DmLu7zHzXRnlz7wmdEEXWtun
 uMJTmOCuNK4PDoogfdHiuagHXPyraMzzkmnwFyptKrqyJGuEEXCT0qV/6b9C4Kno4p1rkB56e
 9hJo6QnTj2wsU7bHz
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/H2h0iHQoMXXnrPUoCtN==M2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2020 19:16:54 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> I did some Benchmarking with iperf3 and memtester (to dirty some guest me=
mory)
> of colo performance in qemu 4.2.0 and in qemu 5.0.0-rc2
> with my bugfixes on top.( https://lists.nongnu.org/archive/html/qemu-deve=
l/2020-04/msg01432.html )
>=20
> I have taken the average over 4 runs.
> Client-to-server tcp bandwidth rose slightly from ~83.98 Mbit/s to ~89.40=
 Mbits.
> Server-to-client tcp bandwidth fell from ~9.73 Mbit/s to ~1.79 Mbit/s.
> Client-to-server udp bandwidth stayed the same at 1.05 Mbit/s
> and jitter rose from ~5.12 ms to ~10.77 ms.
> Server-to-client udp bandwidth fell from ~380.5 Kbit/s to ~33.6 Kbit/s
> and jitter rose from ~41.74 ms to ~83976.15 ms (!).
>=20
> I haven't looked closely into it, but i think
> 0393031a16735835a441b6d6e0495a1bd14adb90 "COLO: Optimize memory back-up p=
rocess"
> is the culprint as it reduces vm downtime for the checkpoints but increas=
es
> the overall checkpoint time and we can only release miscompared primary p=
ackets
> after the checkpoint is completely finished.
>=20
> Another thing that I noticed: With 4.2.0, the secondary qemu uses thrice
> the amount of gest memory. With 5.0.0-rc2 it's just double the amount of
> guest memory. So maybe the ram cache isn't working properly?
>=20
> Regards,
> Lukas Straub

Hmm,
I looked at my test again and saw that the results where very noisy, so qem=
u 5.0.0-rc2
being slower was just a coincidence. I did increase the test time and the r=
esults are=20
more meaningful now. Now qemu 5.0.0-rc2 is around the same speed and still =
faster
in the client-to-server tcp case.

Sorry for the noise.

Regards,
Lukas Straub

--Sig_/H2h0iHQoMXXnrPUoCtN==M2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6UamgACgkQNasLKJxd
sljJJQ//fai9NN4Tj+0G5yA0tUUQ1TuaQEUT49jhSwVhtHFPD8M4b12NvagmY4xu
PsmbsYp1Tc823FKdcNbvGcImwKgXJSh4Kkkoq0IH6cQmYDDzqDiekJCl1Ynkw0zt
zfab6qTCOsVjVaPsx52/8ni4/AzWB0PeJkaMhbYJAotUomWa3D+KmOKidtuKzu5d
lL6ZSU6R5cZV2UtVLYmZ9icAoLc4pSwJX7OcIG1Yv9WktJpPth6T1uWLdfnnSgAy
Kjw5HpdOr+87Z/MSe2QXvxnBaTRlnB6r/5Z31OPuH7UN4pq32bhYfUiieT8CWL3U
SuZK/DZN7WNC1vsA7Q0SZmJxBAUPXzJ9q/y4E91aa6YmLQIrXiLRSUCXjj6SLcX6
rjJ8coWi52d4GFAGwq2S7xeExsOQQLFwDcbmXUV8pEvPt8qogCK0BaZAqmCbKUP9
mgXLp7t9roSHt9TWlr90XaGTuT7O3ZudEFN2gUVgzUyLAU8PYqlceM3RVHVDcJ6e
zlGsa3YXS87QwXHPFNO4FWh14+i0PlVbSpxNQdcQOJxWzL3EocwflcZi23Z6KnTV
+ZUQPXhySmuyI9vGw1XnH+ts9/qMZygxYMfiMq4SPPyV0SWe5HnigBtXI2NTHp+M
nquA/0U1BE7VmiNfCxIqtShBkr2LZDm2zCaxYMYVfVvHuFlUMig=
=JKPp
-----END PGP SIGNATURE-----

--Sig_/H2h0iHQoMXXnrPUoCtN==M2--

