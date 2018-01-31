Received: from eggs.gnu.org ([2001:4830:134:3::10]:60924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxGE-0007K4-9G
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxGA-0006Jp-BD
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:37:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egxGA-0006JB-2w
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:37:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62F1028216
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 18:37:25 +0000 (UTC)
References: <20180129162408.415-1-kraxel@redhat.com>
	<20180129162408.415-5-kraxel@redhat.com>
	<87d11pvrct.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c072cd81-634a-0d96-a2a1-7acff7522e56@redhat.com>
Date: Wed, 31 Jan 2018 12:37:20 -0600
MIME-Version: 1.0
In-Reply-To: <87d11pvrct.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nH1EVHnYGQBcMlpjV6DDYx8vBCous0t72"
Subject: Re: [Qemu-devel] [PATCH v2 04/12] gtk: add and use DisplayOptions +
 DisplayGTK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nH1EVHnYGQBcMlpjV6DDYx8vBCous0t72
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c072cd81-634a-0d96-a2a1-7acff7522e56@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/12] gtk: add and use DisplayOptions +
 DisplayGTK
References: <20180129162408.415-1-kraxel@redhat.com>
 <20180129162408.415-5-kraxel@redhat.com> <87d11pvrct.fsf@dusky.pond.sub.org>
In-Reply-To: <87d11pvrct.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 12:02 PM, Markus Armbruster wrote:
> Got a QAPI remark, cc: Eric.
>=20
> Gerd Hoffmann <kraxel@redhat.com> writes:
>=20

>> +++ b/qapi/ui.json
>> @@ -982,3 +982,62 @@
>>    'data': { '*device': 'str',
>>              '*head'  : 'int',
>>              'events' : [ 'InputEvent' ] } }
>> +
>> +
>> +##
>> +# @DisplayNoOpts:
>> +#
>> +# Empty struct for displays without config options.
>> +#
>> +# Since: 2.12
>> +#
>> +##
>> +{ 'struct'  : 'DisplayNoOpts',
>> +  'data'    : { } }
>=20
> This is the fifth empty struct (QCryptoBlockInfoQCow, NetdevNoneOptions=
,
> Abort, CpuInfoOther), not counting the QAPI frontend's internal one.
> Perhaps we should make the internal one a full built-in type.  Not this=

> patch's problem, of course.

Yeah, I really need to revive my patch that would allow:

>> +{ 'union'   : 'DisplayOptions',
>> +  'base'    : { 'type'           : 'DisplayType',
>> +                '*full-screen'   : 'bool',
>> +                '*window-close'  : 'bool',
>> +                '*gl'            : 'bool' },
>> +  'discriminator' : 'type',
>> +  'data'    : { 'default'        : 'DisplayNoOpts',
>> +                'none'           : 'DisplayNoOpts',
>> +                'gtk'            : 'DisplayGTK' } }

 'data': { 'none': {},
           'gtk': 'DisplayGTK' }

Whoa - it's been a while!
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg00311.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nH1EVHnYGQBcMlpjV6DDYx8vBCous0t72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyDOEACgkQp6FrSiUn
Q2rGBQgApuJyMN1bmzRn+XNsJ6s30Zcn3XIg46auNtcuRDwQTcEkn7gPA2FN76IA
hnTnr1Dt1+r3AuXl7TUYVjgNbDP0k5mb4/p3qhCID64V/X1XkiI/VaiDNA5ECWh/
v27I/rudGY8Rux1qa669d+NatLweSaN3/s0PCvTd0jikhMg00/PQx3Pa5tttMBIq
G5zpUqTFW6bVssC2yuUijvaMkNgNYxzwbOlfVC06x+W0vWTySbS2ZuJSHr7jqql/
bA0B8FJLctCtiLXSs21SoJEfEERuFqZ9n6pw4zFnuFEp7EEAn6+Pq1b//H+wgfHA
nMglIHJGSdLnqrv5UKKjJBg9tz51Gw==
=hutu
-----END PGP SIGNATURE-----

--nH1EVHnYGQBcMlpjV6DDYx8vBCous0t72--
