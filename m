Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX1w-0000t6-Ks
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX1v-0003Tz-NA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:14:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1etX1v-0003Sp-IL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:14:43 -0500
Date: Wed, 7 Mar 2018 12:14:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180307111430.GB7917@localhost.localdomain>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
Subject: Re: [Qemu-devel] [PATCH QEMU v1 0/4] multiboot: bss_end_addr can be
 zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
> Properly account for the possibility of multiboot kernels with a zero
> bss_end_addr.  The Multiboot Specification, section 3.1.3 allows for
> kernels without a bss section, by allowing a zeroed bss_end_addr multiboot
> header field.
> 
> Do some cleanup to multiboot.c as well:
> - Remove some unused variables.
> - Use more intuitive header names when displaying fields in messages.
> - Change fprintf(stderr...) to error_report
> 
> Testing:
>   1) Ran the "make check" test suite.
>   2) Booted multiboot kernel with bss_end_addr=0.  (I rolled my own
>      grub multiboot.elf test "kernel" by modifying source.)  Verified
>      with gdb that new code that reads addresses/offsets from multiboot
>      header was accessed.
>   3) Booted multiboot kernel with non-zero bss_end_addr.
>   4) Uncommented DEBUG_MULTIBOOT in multiboot.c and verified messages worked.
>   5) Code has soaked in an internal repo for two months.
> 
> 	Thanks,
> 	Jack

Thanks, applied to my multiboot branch.

Kevin
