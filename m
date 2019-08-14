Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F68CC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6BE21721
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VzxttoTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6BE21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy0Fm-0002fC-4T
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hy0CZ-00016Y-EL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hy0CX-00019q-LQ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:48:59 -0400
Received: from mout.web.de ([217.72.192.78]:42157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hy0CX-00017D-8j
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565815724;
 bh=V0jdTgZU0cNH7q4hoVZw9POPgAa3Lct0vBllFQblJL4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=VzxttoTI73BoPcuQiPiY/sszESy5PBST6+d4eX2RdWEY9Ly8u3B6sQGU0eCqJ7aBT
 yoGoMVM8ncpwkRCr7zWKAOttCCH+E6lyC54cfVbxaMcoFBjbNzDerYCL/hSCQEPauZ
 slmKD8f4dv41B4oSwaBN5ijALwbO/NUqcjHyeDNk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.175]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8R26-1iBnh80BVa-00vwjB; Wed, 14
 Aug 2019 22:48:44 +0200
Date: Wed, 14 Aug 2019 22:47:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <390c048392b2db51cde1aaca8c5acdd8f3836336.1565814686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1565814686.git.lukasstraub2@web.de>
References: <cover.1565814686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5SG06vCY+BIvDW2D/283vewMoK0ViJgDJjvH5KR3BmcEfoZil3v
 +bJTT3idKr2VeizE5jaIVmHb83UGM7bb0/RHHQdsJMgA5sc9CDcPl7RNnekBxYeceF33P/Y
 YpcpgAZ5e8EmNKbN3b8tcdeP7VqTISQ47qPChewNmdZrLE/8A4ljfF4kSeZaUa5iDwbU1Yy
 wn6wZsYHaouDmZgsdpt8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k2baprNzNFU=:n+s0jMv1YhitfKEQzeL6h0
 q9SLFOdsN5byyjPMVFmUHMGldIMwnC3E9TXt6IO1lQBHojPuMmtMHgVMnALRefU+P8RJT0tIL
 ujkBUfVitH3jfkrO+YPdzMtIB/KO51bAxXdTp9F6RT/oOGuckHXU5uoFWBjGXokC97utq5oz1
 Yi9ZeZScBIyb8JNWKpOrOF6ak4J/1j3D+KnmE6T6qE9XcUULAO7CnqPF2DtyaGLa+LwhF5Xue
 dJpKgZ3iDF6SFTHOBTiQXOdnqiStUO+K7twiEeUSgsCbwQT9hx92ue2Kjr39jJoFNbQLwIroz
 7TvYmPfht94B/sWk6AZ0ag1IlIEVm2o2Tnm2xeqFTNRShq1KUzN1wPVNo/XJAHsOlz5JE4OeM
 02IlHGMtw7NhObp/Zo9vFlrQtw2+KCbbcKwhPwNrWNA4ief136rzVolPzhKUB+IhY6EmN0/wc
 +yfpKi8FMclthkF5o8jS7xv+zzF8oRUTMdA0Rl/kabaKb30p5koqZTErSxgS0IWdMHP1covY1
 HvLlAi1VW35luzSKqjl8b8pIHdgxJlRRyk3qfKbp1CZ5mwUXI5e3Yakaa6Zu3NMRJN+AH+sbt
 zniabJfazgTKaBN68i/23R/htyNWdJMIwi9B59iA1gxd+pqbGBQvT4aJf7EGpLEH01VjP9ubD
 OHy0qm5QnccEtkCJ4wD808uR+zLBa8Qjg83K8AY+RCSflBdtsDptYOSTkDng0J8GqT0kj5hkL
 GnfZ6H+0KAUwG0SwXP1ubE/CaBH/DjmlRA40pAM+8kSIijG7sy5Ih8qMX4azqHs9VmyCLjL2h
 CCAw3KmfENhfKTMorL2KbQAcOVlCURK7PiG/+A5RIa7UKrh8YNUYL/owiAdDlWjZw63Dvc0MQ
 nl/nI8WWWjCrrQzYK3xKI9s6PzmZREAM6zftzniJVxDo2pqBEbDuQf6hLkwUZugZdPvh7GJon
 4cKA3jAijBx5Wb50FKgPjZWhMoSN25Z5HuQVrfFsFp/d9oLZt90YhCTRBNo75N6MQOhyZAOM0
 s3PNWKjpg5lXE80SjtpN9m1AiD05XiQzSnrB22kBIL+hk4+zxzWZZNNeoJ1t4/znbqhEmA+gm
 yS47xHIUBboAFdl2cwuJDrexuxjIdqApfiEW8oNWI2LmKMbr8RpZJbDiRcxvvvDJYzRWWTlDk
 9zDqQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
