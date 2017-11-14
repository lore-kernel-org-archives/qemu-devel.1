Received: from eggs.gnu.org ([2001:4830:134:3::10]:41303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEi4i-0003yU-IF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEi4h-0005T5-JJ
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:44:52 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
	<9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
	<1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
	<20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
	<e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
	<89062bb7-f2fa-db5e-d799-c61e1daa6b99@redhat.com>
	<3db6cc30-f744-7a47-e59a-6a15c9fcfd39@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <db3b249f-7384-8d9e-c280-7c7134c7c294@redhat.com>
Date: Tue, 14 Nov 2017 21:44:39 +0100
MIME-Version: 1.0
In-Reply-To: <3db6cc30-f744-7a47-e59a-6a15c9fcfd39@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fMmm67KJMSgIKl3dm6bvQs6NpwvIfrAw7"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fMmm67KJMSgIKl3dm6bvQs6NpwvIfrAw7
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <db3b249f-7384-8d9e-c280-7c7134c7c294@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
 <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
 <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
 <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
 <9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
 <1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
 <20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
 <e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
 <89062bb7-f2fa-db5e-d799-c61e1daa6b99@redhat.com>
 <3db6cc30-f744-7a47-e59a-6a15c9fcfd39@redhat.com>
In-Reply-To: <3db6cc30-f744-7a47-e59a-6a15c9fcfd39@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 21:38, John Snow wrote:
>=20
>=20
> On 11/14/2017 03:35 PM, Max Reitz wrote:
>> On 2017-11-14 21:30, John Snow wrote:
>>>
>>>
>>> On 11/14/2017 01:46 PM, Max Reitz wrote:
>>>> On 2017-11-14 19:45, Thomas Huth wrote:
>>>>> On 14.11.2017 14:32, Max Reitz wrote:
>>>>> [...]
>>>>>> Well, do you want to document it?  I'd rather deprecate it altoget=
her.
>>>>>
>>>>> Maybe a first step could be to change qemu-img so that it refuses t=
o
>>>>> create new qcow1 images (but still can convert them into other form=
ats).
>>>>> So basically make qcow1 read-only?
>>>>
>>>> Yep, and the actual first step to that is to make it issue a depreca=
tion
>>>> warning when creating qcow v1 images (which is what I proposed). :-)=

>>>>
>>>> Max
>>>>
>>>
>>> Deprecation warning is good.
>>>
>>> In future versions you can shimmy it behind a
>>> --no-really-I-want-this-old-format option, I think we ought to suppor=
t
>>> creating the images for as long as is technologically convenient.
>>
>> Well, at some point you can also demand from users to just dig out som=
e
>> old version of qemu-img to convert their qcow v1 images to qcow2.  It'=
s
>> not like they are going to miss out on anything.
>>
>=20
> As long is convenient. I won't throw a fit that it needs to be around
> forever, but as long as it's sufficiently guarded from use and isn't
> hard to keep around I'd prefer to do that.
>=20
> I suppose it's just a weak preference.

I agree that sufficiently guarding it (albeit our definitions on what is
sufficient may differ) serves all the purpose I need, that is, make
users aware of the fact that they are doing something for which I can
see no reason.

But on the other hand, I want those guards to make it dead code,
effectively.  And if something is dead code... There is no reason to
keep it around.

>> (If you deprecate emulated hardware, users may complain that they don'=
t
>> get the newest qemu features/bugfixes/... while continuing to use that=

>> hardware, so I can see that it's a tough decision whether to deprecate=

>> that.  But it's not like you are going to lose any features or anythin=
g
>> if you convert your dusty images to qcow2.  On the contrary, we're
>> helping you to get more performance out of them.  Maybe qemu should ju=
st
>> silently convert qcow v1 images to qcow2 without asking the user, like=

>> Apple did...)
>>
>> Max
>>
>=20
> "Like Apple did" seems sufficient justification to never do that, but
> maybe that's just my own opinion.

Sorry, forgot the emoticon. :-)

Yes, that was meant to be a joke.  Although adding a qemu-img amend for
amending qcow v1 to v2/v3 images is probably mostly an issue of creating
the right internal interface for cross-format amendments.

(Silently storing qcow v1 as v2/v3 images is actually something where
users could have a problem because maybe they have some tool that only
works on qcow v1 images; and then they can't use that together with an
auto-amending qemu...)

Max


--fMmm67KJMSgIKl3dm6bvQs6NpwvIfrAw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLVbcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmmIH/1wogIx9Wu6lVgf3zy+iWg6ephfOJJv1
fHnLuCQcb0NNxJNLqZFUtkUP8JSsG9GHRV/WykauWBabB0pv7NLkiGfuGsxstbRC
EKOGbE+sWn4ad+vMORExVSNW5cJQnj24IDTg7lWI3TdqqHQkL9LhKXPFsyoVVMiL
2DTZQaaQuDLF1RFp5wb3m+hSCLAFWQkSmBt6K7nbHSyONJVbOFslMj5wzI1oJskl
Kyt10URDU46nR3WFa9paFJqboRdgpquFXn+1CbNJkMe8GflCn2RyVpn7Z/I6n2cO
mQceAuz/e2e4Vyrl/wq4eTXdt0riCbH3UMt8/eGe+oSGIZ0y+h0FclE=
=ZNxd
-----END PGP SIGNATURE-----

--fMmm67KJMSgIKl3dm6bvQs6NpwvIfrAw7--
