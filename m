Received: from eggs.gnu.org ([209.51.188.92]:48727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Wl-0000wZ-Hg
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk8Wk-0005lG-OJ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:20:15 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-19-eblake@redhat.com>
	<0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
	<0bace5ce-8d59-0996-51b8-39d584729acd@redhat.com>
	<482d5377-e4c3-15e8-fd24-2d29c284e322@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <999d1365-f836-ebe2-e530-c38e7c78692c@redhat.com>
Date: Thu, 17 Jan 2019 08:20:07 -0600
MIME-Version: 1.0
In-Reply-To: <482d5377-e4c3-15e8-fd24-2d29c284e322@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vYUC42da39TWBiKopT9cupecGQhxTEXga"
Subject: Re: [Qemu-devel] [PATCH v3 18/19] nbd/client: Work around 3.0 bug
 for listing meta contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vYUC42da39TWBiKopT9cupecGQhxTEXga
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <999d1365-f836-ebe2-e530-c38e7c78692c@redhat.com>
Subject: Re: [PATCH v3 18/19] nbd/client: Work around 3.0 bug for listing meta
 contexts
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-19-eblake@redhat.com>
 <0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
 <0bace5ce-8d59-0996-51b8-39d584729acd@redhat.com>
 <482d5377-e4c3-15e8-fd24-2d29c284e322@virtuozzo.com>
In-Reply-To: <482d5377-e4c3-15e8-fd24-2d29c284e322@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/17/19 2:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 17.01.2019 6:21, Eric Blake wrote:
>> On 1/16/19 9:43 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>>> @@ -839,9 +842,25 @@ static int nbd_list_meta_contexts(QIOChannel *i=
oc,
>>>>
>>>>            ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_LIST_ME=
TA_CONTEXT,
>>>>                                               &context, NULL, errp);=

>>>> +        if (ret =3D=3D 0 && seen_any && !seen_qemu) {
>>>> +            /*
>>>> +             * Work around qemu 3.0 bug: the server forgot to send
>>>> +             * "qemu:" replies to 0 queries. If we saw at least one=

>>>> +             * reply (probably base:allocation), but none of them w=
ere
>>>
>>> if we are saying about 3.0, it is base:allocation for sure, isn't it?=

>>>
>>>> +             * qemu:, then run a more specific query to make sure.
>>
>> If the server is qemu 3.0, then yes, it is base:allocation. But it cou=
ld
>> be some other server that has its own custom return without implementi=
ng
>> base:allocation.
>=20
> Indeed) And in this context, heuristic about that server should have at=
 least one
> context listed with no query seems not generic. Why not query 'qemu:' e=
ven if empty
> query returns nothing?

Because it is highly unlikely that we will ever encounter a server that
knows how to serve "qemu:" contexts but not "base:allocation" (qemu is
not such a server, and why would any other server bother with qemu:
specific information?).

> So, at least, "probably" is imbalanced with this not described
> in comment heuristic which seems bound to 3.0.

qemu 3.0 is the only server where the heuristic will make a difference,
but not the only server where the heuristic may trigger.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vYUC42da39TWBiKopT9cupecGQhxTEXga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAjxcACgkQp6FrSiUn
Q2rYhAf+NPW4ACCtXJw7vbzI9qsdKauRRJanI30nlbcqD/OGPxMOH/D+gODhgghe
UPhnz4GNluHdI/vpZp62ut3HT5/4oGv33mjpTdFfpKTtNrr8VvG3mg2iUI4swm0Y
7ZKugcPzTNibPeUraWQ3Xm1P8LqIaj7OnaGW4vsADUArf25/YInQRVsMikEpE3Yy
cYi78C7PUF6QdN3c4zpAaiT7TQ02ULP4ikCW5T/tHzm7kEv371ubZFBQPVE56zvd
SuUzymbTeubMvjnwD2EWZT8yl6lhAZsCoYOvYoet0jmHTMRGVzrLsRa51Buep29v
uXFRpT3AZd8PTHOG9BoBQC7X/SJf0Q==
=ohed
-----END PGP SIGNATURE-----

--vYUC42da39TWBiKopT9cupecGQhxTEXga--
