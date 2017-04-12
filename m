Received: from eggs.gnu.org ([2001:4830:134:3::10]:39499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyE9t-0006mx-EJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyE9q-0004l8-DU
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:01:49 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:60611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cyE9q-0004kc-87
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:01:46 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BF99831769
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 11:01:44 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-22-git-send-email-clg@kaod.org>
	<1491909013.4099.4.camel@redhat.com>
	<ab9d8d7b-da49-1bc6-dfd8-545cae19cf90@kaod.org>
	<1491984175.4099.9.camel@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5d2081a2-7f77-0787-867c-51bf44edd13c@kaod.org>
Date: Wed, 12 Apr 2017 11:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <1491984175.4099.9.camel@redhat.com>
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

On 04/12/2017 10:02 AM, Andrea Bolognani wrote:
> On Tue, 2017-04-11 at 18:50 +0200, C=C3=A9dric Le Goater wrote:
>>> These bridges and devices are not added when -nodefaults
>>> is in use, right?
>> =20
>> I haven't checked that yet but I will.
>=20
> Thanks. This is very important for libvirt, where we need
> to have full control of the guest's hardware.

OK. and so, this is not the case. This patch will need to be
a little more subtle to handle -nodefaults.

Thanks,

C.=20
