Received: from eggs.gnu.org ([2001:4830:134:3::10]:54813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoz6-00084f-4z
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoz3-0003mf-08
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPoz2-0003lk-QT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:40 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:12 +0200
Message-Id: <1498564100-10045-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 06/14] libnet: Remove remainders of netsave
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

The code does not exist in the repository, so it does not make
sense to keep the prototypes and the Forth wrapper around.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/libnet/netapps.h | 1 -
 pc-bios/s390-ccw/libnet/tftp.h    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/pc-bios/s390-ccw/libnet/netapps.h b/pc-bios/s390-ccw/libnet/netapps.h
index 91c1ebd..2fea4a7 100644
--- a/pc-bios/s390-ccw/libnet/netapps.h
+++ b/pc-bios/s390-ccw/libnet/netapps.h
@@ -20,7 +20,6 @@ struct filename_ip;
 
 extern int netload(char *buffer, int len, char *ret_buffer, int huge_load,
 		   int block_size, char *args_fs, int alen);
-extern int netsave(int argc, char *argv[]);
 extern int ping(char *args_fs, int alen);
 extern int dhcp(char *ret_buffer, struct filename_ip *fn_ip,
 		unsigned int retries, int flags);
diff --git a/pc-bios/s390-ccw/libnet/tftp.h b/pc-bios/s390-ccw/libnet/tftp.h
index 303feaf..b1dbc21 100644
--- a/pc-bios/s390-ccw/libnet/tftp.h
+++ b/pc-bios/s390-ccw/libnet/tftp.h
@@ -42,8 +42,6 @@ typedef struct {
 
 int tftp(filename_ip_t *, unsigned char  *, int, unsigned int,
          tftp_err_t *, int32_t mode, int32_t blocksize, int ip_version);
-int tftp_netsave(filename_ip_t *, uint8_t * buffer, int len,
-		 int use_ci, unsigned int retries, tftp_err_t * tftp_err);
 
 int32_t handle_tftp(int fd, uint8_t *, int32_t);
 void handle_tftp_dun(uint8_t err_code);
-- 
1.8.3.1
