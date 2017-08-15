Received: from eggs.gnu.org ([2001:4830:134:3::10]:47897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcSS-0005nN-Aq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcSR-00035l-7a
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:04:36 -0400
References: <20170808152607.147691-1-vsementsov@virtuozzo.com>
	<6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
	<561af6b4-ca21-7118-e44d-2f12da1b23b8@virtuozzo.com>
	<7ab0fcb2-b033-b67d-cec7-5a7470430a26@redhat.com>
	<ddc6199c-a20d-8c94-e285-ff08369c461f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00c64325-5c9f-e309-ba5c-894398b61ecf@redhat.com>
Date: Tue, 15 Aug 2017 09:04:24 -0500
MIME-Version: 1.0
In-Reply-To: <ddc6199c-a20d-8c94-e285-ff08369c461f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gjMQcW0LPvcKtBda5DLpOsxAgADc77mBM"
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] block/nbd-client: always
 return EIO on and after the first io channel error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gjMQcW0LPvcKtBda5DLpOsxAgADc77mBM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <00c64325-5c9f-e309-ba5c-894398b61ecf@redhat.com>
Subject: Re: [PATCH v2 for 2.10] block/nbd-client: always return EIO on and
 after the first io channel error
References: <20170808152607.147691-1-vsementsov@virtuozzo.com>
 <6079e4c4-ae54-826f-8cb4-dbcd773ecf50@redhat.com>
 <561af6b4-ca21-7118-e44d-2f12da1b23b8@virtuozzo.com>
 <7ab0fcb2-b033-b67d-cec7-5a7470430a26@redhat.com>
 <ddc6199c-a20d-8c94-e285-ff08369c461f@virtuozzo.com>
In-Reply-To: <ddc6199c-a20d-8c94-e285-ff08369c461f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 02:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> The only doubt: is it possible to hang on nbd_rwv because some fail i=
n
>>> connection or server?
>> We _already_ have the bug that we are hanging in trying to talk to a
>> broken server, which is a regression introduced in 2.9 and not present=

>> in 2.8.  And that's what I'm most worried about getting fixed before
>> 2.10 is released.
>>
>> I don't think that sending any more data to the server is necessarily
>> going to cause a hang, so much as trying to read data that is going to=

>> be sent in reply or failing to manipulate the coroutine handlers
>> correctly (that is, our current hang is because even after we detect
>> failure, we are still sending NBD_CMD_FLUSH but no longer have a
>> coroutine in place to read the reply, so we no longer make progress to=

>> the point of sending NBD_CMD_DISC and closing the connection).
>=20
> but we will not try to read.
> However, I'm convinced, ok, let's send nothing to the broken server.

Can you offer a review on my proposed patch? I'm hoping to send an NBD
pull request in the next couple of hours, to make -rc3.
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02593.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gjMQcW0LPvcKtBda5DLpOsxAgADc77mBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmS/2gACgkQp6FrSiUn
Q2pgcQf/TquooIWIsuY9ACX21ULny0jHO/dkl2n4yH0qJOBnBh5BwmBStQjRysxy
WTrLf8dmFHt9lNgOJ2HscLcbtPYLXipaToqo5nG86UkMWlLQpwK0+X1FND58Ma0X
d+dJlqPK6S1BbYYQOfJIjizZYBV3mKHjr0si1lauLaXv3xLgYdXjUfz6EZV7TtMm
WpqYk4CN/UEONOPPExhjHxc+zWv1oUixCjzGi5VVHXAx3bmPdRkgetvhCq7mNn0d
Zzah9qF119ijPGf9B2tBocYzGZ2P3EKCfDTWoKkFDsk99UeIKQI88QXwezEbQS5M
1n0Kwh6p5XNqolXt0IaSaN08zgS8yw==
=lAgP
-----END PGP SIGNATURE-----

--gjMQcW0LPvcKtBda5DLpOsxAgADc77mBM--
