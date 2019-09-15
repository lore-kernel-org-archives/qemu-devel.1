Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C790C4CECD
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3D02067D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gayAJpcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3D02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aEx-000449-EV
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4d-0003ff-6n
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i9a4Z-00018W-5o
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:39 -0400
Received: from mout.web.de ([212.227.17.12]:34913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i9a4Y-00018F-ST
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568575216;
 bh=bYRVmCXfWTISAMgenBJtNWjJCiJGXddMTiif/GPDVlI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=gayAJpcOBTUSUEWtN3IkCj6JKRw5Yys1A+eGuzMHbcJV48Ph4843cEF1q14gTXOby
 I6H0EK7De53nKzhkUjCu987BxAbVUDSKDPJ3H2dA5mroOEM3gV7zw+R6UzOZYfj+f5
 ilV58UmmtX3Z/anLB1CR/wJgJ3o2Xqx6lf9uTe28=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.53]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ls95v-1iEkwh0KRL-013yX9; Sun, 15
 Sep 2019 21:20:16 +0200
Date: Sun, 15 Sep 2019 21:20:14 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <b4241e918682c83163857da3aaab5c14ec1c81f8.1568574478.git.lukasstraub2@web.de>
In-Reply-To: <cover.1568574478.git.lukasstraub2@web.de>
References: <cover.1568574478.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sEngW7Y9n3AfACaxfOoyxBEK/Ix+4SxuP7YwaONOsMxAb/0/LH1
 epNIShIrKca6VPXBWDKltIZuZkilHCpmu2nSK8B9fAf1ck2ndf3kaPuQLwlInYmgHhaHHS4
 A+Z3kM18LUKSiXAQsB9KynQPTsZKuNXzHp75mCkGr6P/aNpg4EexmLnzQa+gcklAU/E2Rwd
 BatC1kuj2sGYJXnln3B4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qC9aMQaPfa0=:MSeq5Zz9eetrXM/QJih9E7
 km9EcxeVjls2+vQs23HZ5CgyufVfgNNyDNZIum3Z8Phs1rjZCaOSwx5en0sCsD+FdBetCtV2W
 Wz1Sv2nVmuwtTkPLxYJ9zViYDFN+6WPwYNI6IZGPNwGuESVcfeQ9GgMIvgHx96GGdQgBqovBO
 mydozBlRQwMa8c2Lo0BsMBTsM7gmLwQGAuvJ6wSbtXqxhOQ2uJv52gG6c1HQxFSDzNHgFrfHj
 O4taQlAniqcDr6CxsehktWRKxDCYeTpVvcbfZPmnMZjWN3+eMUBB0CUKJNb3JqOIA3U3sIK7B
 E1vbndJnPeFSbmnZT9aBif+vIzwl5rhStotMoJ94yJhZqjKmMlBminJ/H/hKcn6sm7amXncZg
 9LTaqCWxiAYG0M2WPA6e/gQ5Bkt9sZtW7ZeZ72ahN71ZwHM8cc568bZcXg+KRvNzDgF/hcXaR
 L3m+sZa0gayJ85lfy9CP/k5DYvV2R5IVNEoE+KuPt5rWImSmhb+OrnbT1yM0TvdA1DH7MbNPc
 n6otB56utwl2GcQm330UEss79Y5EOa8QVw5OCRZtJWmKF4uUROLC+L9QqNRFePzn2972Hu/pr
 PASCjfyfTNzekW/54KX7GagLbR6KFT7b/Km0TmjihR7hBSUgSrV93l6Z/qsrJrDfx1yvPZFUB
 6ArpkvrLPfD8WVL6KX0cEJfMd5jp+O2+b7VHoOyiycQC35dY5Trmy8QPFI+LICzAFJM3XQd8l
 OFEKbHTfFhTptAs0GPDaCQBq3ZPp+SnU2y1z4GMLc6TWohqdUAA2U83p5ET8ljYxyVVKhlbcV
 4F2FZyMqFgzcwWJb3ElaSKF3c2+EIiHxjJY+Sol5lpD+XgDJGcMrKWYSIFjPN3l/N+TYz48wm
 ziUrEoLul2fd8rQkcBV1SKCDCiKM3IW+LcR8Albrz9VSwQprN3ux+mIs6IiA2wrz4WzspbtM+
 japeWd7v4oEXWB9GWE6mPsrA5kt7ItjrdyfpFlCWWsw4hgjbkH912SfjNsIDK67gaTC+SuPR8
 vQOphivqMyrMMJ3XR/DFMzkb05nT1wV6DMqtVtOaHVdU7hzlYDVFIVef5g4RFbOu7JSUVKDTI
 qGPsVVJY5JV5PSZD58Mvj3H6UtIXgSvF7yvPdR1UiB5yoOKi6zGWs0h4WXX/N/0ptG6uM/hdw
 vO0wlKziEdxupI6AYI0rNqylNrUGNeul5WKN+H9tqnu1rYfo/bnG93UxLB/S0zZIGcjWkMyVE
 iwtC8x7q73KIZrluj3d7VBAqgBl7DwteMCSyW8x5FfJgvs7XYOIujancalvQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
