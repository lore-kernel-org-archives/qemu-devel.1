Received: from eggs.gnu.org ([2001:4830:134:3::10]:53932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kash@tripleback.net>) id 1eyhIA-0008TI-O4
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kash@tripleback.net>) id 1eyhI7-0007Vl-JI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:12:50 -0400
Received: from mail.tripleback.net ([198.50.226.104]:46216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kash@tripleback.net>) id 1eyhI7-0007VB-C6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 13:12:47 -0400
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-3-git-send-email-babu.moger@amd.com>
	<20180316180006.GH28578@localhost.localdomain>
	<CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180320175427.GU3417@localhost.localdomain>
	<CY4PR12MB1768A3CBE42AAFB03CB1081E95AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180321170941.GX3417@localhost.localdomain>
From: Kash Pande <kash@tripleback.net>
Message-ID: <f38780c9-e712-df10-9652-8613fd2aefd0@tripleback.net>
Date: Wed, 21 Mar 2018 13:12:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180321170941.GX3417@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RFWpB8MRhmgDzFuKgIb9FNYZIGt2Tvr3I"
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Moger, Babu" <Babu.Moger@amd.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "Hook, Gary" <Gary.Hook@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RFWpB8MRhmgDzFuKgIb9FNYZIGt2Tvr3I
From: Kash Pande <kash@tripleback.net>
To: Eduardo Habkost <ehabkost@redhat.com>, "Moger, Babu" <Babu.Moger@amd.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "rkrcmar@redhat.com"
 <rkrcmar@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 "Singh, Brijesh" <brijesh.singh@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>, "Hook, Gary"
 <Gary.Hook@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <f38780c9-e712-df10-9652-8613fd2aefd0@tripleback.net>
Subject: Re: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
 <1520888449-4352-3-git-send-email-babu.moger@amd.com>
 <20180316180006.GH28578@localhost.localdomain>
 <CY4PR12MB17686EB283987B8A5EDCF49295AB0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <20180320175427.GU3417@localhost.localdomain>
 <CY4PR12MB1768A3CBE42AAFB03CB1081E95AA0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <20180321170941.GX3417@localhost.localdomain>
In-Reply-To: <20180321170941.GX3417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-21 01:09 PM, Eduardo Habkost wrote:
> This makes sense if you want to change a CPU model to enable
> topoext by default.  But I suggest setting it for
> ("EPYC" "-" TYPE_X86_CPU) only, not TYPE_X86_CPU, as EPYC is the
> only CPU model affected by patch 4/5.


AIUI, all 17h CPUs have TOPOEXT and SMT support. I've been in contact
with Babu to have the patches extended to more general use case.



Kash



--RFWpB8MRhmgDzFuKgIb9FNYZIGt2Tvr3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEE5MQWwRLWQeWW1A0MLHWyk7icJXgFAlqykosUHGthc2hAdHJp
cGxlYmFjay5uZXQACgkQLHWyk7icJXhCJgf+KMh+nGBvPkYjbsbSTFtt5QyD+LG1
EyIbfDEwCLXjgOY4c2+Usb+HxgFWbdE11mfNK5fi5pktrBc3LvifSlmolAv+KZMb
bN22JDwkyVDVdsTelN2epc3rvRIhTtgoz16VnvnL6S0id9XDenDNddpx8O4jqTQO
gKDxqpDjQaV/jZD68s3p8GeP38336zyj+4P05sMdXio5mtwT15oTPUgFYjrAs1PD
MAKFkxjJ+2g5fHSzE7YOZwZvU2UE8NaEIRrdl+jpeHcDrM/9EKqFYepnxeP1rlO8
t9pDgvZiU6sG9Mptg6CilogiGHrOUZv0SKBrHuX+ALvKnx+tN770wwCrFg==
=vCRC
-----END PGP SIGNATURE-----

--RFWpB8MRhmgDzFuKgIb9FNYZIGt2Tvr3I--
