Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8NEj-00046h-Sf
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8NEh-0003N9-5c
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:49:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f8NEg-0003Ge-O9
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:49:14 -0400
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
	<1523861081-3600-2-git-send-email-thuth@redhat.com>
	<20180417072134.GJ10770@stefanha-x1.localdomain>
	<275bfe53-7c94-0ad0-b388-d8a44a7fb76f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc89e971-06fd-6bf4-6a68-73a4ffa26b0d@redhat.com>
Date: Tue, 17 Apr 2018 11:48:44 +0200
MIME-Version: 1.0
In-Reply-To: <275bfe53-7c94-0ad0-b388-d8a44a7fb76f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GvNzy6Hiwmldo9EpX4w9j6qqbIwBTiKzX"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.13 1/3] net: Remove the deprecated
 "vlan" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GvNzy6Hiwmldo9EpX4w9j6qqbIwBTiKzX
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>
Message-ID: <bc89e971-06fd-6bf4-6a68-73a4ffa26b0d@redhat.com>
Subject: Re: [PATCH v3 for-2.13 1/3] net: Remove the deprecated "vlan"
 parameter
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
 <1523861081-3600-2-git-send-email-thuth@redhat.com>
 <20180417072134.GJ10770@stefanha-x1.localdomain>
 <275bfe53-7c94-0ad0-b388-d8a44a7fb76f@redhat.com>
In-Reply-To: <275bfe53-7c94-0ad0-b388-d8a44a7fb76f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/04/2018 10:08, Thomas Huth wrote:
>>> -    "-net nic[,vlan=3Dn][,netdev=3Dnd][,macaddr=3Dmac][,model=3Dtype=
][,name=3Dstr][,addr=3Dstr][,vectors=3Dv]\n"
>>> +    "-net nic[,macaddr=3Dmac][,model=3Dtype][,name=3Dstr][,addr=3Dst=
r][,vectors=3Dv]\n"
>>>      "                configure or create an on-board (or machine def=
ault) NIC and\n"
>>> -    "                connect it either to VLAN 'n' or the netdev 'nd=
' (for pluggable\n"
>>> -    "                NICs please use '-device devtype,netdev=3Dnd' i=
nstead)\n"
>>> +    "                connect it to hub 0 (please use -nic for direct=
 connections)\n"
>> What does "direct connections" means?
> I mean a 1:1 connection between the backend and frontend here, without =
a
> hub inbetween. Can you think of a better wording?

"use -nic unless you need a hub"?

Paolo


--GvNzy6Hiwmldo9EpX4w9j6qqbIwBTiKzX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlrVwwQACgkQv/vSX3jH
roPm9gf7BC6Je/m+vTlHFzCWVBungUokFfitY6wy2x8uAyLCdu5CZ5YI78CvCP8d
XWETVqRU8OubE1vGvqxtXUEZ8bPlVqhMazc/CHPO1OIHkJc/S+fWNNcFM7q0nXzD
1m6PNPOCmixSqH3aVnF9ziABjpvHG3UILQ6leRNhNMaUqBNZbf/yOiGHbSupmrqB
0XaHfpDsoXPX1Pnro2FtkTOt7EVR2ZMBln1Xz4IlQlHjS4sXuHNNE7kkAPYAf4dY
3qRGb9vJiFg5dSV+UvhlnlkhFUxxVHiA2LdUeo9HbLsUIqGZ1YZYPMIxD6R8FuKY
09evq+a813zEV3L0bC9znIT1CMlzJg==
=Qgfd
-----END PGP SIGNATURE-----

--GvNzy6Hiwmldo9EpX4w9j6qqbIwBTiKzX--
