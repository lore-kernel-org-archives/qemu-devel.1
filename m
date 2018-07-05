Received: from eggs.gnu.org ([2001:4830:134:3::10]:56747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fb4u5-0005RX-0R
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fb4u0-0007hY-34
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:06:36 -0400
References: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb53939b-4a90-2e7b-32df-3dbe75169d3b@redhat.com>
Date: Thu, 5 Jul 2018 16:06:28 +0200
MIME-Version: 1.0
In-Reply-To: <1530798684-23009-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Add comment explaining ignored
 errors from fdt operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Pilippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 05/07/2018 15:51, Guenter Roeck wrote:
> +        /* Failure to set serial port clocks is not fatal, so just ignore
> +         * errors when trying to do so.
> +         */
> +        (void)fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ);
>          offset = fdt_node_offset_by_compatible(fdt, offset, "ns16550");

Ok, but why would it even fail?  Maybe it's not this case, but even if
it's not fatal for the OS, generating different device trees silently
seems like a recipe for Heisenbugs.

Thanks,

Paolo
