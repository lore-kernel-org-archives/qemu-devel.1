Received: from eggs.gnu.org ([2001:4830:134:3::10]:35897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSLla-0007A6-6o
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSLlV-00027s-7N
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:14 -0400
References: <20170703131455.25424-1-lvivier@redhat.com>
	<20170703131455.25424-3-lvivier@redhat.com>
	<fe1a3b5f-2811-3776-b777-4ae025bf74a1@redhat.com>
	<20170704092701.GD2180@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aa80a641-897b-0408-71d5-55b0d1add29c@redhat.com>
Date: Tue, 4 Jul 2017 13:13:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170704092701.GD2180@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="AX1crM6B7JFIeTAmUnEwetCuP96cBthpr"
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v3 2/2] target/ppc: move POWER9
 DD1 workaround to ppc_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Suraj Singh <sursingh@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AX1crM6B7JFIeTAmUnEwetCuP96cBthpr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.07.2017 11:27, David Gibson wrote:
> On Tue, Jul 04, 2017 at 10:17:18AM +0200, Thomas Huth wrote:
>> On 03.07.2017 15:14, Laurent Vivier wrote:
>>> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
>>> disables compatibility mode for POWER9 DD1 to allow to
>>> boot on POWER9 DD1 host with KVM.
>>>
>>> As the workaround has been added in kvmppc_host_cpu_class_init(),
>>> it applies only on CPU created with "-cpu host".
>>> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
>>> host, this patch moves the workaround from kvmppc_host_cpu_class_init=
()
>>> to ppc_cpu_initfn().
>>
>> Would it be feasible to move it to init_proc_POWER9() instead? I think=

>> that would be a better location for the POWER9 workaround ... not sure=

>> whether it can be done there, though.
>=20
> That would be neater if it works.  I've applied the patch as is for
> now, but if that does work, a follow up to move the workaround would
> be nice.

Seems like it works ... Could you use the patches from v4 instead?

 Thomas




--AX1crM6B7JFIeTAmUnEwetCuP96cBthpr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZW3hBAAoJEC7Z13T+cC21y3YP/iGOMNOA09vWhhQGSo125KFv
MRWsFoaJFkx8zy8tjepVfLhgpfzT9lV701L7kRIls3xtNygoqN6EUcfayfDXSV/M
y/yecXGtZik+xX8nl3MpZ9jCtmZahGJrBs0ybB2eCTxQLHKqMIHfwILPsj5nIodj
D1QHd3G6IgrUkmSlvIonoI50hZYEgqIdQWAjS3gJuWKmzYVp7mjbxbvwy2Nuz4aL
BC8tfCqaHDxCZGfWKW1Bwdz2tGUyY5g6vz2K06Ic3OcH0qohfAWLUwTJzoiyrh7X
gWGOnt1WwJli9HSyvK+Zu7Yp0K5FThxGdek0nosfIUr9w7GAYg16hHcW7NFBnBLx
eUfe2SZRw36ifGcU0WZ5trd84R69tgzEP7nvV2AH80ndrit3LoR73hKPgSnq7u2V
CHV+dUvyRO8+KBrWiI8Z6hqvPjijdgjvTLrDi9Alh4R1DPAYENV+b/RPrgGEWZYJ
2Y8WDpKT69XJL66kMnUI/Hv/xGIJGV2/97aMCZIlpaWcjfuE/q6/xKwG07YaJaGM
jZcWdKhIR5zgMJeaKFGYGnHEw0Of/R70Nl+o2eBWv/UNPXN6zZ567OpHkzEnjA+A
sZBhYLdVaVrmQ8t46wd+KecFkJ3mGDFAKH+/MqMDIB/Exb8aE0Q5gdgQvDqJQ/5l
4CItwElj0KID0Wplke3w
=PIMI
-----END PGP SIGNATURE-----

--AX1crM6B7JFIeTAmUnEwetCuP96cBthpr--
