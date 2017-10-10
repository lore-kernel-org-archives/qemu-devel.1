Received: from eggs.gnu.org ([2001:4830:134:3::10]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1vpg-0001c4-7I
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1vpf-0005r6-9E
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:48:32 -0400
References: <20171004020048.26379-1-eblake@redhat.com>
	<20171010125858.GI4177@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f222503d-2157-b260-38c8-8d3875c7fcf4@redhat.com>
Date: Tue, 10 Oct 2017 09:48:12 -0500
MIME-Version: 1.0
In-Reply-To: <20171010125858.GI4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hwIdKrwpqpNc044qT0BI01jfLv8feghw0"
Subject: Re: [Qemu-devel] [PATCH v5 00/23] make bdrv_get_block_status
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hwIdKrwpqpNc044qT0BI01jfLv8feghw0
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org
Message-ID: <f222503d-2157-b260-38c8-8d3875c7fcf4@redhat.com>
Subject: Re: [PATCH v5 00/23] make bdrv_get_block_status byte-based
References: <20171004020048.26379-1-eblake@redhat.com>
 <20171010125858.GI4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010125858.GI4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/10/2017 07:58 AM, Kevin Wolf wrote:
> Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
>> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
>> but NBD wants to report status on byte granularity (even if the
>> reporting will probably be naturally aligned to sectors or even
>> much higher levels).  I've therefore started the task of
>> converting our block status code to report at a byte granularity
>> rather than sectors.
>>
>> Now that 2.11 is open, I'm rebasing/reposting the remaining patches.
>>
>> The overall conversion currently looks like:
>> part 1: bdrv_is_allocated (merged, commit 51b0a488)
>> part 2: dirty-bitmap (v10 is queued [1])
>> part 3: bdrv_get_block_status (this series, v4 at [2])
>> part 4: .bdrv_co_block_status (v3 is posted [4], mostly reviewed)
>>
>> Available as a tag at:
>> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v4
>>
>> Based-on: <20170925145526.32690-1-eblake@redhat.com>
>> ([PATCH v10 00/20] make dirty-bitmap byte-based)
>> Based-on: <20171004014347.25099-1-eblake@redhat.com>
>> ([PATCH v2 0/5] block: Avoid copy-on-read assertions)
>=20
> We merged v3 of that series, which causes merge conflicts in this one.
> I can try to give the patches a look without applying them, but can you=

> rebase, please?

Yep, and I have other comments to address anyway.  v6 coming up later tod=
ay.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hwIdKrwpqpNc044qT0BI01jfLv8feghw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnc3a0ACgkQp6FrSiUn
Q2pV9wgAoqnivl1LkYdwgeV9Rgqmtt6RU5m1d2V8LnGjRLmTpD5yNyJTLkc60ATQ
NazjNkZZjhynXBLLJ8cmL6+H6FOe6ULgWEkmRti65sPA+gBpPEP57ARi00EE8N1G
zXuq/bsTs11No1Rkbz3Bw2m8atRT+SzG6okboZcbcusRxYznLMqtTiJqdlfTFQ/6
MupkUb2OD84aYNBOereCl8x0j65RjHk2DIWDF1RQOcbKuB3J/kGji381UKQGKjdh
7A+XWK3+Ch2t2TlkmF1nFppLLhAR3wwbQFUGeZCZDzeV9BMJnI8Vrj0rZO3L+tHu
tzocV90gRvDx9MBxo2xxbnnsxLBM9Q==
=dCwT
-----END PGP SIGNATURE-----

--hwIdKrwpqpNc044qT0BI01jfLv8feghw0--
