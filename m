Received: from eggs.gnu.org ([2001:4830:134:3::10]:59729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1hP-0000qQ-UF
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv1hL-0003Xh-5H
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:07:11 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-4-git-send-email-armbru@redhat.com>
	<20170403114855.GV2768@redhat.com>
	<6516cecc-4f5f-9255-3890-7fed57ab7eb4@redhat.com>
	<20170403130517.GX2768@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4616469d-a3cc-e78a-0c4a-578814eec65d@redhat.com>
Date: Mon, 3 Apr 2017 15:06:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170403130517.GX2768@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LD6fBhrKJoVqtHKIthc5OFTXFqXKbfrcK"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 03/10] io vnc sockets: Clean up
 SocketAddressKind switches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LD6fBhrKJoVqtHKIthc5OFTXFqXKbfrcK
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 jcody@redhat.com, pbonzini@redhat.com, namei.unix@gmail.com
Message-ID: <4616469d-a3cc-e78a-0c4a-578814eec65d@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 03/10] io vnc sockets: Clean up
 SocketAddressKind switches
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-4-git-send-email-armbru@redhat.com>
 <20170403114855.GV2768@redhat.com>
 <6516cecc-4f5f-9255-3890-7fed57ab7eb4@redhat.com>
 <20170403130517.GX2768@redhat.com>
In-Reply-To: <20170403130517.GX2768@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.2017 15:05, Daniel P. Berrange wrote:
> On Mon, Apr 03, 2017 at 02:50:12PM +0200, Max Reitz wrote:
>> On 03.04.2017 13:48, Daniel P. Berrange wrote:
>>> On Thu, Mar 30, 2017 at 03:15:00PM +0200, Markus Armbruster wrote:
>>>> We have quite a few switches over SocketAddressKind.  Some have case=

>>>> labels for all enumeration values, others rely on a default label.
>>>> Some abort when the value isn't a valid SocketAddressKind, others
>>>> report an error then.
>>>>
>>>> Unify as follows.  Always provide case labels for all enumeration
>>>> values, to clarify intent.  Abort when the value isn't a valid
>>>> SocketAddressKind, because the program state is messed up then.
>>>>
>>>> Improve a few error messages while there.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  io/dns-resolver.c   |  7 +++++--
>>>>  ui/vnc.c            | 18 ++++++++++++------
>>>>  util/qemu-sockets.c |  4 +---
>>>>  3 files changed, 18 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/io/dns-resolver.c b/io/dns-resolver.c
>>>> index 0ac6b23..a407075 100644
>>>> --- a/io/dns-resolver.c
>>>> +++ b/io/dns-resolver.c
>>>> @@ -164,9 +164,12 @@ int qio_dns_resolver_lookup_sync(QIODNSResolver=
 *resolver,
>>>>                                                  addrs,
>>>>                                                  errp);
>>>> =20
>>>> +    case SOCKET_ADDRESS_KIND_FD:
>>>> +        error_setg(errp, "Unsupported socket address type 'fd'");
>>>> +        return -1;
>>>> +
>>>>      default:
>>>> -        error_setg(errp, "Unknown socket address kind");
>>>> -        return -1;
>>>> +        abort();
>>>>      }
>>>>  }
>>>
>>> Just repeating my v1 comments - this needs to be treating KIND_FD as =
a no-op,
>>> rather than raising an error.
>>
>> Do you want to write a patch? Markus is on vacation and since this is
>> not a regression, dropping this patch from my queue wouldn't do any go=
od
>> either.
>=20
> Ok, i'll do a follow up.

Thanks a lot!

Max


--LD6fBhrKJoVqtHKIthc5OFTXFqXKbfrcK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljiSO4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AI+cH/1E08TvK4dskIxR4divEy6C9tddmuEQk
NSDGxWTn6xfN/NhhweAtc9zkOjDp/3dg1fyC9FWva9/ZA+9lh9sbj1CZjXCFmpMV
RmkdGy0htB8hsZVmfJt/esK8zzjh4akmrTZ0oSEO2lItwXbPd70PMMRS1oSsGdzE
C/Fvt/JpBxLHD/PCxsE5/NKChpkwcuuULXccgb0EHTD6agmBUYinUxhNFZbQK4VM
O43MJR1ohrWfDSN62njvDOCT4LxKz+8ZB3dj8CKYqTYNPGIZtVns8QBVu/x2SkPe
3MPi78Zh0+je2qljyQSLiZDDbU10oEg3GM+trovIaaxV+kl2EOdv+BM=
=+/h/
-----END PGP SIGNATURE-----

--LD6fBhrKJoVqtHKIthc5OFTXFqXKbfrcK--
