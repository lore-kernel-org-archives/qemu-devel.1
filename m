Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CBC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C6720675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 18:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="M0FbiC9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C6720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhuD-000628-Ry
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 14:00:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hNht1-0005Pf-9q
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hNhsz-0001wJ-V8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:58:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:33521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hNhsz-0001p0-Ec
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aYNSfLI1EB2FwxwOFQBv+9wHMzs8UdhjczvSCyUcYS0=;
	b=M0FbiC9oteJvA4hPm4dXm+hfPU
	SUPOUNzMLQNQjPexs5z/BiCvvWCDvT1suG30CU2gXRnM/9na/7q6tE+wv1dPTbph4tMwZCUd1DfZJ
	AhJ2upSod9PyrTYL9SeU5xWRa8gMDnCBUXSDmAjf+X8P4VBR5Q8MhyYTCDg69Tg5PyUph3+dupKE+
	wv2AXRRczIMMpMxj6RhtIIdkP0A4qiqA3+mQtJH1a3cIKbPZnlYUnxJmSugZqILSV6JLFKz0WJjzI
	ASmgfYtqyBKDr9brjWPZ/FLxzTWZTdmcJSnTIfYUUTNiDbXv18sj/4jva9iVlYadxWYknLiYpLczX
	lRaFK+22MFTgJlLuffjhMa5zDRqRGubwyntqbbzJ9MxuJpRI9Hhq2X6Vh9VWxxiKkuWMbTD76F24p
	dLTwXgTXdTEDSS5t8In4XfzfKIPOW7LM7Y448QG6+OcuyD7pB4/6tQLJWLIQuedME0BvXVSEwKfGR
	Ppo0+LKAIiG/BeDGtyv9o/co2h/XLTenui040shm2pTI7O0wYkD6Hy5MKpbTtLLbuMq4BTggQX+9l
	p1Zvho0FuZEOXtUoWtAFugW5iE5zDqqtepaxnpwVmTc6ltvL1b+lWmVcyeseopc0OnZBv5nCGaRbH
	avIGoeeQhH1ycCIDzaKSeSSBQ6pB+vpCdvXllQhCk=;
To: qemu-devel@nongnu.org
Date: Mon, 06 May 2019 19:58:28 +0200
Message-ID: <1895198.u98Sn5qOsY@silver>
In-Reply-To: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the counter part patch against latest libvirt git master head to
support the 'vii' feature of patch 5, which introduces the XML config
XML tag "important" on libvirt side.

To stick with the previous example mentioned with patch 5, likewise
libvirt XML configuration might then look like this:

  <domain type='kvm'>
    ...
    <devices>
      ...
      <filesystem type='mount' accessmode='mapped'>
        <source dir='/vm/fs'/>
        <target dir='root'/>
        <important path='/var/shares'/>
        <important path='/tmp'/>
      </filesystem>
    </devices>
  </domain>

Like with the vii qemu virtfs command line argument, the order of the
"important" tag defines which one gets the highest inode namespace
(smallest generated suffix) on guest side.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 docs/schemas/domaincommon.rng |  6 ++++++
 src/conf/domain_conf.c        | 30 ++++++++++++++++++++++++++++++
 src/conf/domain_conf.h        |  3 +++
 src/qemu/qemu_command.c       | 10 ++++++++++
 4 files changed, 49 insertions(+)

diff --git a/docs/schemas/domaincommon.rng b/docs/schemas/domaincommon.rng
index 111b85c36f..c75edfc4d3 100644
--- a/docs/schemas/domaincommon.rng
+++ b/docs/schemas/domaincommon.rng
@@ -2515,6 +2515,12 @@
             </choice>
           </attribute>
         </optional>
+        <zeroOrMore>
+          <element name='important'>
+            <attribute name="path"/>
+            <empty/>
+          </element>
+        </zeroOrMore>
         <optional>
           <element name='readonly'>
             <empty/>
diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
index b4fb6cf981..cc75c6a7dd 100644
--- a/src/conf/domain_conf.c
+++ b/src/conf/domain_conf.c
@@ -2294,6 +2294,8 @@ virDomainFSDefNew(void)
 
 void virDomainFSDefFree(virDomainFSDefPtr def)
 {
+    size_t i;
+
     if (!def)
         return;
 
@@ -2302,6 +2304,13 @@ void virDomainFSDefFree(virDomainFSDefPtr def)
     virDomainDeviceInfoClear(&def->info);
     VIR_FREE(def->virtio);
 
+    if (def->important) {
+        for (i = 0; i < def->nimportant; i++)
+            if (def->important[i])
+                VIR_FREE(def->important[i]);
+    }
+    VIR_FREE(def->important);
+
     VIR_FREE(def);
 }
 
