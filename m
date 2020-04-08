Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD70C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 19:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FE420768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 19:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XCm5VJ2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FE420768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMGJw-0004yA-NM
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 15:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jMGEE-00040W-IW
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jMGEC-0007aa-T0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:19:14 -0400
Received: from mout.web.de ([212.227.17.12]:35043)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jMGEC-0007Z4-F1
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586373532;
 bh=kdRy8fnQW8O4F2sLhcOj2Q3B+7e6NuKRikS0DcUZi3E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XCm5VJ2A6zGtlW1vUp0wE3kgKz2ztk1YvNsraBNFoZd3TF0jSlk2z8axhlSbuhA1D
 ujOehkW6Zb8JR3l8uixNzsJIWBuoVb7lPMBzrG3zOlKbr8/FZ7RrLcwvuqlDsB1wDk
 Opx1mOdINEVY7cgAtVqh4ijMpHBVf5yjzfcy0lRI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.62]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaCXK-1is7sI1bH4-00lz4F; Wed, 08
 Apr 2020 21:18:52 +0200
Date: Wed, 8 Apr 2020 21:18:42 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Message-ID: <20200408211842.2c0f1e4a@luklap>
In-Reply-To: <20200328124646.7778-3-dereksu@qnap.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-3-dereksu@qnap.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//IDWZ07+v.DEf0X4=ftKJ+Z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6+qUwJhJ2vcD3cVac+w3MeUOnmZZa63qmv0XNJpE9r1WTvNbWV9
 kFkt/1Hy9rEMD9TPBix+83LgAj4JvOX2k91lPzcm9StDHjuATNub7D+YiLhs1F852Xsn8qJ
 JotWbciDxWUXbRaM+WxOSaH0hVobYj/bJGIG3dKo6UGPKyHqhOSHSFbOvb+BUYHJBE6QtCm
 78lvKhwwStnhYkLmekmUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LtPni5CBinM=:lGpABcjoqZKHbmeO6wnClB
 mZuaoQ7ZQMlQagkNjdUCcmDaLL5eTkBR6aivMbVFr1WH/GfzelQl2rmhTAM3R9cnXONhd1lqY
 3iDKm4zCCB5v7j0AmXEfMhHCvv91SwFP+oTvjhmHxvmlturm/zIyX9TnTYCybbnYs/ANGNP5X
 2dWJQWn3LHUyYNsVrjG3NVjq+zs4dKicD5xZ7bj3VMQZPQF6r+i0qfNRFqnv3GFvKaHR2CbRv
 rtO7Z5wKlm7wKP1M8h6RxTS5obxsFs525wgydO0umOMBLsUzU3ez5YrWhXpl8DDLEGDxWxyKV
 pVSU2Wkblqa0bb4TKAc4d5DwMbbPPKNwqojchusYMdoVqSQ6Pe9bGFD+DleFsJ8id556qPokR
 kWSldOZWTPVbN+gm+B3WEP2LVj+BL81krvCm50f2TWfCHXV/9A5/WPuOYSqLo8tYhtviipOFI
 n4x6oL7hMtxKCoIxYX+WTS4cTpoD4obf98HF/P7V+3W9gSOoKkyjJT0FTYNl4nl+dgNMdQxvM
 +YoufXyRd8epzLBzkT+DMfHB2d17AI2andC8Dyw63T/Tl5FUYBExv08Hmzn3gWphM67eqIAU4
 j5BOQe4bb/c5yO3F3k2LNozVgTKZ8U1/z0nVolFraBuDynq3JkGBwFWg27SYUx66gyoZMoCl3
 EDKIYlRFGzfGXNG/AplpkWnpA7zi6pPnAEIeMEy/X8TF3Ohv0XQttF0dLftrdaAHX9mk6sweU
 N2VCXD+TBZybtYbzBSGbTNXgHFLuWnnUcwO3V67caqxEgtZ53WvVkH0Qo6CotEWnix0rL5wQb
 7ufGxL6xEE/NkF3/0zqnqFscMIG5xQ7ij3wTPKf7B2lLdsggU3/EDwjHo/7CzFKO+SWwnuIjC
 YEt9BhBPpdmPjT+UmBh8nEF0wV5S4xsG2HoaN1GAlqgMwlqL9TnqoKUrT6Mmn3FoCvGjtzgx6
 6lxDU9lX5Qz4ruoox0PcIBu/9/3E6OBm9Fx+7bm/SIHRdKnnFxnwMh1dQYttw27TydIS2hMNl
 OzDBWWTPgZ998s4zBw5JrJzKeMy7l9sEVLPTYcEqg7z0KkPXU3Vfu27Q6zIolYBNoj/H3wG8U
 oemG/45JBzREeMNYSQxyRaIMDL1RIE56MsvdSHyKL5JtMACyYxLoJ0dtUgxDjiE0ZqUgj+ugK
 Q2ObG7zj0NBpv6/SOyEpT5cynGMrjguaMShzCCU/fZZeYGneh1Y/SpR08CVhUPgE3RnruCDJ0
 XyUHkq3osHJf3WH/P
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, ctcheng@qnap.com, chen.zhang@intel.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_//IDWZ07+v.DEf0X4=ftKJ+Z
Content-Type: multipart/mixed; boundary="MP_/HK2Jk74KYAP+JrJ7uk2JIZx"

