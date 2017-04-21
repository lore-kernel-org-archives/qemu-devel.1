Received: from eggs.gnu.org ([2001:4830:134:3::10]:40775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mr.katebzadeh@gmail.com>) id 1d1WsY-0005KA-I4
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mr.katebzadeh@gmail.com>) id 1d1WsT-0001IA-MZ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:37:34 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mr.katebzadeh@gmail.com>)
	id 1d1WsT-0001I5-Ej
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:37:29 -0400
Received: by mail-wm0-x242.google.com with SMTP id o81so4366505wmb.0
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 04:37:28 -0700 (PDT)
From: Siavash Katebzadeh <mr.katebzadeh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <F7CD9F9D-2450-46BB-A914-BCA3418975D2@gmail.com>
Date: Fri, 21 Apr 2017 16:07:23 +0430
Subject: [Qemu-devel]  Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, mark.cave-ayland@ilande.co.uk, Artyom Tarasenko <atar4qemu@gmail.com>, hossein.ajallooiean@epfl.ch

Hi,

I can reproduce this panic using debian-7.8.0 image. I=E2=80=99m getting =
this segmentation fault:

[   24.846406] busybox[1]: segfault at f78a000c ip 00000000f77ab0ac (rpc =
00000000f77ab090) sp 00000000ffd95a50 error 30001 in =
libc.so.6[f76f0000+174000]

I found out the commit with 7268adebfda6548b8ae6865dc8337f116a5d266d =
hash is broken.
Could you please take a look at this commit? Thanks.
 =20
Regards,
Siavash.
