Received: from eggs.gnu.org ([2001:4830:134:3::10]:45029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drPEX-0007lr-5L
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drPET-0000yp-6K
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:58:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1drPES-0000xe-Vy
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:58:37 -0400
References: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5ca72c2-4e5c-1a64-ded6-bf2e1cd7cefd@redhat.com>
Date: Mon, 11 Sep 2017 15:58:33 +0200
MIME-Version: 1.0
In-Reply-To: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390: set DHCP client architecure id for
 netboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com

On 11.09.2017 12:33, Viktor Mihajlovski wrote:
> Setting the client architecture DHCP option to 0x001f (s390 Basic) [1]
> allows the DHCP server to return a s390-specific bootfile if wanted.
> DHCP servers not configured for the option (or not yet recognizing the
> option value) will continue to work as they have done before.
> 
> [1] https://www.iana.org/assignments/dhcpv6-parameters

Ah, nice, you already registered a value for s390x :-)
May I ask what's the difference between "Basic" and "Extended" there?

> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/netboot.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
> index a9e1374..a25d238 100644
> --- a/pc-bios/s390-ccw/netboot.mak
> +++ b/pc-bios/s390-ccw/netboot.mak
> @@ -50,7 +50,7 @@ libc.a: $(LIBCOBJS)
>  
>  LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
>  	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o
> -LIBNETCFLAGS := $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
> +LIBNETCFLAGS := $(QEMU_CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
>  
>  %.o : $(SLOF_DIR)/lib/libnet/%.c
>  	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