--MP_/HK2Jk74KYAP+JrJ7uk2JIZx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 28 Mar 2020 20:46:46 +0800
Derek Su <dereksu@qnap.com> wrote:

> The pervious handling of the full primary or queue is only dropping
> the packet. If there are lots of clients to the guest VM,
> the "drop" will lead to the lost of the networking connection
> until next checkpoint.
>=20
> To address the issue, this patch drops the packet firstly.
> Then, do checkpoint and flush packets.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>

Hello,
I had a look at this again and did some benchmarking.
First just qemu 5.0-rc1 with my bugfixes ( https://lists.nongnu.org/archive=
/html/qemu-devel/2020-04/msg01432.html )
Then qemu 5.0-rc1 with my bugfixes and this patch series.

This commit hurts performance too much:
Client-to-server bandwidth falls from ~45.9 Mbit/s to 22.9 Mbit/s.
Server-to-client bandwidth falls from ~6.3 Mbit/s to just ~674 Kbit/s.
Average latency rises from ~197ms to ~397ms.

Meanwhile the packet loss without this commit is negligible,
only 1-2 ping packets got lost during each test run.

Instead I think we should just turn the error message
into a trace so it doesn't flood the logs.

Regards,
Lukas Straub

--MP_/HK2Jk74KYAP+JrJ7uk2JIZx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=qemu-benchmark-summary.txt

5.0-rc1 with bugfixes:

*** iperf -c 192.168.178.65 ***

[  3] local 192.168.178.68 port 33418 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D53 tt=
l=3D64 time=3D2.57 ms
[ ID] Interval       Transfer     Bandwidth                                =
                             64 bytes from 192.168.178.65: icmp_seq=3D54 tt=
l=3D64 time=3D142 ms
[  3]  0.0-10.2 sec  60.1 MBytes  49.4 Mbits/sec                           =
                             64 bytes from 192.168.178.65: icmp_seq=3D55 tt=
l=3D64 time=3D2.64 ms

[  3] Sent 892 datagrams                                                   =
                             rtt min/avg/max/mdev =3D 1.920/235.514/1810.65=
3/411.394 ms, pipe 4

[  3] local 192.168.178.68 port 33420 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D55 tt=
l=3D64 time=3D24.3 ms
[ ID] Interval       Transfer     Bandwidth                                =
                             64 bytes from 192.168.178.65: icmp_seq=3D56 tt=
l=3D64 time=3D505 ms
[  3]  0.0-10.3 sec  51.0 MBytes  41.7 Mbits/sec                           =
                             64 bytes from 192.168.178.65: icmp_seq=3D57 tt=
l=3D64 time=3D11.7 ms

[  3] Sent 892 datagrams                                                   =
                             rtt min/avg/max/mdev =3D 1.962/218.713/1365.51=
0/344.164 ms, pipe 3

[  3] local 192.168.178.68 port 33422 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D54 tt=
l=3D64 time=3D49.2 ms
[ ID] Interval       Transfer     Bandwidth                                =
                             64 bytes from 192.168.178.65: icmp_seq=3D55 tt=
l=3D64 time=3D587 ms
[  3]  0.0-10.8 sec  60.1 MBytes  46.6 Mbits/sec                           =
                             64 bytes from 192.168.178.65: icmp_seq=3D56 tt=
l=3D64 time=3D167 ms

[  3] Sent 892 datagrams                                                   =
                             rtt min/avg/max/mdev =3D 1.573/276.375/1384.08=
5/362.027 ms, pipe 3


