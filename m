Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5CC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E68720720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iECCZPEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E68720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02iy-0001TR-Kp
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j02gj-0006Yv-I6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j02gi-0002wJ-7V
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j02gi-0002vq-40
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581078287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbkkrxK6vPCDjfHB0Gp37vjvxexHPQ+/eYdxybDtoEc=;
 b=iECCZPEcWW6dQR8ejecMwdrG/rEK8SVbQ92+5G38ih86OCkxdLLKFpr11ysivY8FqBpekx
 h3zgKbWlOf97kBVNcfSO6ElsuG457aCf97sZ7M9rGfaG5oBfwsEBHWyynaLMcEPEA5KWjI
 cynPN/G4bV8Vq7oy1gfgLoI4jW+K8PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-XA2S6bXjMPeEH7bGwNPX_A-1; Fri, 07 Feb 2020 07:24:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53B041902EA9
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 12:24:45 +0000 (UTC)
Received: from dhcp-16-105.lcy.redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FC897FB60;
 Fri,  7 Feb 2020 12:24:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] docs: stop documenting the e1000 NIC model as the default
Date: Fri,  7 Feb 2020 12:24:40 +0000
Message-Id: <20200207122440.2650229-4-berrange@redhat.com>
In-Reply-To: <20200207122440.2650229-1-berrange@redhat.com>
References: <20200207122440.2650229-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XA2S6bXjMPeEH7bGwNPX_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default NIC model for QEMU varies per machine type, and is liable to
change across machine type versions. Documenting e1000 NIC as the
default for PC/i386 is thus misleading to users at best. In particular
the PC q35 machine type switched to use e1000e, but only in machine
type versions after 2.11.

Rather than try to explain which NIC model is used for each machine
type version, remove mention of e1000 as the default, and steer users
towards always specifying their desired model.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qemu-options.hx | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ff3e806977..ac315c1ac4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2428,8 +2428,7 @@ Use @option{model=3Dhelp} to list the available devic=
e types.
 The hardware MAC address can be set with @option{mac=3D@var{macaddr}}.
=20
 The following two example do exactly the same, to show how @option{-nic} c=
an
-be used to shorten the command line length (note that the e1000 is the def=
ault
-on i386, so the @option{model=3De1000} parameter could even be omitted her=
e, too):
+be used to shorten the command line length:
 @example
 @value{qemu_system} -netdev user,id=3Dn1,ipv6=3Doff -device e1000,netdev=
=3Dn1,mac=3D52:54:98:76:54:32
 @value{qemu_system} -nic user,ipv6=3Doff,model=3De1000,mac=3D52:54:98:76:5=
4:32
@@ -2843,9 +2842,12 @@ netdev with ID @var{nd} by using the @option{netdev=
=3D@var{nd}} option.
 Legacy option to configure or create an on-board (or machine default) Netw=
ork
 Interface Card(NIC) and connect it either to the emulated hub with ID 0 (i=
.e.
 the default hub), or to the netdev @var{nd}.
-The NIC is an e1000 by default on the PC target. Optionally, the MAC addre=
ss
-can be changed to @var{mac}, the device address set to @var{addr} (PCI car=
ds
-only), and a @var{name} can be assigned for use in monitor commands.
+If @var{model} is omitted, then the default NIC model associated with
+the machine type is used. Note that the default NIC model may change in
+future QEMU releases, so it is highly recommended to always specify a mode=
l.
+Optionally, the MAC address can be changed to @var{mac}, the device
+address set to @var{addr} (PCI cards only), and a @var{name} can be
+assigned for use in monitor commands.
 Optionally, for PCI cards, you can specify the number @var{v} of MSI-X vec=
tors
 that the card should have; this option currently only affects virtio cards=
; set
 @var{v} =3D 0 to disable MSI-X. If no @option{-net} option is specified, a=
 single
--=20
2.24.1


