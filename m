Received: from eggs.gnu.org ([2001:4830:134:3::10]:35917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1da8jq-0005H3-UE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1da8jn-0007iB-Mu
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:55:38 -0400
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1da8jn-0007fB-Bm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 18:55:35 -0400
Received: by mail-it0-x22a.google.com with SMTP id v205so42023906itf.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 15:55:33 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
Date: Tue, 25 Jul 2017 18:55:31 -0400
Subject: [Qemu-devel] hw/core/loader-fit.c:105:41: error: expected expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>

While compiling the mips64el-softmmu target I encountered these errors:

  CC      hw/display/g364fb.o
hw/core/loader-fit.c:105:41: error: expected expression
        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
                                        ^
hw/core/loader-fit.c:105:32: error: use of undeclared identifier =
'fdt32_t'
        *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
                               ^
hw/core/loader-fit.c:108:41: error: expected expression
        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
                                        ^
hw/core/loader-fit.c:108:32: error: use of undeclared identifier =
'fdt64_t'
        *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
                               ^
hw/core/loader-fit.c:278:19: warning: implicit declaration of function
      'fdt_first_subnode' is invalid in C99 =
[-Wimplicit-function-declaration]
            off =3D fdt_first_subnode(itb, configs);
                  ^
hw/core/loader-fit.c:286:23: warning: implicit declaration of function
      'fdt_next_subnode' is invalid in C99 =
[-Wimplicit-function-declaration]
                off =3D fdt_next_subnode(itb, off);
                      ^
2 warnings and 4 errors generated.
make: *** [hw/core/loader-fit.o] Error 1
make: *** Waiting for unfinished jobs=E2=80=A6.



Steps to reproduce the error:
./configure --target-list=3Dmips64el-softmmu && make
