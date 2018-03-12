Received: from eggs.gnu.org ([2001:4830:134:3::10]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evNZv-0000P0-5I
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evNZq-00042j-43
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:33:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evNZp-00041q-V0
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72537D143F
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 13:33:21 +0000 (UTC)
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
	<bc5f376b-ee95-5ce9-8c7c-32e75df97ec3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <47d9f2ab-b9b4-4184-4a39-d5eb73e66996@redhat.com>
Date: Mon, 12 Mar 2018 14:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <bc5f376b-ee95-5ce9-8c7c-32e75df97ec3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 12.03.2018 13:44, Paolo Bonzini wrote:
> On 12/03/2018 13:18, Eric Blake wrote:
>> On 03/12/2018 04:07 AM, Paolo Bonzini wrote:
>>> On 12/03/2018 08:27, Thomas Huth wrote:
>>>> "-net" is clearly a legacy option. Yet we still use it in almost all
>>>> examples in the qemu documentation, and many other spots in the netw=
ork
>>>> chapter. We should make it less prominent that users are not lured i=
nto
>>>> using it so often anymore. So instead of starting the network chapte=
r
>>>> with
>>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>=
"
>>>> everywhere, all the "-net" related documentation is now moved to the=
 end
>>>> of the chapter. The new "--nic" option is moved to the beginning of =
the
>>>> chapter instead, with a new example that should demonstrate how "--n=
ic"
>>>> can be used to shortcut "--device" with "--netdev". The examples in =
this
>>>> chapter are changed to use the "--device" and "--netdev" options or
>>>> "--nic" instead of "-net nic -net <backend>".
>>>>
>>>> While we're at it, also remove a legacy remark about very old Linux
>>>> distributions. Also remove the "[...]" from the examples in this cha=
pter
>>>> since we are not using this ellipsis in any other examples in our do=
cu-
>>>> mentation.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>> =C2=A0 v2:
>>>> =C2=A0 - Fixed the bad "--device=3De1000" example
>>>
>>> Frankly I think this is the proof that double-dash option names are a
>>> bad idea.=C2=A0 The reason to do that was to make qemu-img and qemu c=
ommand
>>> lines more similar in the documentation, but the truth is they are no=
t
>>> similar and shouldn't be made similar.=C2=A0 The equal sign is one ex=
ample,
>>> where qemu-img supports "--format=3Draw" but QEMU doesn't support
>>> "--device=3De1000", but it's not the only one.
>>
>> Our hand-rolled parser sucks.=C2=A0 We should fix it to be more like g=
etopt,
>> at which point --device=3De1000 would work.
>=20
> "--device=3De1000,netdev=3Duser0" is also pretty confusing, as is
> "--machine=3Dkernel_irqchip=3Doff".
>=20
>>> qemu-img supports things such as "-fraw", qemu doesn't---for example
>>> "-m1024" doesn't work).
>>
>> Our hand-rolled parser sucks.=C2=A0 We should fix it to be more like g=
etopt,
>> at which point -m1024 would work.
>=20
> For -m1024 it makes sense, but what about -d?  How do you explain that
> "-din_asm" is a short form of "-d in_asm", but "-device" is not a short
> form of "-d evice"?

Slightly off-topic, but: I think it is also quite unfortunate that we
use a short option "-d" for something that you need rather seldomly,
while something important like "-device" does not have an abbreviated
one-letter alternative.

> I agree that having a non-standard option parser is bad, but
> getopt_long_only always seemed to me like the worst of both worlds.
> "All options are 'long', cannot be abbreviated, must be separated from
> their argument" is pretty easy.

Hey, what about switching to getopt_long(), breaking with traditions and
call the first version that contains the change "QEMU v3.0"? ;-)
... SCNR.

 Thomas
