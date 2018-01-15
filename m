Received: from eggs.gnu.org ([2001:4830:134:3::10]:58047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb3ka-0003JA-Eu
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eb3kW-0003jo-Dz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:20:28 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:45414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eb3kW-0003iH-2k
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:20:24 -0500
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 958D995A8C
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 13:20:22 +0100 (CET)
References: <20180115120752.30734-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <437f5c53-92e2-b565-7218-11ff0a56c2d0@kaod.org>
Date: Mon, 15 Jan 2018 13:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180115120752.30734-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Update skiboot firmware image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 01/15/2018 01:07 PM, C=C3=A9dric Le Goater wrote:
> This is skiboot 5.9 (commit e0ee24c2). It brings improved POWER9
> support among many other things. Built from submodule.

I just noticed that unit test ppc64/boot-serial/powernv needs a=20
change to take into account the first output line. I will send a
fix as a followup.

Thanks,

C.=20
