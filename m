Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A74C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAA224699
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOPCh3HE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAA224699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ft6-0001j7-VK
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fi5-00063Z-RW
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fi4-0003zX-NO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fi4-0003z7-Jm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFxYqTPRC3v1xfb8BAOFPfQcKY0hZcPjdd/3vEwYZC8=;
 b=AOPCh3HESGk7R+Acjq12m/AHnc5xQiq+7DYK3WzseduNR+BQMnx3WmrnGVAQhGxk1moYbE
 T0GhRL7SZ/7SzEZ+hRo8XifsspkzZ2rMVxUY0TmY05uWOakvw0/UqLrt8DzSe2R0WVUQrJ
 1KmyATe31nOVjh1+ULcZGTNuQqN5dO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-la-4X30oMXmQa1Ygalck3w-1; Mon, 02 Mar 2020 02:41:45 -0500
X-MC-Unique: la-4X30oMXmQa1Ygalck3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 467BF18FE860;
 Mon,  2 Mar 2020 07:41:44 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5F260BF3;
 Mon,  2 Mar 2020 07:41:37 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 23/23] l2tpv3: fix RFC number typo in qemu-options.hx
Date: Mon,  2 Mar 2020 15:40:36 +0800
Message-Id: <1583134836-23991-24-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The L2TPv3 RFC number is 3931:
https://tools.ietf.org/html/rfc3931

Reported-by: Henrik Johansson <henrikjohansson@rocketmail.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 828e71b..084a1c1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2330,7 +2330,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                Linux kernel 3.3+ as well as most routers can talk\n"
     "                L2TPv3. This transport allows connecting a VM to a VM=
,\n"
     "                VM to a router and even VM to Host. It is a nearly-un=
iversal\n"
-    "                standard (RFC3391). Note - this implementation uses s=
tatic\n"
+    "                standard (RFC3931). Note - this implementation uses s=
tatic\n"
     "                pre-configured tunnels (same as the Linux kernel).\n"
     "                use 'src=3D' to specify source address\n"
     "                use 'dst=3D' to specify destination address\n"
@@ -2737,7 +2737,7 @@ Example (send packets from host's 1.2.3.4):
 @end example
=20
 @item -netdev l2tpv3,id=3D@var{id},src=3D@var{srcaddr},dst=3D@var{dstaddr}=
[,srcport=3D@var{srcport}][,dstport=3D@var{dstport}],txsession=3D@var{txses=
sion}[,rxsession=3D@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,pinc=
ounter][,txcookie=3D@var{txcookie}][,rxcookie=3D@var{rxcookie}][,offset=3D@=
var{offset}]
-Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3391) is a
+Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931) is a
 popular protocol to transport Ethernet (and other Layer 2) data frames bet=
ween
 two systems. It is present in routers, firewalls and the Linux kernel
 (from version 3.3 onwards).
--=20
2.5.0


