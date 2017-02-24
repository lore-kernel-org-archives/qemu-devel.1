Received: from eggs.gnu.org ([2001:4830:134:3::10]:58264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chJQf-0005dh-Aj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1chJQa-0007sQ-LR
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:13:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1chJQa-0007s8-CY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:13:08 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B46F7E9D5
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 17:13:08 +0000 (UTC)
References: <20170222180423.26571-1-pbonzini@redhat.com>
	<20170222180423.26571-2-pbonzini@redhat.com>
	<87d1e7abbb.fsf@dusky.pond.sub.org>
	<09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
	<488abb9e-d1d3-30ad-18e1-3a00bb7f10d8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <302e693e-9f6f-52b5-a662-a2d7d35da0a3@redhat.com>
Date: Fri, 24 Feb 2017 18:12:59 +0100
MIME-Version: 1.0
In-Reply-To: <488abb9e-d1d3-30ad-18e1-3a00bb7f10d8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o0OeD7d2nITSOFq3pFRrsaFMdXoJE1k5f"
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o0OeD7d2nITSOFq3pFRrsaFMdXoJE1k5f
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Message-ID: <302e693e-9f6f-52b5-a662-a2d7d35da0a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qom-qobject: introduce
 object_property_{g, s}et_ptr
References: <20170222180423.26571-1-pbonzini@redhat.com>
 <20170222180423.26571-2-pbonzini@redhat.com>
 <87d1e7abbb.fsf@dusky.pond.sub.org>
 <09c6aaf5-0575-0445-b8bc-400c026a8a68@redhat.com>
 <488abb9e-d1d3-30ad-18e1-3a00bb7f10d8@redhat.com>
In-Reply-To: <488abb9e-d1d3-30ad-18e1-3a00bb7f10d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/02/2017 17:54, Eric Blake wrote:
>> If you're setting UserDefOne from UserDefOneMore, some of the values a=
re
>> going to be lost.  Presumably there was a reason why you used
>> UserDefOneMore, and therefore an error is the safe bet.
>>
>> If you're getting UserDefOne from UserDefOneMore, some of the values a=
re
>> going to be lost.  However, it's reasonable that you didn't even know
>> that UserDefOneMore existed, which makes it sensible to allow reading
>> into a covariant type.
>
> How often to we add qapi subtypes, but not adjust the rest of the code
> base to cope with it existing?  Is it going to be less of a maintenance=

> burden just patching all the uses of the property getters to deal with
> the new type than it is to keep the non-strict visitor?

It's not about adjusting the rest the code, it's about the other code
not caring about the data in the subtype.  Why should it be using it
rather than the supertype?

Paolo


--o0OeD7d2nITSOFq3pFRrsaFMdXoJE1k5f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYsGmeAAoJEL/70l94x66D2AgH/2AWs5nKQqLtyzgyVBM7Zg0j
3LHlWiUOwXp/oauKmJ2S+JvACuCeotTJT80p0R+dwGXtKde7k12YNiLPsUG00E8o
dQGRy2XZNLxMAjAARhyu82Y21TKMLt/xkayhEez3fndSPRNROXs33VZiF5vdx1Qx
HWYoJnOypTqkwQq3914HEBx9FWGY2LiMbseJsjgMrtCCZzlL07OXVqJ5wKg7Gp+2
kGfhXlegSOnOIh9TB4kmDsXggNtgMmUOv8sLMNnlc2qKoGgqM+zuOmIRrd5z3GXx
t6RnllwdWLXabcxOyQ7nQmd9Y8H58ZVnmB/AiOB+NUq0okTFD4X5ohQZV+jKUFE=
=1/hS
-----END PGP SIGNATURE-----

--o0OeD7d2nITSOFq3pFRrsaFMdXoJE1k5f--
