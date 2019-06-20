Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786EC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3ED20675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3ED20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwJj-0004ZU-I0
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kpouget@redhat.com>) id 1hdw2z-000194-U3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kpouget@redhat.com>) id 1hdvos-0002pE-UM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:07:30 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kpouget@redhat.com>) id 1hdve1-0003r9-MD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:54:21 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so1342708vsp.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 04:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yUQwqDdIbNoYpNkbuA8Faf3YXQvLV4E9e0Z6rdP3frI=;
 b=C4+Iwn3mn6S4S76uvBR+QDyWwhSOLSsvMNSQtJ38ZwrtXMTrO7vg2vynC2Nko2BFef
 yoRXnbCTl2pnozTFnRTL9s7dosUqra0a9Cm5mtxLtLxokNi9V9CoEDx5h4UeUa7RJVwU
 R+OyHCh37Y71gNawSS0HzsD8xlFEvlTh332O9hOQHHfbjqOfMJgmuDiR4Ur3+FG6SYDa
 W2bkBNos/pMYGUwubUMenTtAO9B3+kNNTklX/3XhYjY4LFBd/+1p4XVWC1TcGuKOnlWk
 0RWVQ8uWGQ6liepIyAYujqfZdKWxoXXZk22um7RK5PpeMXx3zve92UI8dhK5oY7bu49B
 nKLA==
X-Gm-Message-State: APjAAAXLBt1E0o4fLbGeDG0mxejFpzP8KflOcyPzJJ23RNwOKHecrl5q
 m+EwBm7sQa7vfucHmSTjLSo0YGdjK2isaEU4pCeRrw==
X-Google-Smtp-Source: APXvYqwbjteUqiSOd+WOKd3opWX5qOQ8Suq3d4GMSdT1j0es5rQhl7/s2mJUhnL9I/nlyur4noGkoJhECTnFyHuETZU=
X-Received: by 2002:a67:f84d:: with SMTP id b13mr7082030vsp.151.1561031657675; 
 Thu, 20 Jun 2019 04:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123042.4822-1-kpouget@redhat.com>
 <e9fcdbfd-cde2-fc91-ce1d-6bfe06d39c4f@redhat.com>
In-Reply-To: <e9fcdbfd-cde2-fc91-ce1d-6bfe06d39c4f@redhat.com>
From: Kevin Pouget <kpouget@redhat.com>
Date: Thu, 20 Jun 2019 13:54:06 +0200
Message-ID: <CADJ1XR3fh0cyOerSM8VQkpde6cHLb8WccP05Rwr7xWMOK59rog@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>, spice-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.217.65
Subject: Re: [Qemu-devel] [RFC] spice-core: allow setting properties from QMP
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
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Eric,

> A new command may be okay, however,

thanks, I've fix the typos and updated the patch to use an Enum, which
indeed makes more sense.

I've also updated "spice-query" command to provide the current value
of the "video-codec" property,
but it made me wonder if I should improve this QMP interface with a
json list, or keep the current string-based list
("enc1:codec1;enc2:codec2").

I CC the spice-devel list to get their point of view

The current behavior is:

--> { "execute": "set-spice", "arguments": { "property":
"video-codecs", "value": "spice:mjpeg;gstreamer:h264" } }
<-- {"return":{},"id":"libvirt-23"}

--> { "execute": "query-spice" }
<-- {.... "video-codecs": "spice:mjpeg;gstreamer:h264;" ....}


I put the new version of the RFC patch below

best regards,

Kevin

---

This patch allows setting spice properties from the QMP interface.

At the moment, only the 'video-codecs' property is supported.

Signed-off-by: Kevin Pouget <kpouget@redhat.com>
---
 qapi/ui.json    | 42 ++++++++++++++++++++++++++++++++++++++++--
 ui/spice-core.c | 21 +++++++++++++++++++++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 59e412139a..5f67096bcb 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -211,12 +211,16 @@
 #
 # @channels: a list of @SpiceChannel for each active spice channel
 #
+# @video-codecs: The list of encoders:codecs currently allowed for
+#                video streaming (since: ...)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'SpiceInfo',
   'data': {'enabled': 'bool', 'migrated': 'bool', '*host': 'str',
'*port': 'int',
            '*tls-port': 'int', '*auth': 'str', '*compiled-version': 'str',
-           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChannel']},
+           'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChannel'],
+           'video-codecs': 'str'},
   'if': 'defined(CONFIG_SPICE)' }

 ##
@@ -257,7 +261,8 @@
 #                "tls": false
 #             },
 #             [ ... more channels follow ... ]
-#          ]
+#          ],
+#          "video-codecs": "spice:mjpeg;gstreamer:h264;"
 #       }
 #    }
 #
@@ -265,6 +270,39 @@
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
   'if': 'defined(CONFIG_SPICE)' }

+##
+# @SpiceProperty:
+#
+# An enumeration of Spice properties that can be set at runtime.
+#
+# @video-codecs: the ;-separated list of video-codecs allowed for
+# spice-server video streaming.
+#
+# Since: ...
+##
+{ 'enum': 'SpiceProperty',
+  'data': [ 'video-codecs'],
+  'if': 'defined(CONFIG_SPICE)' }
+
+##
+# @set-spice:
+#
+# Set Spice properties.
+# @property: the SPICE property to modify
+# @value: the new value to affect to this property
+#
+# Since: ...
+#
+# Example:
+#
+# -> { "execute": "set-spice", "arguments": { "property": "video-codecs",
+#                                             "value": "spice:mjpeg;" } }
+# <- { "returns": {} }
+##
+{ 'command': 'set-spice',
+  'data': {'property': 'SpiceProperty', 'value': 'str'},
+  'if': 'defined(CONFIG_SPICE)' }
+
 ##
 # @SPICE_CONNECTED:
 #
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 63e8694df8..1660f49f15 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -506,6 +506,25 @@ static QemuOptsList qemu_spice_opts = {
     },
 };

+void qmp_set_spice(SpiceProperty property, const char *value, Error **errp)
+{
+    int invalid_codecs;
+
+    switch(property) {
+    case SPICE_PROPERTY_VIDEO_CODECS:
+        invalid_codecs = spice_server_set_video_codecs(spice_server, value);
+
+        if (invalid_codecs) {
+            error_setg(errp, "Found %d invalid video-codecs while
setting spice"
+                       " property 'video-codec=%s'", invalid_codecs, value);
+        }
+        break;
+    default:
+        /* only reached in case of version mismatched */
+        error_setg(errp, "Property #%d not supported.", property);
+    }
+}
+
 SpiceInfo *qmp_query_spice(Error **errp)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
@@ -555,6 +574,8 @@ SpiceInfo *qmp_query_spice(Error **errp)
                        SPICE_QUERY_MOUSE_MODE_SERVER :
                        SPICE_QUERY_MOUSE_MODE_CLIENT;

+    info->video_codecs = spice_server_get_video_codecs(spice_server);
+
     /* for compatibility with the original command */
     info->has_channels = true;
     info->channels = qmp_query_spice_channels();
-- 
2.21.0

