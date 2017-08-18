Received: from eggs.gnu.org ([2001:4830:134:3::10]:36304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diigi-0007XK-Sy
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diigf-0001so-QS
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:55:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diigf-0001rM-CI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:55:49 -0400
References: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
	<20170818143707.GE2222@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7006f856-bd13-0716-259a-a4c665e3b89a@redhat.com>
Date: Fri, 18 Aug 2017 09:55:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170818143707.GE2222@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W3BKRV6FUJB8tdFdTDrUDf6u9QvDXVANt"
Subject: Re: [Qemu-devel] [PATCH] QXL: always show default cursor,
 even for unsupported chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.com>, kraxel@redhat.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W3BKRV6FUJB8tdFdTDrUDf6u9QvDXVANt
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.com>, kraxel@redhat.com
Cc: qemu-devel@nongnu.org
Message-ID: <7006f856-bd13-0716-259a-a4c665e3b89a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] QXL: always show default cursor, even for
 unsupported chunks
References: <85cdeb9f-a6ea-5530-edcd-10ed3853026f@exactcode.com>
 <20170818143707.GE2222@work-vm>
In-Reply-To: <20170818143707.GE2222@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2017 09:37 AM, Dr. David Alan Gilbert wrote:
> cc'ing in Gerd
>=20
> * Ren=C3=A9 Rebe (rene@exactcode.com) wrote:
>> Hi,
>>
>> I was testing a Windows 10 guest with HiDPI scaling which
>>
>> actually made the cursor disappear and only multiple chunks
>>
>> warnings being printed.
>>
>> When the cursor is using currently unsupported multiple chunks, the
>> builtin-left cursor is better than none.

This part is okay, but might be better written in an imperative sense
(the best commit messages are ones where you add an implicit "Apply this
patch to ..." prior to the first word after the blank line separating
the subject).

>>
>> PS: if TB damages the white-space just let me know, only recently star=
ted
>> using it, ...

This part belongs after a --- separator, as it is useful to reviewers
but adds nothing to git.

By the way, while your patch did not appear to be whitespace damaged on
a cursory glance, the fact that you used thunderbird to send it is
risky; thunderbird HAS been known to mess up patches that are pasted
inline, and sending patches as attachments is harder to read than direct
patches.  Using 'git send-email' excels at making sure the patch will be
in a format easy to apply.

>>
>>   - Ren=C3=A9 Rebe <rene@exactcode.de>

And this is not a proper Signed-off-by: tag; we'll need one of those
before your patch can be considered.  More hints at:
http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--W3BKRV6FUJB8tdFdTDrUDf6u9QvDXVANt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmW/+0ACgkQp6FrSiUn
Q2oj5ggAqZ87xs1gPKucB/SagRQnnqY7TKALl2yU/2+krb7dcy6Ggrny9ufyuy8V
2dsVpCPdrj99xJP0kZd8GgGZo/OHvq1tc5A+djCqWGbDmCaVu7oqJ10zEl2K4D5T
anD6KAOBH+xkw2Oxh+Nus0y9c69vYMV4BhH3Ve7NLVpe0YSL4ZYcrpYi6AODpV4z
ou5wjVyP8eHxBnVw1ncaE3G8mbXsrpr98wCS+R5yfno7rWjUCu63g/gIX4EvY7iL
aeMDd2pASlMH1sUpRdxUGA776QEqV6lEiZgEUGT341Hu0DLniRAZG9wz3YQVNwk3
q/mcusl7lB3T0ib5ETWPbZrr7Q/ZKQ==
=DYvD
-----END PGP SIGNATURE-----

--W3BKRV6FUJB8tdFdTDrUDf6u9QvDXVANt--
