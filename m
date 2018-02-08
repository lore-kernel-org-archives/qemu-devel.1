Received: from eggs.gnu.org ([2001:4830:134:3::10]:52510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuw9-0005Ad-Dp
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuw6-0000ov-Ci
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:45:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejuw6-0000oe-7d
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:44:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C098E404084A
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 22:44:57 +0000 (UTC)
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
	<1518120582-26647-15-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6825645b-8ed2-75a5-ac80-17931b16c709@redhat.com>
Date: Thu, 8 Feb 2018 16:44:57 -0600
MIME-Version: 1.0
In-Reply-To: <1518120582-26647-15-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/14] tests/boot-serial-test: Add support
 for the aarch64 virt machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 02/08/2018 02:09 PM, Thomas Huth wrote:
> From: Wei Huang <wei@redhat.com>
> 
> This patch adds a small binary kernel to test aarch64 virt machine's
> UART.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> [thuth: Fixed contextual conflict with the hppa patch]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include   | 1 +
>   tests/boot-serial-test.c | 9 +++++++++
>   2 files changed, 10 insertions(+)
> 

> +++ b/tests/boot-serial-test.c
> @@ -55,6 +55,13 @@ static const uint8_t bios_raspi2[] = {
>       0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
>   };
>   
> +static const uint8_t kernel_aarch64[] = {
> +    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
> +    0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
> +    0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
> +    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
> +};

Code like this reminds me of the 1984 IOCCC winner 
(https://www.ioccc.org/1984/mullender/mullender.c) - there's just 
something strangely satisfying about an array of integers being compiled 
into executable code ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
