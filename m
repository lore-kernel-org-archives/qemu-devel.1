Received: from eggs.gnu.org ([2001:4830:134:3::10]:49705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvDO-0005za-9M
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvDJ-0005WX-BO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:10:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckvDJ-0005W2-3E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:10:21 -0500
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-11-git-send-email-armbru@redhat.com>
	<dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
	<87efycduf0.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ea524b7-bc6b-553a-d548-76faf99fccbb@redhat.com>
Date: Mon, 6 Mar 2017 10:10:18 -0600
MIME-Version: 1.0
In-Reply-To: <87efycduf0.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FaqHqJRCViDAbCQLUEVR1MAQnijrt9O51"
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FaqHqJRCViDAbCQLUEVR1MAQnijrt9O51
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Message-ID: <1ea524b7-bc6b-553a-d548-76faf99fccbb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-11-git-send-email-armbru@redhat.com>
 <dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
 <87efycduf0.fsf@dusky.pond.sub.org>
In-Reply-To: <87efycduf0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2017 02:01 AM, Markus Armbruster wrote:

>>> @@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObjec=
t *request, Error **errp)
>>>
>>>          if (!strcmp(arg_name, "execute")) {
>>>              if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
>>> -                error_setg(errp, "QMP input object member '%s' expec=
ts '%s'",
>>> -                           "execute", "string");
>>> +                error_setg(errp,
>>> +                           "QMP input object member '%s' must be %s"=
,
>>> +                           "execute", "a string");
>>
>> let's avoid formatting like the rest of this patch.
>>

> Since substantial other work depends on this series, it needs to go in
> sooner rather than later.  I'm therefore *dropping* this patch from the=

> series.  We can then bikeshed^Wpolish to our heart's content without
> holding up other work.

Agreed.

>=20
> That said: what about this?

Looks better.  Do you want R-b now, or when you re-post it as an
official patch?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FaqHqJRCViDAbCQLUEVR1MAQnijrt9O51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvYnqAAoJEKeha0olJ0NqAFsH/R7MCHZrjMLUMvJ8Sj3pXn9J
5dE+en2rPNyPsblCjQuoLl42I1L6h6wFR7g9G5jNN88XN6WkK0cevC/8iRMIP3zW
Vp/EB9I/QbgDrEsR5ZVizi/ooNWLx2+RtQxcMogK4vli16MHXnRI8Q195Dvrk8jO
p08UOeMIwFEaqt6BAK1r09koVSWy83IMYv3v8cZHsolAiNUSPy2kQd3jbXq1EdFl
txhvWMUW9cdb2IfvOo5IG1h+vs18H8rBxNw3tPKJ6C+0t1RTQdTsDuUcQjmCeHE4
ZjkW3jUOVDXGhOlRIn4jQF4z4+447fU0N0B5U9Ue1gRj2nzQX/yqSxcBwDYxO/k=
=zKVF
-----END PGP SIGNATURE-----

--FaqHqJRCViDAbCQLUEVR1MAQnijrt9O51--
