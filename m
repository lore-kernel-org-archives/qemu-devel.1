Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dh9Dt-0002LE-Nn
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dh9Dq-00013f-My
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dh9Dq-00011l-G2
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:51:34 -0400
References: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff49cfa1-5a00-c329-1647-3ad8367cc804@redhat.com>
Date: Mon, 14 Aug 2017 08:51:27 +0200
MIME-Version: 1.0
In-Reply-To: <C2D23A89-6DB7-445C-BC25-71E9E49C288D@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Help with Windows NT 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 13/08/2017 21:13, Programmingkid wrote:
> Lately I found out that Windows NT 4.0 seems to work well with the
> 486 and pentium processors. Using "-cpu 486" made installing it
> actually work. Now I am seeing another issue. When I boot Windows NT
> 4.0 I see this error message:
>=20
> *** STOP: 0x0000007B (0x807A8610,0x00000000,0x00000000,0x00000000)=20
> INACESSIBLE_BOOT_DEVICE
>=20
> Would anyone know a way to solve this issue?

Herv=C3=A9 is probably the best person to answer this question.  Maybe tr=
y
installing it with SCSI disks ("-drive if=3Dscsi,id=3Dhd,file=3D... -driv=
e
if=3Dscsi,id=3Dcd,file=3D... -device lsi -device scsi-hd,drive=3Dhd -devi=
ce
scsi-cd,drive=3Dcd").

Thanks,

Paolo
