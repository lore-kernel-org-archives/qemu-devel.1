Received: from eggs.gnu.org ([2001:4830:134:3::10]:56178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjoWP-0003Ak-Kn
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cjoWM-0004Vz-EA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:49:29 -0500
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:38533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cjoWM-0004Vb-7G
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:49:26 -0500
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6365950490
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 15:49:22 +0100 (CET)
References: <1488548254-456-1-git-send-email-clg@kaod.org>
	<39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f55bb0be-778c-6ded-1564-9b77c4521f52@kaod.org>
Date: Fri, 3 Mar 2017 15:49:15 +0100
MIME-Version: 1.0
In-Reply-To: <39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: QOM'ify sPAPRRTCState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03/03/2017 03:13 PM, Thomas Huth wrote:
> On 03.03.2017 14:37, C=C3=A9dric Le Goater wrote:
>> Also use an 'Object *' under the sPAPR machine to hold the RTC
>> object.
>=20
> The change from TYPE_SYS_BUS_DEVICE to TYPE_DEVICE is certainly a good
> idea! But what's the advantage of using Object* instead of DeviceState*
> in sPAPRMachineState ?

it makes spapr_rtc_create() a little simpler. =20

We could go even further and use a sPAPRRTCState under sPAPRMachineState=20
that we  would initialize with object_initialize().=20

C.
