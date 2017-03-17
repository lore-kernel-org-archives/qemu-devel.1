Received: from eggs.gnu.org ([2001:4830:134:3::10]:56753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiP2-0006GU-Td
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiOy-0000IX-5H
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36745
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1coiOx-0000II-UW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:18:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H3DsWk191809
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:03 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 297wd0h1rr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:18:03 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 21:18:02 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 04:17:29 +0100
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170317031743.40128-3-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 02/16] s390: cio: export more interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

Export the common I/O interfaces those are needed by an I/O
subchannel driver to actually talk to the subchannel.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
---
 drivers/s390/cio/cio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 5711e28..7ab6e60 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -170,12 +170,14 @@ cio_start_key (struct subchannel *sch,	/* subchannel structure */
 		return ccode;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_start_key);
 
 int
 cio_start (struct subchannel *sch, struct ccw1 *cpa, __u8 lpm)
 {
 	return cio_start_key(sch, cpa, lpm, PAGE_DEFAULT_KEY);
 }
+EXPORT_SYMBOL_GPL(cio_start);
 
 /*
  * resume suspended I/O operation
@@ -208,6 +210,7 @@ cio_resume (struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_resume);
 
 /*
  * halt I/O operation
@@ -241,6 +244,7 @@ cio_halt(struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_halt);
 
 /*
  * Clear I/O operation
@@ -271,6 +275,7 @@ cio_clear(struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_clear);
 
 /*
  * Function: cio_cancel
@@ -308,6 +313,7 @@ cio_cancel (struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_cancel);
 
 /**
  * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt
@@ -368,6 +374,7 @@ int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)
 	/* Function was unsuccessful */
 	return -EIO;
 }
+EXPORT_SYMBOL_GPL(cio_cancel_halt_clear);
 
 static void cio_apply_config(struct subchannel *sch, struct schib *schib)
 {
@@ -441,6 +448,7 @@ int cio_commit_config(struct subchannel *sch)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cio_commit_config);
 
 /**
  * cio_update_schib - Perform stsch and update schib if subchannel is valid.
@@ -1046,6 +1054,7 @@ int cio_tm_start_key(struct subchannel *sch, struct tcw *tcw, u8 lpm, u8 key)
 		return cio_start_handle_notoper(sch, lpm);
 	}
 }
+EXPORT_SYMBOL_GPL(cio_tm_start_key);
 
 /**
  * cio_tm_intrg - perform interrogate function
@@ -1071,3 +1080,4 @@ int cio_tm_intrg(struct subchannel *sch)
 		return -ENODEV;
 	}
 }
+EXPORT_SYMBOL_GPL(cio_tm_intrg);
-- 
2.8.4
