Received: from eggs.gnu.org ([2001:4830:134:3::10]:60527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV1Hz-0004nu-OU
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV1Hw-0003vQ-ET
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV1Hw-0003ob-3c
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:34:28 -0500
References: <20181108141944.15769-1-minyard@acm.org>
	<20181108232211.GB26872@umbus.fritz.box>
	<8a03cead-db46-f4fb-1e57-30bec0802bc8@acm.org>
	<61eb1702-f620-9267-1dd5-e024c65a22ef@redhat.com>
	<ec06b913-304c-a9b1-c314-350b712a9d0a@acm.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <619ccd65-b66a-92ab-a581-056bc07c1022@redhat.com>
Date: Thu, 6 Dec 2018 22:34:09 +0100
MIME-Version: 1.0
In-Reply-To: <ec06b913-304c-a9b1-c314-350b712a9d0a@acm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] ipmi: Allow UUID to be set for a BMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/12/18 22:27, Corey Minyard wrote:
> On 12/6/18 3:10 PM, Paolo Bonzini wrote:
>> On 09/11/18 14:33, Corey Minyard wrote:
>>> On 11/8/18 5:22 PM, David Gibson wrote:
>>> I'm not sure about migration.=A0 I suppose it could be migrated, but =
I
>>> would consider the BMC part of the hardware that needs to be the
>>> same on both sides.=A0 It's a fuzzy line, I suppose.=A0 The qemu UUID
>>> is migrated, so I suppose that's not an issue.
>>>
>>> Controlling it explicitly is important for some testing I do, and mig=
ht
>>> be for other people at some point in time, if you are trying to
>>> emulate something specific.=A0 And when re-invoking qemu, you
>>> might want to keep it the same to avoid confusing software.
>> I don't understand, do you need it to be different from the dmicode
>> UUID?=A0 On real hardware are they the same or different?
>=20
> They are different on real hardware, and software that uses IPMI
> can expect that it doesn't change unless the BMC changes.

You can say the latter of the dmidecode UUID too, it's not supposed to
change.  However, if they are different in real hardware they should be
different in QEMU too.  Or at least it should be possible to make them
different. :)

I guess it's up to you whether the default should be qemu_uuid or no
support for the get UUID command.

Thanks,

Paolo
