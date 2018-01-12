Received: from eggs.gnu.org ([2001:4830:134:3::10]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ea44Q-0006AU-TS
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ea44N-0005Q2-Q9
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:28:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1ea44N-0005LG-FJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:28:47 -0500
From: Jack Schwartz <jack.schwartz@oracle.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Message-ID: <e389d65a-ba0f-3104-4cb4-51060bf84d2c@oracle.com>
Date: Fri, 12 Jan 2018 10:28:59 -0800
MIME-Version: 1.0
In-Reply-To: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ping: Re: [PATCH QEMU v1 0/4] multiboot: bss_end_addr
 can be zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

Hi everyone.

Ping!=C2=A0 Please review.

Patchwork links:

1/4 multiboot: bss_end_addr can be zero
http://patchwork.ozlabs.org/patch/852049/

2/4 multiboot: Remove unused variables from multiboot.c
http://patchwork.ozlabs.org/patch/852045/

3/4 multiboot: Use header names when displaying fields
http://patchwork.ozlabs.org/patch/852046/

4/4 multiboot: fprintf(stderr...) -> error_report()
http://patchwork.ozlabs.org/patch/852051/

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack


On 12/21/17 09:25, Jack Schwartz wrote:
> Properly account for the possibility of multiboot kernels with a zero
> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
> kernels without a bss section, by allowing a zeroed bss_end_addr multib=
oot
> header field.
>
> Do some cleanup to multiboot.c as well:
> - Remove some unused variables.
> - Use more intuitive header names when displaying fields in messages.
> - Change fprintf(stderr...) to error_report
>
> Testing:
>    1) Ran the "make check" test suite.
>    2) Booted multiboot kernel with bss_end_addr=3D0.  (I rolled my own
>       grub multiboot.elf test "kernel" by modifying source.)  Verified
>       with gdb that new code that reads addresses/offsets from multiboo=
t
>       header was accessed.
>    3) Booted multiboot kernel with non-zero bss_end_addr.
>    4) Uncommented DEBUG_MULTIBOOT in multiboot.c and verified messages =
worked.
>    5) Code has soaked in an internal repo for two months.
>
> 	Thanks,
> 	Jack
>
> Jack Schwartz (4):
>    multiboot: bss_end_addr can be zero
>    multiboot: Remove unused variables from multiboot.c
>    multiboot: Use header names when displaying fields
>    multiboot: fprintf(stderr...) -> error_report()
>
>   hw/i386/multiboot.c | 77 ++++++++++++++++++++++++++------------------=
---------
>   1 file changed, 38 insertions(+), 39 deletions(-)
>