*** iperf -c 192.168.178.65 -d ***

[  4] local 192.168.178.68 port 33424 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D60 tt=
l=3D64 time=3D2.27 ms
[  5] local 192.168.178.68 port 5001 connected with 192.168.178.65 port 484=
40                           ^C
[ ID] Interval       Transfer     Bandwidth                                =
                             --- 192.168.178.65 ping statistics ---
[  4]  0.0-10.1 sec  60.8 MBytes  50.4 Mbits/sec                           =
                             60 packets transmitted, 59 received, 1.66667% =
packet loss, time 29595ms
[  5]  0.0-11.7 sec  11.2 MBytes  8.05 Mbits/sec                           =
                             rtt min/avg/max/mdev =3D 1.785/254.258/1352.91=
6/395.070 ms, pipe 3

[  5] local 192.168.178.68 port 33426 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D59 tt=
l=3D64 time=3D2.98 ms
[  4] local 192.168.178.68 port 5001 connected with 192.168.178.65 port 484=
42                           ^C
[ ID] Interval       Transfer     Bandwidth                                =
                             --- 192.168.178.65 ping statistics ---
[  5]  0.0-10.3 sec  58.6 MBytes  47.6 Mbits/sec                           =
                             59 packets transmitted, 59 received, 0% packet=
 loss, time 29088ms
[  4]  0.0-11.9 sec  13.8 MBytes  9.77 Mbits/sec                           =
                             rtt min/avg/max/mdev =3D 2.026/207.507/1518.01=
3/331.972 ms, pipe 4

[  5] local 192.168.178.68 port 33432 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D93 tt=
l=3D64 time=3D12.6 ms
[  4] local 192.168.178.68 port 5001 connected with 192.168.178.65 port 484=
46                           ^C
[ ID] Interval       Transfer     Bandwidth                                =
                             --- 192.168.178.65 ping statistics ---
[  5]  0.0-10.2 sec  59.4 MBytes  49.0 Mbits/sec                           =
                             93 packets transmitted, 92 received, 1.07527% =
packet loss, time 46137ms
[  4]  0.0-31.0 sec  4.41 MBytes  1.19 Mbits/sec                           =
                             rtt min/avg/max/mdev =3D 2.107/131.212/1405.67=
0/287.854 ms, pipe 3


5.0-rc1 with bugfixes and checkpoint on queue full:

*** iperf -c 192.168.178.65 ***

[  3] local 192.168.178.68 port 33402 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D52 tt=
l=3D64 time=3D1329 ms
[ ID] Interval       Transfer     Bandwidth                                =
                             64 bytes from 192.168.178.65: icmp_seq=3D53 tt=
l=3D64 time=3D828 ms
[  3]  0.0-10.1 sec  35.9 MBytes  29.9 Mbits/sec                           =
                             64 bytes from 192.168.178.65: icmp_seq=3D54 tt=
l=3D64 time=3D619 ms

[  3] Sent 892 datagrams                                                   =
                             rtt min/avg/max/mdev =3D 2.183/788.828/3329.04=
5/958.683 ms, pipe 7

[  3] local 192.168.178.68 port 33404 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D57 tt=
l=3D64 time=3D2.58 ms
[ ID] Interval       Transfer     Bandwidth                                =
                             64 bytes from 192.168.178.65: icmp_seq=3D58 tt=
l=3D64 time=3D322 ms
[  3]  0.0-11.5 sec  36.5 MBytes  26.6 Mbits/sec                           =
                             64 bytes from 192.168.178.65: icmp_seq=3D59 tt=
l=3D64 time=3D10.2 ms

[  3] Sent 892 datagrams                                                   =
                             rtt min/avg/max/mdev =3D 1.962/610.122/3303.54=
4/907.708 ms, pipe 7

[  3] local 192.168.178.68 port 33406 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D55 tt=
l=3D64 time=3D2.60 ms
[ ID] Interval       Transfer     Bandwidth                                =
                             64 bytes from 192.168.178.65: icmp_seq=3D56 tt=
l=3D64 time=3D112 ms
[  3]  0.0-11.1 sec  16.1 MBytes  12.2 Mbits/sec                           =
                             64 bytes from 192.168.178.65: icmp_seq=3D57 tt=
l=3D64 time=3D118 ms

[  3] Sent 892 datagrams                                                   =
                             rtt min/avg/max/mdev =3D 2.088/593.139/2734.77=
