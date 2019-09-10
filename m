Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B196C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABCB2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SMPpITeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABCB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7dJy-00005H-VM
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAu-0001qd-7Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i7dAr-0005M5-QO
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:04 -0400
Received: from mout.web.de ([212.227.17.11]:55739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i7dAr-0005LX-DL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568110490;
 bh=ky24J0BV9q7LhMECzyRhDm2e8abfWgxpXvC7+9DdEXk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=SMPpITePJ/t51tWrlWyAEVc/7wi9s0JS79FuAlmXSsFYXgESI0ei1YlXvtT23s8Qs
 PobSGGf4wygwYyaRbqA2doGNKRPI1bjzhKkbXZMAHdMZ/dAwUwKXEBrs0a/iJAjgYK
 0d7r9xhIlX0HLBtEymPFB16uJNjRA9bl28wViB54=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.217]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVtxM-1hevB342Ei-00X1tu; Tue, 10
 Sep 2019 12:14:50 +0200
Date: Tue, 10 Sep 2019 12:14:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <77d2eb7d0ce8a1887a575119e21ce0a06d4af533.1568110100.git.lukasstraub2@web.de>
In-Reply-To: <cover.1568110100.git.lukasstraub2@web.de>
References: <cover.1568110100.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YA46yQGpgFCIO4NSjWG2eniCmLRgMb93yjByJawZbin3qssseQZ
 3qeQmQbg7egW9MezSMJylGadO9s4c2ykq6E3wzbpHkOtEruYwl8w5u9zdlPYdYkTMC6j8pX
 i5FSjKDDAtNLqrV2JbNeFHCbchShnJTUVnfy6RP0ICsZpBiNL9fTw7Rm9ZzfZUNCB/gSM95
 UdOdm6lkRMBB+5OAlI0pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QeOsxHpznPQ=:KNfaovBqlIqaXjKEX8cWF1
 FOyZ1FL9qmB7Dlfa7ovHESBfe0fWvTLRWFXgMPt4Rm2mOP04J9pxLPsa7OvVzq/rZH4cQAPtN
 NllpbUQ+bUaz2nacf0/cZUqvD+rC7vurLYoynag0foTs6A/B0mRT5eAkcNszz0xnHo5v3wejq
 QEfXVI/YaDftuQE9HCfbUq4zDrNoxhJI4fY+y924XnAhn/znA7+Tk0pWRtzVnV/HDspIqvBFT
 zQibLF+bEZ/qfIPf8Yhe+gyDFvqsvV62ssrMF9z3IA6/8fxEOQz1H/sJecncc6babfnPCJw4G
 bWp7oHUlznrYU82VJk22yG1w2y9Nc39kvubdc39DGyMRSZNzpV5ucjW4FibDrOkE9TzgbOLLg
 9sBy0tN2/XaDc8xoWUgsP0bj4TAqXl3Dl9MHd3ZurIPmQFTJO+qKDenFSWhD/iNeSNbiXIYqH
 krWqTIbtZNiUvZBWj4SX65aqA9q1fg1FGsUgsLkkUEftBfBTRFlb2JQfXtB21wVpYv31t4kzJ
 JxagRJMhILijdFjWrAHkmd8JUdeD06hl+kvY08eKPf6itQCE0aH2rOgAPu/jonxCcUSNhAOzs
 HeaG9+86HlK1jNjY1g0b+ZFm4qoxc199ElBuQrJirF3JIGsC3KfyEDC3U9KjFjkTnQHBRM27i
 7HF8uviuIhKqKj78LnNMTWdCLl2jwSPmVBYo+1w+eVMoqWpCntBcGPDdK8DrBNBuM3oUH7Ful
 ARoQDQquuqao9r8lyS872CvHapSVzRRRH07W7t20Ck35xxztRbvBajHGZ2LoTG6tK0cnITUIR
 cgnDtEs9NOm/xuLhc0PZHtwNgmBy8KIDEvs2mQs1wITWEpwyQ9zMOITlMfFD1oeb2GTR2Gg8w
 NGIzoOzwmGAnUSGNJfifQAYuiekikWEbEAGBf7sR/GMaIBJbBAynAzbA6y82VY0J5oghwfNJz
 MoAocUTL+9MS1bIIWWtYBLgEYluHAbP4PUB6s8vcy+mouipWRiRz35LkpkSBQTLmWIQh8wrTI
 Ll/cKGkBe3gkTA1D8krrekqv7YbnddcIAy5Q6n8Tyf19cJLYFNMbKhG0FjcrIclXLGbTeG9F4
 NcDu0aYmhVtNcX/0tw9482OXxDFnwlvwexVh8Cf2QSeEu2uRuwJfN1eMWcFOmF/D5tAL/MvW7
 d+KwzJhyWYvpWvpiX13Q+6UrCyyyn3tPasepj9ZeitzHby+Ewdg0nLbF9rlby+eVx+sB81ItB
 MVTi37u83EaR1O6Lr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