Subject: [Qemu-devel] [PATCH 2/3] net/filter.c: Add Options to insert
 filters anywhere in the filter list
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To switch the Secondary to Primary, we need to insert new filters before
the filter-rewriter.

Add the necessary options to insert filters anywhere in the filter list.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/net/filter.h |  2 ++
 net/filter.c         | 73 ++++++++++++++++++++++++++++++++++++++++++--
 qemu-options.hx      | 10 +++---
 3 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/include/net/filter.h b/include/net/filter.h
index 49da666ac0..355c178f75 100644
=2D-- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -62,6 +62,8 @@ struct NetFilterState {
     NetClientState *netdev;
     NetFilterDirection direction;
     bool on;
+    char *position;
+    bool insert_before;
     QTAILQ_ENTRY(NetFilterState) next;
 };

diff --git a/net/filter.c b/net/filter.c
index 28d1930db7..1058100b83 100644
=2D-- a/net/filter.c
+++ b/net/filter.c
@@ -171,11 +171,47 @@ static void netfilter_set_status(Object *obj, const =
char *str, Error **errp)
     }
 }

+static char *netfilter_get_position(Object *obj, Error **errp)
+{
+    NetFilterState *nf =3D NETFILTER(obj);
+
+    return g_strdup(nf->position);
+}
+
+static void netfilter_set_position(Object *obj, const char *str, Error **=
errp)
+{
+    NetFilterState *nf =3D NETFILTER(obj);
+
+    nf->position =3D g_strdup(str);
+}
+
+static char *netfilter_get_insert(Object *obj, Error **errp)
+{
+    NetFilterState *nf =3D NETFILTER(obj);
+
+    return nf->insert_before ? g_strdup("before") : g_strdup("after");
+}
+
+static void netfilter_set_insert(Object *obj, const char *str, Error **er=
rp)
+{
+    NetFilterState *nf =3D NETFILTER(obj);
+
+    if (strcmp(str, "before") && strcmp(str, "after")) {
+        error_setg(errp, "Invalid value for netfilter insert, "
+                         "should be 'head' or 'tail'");
+        return;
+    }
+
+    nf->insert_before =3D !strcmp(str, "before");
+}
+
 static void netfilter_init(Object *obj)
 {
     NetFilterState *nf =3D NETFILTER(obj);

     nf->on =3D true;
+    nf->insert_before =3D false;
+    nf->position =3D g_strdup("tail");

     object_property_add_str(obj, "netdev",
                             netfilter_get_netdev_id, netfilter_set_netdev=
_id,
@@ -187,16 +223,23 @@ static void netfilter_init(Object *obj)
     object_property_add_str(obj, "status",
                             netfilter_get_status, netfilter_set_status,
                             NULL);
+    object_property_add_str(obj, "position",
+                            netfilter_get_position, netfilter_set_positio=
n,
+                            NULL);
+    object_property_add_str(obj, "insert",
+                            netfilter_get_insert, netfilter_set_insert,
+                            NULL);
 }

 static void netfilter_complete(UserCreatable *uc, Error **errp)
 {
     NetFilterState *nf =3D NETFILTER(uc);
+    NetFilterState *position;
     NetClientState *ncs[MAX_QUEUE_NUM];
     NetFilterClass *nfc =3D NETFILTER_GET_CLASS(uc);
     int queues;
     Error *local_err =3D NULL;
-
+
     if (!nf->netdev_id) {
         error_setg(errp, "Parameter 'netdev' is required");
         return;
@@ -219,6 +262,20 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
         return;
     }

+    if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
+        /* Search for the position to insert before/after */
+        Object *container;
+        Object *obj;
+
+        container =3D object_get_objects_root();
+        obj =3D object_resolve_path_component(container, nf->position);
+        if (!obj) {
+            error_setg(errp, "filter '%s' not found", nf->position);
+            return;
+        }
+        position =3D NETFILTER(obj);
+    }
+
     nf->netdev =3D ncs[0];

     if (nfc->setup) {
@@ -228,7 +285,18 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
             return;
         }
     }
