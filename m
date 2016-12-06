Received: from eggs.gnu.org ([2001:4830:134:3::10]:38858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cELRY-0000pu-RV
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cELRU-00011H-0Z
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:30:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cELRT-00011B-OH
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:30:19 -0500
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
	<20161206153945-mutt-send-email-mst@kernel.org>
	<20161206173337.GB30363@stefanha-x1.localdomain>
	<20161206211034-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66ab8815-b9bb-7068-1809-0a31367534ff@redhat.com>
Date: Tue, 6 Dec 2016 13:30:12 -0600
MIME-Version: 1.0
In-Reply-To: <20161206211034-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LQpXwm7LuhNNHl8dX9JmBPu32rg1JQXKi"
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LQpXwm7LuhNNHl8dX9JmBPu32rg1JQXKi
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <66ab8815-b9bb-7068-1809-0a31367534ff@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
 <20161206153945-mutt-send-email-mst@kernel.org>
 <20161206173337.GB30363@stefanha-x1.localdomain>
 <20161206211034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20161206211034-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 01:22 PM, Michael S. Tsirkin wrote:
> On Tue, Dec 06, 2016 at 05:33:37PM +0000, Stefan Hajnoczi wrote:
>> On Tue, Dec 06, 2016 at 03:40:49PM +0200, Michael S. Tsirkin wrote:
>>> On Tue, Dec 06, 2016 at 05:29:13PM +0800, Gonglei wrote:
>>>> Zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
>>>> for key material security.
>>>>

>>>> +            /* Zeroize and free request data structure */
>>>> +            memset(op_info, 0, sizeof(*op_info) + max_len);
>>>> +            g_free(op_info);
>>>
>>> Write into memory, then free it?  This looks rather strange. Why are =
we
>>> doing this?
>>
>> Common practice with sensitive information (key material, passwords,
>> etc).
>=20
> Some kind of explanation about what makes this one
> more sensitive than others would be nice.

Even mentioning existing practice would go a long way; see commit 8813800=
b.

>=20
> Also, what makes it 2.8 material? Considering the pointer math
> involved, it's not risk-free.
>=20
>> coredumps, memory disclosure bugs when heap memory is reused, etc.
>>
>> Sensitive information is sometimes also held in mlocked pages to preve=
nt
>> it being swapped to disk but that's not being done here.

And existing practice is that we aren't going to be that paranoid at
this time (and yes, I asked Dan that same question on his commit
mentioned above).

>>
>> Perhaps the comment should be more explicit but this patch seems
>> reasonable.
>=20
> Right.  One can see memset and free at a glance.
> The comment and the commit log should explain the why,
> not the what.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LQpXwm7LuhNNHl8dX9JmBPu32rg1JQXKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRxHEAAoJEKeha0olJ0Nq204H/jNC7dEZsKXV1t8exficAIbo
FaSKM6Ipa6jGEdxGILtddMcfFK2I0mAySYANh3gm7ARUx5eoAJYEQCk/FU8Ik/0X
+//okSQH6ax3XTHCBOshUrue0ueBfNV9pehugzvTSMKcJ+vCo+sFc/JZfErEePJO
fQ9yXU4oRRpw4xKTKAjDVvGXCuUSj+xvCFOfeK2J94l0aNiMQYHeRhqQM6MWeLr3
g88587mXzsR22XFClW/QP/E6cI/iBJnFgLHN0YN9OX4E2xLfYqLjyeBROMRpynMt
OFwJs5VfRvXdkx68uJBoAOpyb7TqPkNVzHOwgRcl8vBb4IAel7ra+pec0JdcMmA=
=BelO
-----END PGP SIGNATURE-----

--LQpXwm7LuhNNHl8dX9JmBPu32rg1JQXKi--
