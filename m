Received: from eggs.gnu.org ([2001:4830:134:3::10]:38404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1drML7-0006kV-Im
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1drML2-0000dM-NB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:53:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1drML2-0000cl-EW
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:53:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8BAnVTq008897
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:53:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cwnq351jc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:53:10 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Sep 2017 11:53:08 +0100
References: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Sep 2017 12:53:05 +0200
MIME-Version: 1.0
In-Reply-To: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <07c24be6-14c2-acd2-59d9-047ff04581a7@de.ibm.com>
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
Cc: thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

On 09/11/2017 12:33 PM, Viktor Mihajlovski wrote:
> Setting the client architecture DHCP option to 0x001f (s390 Basic) [1]
> allows the DHCP server to return a s390-specific bootfile if wanted.
> DHCP servers not configured for the option (or not yet recognizing the
> option value) will continue to work as they have done before.
> 
> [1] https://www.iana.org/assignments/dhcpv6-parameters
> 
> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Adding Cornelia. Conny as you have pending patches anyway, I assume
you can pick this up. Would be good if Thomas could give his Ack, though.
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
