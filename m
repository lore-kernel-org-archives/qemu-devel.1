Received: from eggs.gnu.org ([2001:4830:134:3::10]:42161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxz0F-0004g3-Gf
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxz0A-0002hG-Lx
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:50:51 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxz0A-0002gw-F3
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:50:46 -0400
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 680EF30FA5
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 18:50:43 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-22-git-send-email-clg@kaod.org>
	<1491909013.4099.4.camel@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ab9d8d7b-da49-1bc6-dfd8-545cae19cf90@kaod.org>
Date: Tue, 11 Apr 2017 18:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <1491909013.4099.4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 21/21] ppc/pnv: Create a default
 PCI layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

On 04/11/2017 01:10 PM, Andrea Bolognani wrote:
> On Wed, 2017-04-05 at 14:41 +0200, C=C3=A9dric Le Goater wrote:
>> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> =20
>> This creates a legacy PCIe->PCI bridge under the PHB by default to whi=
ch
>> a bunch of standard devices are attached. Currently:
>> =20
>>    - VGA (as specified by -vga)
>>    - USB (with keyboard and mouse if graphcis is enabled)
>>    - AHCI
>>    - e1000
>> =20
>> This gives us something close to a standard OpenPower platform.
>=20
> These bridges and devices are not added when -nodefaults
> is in use, right?

I haven't checked that yet but I will.

Thanks,

C.=20
