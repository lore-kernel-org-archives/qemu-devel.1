Received: from eggs.gnu.org ([2001:4830:134:3::10]:52931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK5Ko-0005tw-CT
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gK5Ke-0008Av-KI
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gK5Kd-0006cQ-HN
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:03 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA6HYL4o047975
	for <qemu-devel@nongnu.org>; Tue, 6 Nov 2018 12:39:04 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nkcxm047j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 12:39:04 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Tue, 6 Nov 2018 17:39:03 -0000
References: <20181106112829.1948-1-kraxel@redhat.com>
	<20181106112829.1948-2-kraxel@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 6 Nov 2018 12:38:58 -0500
MIME-Version: 1.0
In-Reply-To: <20181106112829.1948-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <3ecb139d-4e06-d04c-8ae3-69ffeda78372@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/1] update seabios to master snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 11/6/18 6:28 AM, Gerd Hoffmann wrote:
> seabios 1.12 release is planned for november.
>
> update seabios to a master branch snapshot so it gets more testing
> and to make the delta smaller when updating to -final during freeze.
>
> git shortlog rel-1.11.2..14221cd86e
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [...]
>
> Paul Menzel (1):
>        docs/Download: Use more secure HTTPS URLs where possible
>
> Stefan Berger (5):
>        tpm: Add support for TPM2 ACPI table
>        tpm: Wait for tpmRegValidSts flag on CRB interface before probin=
g
>        tpm: revert return values for successful/failed CRB probing
>        tpm: when CRB is active, select, lock it, and check addresses
>        tpm: Request access to locality 0
>
> Stephen Douthit (3):
>        tpm: Refactor duplicated wait code in tis_wait_sts() & crb_wait_=
reg()
>        tpm: Wait for interface startup when probing
>        tpm: Handle unimplemented TIS_REG_IFACE_ID in tis_get_tpm_versio=
n()
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks for taking the latest version. If this works out well, would it=20
be possible to use this version of Seabios also for QEMU 3.0 stable? I=20
am asking primarily due to the TPM patches and the fact that QEMU 3.0 is=20
packaged in F29, with the CRB port missing in Seabios...


 =C2=A0=C2=A0 Stefan
