Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7921ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3161521872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pTQ7XG7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3161521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZSh-0003Ja-Tk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9W-0008BY-Lu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9U-0004hS-VV
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9U-0004gz-NO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94M3M094924;
 Thu, 24 Oct 2019 09:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=oTCRPbeKTf2q9fkE6iDwaefSFhw8FReF4WhrJOU1zgs=;
 b=pTQ7XG7KLCULfnCfSGTcBvg15KLvagSPOzCqF7HTlO8Nz5iKeH5jd57FkDtdu0kVjArw
 VMEo5vdU8j6su3GgprgcHFSHME18OcecIj0uD3lCCTyAdZAi6DrwUsaHzcRrqjF3f+H9
 VmKbyAqyaZCvCD+rn7deDFKscL1jxlFox83zKCyjll5To61YImAfMxtQ+pXhbG/GIwfm
 sP+8ng17nO4wTqcD8tpZD/pkW/U+4O2YuxpPBcMjPx+or151cmL5mtk8izxkrsQiPDe5
 rodff8+TtFrc9hUrfjBQu03AlOFLIlDTi2V6EOkK0mEVGbMOAzYzpBEzihs9H5ga0lpa 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2vqu4r24rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98LET047080;
 Thu, 24 Oct 2019 09:11:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu869-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:20 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9BJlG002559;
 Thu, 24 Oct 2019 09:11:19 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:19 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 34/49] multi-process/mon: choose HMP commands based on
 target
Date: Thu, 24 Oct 2019 05:09:15 -0400
Message-Id: <15063eb2e3392e3d5ec8edb73f7a5fc55a7563e3.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=859
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=942 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Add "targets" field to HMP command definition to select the targets
which would be supported by each command

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 hmp-commands-info.hx | 10 ++++++++++
 hmp-commands.hx      | 20 ++++++++++++++++++++
 scripts/hxtool       | 44 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 scripts/hxtool

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 257ee7d..631cc76 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -19,6 +19,7 @@ ETEXI
         .params     = "",
         .help       = "show the version of QEMU",
         .cmd        = hmp_info_version,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -48,6 +49,7 @@ ETEXI
         .params     = "",
         .help       = "show the character devices",
         .cmd        = hmp_info_chardev,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -64,6 +66,7 @@ ETEXI
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -78,6 +81,7 @@ ETEXI
         .params     = "",
         .help       = "show block device statistics",
         .cmd        = hmp_info_blockstats,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -92,6 +96,7 @@ ETEXI
         .params     = "",
         .help       = "show progress of ongoing block device operations",
         .cmd        = hmp_info_block_jobs,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -167,6 +172,7 @@ ETEXI
         .params     = "",
         .help       = "show the command line history",
         .cmd        = hmp_info_history,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -224,6 +230,7 @@ ETEXI
         .params     = "",
         .help       = "show PCI info",
         .cmd        = hmp_info_pci,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -630,6 +637,7 @@ ETEXI
         .params     = "",
         .help       = "show device tree",
         .cmd        = hmp_info_qtree,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -644,6 +652,7 @@ ETEXI
         .params     = "",
         .help       = "show qdev device model list",
         .cmd        = hmp_info_qdm,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -658,6 +667,7 @@ ETEXI
         .params     = "[path]",
         .help       = "show QOM composition tree",
         .cmd        = hmp_info_qom_tree,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index cfcc044..6d9674b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -49,6 +49,7 @@ ETEXI
         .params     = "",
         .help       = "quit the emulator",
         .cmd        = hmp_quit,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -82,6 +83,7 @@ ETEXI
         .params     = "device size",
         .help       = "resize a block image",
         .cmd        = hmp_block_resize,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -99,6 +101,7 @@ ETEXI
         .params     = "device [speed [base]]",
         .help       = "copy data from a backing file into a block device",
         .cmd        = hmp_block_stream,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -113,6 +116,7 @@ ETEXI
         .params     = "device speed",
         .help       = "set maximum speed for a background block operation",
         .cmd        = hmp_block_job_set_speed,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -129,6 +133,7 @@ ETEXI
                       "\n\t\t\t if you want to abort the operation immediately"
                       "\n\t\t\t instead of keep running until data is in sync)",
         .cmd        = hmp_block_job_cancel,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -143,6 +148,7 @@ ETEXI
         .params     = "device",
         .help       = "stop an active background block operation",
         .cmd        = hmp_block_job_complete,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -158,6 +164,7 @@ ETEXI
         .params     = "device",
         .help       = "pause an active background block operation",
         .cmd        = hmp_block_job_pause,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -172,6 +179,7 @@ ETEXI
         .params     = "device",
         .help       = "resume a paused background block operation",
         .cmd        = hmp_block_job_resume,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -186,6 +194,7 @@ ETEXI
         .params     = "[-f] device",
         .help       = "eject a removable medium (use -f to force it)",
         .cmd        = hmp_eject,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -200,6 +209,7 @@ ETEXI
         .params     = "device",
         .help       = "remove host block device",
         .cmd        = hmp_drive_del,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -219,6 +229,7 @@ ETEXI
         .params     = "device filename [format [read-only-mode]]",
         .help       = "change a removable medium, optional format",
         .cmd        = hmp_change,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -732,6 +743,7 @@ ETEXI
         .help       = "add device, like -device on the command line",
         .cmd        = hmp_device_add,
         .command_completion = device_add_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -747,6 +759,7 @@ ETEXI
         .help       = "remove device",
         .cmd        = hmp_device_del,
         .command_completion = device_del_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1351,6 +1364,7 @@ ETEXI
                       "The -c flag requests QEMU to compress backup data\n\t\t\t"
                       "(if the target format supports it).\n\t\t\t",
         .cmd        = hmp_drive_backup,
