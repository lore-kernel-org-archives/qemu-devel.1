Received: from eggs.gnu.org ([2001:4830:134:3::10]:38901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdT-00065r-Je
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdQ-0002qN-QE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdQ-0002pQ-KB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:09 +0200
Message-Id: <20170919164337.18555-11-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 10/38] s390: set DHCP client architecure id
 for netboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Setting the client architecture DHCP option to 0x001f (s390 Basic) [1]
allows the DHCP server to return a s390-specific bootfile if wanted.
DHCP servers not configured for the option (or not yet recognizing the
option value) will continue to work as they have done before.

[1] https://www.iana.org/assignments/dhcpv6-parameters

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Message-Id: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/netboot.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/netboot.mak b/pc-bios/s390-ccw/netboot.mak
index a9e1374e97..a25d238144 100644
--- a/pc-bios/s390-ccw/netboot.mak
+++ b/pc-bios/s390-ccw/netboot.mak
@@ -50,7 +50,7 @@ libc.a: $(LIBCOBJS)
 
 LIBNETOBJS := args.o dhcp.o dns.o icmpv6.o ipv6.o tcp.o udp.o bootp.o \
 	      dhcpv6.o ethernet.o ipv4.o ndp.o tftp.o
-LIBNETCFLAGS := $(QEMU_CFLAGS) $(LIBC_INC) $(LIBNET_INC)
+LIBNETCFLAGS := $(QEMU_CFLAGS) -DDHCPARCH=0x1F $(LIBC_INC) $(LIBNET_INC)
 
 %.o : $(SLOF_DIR)/lib/libnet/%.c
 	$(call quiet-command,$(CC) $(LIBNETCFLAGS) -c -o $@ $<,"CC","$(TARGET_DIR)$@")
-- 
2.13.5
