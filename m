Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EEEC2BB55
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 17:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B522084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 17:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="M3HnFQ3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B522084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNJr9-0007Rr-Sq
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 13:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jNJl2-0006Es-NT
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jNJl1-0006XL-Ko
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:17:28 -0400
Received: from mout.web.de ([212.227.15.3]:40627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jNJl1-0006WK-8N
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586625425;
 bh=sE016N4D5fbAw5sSDXveWpV/27nNVD+Bl5ciikE1JZg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=M3HnFQ3KwOL3OR98nGMn6Di79idlVtRBJ4LAsvnof5JDdx55lThIkTStJVOVHT48T
 luHxhmVncXv4vRQLscq9xmabC6ZVf/r1IoAADX1PwIA9rdaT4O/vv/4O5wPn0Fan8x
 Y3bMaKHj6orebmjGxFNiy+cNonFE+bxy9Pu5o9W4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.63]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZUnl-1jhrqO1Mzt-00LGGT; Sat, 11
 Apr 2020 19:17:05 +0200
Date: Sat, 11 Apr 2020 19:16:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: <qemu-devel@nongnu.org>
Subject: colo: qemu 4.2.0 vs. qemu 5.0.0-rc2 performance regression
Message-ID: <20200411191655.0365532d@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kNUm4tzzF28.y7fHveUqrb2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:j0QpOyEwBz4ICEYzkS1XuQ02iZsCsxEzsP3ynUScGaJ2h3meHco
 FXbIFsT1S2KWhORrpFj1Q1bbSOGjgH5ZfxiA+BhUDpzcvo4V0Afek/TAuzEQ14VD5D2v18K
 BKtxKzjB3372rqcsJ8Yhn4tg6xP1fDwls79C2AHPUdH/aNs+p3G+lOOMjuPSLh0lAfmNPS2
 8MnrlOsxi6MZHjEqUaDcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6xGmQHqWWbA=:P0Po+B2ejnWG0riMQozWVK
 PGKrt9x8SdDo/HzxB5YiNFlV4oqX6yy0W40EQz84qzX2BL9CkVHInOhMaSZaxDzRHaZET9rce
 IZxJ6SBN4bIOVgAnHofQKs9O7oEap8qMef8Ju0sqMmjrbpr88xliQZ4iK0ZtONJvZ2MqUpoBd
 4Pof+ZUqZpVF1hQxjgvaXG06wTnCpeBu/xWK/MrHuvt+4Eo7Iy3nsHkgbZWmxTFvY4H2YrxxR
 Cg3hdGExsv+e+XCKLiR07xPDC+Nk15B6WJsqqrVX08WXhbF8+757a1Ww/I5TN3NsRoQ4xkBhl
 KPk+r1aauNg1ZRmqc+sSjjVpx9c+nb7gPoKo4BUDt5f715k5jE+eNpmSeYOL1S2jnvfC1PT16
 9duCX/YLVOnPj8LLPsB6Hr48QwpxQZM0cOkKZGnoJcEvlKWXM8Z9XBfVvWG9G71xvPhs5YQf6
 S4JhqPlQNMiOg+Mo6aIx4QU6Y1VD/6+ChktRRakQ2Yd0P+STQxlJkgL2gHdl75i1Q2nHvsl3r
 99CAejkPzuM/rdihNsqXj1wVhDMD+ZV4k41NOm6kfcNg1lDSSCWtqQNZQRwzYR4dzo/3iij4z
 VBaOpIODk/uJ4aMhFBO5miQlFTd/miDhg0q2P2Va5FStlLXMa8AzD9jBfmGgU7QurG/ocTiKX
 E0MB4odraMgdNfldV0rg1l32TdglruYmARTXN/th8oiOOLjLG215TI3SMzDL+n/xbsDQuTqGk
 CjyRq4Mqitwtb7Caf01UfXBDl2ayNHF9G2f4LhJQLpcfnTJcsUxfpRhwTSUGPvbh6IO0loFxk
 vv/ZbUNjiiiog2jjmUqG/D4V7fIlROotlnXySSR3jGhSTPMyPCTCJApmWbSwR/vF6RyhT5Mw0
 zuAUxFcCfhXEHqKRDzLnz+lX/FAs/mokdc5+6Arnl7lihXeRRDHyeOMczHQ0KQohR0kjak1fi
 UnERA/NnD06JEt091aHjK/wepacq+KSHlewuPEXFvUpFDuf/MP1MaNUciTdqpm9YWfb2L/qKa
 8qM7o4nT+5VE341y6tfIDhEUJC3inGCN3C/6keW8ayVL4KfT7k6h9HTr6mDx1BrRlsGhHeBqY
 I4gvm3M7Q0bQRGmV4pwkXeGg5bBCr8n5cadNe+tdggYj1RW4b5nPtaNruJj5UcK1AE/3vIeiy
 sYCpGIUTMC8ikSy5lrw9Sl809dPecPSXVERTKQv1LZWdHTGTqDjzg6VcSt0H/LTThQB7c0qMz
 RFMfV33FXYZ+0x8Gr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
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

