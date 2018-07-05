Received: from eggs.gnu.org ([2001:4830:134:3::10]:54234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb4ni-0002cP-Id
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fb4nf-00079I-Hm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:00:02 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:36238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fb4nf-00077B-Ar
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:59:59 -0400
Received: by mail-it0-x230.google.com with SMTP id j185-v6so12182366ite.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 06:59:59 -0700 (PDT)
Received: from [192.168.0.4] ([69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	u20-v6sm3009388itc.7.2018.07.05.06.59.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 Jul 2018 06:59:57 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <F5A73E79-846C-4678-B740-1950B791AE5D@gmail.com>
References: <F863D1F5-0218-488E-A0E0-9F5991339BC8@gmail.com>
Date: Thu, 5 Jul 2018 09:59:56 -0400
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-3.1 0/7] target/ppc fp
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>


> Hi,
>=20
> qemu-system-ppc has an issue after building from the 3.1 branch. Mac
> OS 9 hangs at the grey boot screen, OSX 10.3 hangs after verbose boot,
> just before entering the graphical desktop.
>=20
> Command line to reproduce:
>=20
> qemu-system-ppc -L pc-bios -boot c -M mac99,via=3Dpmu -m 512 -prom-env
> 'auto-boot?=3Dtrue' -prom-env 'boot-args=3D-v' -prom-env =
'vga-ndrv?=3Dtrue'
> -drive file=3DMacOS9.2.img,format=3Draw,media=3Ddisk -netdev
> user,id=3Dnetwork01 -device sungem,netdev=3Dnetwork01
>=20
> I bisected to this commit:
>=20
> cdee6bed3e2ed60f039fb84f63c5dc5f4af4619c is the first bad commit
> commit cdee6bed3e2ed60f039fb84f63c5dc5f4af4619c
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Tue Jul 3 08:17:32 2018 -0700
>=20
>   target/ppc: Use non-arithmetic conversions for fp load/store
>=20
>   Memory operations have no side effects on fp state.
>   The use of a "real" conversions between float64 and float32
>   would raise exceptions for SNaN and out-of-range inputs.
>=20
>   Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>   Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> :040000 040000 d61b35b777c3ac2f28980a98fc83b8dfdce11bba
> ec7c15afcef93cc469c5ee0a2bfda293ba745dc3 M    target
>=20
> Thanks for looking into it.
>=20
> Best regards,
> Howard

I also noticed that my Mac OS 10.4.3 VM stopped booting. When I reversed =
the above patch the VM started booting again. I am CC'ing Richard =
Henderson on this issue.=20
