Received: from eggs.gnu.org ([2001:4830:134:3::10]:42947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <informmanuel@gmail.com>) id 1eYiCb-0001Ho-WC
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <informmanuel@gmail.com>) id 1eYiCY-0008OA-P3
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:55:41 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:42967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <informmanuel@gmail.com>)
	id 1eYiCY-0008MH-5d
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 19:55:38 -0500
Received: by mail-wr0-x232.google.com with SMTP id w107so12541988wrb.9
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 16:55:37 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: Manu <informmanuel@gmail.com>
In-Reply-To: <71ce8cd0-1b37-bc93-83b2-2fb3e9d0bbf0@profihost.ag>
Date: Tue, 9 Jan 2018 00:55:33 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F348FA7-727E-45D3-9061-B3EEE0F20D1E@gmail.com>
References: <71ce8cd0-1b37-bc93-83b2-2fb3e9d0bbf0@profihost.ag>
Subject: Re: [Qemu-devel] What's needed to pass pciid cpu flag to guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>



> Am 08.01.2018 um 19:58 schrieb Stefan Priebe - Profihost AG <s.priebe@prof=
ihost.ag>:
>=20
> Hello,
>=20
> for meltdown mitigation and performance it's important to have the pcid
> flag passed down to the guest (f.e.
> https://groups.google.com/forum/m/#!topic/mechanical-sympathy/L9mHTbeQLNU)=
.
>=20
> My host shows the flag:
> # grep ' pcid ' /proc/cpuinfo  | wc -l
> 56
>=20
> But the guest does not:
> # grep pcid /proc/cpuinfo
> #
>=20
> Guest was started with:
> -cpu IvyBridge,+kvm_pv_unhalt,+kvm_pv_eoi,enforce,vendor=3DGenuineIntel

$ qemu -cpu help=20
gives a overview.

+pcid

should do it.

>=20
> Qemu is 2.9.1
>=20
> Thanks!
>=20
> Greets,
> Stefan
>=20