Subject: [Qemu-devel] [PATCH v5 3/4] net/filter.c: Add Options to insert
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
Cc: kwolf@redhat.com, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To switch the Secondary to Primary, we need to insert new filters
before the filter-rewriter.

Add the options insert=3D and position=3D to be able to insert filters
anywhere in the filter list.

position should be "head" or "tail" to insert at the head or
tail of the filter list or it should be "id=3D<id>" to specify
the id of another filter.
insert should be either "before" or "behind" to specify where to
insert the new filter relative to the one specified with position.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/net/filter.h |  2 +
 net/filter.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx      | 10 ++---
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/net/filter.h b/include/net/filter.h
index 49da666ac0..22a723305b 100644
=2D-- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -62,6 +62,8 @@ struct NetFilterState {
     NetClientState *netdev;
     NetFilterDirection direction;
     bool on;
+    char *position;
+    bool insert_before_flag;
     QTAILQ_ENTRY(NetFilterState) next;
 };

diff --git a/net/filter.c b/net/filter.c
index 28d1930db7..cd2ef9e979 100644
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
+    return nf->insert_before_flag ? g_strdup("before") : g_strdup("behind=
");
+}
+
+static void netfilter_set_insert(Object *obj, const char *str, Error **er=
rp)
+{
+    NetFilterState *nf =3D NETFILTER(obj);
+
+    if (strcmp(str, "before") && strcmp(str, "behind")) {
+        error_setg(errp, "Invalid value for netfilter insert, "
+                         "should be 'before' or 'behind'");
+        return;
+    }
+
+    nf->insert_before_flag =3D !strcmp(str, "before");
+}
+
 static void netfilter_init(Object *obj)
 {
     NetFilterState *nf =3D NETFILTER(obj);

     nf->on =3D true;
+    nf->insert_before_flag =3D false;
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
@@ -219,6 +262,41 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
         return;
     }

+    if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
+        Object *container;
+        Object *obj;
+        char *position_id;
+
+        if (!g_str_has_prefix(nf->position, "id=3D")) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "position",
+                       "'head', 'tail' or 'id=3D<id>'");
+            return;
+        }
+
+        /* get the id from the string */
+        position_id =3D g_strndup(nf->position + 3, strlen(nf->position) =
- 3);
+
+        /* Search for the position to insert before/behind */
+        container =3D object_get_objects_root();
+        obj =3D object_resolve_path_component(container, position_id);
+        if (!obj) {
+            error_setg(errp, "filter '%s' not found", position_id);
+            g_free(position_id);
+            return;
+        }
+
+        position =3D NETFILTER(obj);
+
+        if (position->netdev !=3D ncs[0]) {
+            error_setg(errp, "filter '%s' belongs to a different netdev",
+                        position_id);
+            g_free(position_id);
+            return;
+        }
+
+        g_free(position_id);
+    }
+
     nf->netdev =3D ncs[0];

     if (nfc->setup) {
@@ -228,7 +306,18 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
             return;
         }
     }
-    QTAILQ_INSERT_TAIL(&nf->netdev->filters, nf, next);
+
+    if (position) {
+        if (nf->insert_before_flag) {
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
@@ -245,6 +334,7 @@ static void netfilter_finalize(Object *obj)
         QTAILQ_REMOVE(&nf->netdev->filters, nf, next);
     }
     g_free(nf->netdev_id);
+    g_free(nf->position);
 }

 static void default_handle_event(NetFilterState *nf, int event, Error **e=
rrp)
diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..23fa5a344e 100644
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
@var{head|tail|id=3D<id>}][,insert=3D@var{behind|before}]

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
@var{head|tail|id=3D<id>}][,insert=3D@var{behind|before}]

 filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{c=
hardevid}, if it has the vnet_hdr_support flag, filter-mirror will mirror =
packet with vnet_hdr_len.

-@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},ind=
ev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vne=
t_hdr_support]
+@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},ind=
ev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vne=
t_hdr_support][,position=3D@var{head|tail|id=3D<id>}][,insert=3D@var{behin=
d|before}]

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
=3D@var{all|rx|tx},[vnet_hdr_support][,position=3D@var{head|tail|id=3D<id>=
}][,insert=3D@var{behind|before}]

 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
@@ -4413,7 +4413,7 @@ colo secondary:
 -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1
 -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall

-@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{f=
ilename}][,maxlen=3D@var{len}]
+@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{f=
ilename}][,maxlen=3D@var{len}][,position=3D@var{head|tail|id=3D<id>}][,ins=
ert=3D@var{behind|before}]

 Dump the network traffic on netdev @var{dev} to the file specified by
 @var{filename}. At most @var{len} bytes (64k by default) per packet are s=
tored.
=2D-
2.20.1