--Sig_/kNUm4tzzF28.y7fHveUqrb2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
I did some Benchmarking with iperf3 and memtester (to dirty some guest memo=
ry)
of colo performance in qemu 4.2.0 and in qemu 5.0.0-rc2
with my bugfixes on top.( https://lists.nongnu.org/archive/html/qemu-devel/=
2020-04/msg01432.html )

I have taken the average over 4 runs.
Client-to-server tcp bandwidth rose slightly from ~83.98 Mbit/s to ~89.40 M=
bits.
Server-to-client tcp bandwidth fell from ~9.73 Mbit/s to ~1.79 Mbit/s.
Client-to-server udp bandwidth stayed the same at 1.05 Mbit/s
and jitter rose from ~5.12 ms to ~10.77 ms.
Server-to-client udp bandwidth fell from ~380.5 Kbit/s to ~33.6 Kbit/s
and jitter rose from ~41.74 ms to ~83976.15 ms (!).

I haven't looked closely into it, but i think
0393031a16735835a441b6d6e0495a1bd14adb90 "COLO: Optimize memory back-up pro=
cess"
is the culprint as it reduces vm downtime for the checkpoints but increases
the overall checkpoint time and we can only release miscompared primary pac=
kets
after the checkpoint is completely finished.

Another thing that I noticed: With 4.2.0, the secondary qemu uses thrice
the amount of gest memory. With 5.0.0-rc2 it's just double the amount of
guest memory. So maybe the ram cache isn't working properly?

Regards,
Lukas Straub

--Sig_/kNUm4tzzF28.y7fHveUqrb2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6R+4cACgkQNasLKJxd
slhezg//SYtpZl6DNMyxz0q4+U/hirm9CJJEFJSA0zRpQ0tfaRzXdaee2NUyScaF
xOLcVKXHu43V7xZT31TLd9xyN19Pd2vMAvT1cnLg8EkSd+ZdqLkVafKGXFACjCzB
A7BGw3yyAanyCfgd/7BbLdWdEzv4Xc5OuvTZVZ3/Fr+0Fef/xsWfC0ix6LaPYywM
kGHZMOfmEjPQq2opOS7n5I77TbsULu7bguqdJQ7Iq+dhBKHHX/Hog5xo+lI9ls9J
kVXj+RQe4hJkhUzK39QlUbFd8uuGTEkMK1oHXBIGncy4rgzzKUCD8FupcrnEBP99
UocG/IcISDhW5CTRirzwUWF4icmYA2GTkB+q+aHAQ7XYTP1IzInYpD/lBRrTkY7o
n9o/38NU/9hkp/SUDCWIIloAQ1Q2kfFciEGiJ68KLqwfDpNellMUFUSV+eA2e4Ih
DFQX7fRt+GFST3bHosZs6oee6Sd5cZpaxRTof7vBrZyzVNyhPH7OsO/uHtDk/o3d
60fCiDhlE31tK+Z9/DJNKLtGxfRJ0rmbXxeFefk7YJxinG4ilcSq2EbjK9glv20l
HBQ3DLV3lLgWkDqt98OU4KlPA+rehOQSZ5XL+BUDGHeI4ilopHAO8fo18HjOHGns
XASsXtctOMfbkAmmUPlwPArWmZxHKApVtNl1IQ73LhbTkjirhKc=
=kTAs
-----END PGP SIGNATURE-----

--Sig_/kNUm4tzzF28.y7fHveUqrb2--