0/857.021 ms, pipe 6

*** iperf -c 192.168.178.65 -d ***

[  5] local 192.168.178.68 port 33408 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D75 tt=
l=3D64 time=3D2.64 ms
[  4] local 192.168.178.68 port 5001 connected with 192.168.178.65 port 474=
92                           ^C
[ ID] Interval       Transfer     Bandwidth                                =
                             --- 192.168.178.65 ping statistics ---
[  5]  0.0-10.3 sec  51.2 MBytes  41.9 Mbits/sec                           =
                             75 packets transmitted, 75 received, 0% packet=
 loss, time 37122ms
[  4]  0.0-25.0 sec  1.00 MBytes   336 Kbits/sec                           =
                             rtt min/avg/max/mdev =3D 1.830/563.652/1996.99=
2/651.117 ms, pipe 4

[  4] local 192.168.178.68 port 33410 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D127 t=
tl=3D64 time=3D2.41 ms
[  5] local 192.168.178.68 port 5001 connected with 192.168.178.65 port 474=
94                           ^C
[ ID] Interval       Transfer     Bandwidth                                =
                             --- 192.168.178.65 ping statistics ---
[  4]  0.0-10.1 sec  39.0 MBytes  32.4 Mbits/sec                           =
                             127 packets transmitted, 126 received, 0.78740=
2% packet loss, time 63205ms
[  5]  0.0-50.8 sec  5.01 MBytes   826 Kbits/sec                           =
                             rtt min/avg/max/mdev =3D 1.791/239.200/2105.86=
7/513.022 ms, pipe 5

[  4] local 192.168.178.68 port 33414 connected with 192.168.178.65 port 50=
01                           64 bytes from 192.168.178.65: icmp_seq=3D90 tt=
l=3D64 time=3D69.4 ms
[  5] local 192.168.178.68 port 5001 connected with 192.168.178.65 port 474=
96                           ^C
[ ID] Interval       Transfer     Bandwidth                                =
                             --- 192.168.178.65 ping statistics ---
[  4]  0.0-10.5 sec  46.1 MBytes  37.0 Mbits/sec                           =
                             90 packets transmitted, 90 received, 0% packet=
 loss, time 44643ms
[  5]  0.0-31.8 sec  3.26 MBytes   861 Kbits/sec                           =
                             rtt min/avg/max/mdev =3D 1.909/391.216/1878.48=
4/645.897 ms, pipe 4

--MP_/HK2Jk74KYAP+JrJ7uk2JIZx--

--Sig_//IDWZ07+v.DEf0X4=ftKJ+Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6OI5IACgkQNasLKJxd
slgnug//Yhm8khJrc1A5w5ReimblMQqeBJYZ3Krc6rbFkrUMFtTR3L7DpzOf01Zf
Yw6pg6A5+IsyJ/8zD0+/C/16MSUj97qBYiieDnnlkSrhEZRegn0M6//RS6SYNI7c
UYBn02RKyTyeWZscMksUuTHfojqfvVSaSH9nv7Gna3exrneBX0jczQjR6QyFYaGT
TcQwBLGD3F1mK+1Um731e30SZTMH7uAbi3N4jMEhfP8ScUCJW6uf6uE9XyRyKdTV
S9kq7+ulcnZancdBtAZGLPRfXfXQe4TmA0V9BWTpJY/6nm+er+odtEZ6COnw6gNp
C1jLmhrwAsZI0fqYfzaTNRECfMRmIDd8T8ZKxloKx5oURs0fMPZbKp3Rkea63CQJ
CpjIVerodIo5ycIe2YW/XaNcjljU5kUODrcYM/f+zd7ElmZzaE1CfAtuhWzYSF1x
9fbIrupcl55jZylQH3h1h4ML+eA/NxPpn6zyL8VCtNhd1RrmOfy3L++kOJCv9q9O
Qi0BqK1m/CxvWMndIIMztJtOl4kxnPLF9LLRQTgfTi5iYXsams3gk1SQLai19BIh
gPDuKsHEyLs7pX3LkqAig9Xjo8AHrEnuJ38hcNu63vc/SP90FpiHGYF+65X/ykH/
f644aIBvY5YCQqnLAgYzqZqzQh/R4D0biN4X/z0W6Rcc4VKSq3I=
=aOMU
-----END PGP SIGNATURE-----

--Sig_//IDWZ07+v.DEf0X4=ftKJ+Z--

