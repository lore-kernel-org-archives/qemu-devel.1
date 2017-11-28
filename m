Received: from eggs.gnu.org ([2001:4830:134:3::10]:35982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fweimer@redhat.com>) id 1eJeev-0002yD-0s
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fweimer@redhat.com>) id 1eJeeq-0000f8-Ah
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:06:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fweimer@redhat.com>) id 1eJeeq-0000be-51
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:06:36 -0500
References: <20171128113204.22912-1-pbonzini@redhat.com>
	<CAJ+F1CLzoyrtwG=iiB0_ocMGELrYY9-v_pm4AGaShFw3_CzHhQ@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <ac018dcf-7868-052e-7bdb-df0f3774f060@redhat.com>
Date: Tue, 28 Nov 2017 13:06:31 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLzoyrtwG=iiB0_ocMGELrYY9-v_pm4AGaShFw3_CzHhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

On 11/28/2017 12:42 PM, Marc-Andr=C3=A9 Lureau wrote:

> Couldn't the declarations be put in sys/memfd.h like the man claimed
> it would be for > 1y?

We discussed it.  It was a typo in the manual page.  There never was a=20
<sys/memfd.h> header file:

   https://marc.info/?l=3Dlinux-man&m=3D150988359906012&w=3D2

The UAPI header is called <linux/memfd.h>.

The downside of using a separate header is that you cannot determine,=20
using the preprocessor alone, whether the toolchain provides the=20
memfd_create function.  If we put everything in <sys/mman.h>, you can=20
use =E2=80=9C#ifdef MFD_CLOEXEC=E2=80=9D to see if the definitions and de=
clarations are=20
there.

Thanks,
Florian
