Received: from eggs.gnu.org ([2001:4830:134:3::10]:33504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dug5R-0005QU-F0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dug5O-0004fQ-8E
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dug5N-0004f0-V0
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:34:46 -0400
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<20170920111431.1435dacd.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8db42985-77cd-6be6-585f-de402fbc64ce@redhat.com>
Date: Wed, 20 Sep 2017 09:34:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170920111431.1435dacd.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9nOSuUac9U1Qbq0cahJhC2mtcVCO1RWLP"
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9nOSuUac9U1Qbq0cahJhC2mtcVCO1RWLP
From: Eric Blake <eblake@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>
Message-ID: <8db42985-77cd-6be6-585f-de402fbc64ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
 <20170920111431.1435dacd.cohuck@redhat.com>
In-Reply-To: <20170920111431.1435dacd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 04:14 AM, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 09:43:14 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
>> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>>
>> This patch is the s390 implementation of guest crash information, simi=
lar
>> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") =
and
>> the related commits. We will detect several crash reasons, with the
>> "disabled wait" being the most important one, since this is used by al=
l
>> s390 guests as a "panic like" notification.
>>

>>       "data": {
>>           "action": "pause",
>>           "info": {
>>               "psw-addr": 1105350,
>>               "reason": "disabled wait",
>>               "psw-mask": 562956395872256,
>>               "type": "s390"
>>           }
>>       }
>>   }
>=20
> Out of scope for this patch, but is there a way to print the values as
> hex in the monitor?
>=20

Sadly, no. JSON intentionally chose decimal-only as its numeric format,
so hex values can only be provided as JSON strings.  And since pure JSON
doesn't even allow comments, it's tough to argue that we could modify
the JSON pretty-printer to even list a hex representation as a comment
alongside every integer (although it's hard to know without more context
which values are most useful as hex, so it may be noisier than expected
if every JSON number has that sort of comment).

>>
>>   3. log;
>>
>>   Run qemu with the parameters: -D <logfile> -d guest_errors, to
>>   specify the logfile and log item. The results might be,
>>
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> =20
>>   Guest crashed
>>   S390 crash parameters: (0x2000180000000 0x10ddc6)
>=20
> Would it make sense to pad with zeroes, for readability?

Here, you're asking about post-processing the JSON output - at which
point, yes, we can make whatever changes we want to the decimal data
passed over the wire to transform it into something more useful to the
reader.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9nOSuUac9U1Qbq0cahJhC2mtcVCO1RWLP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCfH0ACgkQp6FrSiUn
Q2rKNwf9H7JKvqWvpqnLnlJxZ7bO+rux5DNESTXR0XTgt4S5HKti3MR6fvT9kcek
JucSSr2K5cuYRXfRIlyo1Cpjp0W1Qz2X8O8T1BiF+9cnnKaORZ30C6qqJmVRmY3N
hLgec7aGDkZa5UDShjcxaGLSKq0Y7F7OCX02sO9tDy1GC8H1e238CroKcJqxk7it
VO4dFFZEhkz2bTfmgdtv9EO+D3mgmidB1U+l+2WGgOnAMX38mEBodXBhF3/mLB/d
6xZ6fCh/K6/AFsHN8JYOPEzHc1lyIhgwhpx/nvPiHWS+/gco/TykfQOYEJd/POkP
8APw3kndgtXdIZOHjBmhr5DgMKIEPQ==
=PDd5
-----END PGP SIGNATURE-----

--9nOSuUac9U1Qbq0cahJhC2mtcVCO1RWLP--
