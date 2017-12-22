Received: from eggs.gnu.org ([2001:4830:134:3::10]:44616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSPXz-0005Kp-E6
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSPXy-0002EU-MP
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:47:43 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<87shc4umku.fsf@dusky.pond.sub.org>
	<d4c1aa6a-9583-ade6-4ef6-fc060fa5ffcd@redhat.com>
	<8dceb718-b8eb-ce51-2af1-6b5efc2a0aa0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9133bef1-c2d0-8332-5946-97432319aff4@redhat.com>
Date: Fri, 22 Dec 2017 09:47:35 -0600
MIME-Version: 1.0
In-Reply-To: <8dceb718-b8eb-ce51-2af1-6b5efc2a0aa0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] nbd export qmp interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, dgilbert@redhat.com

On 12/22/2017 02:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> 21.12.2017 21:32, Eric Blake wrote:
>> On 12/21/2017 09:28 AM, Markus Armbruster wrote:
>>> Looks like you forgot to cc: Eric. Fixing...
>>
>> Or that he did cc me, and the mailman bug ate the cc line because of=20
>> my list subscription settings.=C2=A0 (Have I mentioned that I hate tha=
t=20
>> mailman 2 bug, but don't know whether mailman 3 will make it any bette=
r?)
>>
>=20
> Hmm, when did it eat it? I've send this with git send-email, and in my=20
> thunderbird I see (through view->source)

Mailman eats the cc line of anyone that sets the 'avoid duplicate emails=20
to me' checkbox, but only for people that get the mail through mailman.=20
If you get the email directly (as is true in this case), then you see=20
the original cc's.  It's a highly annoying behavior of mailman 2; I wish=20
there were two separate knobs (one for avoiding duplicates, one for=20
controlling whether your name appears in cc), rather than one knob that=20
does both things at once.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