-    QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
+
+    if (!strcmp(nf->position, "head")) {
+        QTAILQ_INSERT_HEAD(&nf->netdev->filters, nf, next);
+    } else if (!strcmp(nf->position, "tail")) {
+        QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
+    } else {
+        if (nf->insert_before) {
+            QTAILQ_INSERT_BEFORE(position, nf, next);
+        } else {
+            QTAILQ_INSERT_AFTER(&nf->netdev->filters, position, nf, next)=
;
+        }
+    }
 }

 static void netfilter_finalize(Object *obj)
@@ -245,6 +313,7 @@ static void netfilter_finalize(Object *obj)
         QTAILQ_REMOVE(&nf->netdev->filters, nf, next);
     }
     g_free(nf->netdev_id);
+    g_free(nf->position);
 }

 static void default_handle_event(NetFilterState *nf, int event, Error **e=
rrp)
diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..f0a47a0746 100644
=2D-- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4368,7 +4368,7 @@ applications, they can do this through this paramete=
r. Its format is
 a gnutls priority string as described at
 @url{https://gnutls.org/manual/html_node/Priority-Strings.html}.

-@item -object filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interva=
l=3D@var{t}[,queue=3D@var{all|rx|tx}][,status=3D@var{on|off}]
+@item -object filter-buffer,id=3D@var{id},netdev=3D@var{netdevid},interva=
l=3D@var{t}[,queue=3D@var{all|rx|tx}][,status=3D@var{on|off}][,position=3D=
@var{head|tail|id}][,insert=3D@var{after|before}]

 Interval @var{t} can't be 0, this filter batches the packet delivery: all
 packets arriving in a given interval on netdev @var{netdevid} are delayed
@@ -4387,11 +4387,11 @@ queue @var{all|rx|tx} is an option that can be app=
lied to any netfilter.
 @option{tx}: the filter is attached to the transmit queue of the netdev,
              where it will receive packets sent by the netdev.

-@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=
=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
+@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=
=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support][,position=3D=
@var{head|tail|id}][,insert=3D@var{after|before}]

 filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{c=
hardevid}, if it has the vnet_hdr_support flag, filter-mirror will mirror =
packet with vnet_hdr_len.

-@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},ind=
ev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vne=
t_hdr_support]
+@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},ind=
ev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vne=
t_hdr_support][,position=3D@var{head|tail|id}][,insert=3D@var{after|before=
}]

 filter-redirector on netdev @var{netdevid},redirect filter's net packet t=
o chardev
 @var{chardevid},and redirect indev's packet to filter.if it has the vnet_=
hdr_support flag,
@@ -4400,7 +4400,7 @@ Create a filter-redirector we need to differ outdev =
id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev o=
r outdev
 need to be specified.

-@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=
=3D@var{all|rx|tx},[vnet_hdr_support]
+@item -object filter-rewriter,id=3D@var{id},netdev=3D@var{netdevid},queue=
=3D@var{all|rx|tx},[vnet_hdr_support][,position=3D@var{head|tail|id}][,ins=
ert=3D@var{after|before}]

 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
@@ -4413,7 +4413,7 @@ colo secondary:
 -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1
 -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall

-@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{f=
ilename}][,maxlen=3D@var{len}]
+@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{f=
ilename}][,maxlen=3D@var{len}][,position=3D@var{head|tail|id}][,insert=3D@=
var{after|before}]

 Dump the network traffic on netdev @var{dev} to the file specified by
 @var{filename}. At most @var{len} bytes (64k by default) per packet are s=
tored.
=2D-
2.20.1