+        .targets    = "scsi",
     },
 STEXI
 @item drive_backup
@@ -1368,6 +1382,7 @@ ETEXI
                       "[,readonly=on|off][,copy-on-read=on|off]",
         .help       = "add drive to PCI storage controller",
         .cmd        = hmp_drive_add,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1816,6 +1831,7 @@ ETEXI
         .help       = "add chardev",
         .cmd        = hmp_chardev_add,
         .command_completion = chardev_add_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1831,6 +1847,7 @@ ETEXI
         .params     = "id args",
         .help       = "change chardev",
         .cmd        = hmp_chardev_change,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1848,6 +1865,7 @@ ETEXI
         .help       = "remove chardev",
         .cmd        = hmp_chardev_remove,
         .command_completion = chardev_remove_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1864,6 +1882,7 @@ ETEXI
         .help       = "send a break on chardev",
         .cmd        = hmp_chardev_send_break,
         .command_completion = chardev_remove_completion,
+        .targets    = "scsi",
     },
 
 STEXI
@@ -1938,6 +1957,7 @@ ETEXI
         .params     = "[subcommand]",
         .help       = "show various information about the system state",
         .cmd        = hmp_info_help,
+        .targets    = "scsi",
         .sub_table  = hmp_info_cmds,
         .flags      = "p",
     },
diff --git a/scripts/hxtool b/scripts/hxtool
old mode 100644
new mode 100755
index 7d7c428..02fbbd8
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -10,7 +10,14 @@ hxtoh()
             STEXI*|ETEXI*) flag=$(($flag^1))
             ;;
             *)
-            test $flag -eq 1 && printf "%s\n" "$str"
+            # Skip line that has ".targets" as it is for multi-process targets based hmp
+            # commands generation.
+            echo $str | grep -q '.targets'
+            if [ $? -eq 0 ]; then
+                continue
+            else
+                test $flag -eq 1 && printf "%s\n" "$str"
+            fi
             ;;
         esac
     done
@@ -53,16 +60,49 @@ hxtotexi()
             print_texi_heading "$(expr "$str" : "ARCHHEADING(\(.*\),.*)")"
             ;;
             *)
-            test $flag -eq 1 && printf '%s\n' "$str"
+            # Skip line that has ".targets" as it is for multi-process targets based hmp
+            # commands generation.
+            echo $str | grep -q '.targetss'
+            if [ $? -eq 0 ]; then
+                continue
+            else
+                test $flag -eq 1 && printf '%s\n' "$str"
+            fi
             ;;
         esac
         line=$((line+1))
     done
 }
 
+hxtoh_tgt()
+{
+    section=""
+    flag=1
+    use_section=0
+    while read -r str; do
+        # Print section if it has ".targets" and the second argument passed to the
+        # script, such as "scsi".
+        echo "$str" | grep -q -E ".targets.*$1"
+        if [ $? -eq 0 ]; then
+            use_section=1
+            continue
+        fi
+        case $str in
+            HXCOMM*)
+            ;;
+            STEXI*|ETEXI*) flag=$(($flag^1)); test $use_section -eq 1 && printf '%s' "$section"; section=""; use_section=0
+            ;;
+            *)
+            test $flag -eq 1 && section="${section} ${str} ${IFS}"
+            ;;
+        esac
+    done
+}
+
 case "$1" in
 "-h") hxtoh ;;
 "-t") hxtotexi ;;
+"-tgt") hxtoh_tgt $2 ;;
 *) exit 1 ;;
 esac
 
-- 
1.8.3.1


