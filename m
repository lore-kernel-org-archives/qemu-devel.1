Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D68C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CA422CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LxILPuoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CA422CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i558G-0006NC-JP
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i54zj-0008JM-FV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i54zg-0002bi-Hb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:59 -0400
Received: from mout.web.de ([212.227.15.4]:51727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i54zg-0002aJ-8O
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567502433;
 bh=EQfG/A3jWr0rwlKpE0l7vZXu2bBYArUGmn3F6XCqY6U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LxILPuojfR+pfIGd0iRspe4cyRXK1ewCGqJbZlh3j81ZW/NRMI75zuIlSbtYdhzLS
 Y2SN6mgnQ2b22iLM2Fpa3OklJ03bEIYqTtCtEaaCkYL09+SMMawNghFZwgS7DyfgRW
 x6ict+fadrQqObFv0r6NRMb3fZAzuM1X0fj3LZWU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.78]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMFB7-1i6S2W2ixp-0081qR; Tue, 03
 Sep 2019 11:20:33 +0200
Date: Tue, 3 Sep 2019 11:20:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <13409421f1217cf755b694779dccb6dd127708fc.1567500411.git.lukasstraub2@web.de>
In-Reply-To: <cover.1567500411.git.lukasstraub2@web.de>
References: <cover.1567500411.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yj61fF/zWfbRK2noQMvAcQs9f732wkJh44ZaXcFpe61rC496ebp
 1C5ibpHYtir9M90WokrDtaWHjx5NBc433eDvlPuCA/BzXtVkTMq/d4m1j3e1D5UljyqoLSq
 DtUrFvztVh36wL/BgPCs1oiw0+HjrWeYWtJJTor9dUVVCENNKH0lEukAIPtikMeXA3Ev7Eu
 kCzbWwZ3vP2ftam5sWOcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gs8JxF+T2iY=:iDDirV4S2RrrVlARhL3opw
 kgC7h0PLenrJdUzNN6ijAd5RFLNCMTXhZRVyaSqAn+04HSz2sEfCBEwIq4rkc3Sddq41juUAD
 izgQJ71+UKc4IzSZRfTKHRs4Akl9oOhkZkQ/Yoxch+ZDiWH9gqFUZis/KtJ7+9NvD6LllRpcl
 4DriIpaGjFWkXSzPzqgAXg0Za1rfGWXAOh1ZW1bsgI78JQvFPlZ+cHdJ8Q1+vVFENNayO/Hnk
 6lmN93FRSY+XHFM2vDjI2XycznZ6T4Jy0OyGBGWvgPnWllfNN9Op/Uc/Ty9zeYnXa7SV+GZFw
 MGkDTZqXHjwFLM7dwUhfJlHo0IBS32MeE3I+D67mEnX1nThlbCvsE5H0T8InoG5HMAYf3EtsE
 iXC4Vgu17vzrEwjpYJqKEGoDl9vJ2kvRJI+hxURKdcSWgWB6yY50YUrqz1Mz93ouXBLewc2rn
 gQljNMc7MCv0iqyQFKF5lwbegxCuxffM8dg2kCKiLikMwgEZxclDa51RaOoa6JmtfeUoR6hH7
 OgpW0LM0HvCVWdQvvpvO3pD/n952xmDf6s9BsWkbFEEYaIEO2etAqlrJq3+r9VoTZ2hltX2tA
 ngDZ4RD2KEN5AfZobABNMI9zl9OMHxfh9j1ftUsc9gB29dlOc+kjpg9m1+Kx5706ys989vPM4
 K80/p7qOLe1eo2GpQigVg2WUlYNf7LHoVbstPncnBpeuP51pzfLGmZbGU+NN36c/tihzaCUVh
 0c1YhfE12ENejHkXMu82VsIvZhZcPNEFhiB5nqDYzmxWyV8DVujbIyIVFFcz1/VcQuwoIi1zi
 bxcWn3JK+TRdvBnuUwet21bFLDACIUwo9OZBayTJNaKzhVZVoJ3CzWPFKgj5/kPkcKvb8QWfJ
 FmX8b6yf775nKSJo02kb1EUl9eW9zbA9gGlbg3Cku5f9DO4/9qFePOd06Jz6sISlQaYtt6JBQ
 ZfrQOBEEbAzfkgX4CzvpFa2+IrQxbp1O2vTCNn4QGMr9vZx/jHF1hVa0gKyzzebZnLWDp+VVx
 nSa/nyCqIEYjnLt6ZhKCk+sIVssSYwnxnEy1qXXxFmxBSI2onUC7krLpyCjuiWDpyTsnZol60
 gwsledllExjdQ0oo0gwSyqa/eazokZurGDNXP+mrmLnNwu6Uroon5nbJAEoDej1E19FfJYsHA
 y2QBYhZSEnNlFgij8QMRqEoAqY5SA/w6iQngWqIQ4NbS1YEg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
Subject: [Qemu-devel] [PATCH v3 3/4] net/filter.c: Add Options to insert
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
index 28d1930db7..7edebb2bf7 100644
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


