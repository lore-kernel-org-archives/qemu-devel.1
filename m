Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEF2V-0000XG-Br
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEF2P-0006w7-Iw
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:16:55 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEF2P-0006vh-C2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:16:49 -0400
Received: from player714.ha.ovh.net (unknown [10.109.108.1])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id C15A912F68B
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 16:16:47 +0200 (CEST)
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<062deb2a-35fc-319f-b159-3b58cbf910df@redhat.com>
	<20180502115844.GO3308@redhat.com>
	<CAFEAcA-e_=08658O8E3CAmYXvBbNWmznnhfMLUW+MXnxb_vKfQ@mail.gmail.com>
	<20180503093329.GF11382@redhat.com>
	<8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <222ee475-9eb5-8887-819a-7b093fc269b1@kaod.org>
Date: Thu, 3 May 2018 16:16:41 +0200
MIME-Version: 1.0
In-Reply-To: <8af696b5-3985-ffd6-43fb-2bcbfe0d0493@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>

On 05/03/2018 11:42 AM, Thomas Huth wrote:
> On 03.05.2018 11:33, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, May 02, 2018 at 01:05:21PM +0100, Peter Maydell wrote:
>>> On 2 May 2018 at 12:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>>>> I'm curious what is the compelling benefit of having a single fat QE=
MU
>>>> binary that included all archiectures at once ?
>>>
>>> The motivation is "I want to model a board with an SoC that has
>>> both Arm cores and Microblaze cores". One binary seems the most
>>> sensible way to do that, since otherwise we'd end up with some
>>> huge multiplication of binaries for all the possible architecture
>>> combinations. It also would reduce the number of times we end up
>>> recompiling and shipping any particular PCI device. From the
>>> perspective of QEMU as emulation environment, it's a nice
>>> simplification.
>>
>> Ah that's interesting - should have known there was wierd hardware
>> like that out there :-)
>=20
> It's not that weird. A lot of "normal" machines have a service processo=
r
> (aka. BMC - board management controller) on board - and this service
> processor is completely different to the main CPU. For example, the mai=
n
> CPU could be an x86 or PPC, and the service processor is an embedded AR=
M
> chip. To emulate a complete board, you'd need both CPU types in one QEM=
U
> binary. Or you need to come up with some fancy interface between two
> QEMU instances...

like a QEMU chardev backend to implement an IPMI BT interface between=20
a QEMU Aspeed SoC machine and a QEMU PowerNV machine ? It works :) But,
you need real HW to find timing issues ...

They are plenty of other "wires" to fully model an OpenPower system,=20
LPC, MBOX, etc. The dialogues between the ppc64 host firmware and=20
the BMC firmware are very diverse.=20

Coming back to the initial motivation that Peter pointed out, would
the goal to be able to run vcpus of different architectures ? It would
certainly be interesting to model a platform, specially if we can=20
synchronize the execution in some ways and find timing issues.


C.
