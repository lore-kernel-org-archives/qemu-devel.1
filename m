Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C168C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348E820879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348E820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcL6-00025N-F1
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:39:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcHJ-00075D-DQ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQcHH-0001eE-VU
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQcHH-0001cw-Px
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:35:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1ADD5309702E;
	Tue, 14 May 2019 18:35:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
	[10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94A02608A6;
	Tue, 14 May 2019 18:35:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
	ehabkost@redhat.com, richardw.yang@linux.intel.com,
	yury-kotov@yandex-team.ru, chen.zhang@intel.com
Date: Tue, 14 May 2019 19:34:46 +0100
Message-Id: <20190514183454.12758-9-dgilbert@redhat.com>
In-Reply-To: <20190514183454.12758-1-dgilbert@redhat.com>
References: <20190514183454.12758-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 14 May 2019 18:35:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/16] qemu-option.hx: Update missed parameter
 for colo-compare
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

We missed the iothread related args in this file.
This patch is used to fix this issue.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Message-Id: <20190426090730.2691-4-chen.zhang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 qemu-options.hx | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 51802cbb26..3faa935929 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4425,13 +4425,15 @@ Dump the network traffic on netdev @var{dev} to t=
he file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcp=
dump
 or Wireshark.
=20
-@item -object colo-compare,id=3D@var{id},primary_in=3D@var{chardevid},se=
condary_in=3D@var{chardevid},outdev=3D@var{chardevid}[,vnet_hdr_support]
+@item -object colo-compare,id=3D@var{id},primary_in=3D@var{chardevid},se=
condary_in=3D@var{chardevid},outdev=3D@var{chardevid},iothread=3D@var{id}=
[,vnet_hdr_support]
=20
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in=
@var{chardevid}, than compare primary packet with
 secondary packet. If the packets are same, we will output primary
 packet to outdev@var{chardevid}, else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
-if it has the vnet_hdr_support flag, colo compare will send/recv packet =
with vnet_hdr_len.
+In order to improve efficiency, we need to put the task of comparison
+in another thread. If it has the vnet_hdr_support flag, colo compare
+will send/recv packet with vnet_hdr_len.
=20
 we must use it with the help of filter-mirror and filter-redirector.
=20
@@ -4446,10 +4448,11 @@ primary:
 -chardev socket,id=3Dcompare0-0,host=3D3.3.3.3,port=3D9001
 -chardev socket,id=3Dcompare_out,host=3D3.3.3.3,port=3D9005,server,nowai=
t
 -chardev socket,id=3Dcompare_out0,host=3D3.3.3.3,port=3D9005
+-object iothread,id=3Diothread1
 -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0
 -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=3Dc=
ompare_out
 -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=3D=
compare0
--object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3Dc=
ompare1,outdev=3Dcompare_out0
+-object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=3Dc=
ompare1,outdev=3Dcompare_out0,iothread=3Diothread1
=20
 secondary:
 -netdev tap,id=3Dhn0,vhost=3Doff,script=3D/etc/qemu-ifup,down script=3D/=
etc/qemu-ifdown
--=20
2.21.0


