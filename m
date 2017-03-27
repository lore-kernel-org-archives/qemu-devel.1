Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csZjI-0000vw-CT
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csZjE-0008Ul-33
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csZjD-0008UH-Q6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:50:56 -0400
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
	<aea80d19-4a6f-8791-9b10-34734d238206@redhat.com>
	<CAAo6VWPT36ECzr1gDdW0CqmdXtPbZudtec9Tc_xi+9cvbuDmMw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9ce07b44-e685-6c4f-0ded-260c5b088af5@redhat.com>
Date: Mon, 27 Mar 2017 13:50:49 -0500
MIME-Version: 1.0
In-Reply-To: <CAAo6VWPT36ECzr1gDdW0CqmdXtPbZudtec9Tc_xi+9cvbuDmMw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JJV1wS5JJUuHmdhS5rwWANosLbCfOcFDR"
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JJV1wS5JJUuHmdhS5rwWANosLbCfOcFDR
From: Eric Blake <eblake@redhat.com>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>,
 Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Ketan Nilangekar <Ketan.Nilangekar@veritas.com>,
 John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>,
 Suraj Singh <Suraj.Singh@veritas.com>,
 Nitin Jerath <Nitin.Jerath@veritas.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Venkatesha M.G." <venkatesha.mg@veritas.com>,
 Abhijit Dey <Abhijit.Dey@veritas.com>
Message-ID: <9ce07b44-e685-6c4f-0ded-260c5b088af5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
References: <1490583036-3683-1-git-send-email-Ashish.Mittal@veritas.com>
 <aea80d19-4a6f-8791-9b10-34734d238206@redhat.com>
 <CAAo6VWPT36ECzr1gDdW0CqmdXtPbZudtec9Tc_xi+9cvbuDmMw@mail.gmail.com>
In-Reply-To: <CAAo6VWPT36ECzr1gDdW0CqmdXtPbZudtec9Tc_xi+9cvbuDmMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 01:25 PM, ashish mittal wrote:

>>>
>>> Sample command line using URI syntax:
>>> qemu-img convert -f raw -O raw -n
>>> /var/lib/nova/instances/_base/0c5eacd5ebea5ed914b6a3e7b18f1ce734c386a=
d
>>> vxhs://192.168.0.1:9999/c6718f6b-0401-441d-a8c3-1f0064d75ee0
>>
>> Do we really need URI syntax, now that we have -blockdev-add going int=
o 2.9?
>>
>=20
> Having it just makes manual testing with CLI easier (less to type).
> Would like to retain it for now, unless having this is a problem.
> Removing it will also require rework and retesting of the qemu-iotests
> patch.

At this point, it's a maintenance burden. We're trying to get rid of
QemuOpts madness in favor of sane QMP design, and every new driver that
adds yet another URI hack on top of QemuOpts makes it that much harder
to get rid of the cruft.  I'm not going to be the one to outright reject
a URI scheme as long as the QMP works with equal features.  But given
the churn currently going on about RBD support for 2.9, I want to make
absolutely sure we get the QMP part exactly right, and don't have to
maintain any extra translation layers to URI than absolutely necessary.


>>
>> No Copyright notice?  The GPL works by virtue of copyright law, so
>> generally a copyright holder should be mentioned.
>>
>=20
> I guess what's missing is the "Copyright (c) Veritas, LLC. 2017" line.
> Is that correct?

Yes. (Your company's legal team may have specific requirements or advice
on exactly how to format the line; I can't speak to whether you have
complied with those checklists, but from my perspective your proposal
looks fine).


>>> +##
>>> +{ 'struct': 'BlockdevOptionsVxHS',
>>> +  'data': { 'vdisk-id': 'str',
>>> +            'server': 'InetSocketAddress',
>>
>> Do you want to use the new InetSocketAddressBase (just host and port,
>> eliminating things like 'to' that don't make much sense in this contex=
t)?
>>
>=20
> Don't see InetSocketAddressBase in the latest code. Could you please
> give me a usage example for reference? Thanks!

Part of Markus' pending series that you'd have to rebase on ;)
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05215.html


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JJV1wS5JJUuHmdhS5rwWANosLbCfOcFDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2V8JAAoJEKeha0olJ0NqvKsH/1AIDFUp5vIGjTj5tih/vUCK
NibvjTak81y1qJcbK0c1E4Hqs/qB5b3/pnl9T4UvIzLsZ1EGVGaBYxfu1K1r1YE6
68V+lhZ/JbKngdyhRdZLF5eFGGC+PTc6Gl+V+JGvhKG6jlvuGDLcGPzsoB+I46Wj
eIbAs0u59AJu4B8pHdgcGg68LSYBIsn/i7C34JFZXsBQJOndOKWWx4Kdkd+Cd7zg
5kaROqLPj1H/jSYrbzC6wjK1AuoDraHj5qBrZheMnwGirr7smrhhBL3Ho+tB/F7K
Z0Lwm3eSdO+b/gKw+9x896wWnZkAfF4mVJQ3Dn6LB75GFTo4a6FEYIRmSG4xwbE=
=LItZ
-----END PGP SIGNATURE-----

--JJV1wS5JJUuHmdhS5rwWANosLbCfOcFDR--
