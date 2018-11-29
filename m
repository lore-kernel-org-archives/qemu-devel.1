Received: from eggs.gnu.org ([2001:4830:134:3::10]:39421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSPQ4-0006gU-QY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSPQ0-0002U0-Nv
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:44:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSPQ0-0002Tn-Gv
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:44:00 -0500
References: <20181126182844.23109-1-minyard@acm.org>
	<d7a7cb4a-a55d-ec84-4bd8-89ef3fad7ebf@mvista.com>
	<20181129104930-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94fea825-f77b-760f-d093-eccc137594d8@redhat.com>
Date: Thu, 29 Nov 2018 10:43:50 -0600
MIME-Version: 1.0
In-Reply-To: <20181129104930-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1?] pc:piix4: Update smbus I/O space
 after a migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>

On 11/29/18 9:49 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 29, 2018 at 09:45:17AM -0600, Corey Minyard wrote:
>> On 11/26/18 12:28 PM, minyard@acm.org wrote:
>>> From: Corey Minyard <cminyard@mvista.com>
>>>
>>> Otherwise it won't be set up correctly and won't work after
>>> miigration.
>>
>> Any opinions on this?=C2=A0 I think this would be good for 3.1. Withou=
t
>> this when a migration occurs on piix4 the SMBus address space
>> appears in the wrong place.=C2=A0 I'm not sure how bad that is, but
>> SMBus certainly ceases to work.
>>
>> -corey
>=20
>=20
> I have this queued. Thanks!

We've missed -rc3. Is the problem this patch addresses severe enough to=20
warrant -rc4? Is it a regression since 3.0?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
