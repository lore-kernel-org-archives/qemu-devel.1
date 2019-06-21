Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E154C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CE72089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CE72089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heESA-0001em-Du
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 03:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kpouget@redhat.com>) id 1heEPi-00007y-5h
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kpouget@redhat.com>) id 1heEPg-00036m-Ui
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:56:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:47062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kpouget@redhat.com>) id 1heEPg-0002s6-R0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:56:48 -0400
Received: by mail-ua1-f66.google.com with SMTP id o19so2620852uap.13
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 00:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IbJAK5l7HdF6/q1AeQbgGHAv8N9jSFXyEHrl5uP8358=;
 b=VEnQrHc3M/m3vS+PlcRbU4+f2qqlQAY7rQJJE6OsHm7/cYYZs+Ko9yU5upitwGSVaW
 lWSr6STsFbFHsOhtwiLvhbFoRfUJwPv2JUbtCH+mmT7D5xwwYpOw7D/jk1dOFBeER52G
 d3DwLeiByFPcUTtACuxQlBuLKb1hE9XiLwAsZYvmsHT5aEVXWDP4nPz6V1iF2K0wmHce
 NFWxMHHjf1vHMAA8l8RIZFaOqjIXOsdCHbusYb5XEbg3f/aFQ5rE0JgTZPCyZqASzi9L
 1SMcDZDLsXZbCwcuznLE57kGy1VSHMoAl9lcPADORg5chenGUbpm0IOiIup9C7vLduFw
 iupA==
X-Gm-Message-State: APjAAAVyogO3I/4wwJ2PIe/5PgbyV0oUDwrR23SK1uVbWV1T2SJ51fhS
 WXetBwO/WO5HT3Qz9FU+p8VqbO0Sx4ajR9qDkIOuQw==
X-Google-Smtp-Source: APXvYqwsoG4rqgwDWKBsMjJQMbemVZKH9RKVwnvl9CNzOHcjEqLMhtj71HJB/n+RfAwvzDgpN4aIZeibUxoMLv3DsY0=
X-Received: by 2002:ab0:2756:: with SMTP id c22mr27886353uap.22.1561103788103; 
 Fri, 21 Jun 2019 00:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190619123042.4822-1-kpouget@redhat.com>
 <e9fcdbfd-cde2-fc91-ce1d-6bfe06d39c4f@redhat.com>
 <CADJ1XR3fh0cyOerSM8VQkpde6cHLb8WccP05Rwr7xWMOK59rog@mail.gmail.com>
 <2139720774.23871724.1561101408712.JavaMail.zimbra@redhat.com>
In-Reply-To: <2139720774.23871724.1561101408712.JavaMail.zimbra@redhat.com>
From: Kevin Pouget <kpouget@redhat.com>
Date: Fri, 21 Jun 2019 09:56:17 +0200
Message-ID: <CADJ1XR3pq78_OCkNkGYnfUJWL+Tet72PZmGOr4gHzMGcDnRvFA@mail.gmail.com>
To: Frediano Ziglio <fziglio@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.66
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
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 9:16 AM Frediano Ziglio <fziglio@redhat.com> wrote:
>
> >
> > Hello Eric,
> >
> > > A new command may be okay, however,
> >
> > thanks, I've fix the typos and updated the patch to use an Enum, which
> > indeed makes more sense.
> >
> > I've also updated "spice-query" command to provide the current value
> > of the "video-codec" property,
> > but it made me wonder if I should improve this QMP interface with a
> > json list, or keep the current string-based list
> > ("enc1:codec1;enc2:codec2").
> >
> > I CC the spice-devel list to get their point of view
> >
> > The current behavior is:
> >
> > --> { "execute": "set-spice", "arguments": { "property":
> > "video-codecs", "value": "spice:mjpeg;gstreamer:h264" } }
> > <-- {"return":{},"id":"libvirt-23"}
>
> It looks complicated from the user. Why not just
>
> --> { "execute": "set-spice", "arguments": { "video-codecs": "spice:mjpeg;gstreamer:h264" } }

it makes sense indeed, I've updated the code:

# -> { "execute": "set-spice", "arguments": { "video-codecs": "spice:mjpeg;" }
# <- { "returns": {} }

+{ 'command': 'set-spice',
+  'data': {'*video-codecs': 'str'},
+  'if': 'defined(CONFIG_SPICE)' }


---
 qapi/ui.json    | 27 +++++++++++++++++++++++++--
 ui/spice-core.c | 17 +++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 59e412139a..cdbe04bda0 100644
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
@@ -265,6 +270,24 @@
 { 'command': 'query-spice', 'returns': 'SpiceInfo',
   'if': 'defined(CONFIG_SPICE)' }

+##
+# @set-spice:
+#
+# Set Spice properties.
+# @video-codecs: the ;-separated list of video-codecs allowed for
+#                spice-server video streaming.
+#
+# Since: ...
+#
+# Example:
+#
+# -> { "execute": "set-spice", "arguments": { "video-codecs": "spice:mjpeg;" }
+# <- { "returns": {} }
+##
+{ 'command': 'set-spice',
+  'data': {'*video-codecs': 'str'},
+  'if': 'defined(CONFIG_SPICE)' }
+
 ##
 # @SPICE_CONNECTED:
 #
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 63e8694df8..a4b265b663 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -506,6 +506,21 @@ static QemuOptsList qemu_spice_opts = {
     },
 };

+void qmp_set_spice(bool has_video_codecs, const char *video_codecs,
+                   Error **errp)
+{
+    if (has_video_codecs) {
+        int invalid_codecs = spice_server_set_video_codecs(spice_server,
+                                                           video_codecs);
+
+        if (invalid_codecs) {
+            error_setg(errp, "Found %d invalid video-codecs while setting"
+                       " spice property 'video-codec=%s'", invalid_codecs,
+                       video_codecs);
+        }
+    }
+}
+
 SpiceInfo *qmp_query_spice(Error **errp)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
@@ -555,6 +570,8 @@ SpiceInfo *qmp_query_spice(Error **errp)
                        SPICE_QUERY_MOUSE_MODE_SERVER :
                        SPICE_QUERY_MOUSE_MODE_CLIENT;

+    info->video_codecs = spice_server_get_video_codecs(spice_server);
+
     /* for compatibility with the original command */
     info->has_channels = true;
     info->channels = qmp_query_spice_channels();
-- 
2.21.0

