Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31646CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92FE21872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="D/M17jeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92FE21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeQt-0002Fp-Ni
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iNe48-0008DX-6h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iNe46-0002fF-2B
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:26:16 -0400
Received: from mout.web.de ([212.227.17.11]:57843)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>)
 id 1iNe3z-0002T6-Vv; Thu, 24 Oct 2019 10:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571927151;
 bh=6Uf5G14Now/peaYZfO+y9x/dGzGKbhnBYYKyspPJYcQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=D/M17jeYHTyUdlVEzF2vZUmGaAnQQYQJcB/Pm+/2BuuhJBRiQgsT4xvdoG/5wNNLI
 Y+wz4EnfgS12x426zTxksqA4MZjb9xN99doBAwl5/guWjNVS1csbZEviLCKkrj6aTU
 nyuSecSVXx7gUps5AXVQe8wRgWr3nM/iYRhZIXHY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.150]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mf0pJ-1icpWx31Yn-00OXC5; Thu, 24
 Oct 2019 16:25:50 +0200
Date: Thu, 24 Oct 2019 16:25:48 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v7 3/4] net/filter.c: Add Options to insert filters anywhere
 in the filter list
Message-ID: <08d0f857cead8b41d1dca5168dc9552c843644bd.1571925700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1571925699.git.lukasstraub2@web.de>
References: <cover.1571925699.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LCvjcEZF5weijcqBIA8BP5NO8f3y+5ePDyT69+hhBoud6ZGVa7F
 x+k0FawAvED/Cwr6HB0/8DZfGNNfuDms2PL1rnAqiigRURhBKbmxdO+H83UFVPt0wzv24F6
 CcmCiz3cFbI/K7gyCurViVN1OZV2XClLfFAfqxuws7+rlH1DTaoIawXaeNjT7fuVxKAvU8P
 NtaAD0AC9hatlnEkSOy1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NVboErVue28=:HcpN6C5nYdGysiJZUoXyQl
 tdeJupE6NnP0Nq8gpBEKnmiOhY6P6ZnEA7hxT3TgfTGObYPSZZZo+b/sdG740Cki7BtJg/tMa
 6J8DXpQkIToHITIYzbidKOwUOFB/Gk+1pHBYIaS0eKwyM1BxMeYNRUNEznUEmw+3pCnmnvm8y
 FsHalxdjWgfU3rFrFGwPxC1zaNxHaZu8Ww7isA3+1RcnIfU2sh51URwmEKCkmbL49qI88CFfr
 AB5ONX7RspbKYqVwzCFKvUa0J6QyAPc3My2jKOGqjanvSMcUWq0N2odtJev5/3X7F/4oBGTDG
 /mxAgdtjblO67FC46GGcDlZu7Zfh8zSz28/SEBe/UBpTPnBdvtbAd54Sn6ujj7Csx3Y/8DIQr
 BqIflJKfSdxPG8x6e8c5zLvuSND6YqAVT1gRyMOqcMsH1MkQ73eWqpvaUPwN3Ljh+QZSLUJFu
 8nlKuGMYyUjnVx+ydgIHaF9/7LGcpZwG0E5HNIZiqz2NQxp0zYSym2vikK9VETk4toz8axJ8D
 lu75LHmryk44BFV3FB6rqZtx+ajtW0mDGRwsu5Kfcv0gDN7Cs4enojBoAUSJVNzcjU6StgCos
 VWVqfP6aCRhM87cBAYJZVfyR0BEZVOWnlGY5E1UpL1lgPDmp8MX64nhu7UF9ShLomuqgyfi0Y
 CfwmJUoIpbmC8iyatThM2l2mzyZRw64JfexkcNtziCdRtmv1zh6g7MRHNBA0kEE8Nj/AehIeM
 OOd9C5Y4n/dGYOSf/j2LWcuXlyLmr0JQzxWa146eQgyC5z0TcRkRViBOIin91K3J6FPMoJPbn
 Va5nAO1OJhM75RgVnvfMKKbK53QmIuhBAO+dFMPJs+IEniE5pYRxFXqRzSWjLfxpXcdEiWSNw
 0GmKAtmAXNOMAzDVW4+OM2qg0t1XXTctu/UHMXOZVapXfOlwH/NfLepryrMBMRuxMA/QlMqSc
 ei7aCpggu3ha07V0DwJhRpPFIcwFgOnWltz1WOTafPgdiACZBgq+o+hnM6SiEGdqFPoVUYzZF
 D+MYPQUk1xrOHQl3/xonaUeYMMRveVFZN1foi9mhu+rPfc9qvqIuWlwCgxUwbJq2R+KzpuHfR
 jvSrGNE+Ws02ZuGagE4+nEw0Yv6OlzU1UBZQrOPr739L2zl26M9ceycSe59xwSeUxzPj1PDSR
 cPNcd1YAns8e/tbiVmBh64vZLV71Y/PMlyZzXY1SLD+hvQJhW1UpkHzd3O/gep5ZK2QGcSDwJ
 K3Mo8+oSylxzm1N6q5ciSIeY9ROc+V60KzeXekjyT61c/V2l1LudWhtT/tiE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wency@cn.fujitsu.com>, Wen Congyang <wencongyang2@huawei.com>,
 Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>,
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
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
=2D--
 include/net/filter.h |  2 +
 net/filter.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx      | 31 ++++++++++++---
 3 files changed, 119 insertions(+), 6 deletions(-)

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
index 08749a3391..d2a6cb7da1 100644
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
@@ -4387,11 +4387,32 @@ queue @var{all|rx|tx} is an option that can be app=
lied to any netfilter.
 @option{tx}: the filter is attached to the transmit queue of the netdev,
              where it will receive packets sent by the netdev.

-@item -object filter-mirror,id=3D@var{id},netdev=3D@var{netdevid},outdev=
=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vnet_hdr_support]
+position @var{head|tail|id=3D<id>} is an option to specify where the
+filter should be inserted in the filter list. It can be applied to any
+netfilter.
+
+@option{head}: the filter is inserted at the head of the filter
+               list, before any existing filters.
+
+@option{tail}: the filter is inserted at the tail of the filter
+               list, behind any existing filters (default).
+
+@option{id=3D<id>}: the filter is inserted before or behind the filter
+                  specified by <id>, see the insert option below.
+
+insert @var{behind|before} is an option to specify where to insert the
+new filter relative to the one specified with position=3Did=3D<id>. It ca=
n
+be applied to any netfilter.
+
+@option{before}: insert before the specified filter.
+
+@option{behind}: insert behind the specified filter (default).
+
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
@@ -4400,7 +4421,7 @@ Create a filter-redirector we need to differ outdev =
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
@@ -4413,7 +4434,7 @@ colo secondary:
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


