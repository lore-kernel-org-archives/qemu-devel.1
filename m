Received: from eggs.gnu.org ([2001:4830:134:3::10]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cibgp-00085F-S4
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cibgm-0006AO-Qj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:55:15 -0500
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:44295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cibgm-0006A3-Kl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:55:12 -0500
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 426F15A5D3
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:55:09 +0100 (CET)
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
	<1488205773-30436-3-git-send-email-clg@kaod.org>
	<20170228020046.GN17615@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bd6aa9a9-45a1-bb90-5c94-b16a43330712@kaod.org>
Date: Tue, 28 Feb 2017 07:54:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170228020046.GN17615@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/26] ppc/xics: fix ICP and ICS reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/28/2017 03:00 AM, David Gibson wrote:
> On Mon, Feb 27, 2017 at 03:29:09PM +0100, C=E9dric Le Goater wrote:
>> commit 5b17c7207938 ("xics: XICS should not be a SysBusDevice")
>> changed the nature of the XICS object to be a descendent of
>> TYPE_DEVICE. By doing so, the object is not on a bus and its reset
>> handler is not called anymore. The direct consequence is that the ICP
>> and ICS objects are not correctly initialized and so the IRQ subsystem
>> is broken in the guest.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I've merged 1&2 into my tree, but folded together.  First, I don't
> want to break bisects, second you reference an explicit commit above,
> which would have been made incorrect by rebases of the first patch.

Perfect. That was the thing to do.=20

Thanks,

C.