Subject: [Qemu-devel] [PATCH v4 3/4] net/filter.c: Add Options to insert
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

position should be either "head", "tail" or the id of another filter.
insert should be either "before" or "behind" to specify where to
insert the new filter relative to the one specified with position.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/net/filter.h |  2 ++
 net/filter.c         | 78 +++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx      | 10 +++---
 3 files changed, 84 insertions(+), 6 deletions(-)

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
index 28d1930db7..eb0e9849a5 100644
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
@@ -219,6 +262,27 @@ static void netfilter_complete(UserCreatable *uc, Err=
or **errp)
         return;
     }

+    if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
+        /* Search for the position to insert before/behind */
+        Object *container;
+        Object *obj;
+
+        container =3D object_get_objects_root();
+        obj =3D object_resolve_path_component(container, nf->position);
+        if (!obj) {
+            error_setg(errp, "filter '%s' not found", nf->position);
+            return;
+        }
+
+        position =3D NETFILTER(obj);
+
+        if (position->netdev !=3D ncs[0]) {
+            error_setg(errp, "filter '%s' belongs to a different netdev",
+                        nf->position);
+            return;
+        }
+    }
+
     nf->netdev =3D ncs[0];

     if (nfc->setup) {
@@ -228,7 +292,18 @@ static void netfilter_complete(UserCreatable *uc, Err=
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
@@ -245,6 +320,7 @@ static void netfilter_finalize(Object *obj)
         QTAILQ_REMOVE(&nf->netdev->filters, nf, next);
     }
     g_free(nf->netdev_id);
+    g_free(nf->position);
 }

 static void default_handle_event(NetFilterState *nf, int event, Error **e=
rrp)
diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..1fd294a10f 100644
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
@var{head|tail|id}][,insert=3D@var{behind|before}]

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
@var{head|tail|id}][,insert=3D@var{behind|before}]

 filter-mirror on netdev @var{netdevid},mirror net packet to chardev@var{c=
hardevid}, if it has the vnet_hdr_support flag, filter-mirror will mirror =
packet with vnet_hdr_len.

-@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},ind=
ev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vne=
t_hdr_support]
+@item -object filter-redirector,id=3D@var{id},netdev=3D@var{netdevid},ind=
ev=3D@var{chardevid},outdev=3D@var{chardevid},queue=3D@var{all|rx|tx}[,vne=
t_hdr_support][,position=3D@var{head|tail|id}][,insert=3D@var{behind|befor=
e}]

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
ert=3D@var{behind|before}]

 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
@@ -4413,7 +4413,7 @@ colo secondary:
 -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1
 -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall

-@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{f=
ilename}][,maxlen=3D@var{len}]
+@item -object filter-dump,id=3D@var{id},netdev=3D@var{dev}[,file=3D@var{f=
ilename}][,maxlen=3D@var{len}][,position=3D@var{head|tail|id}][,insert=3D@=
var{behind|before}]

 Dump the network traffic on netdev @var{dev} to the file specified by
 @var{filename}. At most @var{len} bytes (64k by default) per packet are s=
tored.
=2D-
2.20.1


