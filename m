Received: from eggs.gnu.org ([2001:4830:134:3::10]:49210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cqytE-0003p0-Dq
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cqyt9-0004oc-FQ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cqyt9-0004o5-93
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:18:35 -0400
References: <87bmstu19t.fsf@dusky.pond.sub.org>
	<1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
	<da2bfbb8-c000-eaff-826f-904582f6e98a@redhat.com>
	<1490257145.463.24.camel@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c03647b6-069d-6f47-bffc-af30f8c634e7@redhat.com>
Date: Thu, 23 Mar 2017 10:18:28 +0100
MIME-Version: 1.0
In-Reply-To: <1490257145.463.24.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

On 23.03.2017 09:19, Gerd Hoffmann wrote:
> On Mi, 2017-03-22 at 11:19 +0100, David Hildenbrand wrote:
>> On 22.03.2017 11:03, Thomas Huth wrote:
>>> On 22.03.2017 10:08, Markus Armbruster wrote:
>>> [...]
>>>> Are we now ready to accept a simple & stupid patch that actually hel=
ps
>>>> users, say letting boards that care declare minimum and maximum RAM
>>>> size?  And make PC reject RAM size less than 1MiB, even though "some=
one"
>>>> might conceivably have firmware that works with less?
>>>
>>> I'd say enforce a minimum RAM size on the normal "pc" and "q35" machi=
ne,
>>> but still allow smaller sizes on the "isapc" machine. So if "someone"
>>> comes around and claims to have a legacy firmware that wants less mem=
ory
>>> than 1MiB, just point them to the isapc machine.
>>> Just my 0.02 =E2=82=AC.
>>>
>>>  Thomas
>>
>> Or maybe simply warn the user that things may go wrong instead of
>> enforcing it.
>=20
> Why bother?  I have my doubts physical i440fx works with less than 1M
> either, given that this memory is needed to shadow the roms.  Possibly
> you can't even find dimms that are small to plug them into such a syste=
m
> to try ...

Because it seems to work if you supply the correct rom. We are trying to
catch user errors, don't we?

>=20
> I'd say just add a hard limit and be done with it.

"640K ought to be enough for anybody". Any limit we set will become out
of date.

>=20
> Maybe exclude isapc.  That one hasn't shadow support so things have at
> least a chance to work with less than 1M of memory.  But honestly I'd
> rather drop isapc, together with ia64 and sparc.  I mean, what is the
> use case?  'pc' machine type is compatible enough with vga and ide port=
s
> being on the standard isa locations so even msdos which has no pci
> support at all boots happily.

I think I like that idea.

> cheers,
>   Gerd
>=20


--=20

Thanks,

David
