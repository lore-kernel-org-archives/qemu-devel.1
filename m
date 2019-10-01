Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB3C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2E52070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2E52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSAC-0007bF-QA
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrl-00018L-LT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrc-0001LG-1T
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrb-0001IG-Aa; Tue, 01 Oct 2019 19:47:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPCU074810; Tue, 1 Oct 2019 19:47:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdv2vpru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:26 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlPWM074813;
 Tue, 1 Oct 2019 19:47:25 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdv2vpqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:25 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlOs031629;
 Tue, 1 Oct 2019 23:47:22 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:22 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlMtm54133138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:22 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36F8B28058;
 Tue,  1 Oct 2019 23:47:22 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A8EC28059;
 Tue,  1 Oct 2019 23:47:22 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:22 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/97] QEMUMachine: add events_wait method
Date: Tue,  1 Oct 2019 18:44:59 -0500
Message-Id: <20191001234616.7825-21-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Instead of event_wait which looks for a single event, add an events_wait
which can look for any number of events simultaneously. However, it
will still only return one at a time, whichever happens first.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-4-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit f6f4b3f045ea18e3fa93a50cd0462236c428d62e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 python/qemu/__init__.py | 69 +++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index fd144c0006..4cb8eb2f01 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -408,42 +408,71 @@ class QEMUMachine(object):
         self._qmp.clear_events()
         return events
 
-    def event_wait(self, name, timeout=60.0, match=None):
+    @staticmethod
+    def event_match(event, match=None):
         """
-        Wait for specified timeout on named event in QMP; optionally filter
-        results by match.
+        Check if an event matches optional match criteria.
 
-        The 'match' is checked to be a recursive subset of the 'event'; skips
-        branch processing on match's value None
-           {"foo": {"bar": 1}} matches {"foo": None}
-           {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
+        The match criteria takes the form of a matching subdict. The event is
+        checked to be a superset of the subdict, recursively, with matching
+        values whenever those values are not None.
+
+        Examples, with the subdict queries on the left:
+         - None matches any object.
+         - {"foo": None} matches {"foo": {"bar": 1}}
+         - {"foo": {"baz": None}} does not match {"foo": {"bar": 1}}
+         - {"foo": {"baz": 2}} matches {"foo": {"bar": 1, "baz": 2}}
         """
-        def event_match(event, match=None):
-            if match is None:
-                return True
+        if match is None:
+            return True
 
-            for key in match:
-                if key in event:
-                    if isinstance(event[key], dict):
-                        if not event_match(event[key], match[key]):
-                            return False
-                    elif event[key] != match[key]:
+        for key in match:
+            if key in event:
+                if isinstance(event[key], dict):
+                    if not QEMUMachine.event_match(event[key], match[key]):
                         return False
-                else:
+                elif event[key] != match[key]:
                     return False
+            else:
+                return False
+        return True
 
-            return True
+    def event_wait(self, name, timeout=60.0, match=None):
+        """
+        event_wait waits for and returns a named event from QMP with a timeout.
+
+        name: The event to wait for.
+        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
+        match: Optional match criteria. See event_match for details.
+        """
+        return self.events_wait([(name, match)], timeout)
+
+    def events_wait(self, events, timeout=60.0):
+        """
+        events_wait waits for and returns a named event from QMP with a timeout.
+
+        events: a sequence of (name, match_criteria) tuples.
+                The match criteria are optional and may be None.
+                See event_match for details.
+        timeout: QEMUMonitorProtocol.pull_event timeout parameter.
+        """
+        def _match(event):
+            for name, match in events:
+                if (event['event'] == name and
+                    self.event_match(event, match)):
+                    return True
+            return False
 
         # Search cached events
         for event in self._events:
-            if (event['event'] == name) and event_match(event, match):
+            if _match(event):
                 self._events.remove(event)
                 return event
 
         # Poll for new events
         while True:
             event = self._qmp.pull_event(wait=timeout)
-            if (event['event'] == name) and event_match(event, match):
+            if _match(event):
                 return event
             self._events.append(event)
 
-- 
2.17.1


