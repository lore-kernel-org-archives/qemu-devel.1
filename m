Received: from eggs.gnu.org ([2001:4830:134:3::10]:38543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjqTt-0002s2-A2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cjqTq-0002tF-8e
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:55:01 -0500
References: <1488548254-456-1-git-send-email-clg@kaod.org>
	<39ad7cac-b29e-b01e-723c-8cbdb1cf3ca9@redhat.com>
	<f55bb0be-778c-6ded-1564-9b77c4521f52@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4b5780b-4604-9577-f42a-8821c4cb18d4@redhat.com>
Date: Fri, 3 Mar 2017 17:54:54 +0100
MIME-Version: 1.0
In-Reply-To: <f55bb0be-778c-6ded-1564-9b77c4521f52@kaod.org>
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
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03.03.2017 15:49, C=C3=A9dric Le Goater wrote:
> On 03/03/2017 03:13 PM, Thomas Huth wrote:
>> On 03.03.2017 14:37, C=C3=A9dric Le Goater wrote:
>>> Also use an 'Object *' under the sPAPR machine to hold the RTC
>>> object.
>>
>> The change from TYPE_SYS_BUS_DEVICE to TYPE_DEVICE is certainly a good
>> idea! But what's the advantage of using Object* instead of DeviceState=
*
>> in sPAPRMachineState ?
>=20
> it makes spapr_rtc_create() a little simpler. =20
>=20
> We could go even further and use a sPAPRRTCState under sPAPRMachineStat=
e=20
> that we  would initialize with object_initialize().=20

I think a sPAPRRTCState* would make more sense here - if you just see an
Object* and are not familiar with the code, you wonder what this pointer
is all about (and you then have to cast it to something different if you
want to do anything with it) ... so IMHO either a DeviceState* or
sPAPRRTCState* is the better choice here.

 Thomas