@@ -10953,6 +10962,7 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
     VIR_AUTOFREE(char *) usage = NULL;
     VIR_AUTOFREE(char *) units = NULL;
     VIR_AUTOFREE(char *) model = NULL;
+    long n;
 
     ctxt->node = node;
 
@@ -11001,6 +11011,12 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
                                   1, ULLONG_MAX, false) < 0)
         goto error;
 
+    n = virXMLChildElementCount(node);
+    if (n > 0) {
+        if (VIR_ALLOC_N(def->important, n) < 0)
+            goto error;
+    }
+
     cur = node->children;
     while (cur != NULL) {
         if (cur->type == XML_ELEMENT_NODE) {
@@ -11039,6 +11055,8 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
 
                 if (virDomainVirtioOptionsParseXML(cur, &def->virtio) < 0)
                     goto error;
+            } else if (virXMLNodeNameEqual(cur, "important")) {
+                def->important[def->nimportant++] = virXMLPropString(cur, "path");
             }
         }
         cur = cur->next;
@@ -11107,6 +11125,8 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
         goto error;
 
  cleanup:
+    if (def && def->important && !def->nimportant)
+        VIR_FREE(def->important);
     return def;
 
  error:
@@ -24601,6 +24621,7 @@ virDomainFSDefFormat(virBufferPtr buf,
     const char *src = def->src->path;
     VIR_AUTOCLEAN(virBuffer) driverBuf = VIR_BUFFER_INITIALIZER;
     int ret = -1;
+    size_t i;
 
     if (!type) {
         virReportError(VIR_ERR_INTERNAL_ERROR,
@@ -24689,6 +24710,15 @@ virDomainFSDefFormat(virBufferPtr buf,
     if (def->readonly)
         virBufferAddLit(buf, "<readonly/>\n");
 
+    if (def->important) {
+        for (i = 0; i < def->nimportant; ++i) {
+            if (!def->important[i]) continue;
+            virBufferAddLit(buf, "<important");
+            virBufferEscapeString(buf, " path='%s'", def->important[i]);
+            virBufferAddLit(buf, "/>\n");
+        }
+    }
+
     if (virDomainDeviceInfoFormat(buf, &def->info, flags) < 0)
         goto cleanup;
 
diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
index 01c22d8cc3..9bbd66d932 100644
--- a/src/conf/domain_conf.h
+++ b/src/conf/domain_conf.h
@@ -818,6 +818,9 @@ struct _virDomainFSDef {
     unsigned long long space_soft_limit; /* in bytes */
     bool symlinksResolved;
     virDomainVirtioOptionsPtr virtio;
+
+    size_t nimportant;
+    char **important;
 };
 
 
diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
index 50b4205267..2005ccadf8 100644
--- a/src/qemu/qemu_command.c
+++ b/src/qemu/qemu_command.c
@@ -2732,6 +2732,7 @@ qemuBuildFSStr(virDomainFSDefPtr fs)
     virBuffer opt = VIR_BUFFER_INITIALIZER;
     const char *driver = qemuDomainFSDriverTypeToString(fs->fsdriver);
     const char *wrpolicy = virDomainFSWrpolicyTypeToString(fs->wrpolicy);
+    size_t i;
 
     if (fs->type != VIR_DOMAIN_FS_TYPE_MOUNT) {
         virReportError(VIR_ERR_CONFIG_UNSUPPORTED, "%s",
@@ -2775,6 +2776,15 @@ qemuBuildFSStr(virDomainFSDefPtr fs)
     if (fs->readonly)
         virBufferAddLit(&opt, ",readonly");
 
+    if (fs->important) {
+        for (i = 0; i < fs->nimportant; ++i) {
+            if (i == 0)
+                virBufferAsprintf(&opt, ",vii=%s", fs->important[i]);
+            else
+                virBufferAsprintf(&opt, ":%s", fs->important[i]);
+        }
+    }
+
     if (virBufferCheckError(&opt) < 0)
         goto error;
 
-- 
2.11.0



