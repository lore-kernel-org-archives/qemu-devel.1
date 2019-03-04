Received: from eggs.gnu.org ([209.51.188.92]:59443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0lAu-00046U-Lo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0lAt-00082M-UH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:50:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h0lAt-000826-MH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:50:23 -0500
References: <20190214220453.15858-1-svens@stackframe.org>
	<65d59485-9973-4ed1-b08f-084ed4db7ef1@redhat.com>
	<CAFEAcA-autqypsBsOkKjkKNuRd1tVW9dOLrdswA-HGUfgLNA1A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f665608-cf35-2774-ddf7-05efacd55e5e@redhat.com>
Date: Mon, 4 Mar 2019 11:50:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-autqypsBsOkKjkKNuRd1tVW9dOLrdswA-HGUfgLNA1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] lsi: implement basic SBCL functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sven Schnelle <svens@stackframe.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>

On 04/03/19 11:19, Peter Maydell wrote:
> On Fri, 15 Feb 2019 at 09:38, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>>
>> On 14/02/19 23:04, Sven Schnelle wrote:
>>> @@ -2202,6 +2224,7 @@ static const VMStateDescription vmstate_lsi_scs=
i =3D {
>>>          VMSTATE_UINT8(stime0, LSIState),
>>>          VMSTATE_UINT8(respid0, LSIState),
>>>          VMSTATE_UINT8(respid1, LSIState),
>>> +        VMSTATE_UINT8(sbcl, LSIState),
>>
>> This breaks live migration.  You need to bump the version number highe=
r
>> in vmstate_lsi_scsi and use "VMSTATE_UINT8_V(sbcl, LSIState, 1)" so th=
at
>> the field is only marshalled/unmarshalled for version 1 of the migrati=
on
>> state.
>=20
> I thought we preferred to do this with migration subsections
> rather than versioning fields these days ? In this case I
> think a subsection that says "needed if sbcl is non-zero" would
> do the right thing.

Yes, we prefer migration subsections but the only advantage is support
for backwards migration.  LSI is not a device for which I would
guarantee that backwards migration works at all, and it is not the
default controller for any board whose machine types are versioned.

Paolo
