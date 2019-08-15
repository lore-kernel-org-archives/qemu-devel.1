Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDFC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABF2206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XhDEdUMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABF2206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKrN-0006PI-GM
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hyKoK-0004BU-6o
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hyKoH-0006rj-1B
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:20 -0400
Received: from mout.web.de ([212.227.17.12]:32861)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hyKoG-0006qj-P9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565894942;
 bh=lWpltg5ktOFn/3NdP2OLih9c+P9SmdyvyAgJtuJDT7s=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XhDEdUMC8l9P1Mg0Ufweg4bTQU7fmNvtA0hSAb3mbeEWAx3yCHG/SkBoJH/jZL+QV
 wWMZ1JbOhXB2k4FSgF2725PMufao1LTjNKsBYyhwJCz72YnKbLkoS0JS9r89i+EVzG
 3e3yBKSPKvWW8epcFnXTX83llesk2J5xT3Gp0ARw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.245]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqUbl-1iSjjr2Atd-00e4yx; Thu, 15
 Aug 2019 20:49:02 +0200
Date: Thu, 15 Aug 2019 20:48:58 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <6643a807a5f4c5ceb2f09e0718e97e5f968577f7.1565894837.git.lukasstraub2@web.de>
In-Reply-To: <cover.1565894837.git.lukasstraub2@web.de>
References: <cover.1565894837.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WmttyqNDQt8jPJGz2T9hC4N2dmAecKZzb4G8OCz92i/89W+CKyg
 dKq6RhBBijRKruGEhgZfUx766tuGyAwgBM17vCorLVYVMttVpIVeyuQqQy3KHg1mbxDsE/l
 tBN0er/zQNao2kxf3LWsRW8jkU2l2ejWrJ28gqd02aPXev5XAKDaV7/lTnLHNWUOWXM4wZF
 WA8vpwJNRB6dAmZBoUlkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mgWX4sXRvUg=:ygP62wYIu2bzqGILZkKJWI
 HU55eix1RJ7OhbK7G2HuoISG2DdaEc4QBS+DGLsNOe9Wo5TDcK10LCsxa4N8QcSOBSQ97jYqq
 YXsk/fWX2jeF7yZC+HzJAGPB68bQ5brznn7E+YQzr4GlwdrzZPlIU3DkknQlAnh2Vb15AK/os
 VOfh7puCvz2oLu8XsZe1gytj/fzPT2yqNFnG0y9czralx0m4ihdJ0pG+v788nsT2xRLiXphIb
 uz58/Ub8ZEfHh0huwZIpOqbavf11qQvu02zPtLCrUWAqH2GC9oOky/mogJMCzUrt8MzCHORje
 lmn4jxm4p72V5lxH4iDZIP9VFNtcyxggdWJ9dqCorncRfCDFRJGQFJVLY/h7O/zy0o03eCDde
 2vVX76bz21FuMU08s1LwI+xYJjPEhWdWE2oYjbtrf8zEXrJth1FRi13Oh1ocNwr55lqJLSmd6
 jzeR40tTuizkVZo6OubrU45d32XVKJklXKRLzokdq0CpFTs2oSMwi7n8OyBsxQDvqsCWRQmRw
 0qplI2U9jdIclxf9eUtTCRGo9jZgolyRO3lTQtIAUT06Dih7iAiZVTj3LvDqVZ/alJ0yDTWQf
 5x14kEJpiRPyTqBy+y+BILVBDhli9iQa8fPICFqNkfMASOIybGx9BDvZLf91E1eHyuyzUMnLz
 ZY+gnWBjA5z3AFeHmlPvBOzminWbVEkJW9DzfA4Ho5CN7Lp5sSo4uw0ljyUbyUtrG/PUGdip0
 5/IG+2f7xOX/cWM79OuWWXf18F1LeJmEjJJ+RZqJfxbRHPYI5qsVUTK/RuhiiVPwgV7CSuXE3
 vwpJVVrsr02JdOlCRUkpm55Tex1M6avtmdhuX/xzAoZk3GdvIZ0mcEqVoG+8jqmstAtymOscv
 QGREqKYuwDTg3J9hepIM5yhxv67LNkySKBOTwXErg5/Lfuur9XXtgGydt/7L1Pt+79EHF/lyJ
 abVn4ED27H+Dn1NS+UFNxbFEZGjehQB+eh+W/j6M0Y6kU1nIoFNb7hulTXUpQhdwoffkztgrU
 SpNOpoVzHEEJh0b6EoUsKahw7Qzg/2dZRUQeCmYMwaJ4vOS01cvRqtWxbYBh1nzF1Cq97k5zP
 o0JYRTSn1uojFQeSN/9TsbEY0osskQbjS5FSKhgoBsMBSVvbkgycGmLhyXPtkXc6Nx3LqDmqY
 1CorM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
Subject: [Qemu-devel] [PATCH v2 2/3] net/filter.c: Add Options to insert
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To switch the Secondary to Primary, we need to insert new filters
before the filter-rewriter.

Add the options insert=3D and position=3D to be able to insert filters
anywhere in the filter list.

position should be either "head", "tail" or the id of another filter.
insert should be either "before" or "after" to specify where to
insert the new filter relative to the one specified with position.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/net/filter.h |  2 ++
 net/filter.c         | 71 +++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx      | 10 +++----
 3 files changed, 77 insertions(+), 6 deletions(-)

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
index 28d1930db7..309fd778df 100644
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
@@ -187,11 +223,18 @@ static void netfilter_init(Object *obj)
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
+    NetFilterState *position =3D NULL;
     NetClientState *ncs[MAX_QUEUE_NUM];
     NetFilterClass *nfc =3D NETFILTER_GET_CLASS(uc);
     int queues;
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
+    if (position) {
+        if (nf->insert_before) {
+            QTAILQ_INSERT_BEFORE(position, nf, next);
+        } else {
+            QTAILQ_INSERT_AFTER(&nf->netdev->filters, position, nf, next)=
;
+        }
+    } else if (!strcmp(nf->position, "head")) {
+        QTAILQ_INSERT_HEAD(&nf->netdev->filters, nf, next);
+    } else if (!strcmp(nf->position, "tail")) {
+        QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
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


