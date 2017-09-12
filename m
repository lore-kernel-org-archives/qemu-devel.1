Received: from eggs.gnu.org ([2001:4830:134:3::10]:54445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drjPH-0004mp-Ce
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drjPG-0005XJ-0o
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drjPF-0005Wq-Qk
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:31:05 -0400
Date: Tue, 12 Sep 2017 13:31:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170912133102.26102c83.cohuck@redhat.com>
In-Reply-To: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com

On Mon, 11 Sep 2017 12:33:47 +0200
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> Setting the client architecture DHCP option to 0x001f (s390 Basic) [1]
> allows the DHCP server to return a s390-specific bootfile if wanted.
> DHCP servers not configured for the option (or not yet recognizing the
> option value) will continue to work as they have done before.
> 
> [1] https://www.iana.org/assignments/dhcpv6-parameters
> 
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

Thanks, applied.
