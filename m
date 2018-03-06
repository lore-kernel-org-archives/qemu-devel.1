Received: from eggs.gnu.org ([2001:4830:134:3::10]:45704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1et5j8-0004OY-0d
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1et5j4-0002tf-Sb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 01:05:29 -0500
References: <152027837043.1380.11419692105622507583@bdbb90650ae5>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <87d75913-1a85-41d8-4508-c08a837d4ebe@redhat.com>
Date: Tue, 6 Mar 2018 07:05:14 +0100
MIME-Version: 1.0
In-Reply-To: <152027837043.1380.11419692105622507583@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Move string arrays from
 bootmap header to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 05.03.2018 20:32, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
[...]
> /var/tmp/patchew-tester-tmp-tbi65_5t/src/pc-bios/s390-ccw/bootmap.c:51:=
22: error: =E2=80=98vol_desc_magic=E2=80=99 defined but not used [-Werror=
=3Dunused-const-variable=3D]
>  static const uint8_t vol_desc_magic[] =3D "CD001";
>                       ^~~~~~~~~~~~~~

Oops, copy-n-paste error, please ignore this version of the patch! (I
wonder why my compiler did not complain here...)

 Thomas
