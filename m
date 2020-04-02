Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8846B20719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLabWmZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8846B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5EA-0007mS-KV
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B1-0002Ua-Lo
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0000Oz-P1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0000MX-KX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=we81EMi0HuTjy4csfYnufkD+oqMDDEevQLiXwsqvJDI=;
 b=PLabWmZ/WVLcQun/XuFSDaRQP4GVDhzCEgURQJ9oVbdW6dIDgnCsWMIUoDNtXk1YLbJsrk
 peY9bAjrZaQiEU8MAQwnOtQmtW4rSL27A4NcQS0wY7P0xnWJqpWwFyzIax3o5PIZG+0/gy
 KPZ/685M7lMI3VLTXwmdg2CsDmjiH+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-gS4d2xVXOJafHu86GwdGOQ-1; Thu, 02 Apr 2020 15:06:49 -0400
X-MC-Unique: gS4d2xVXOJafHu86GwdGOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6D1800D50;
 Thu,  2 Apr 2020 19:06:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 897D150BEE;
 Thu,  2 Apr 2020 19:06:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] MAINTAINERS: Add an entry for the HVF accelerator
Date: Thu,  2 Apr 2020 15:06:30 -0400
Message-Id: <20200402190640.1693-6-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Patrick Colp <patrick.colp@oracle.com>
Cc: Cameron Esfahani <dirty@apple.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Heiher <r@hev.cc>

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200316171825.42544-1-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e580276603..7cb53ec138 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -412,6 +412,13 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
=20
+X86 HVF CPUs
+M: Roman Bolshakov <r.bolshakov@yadro.com>
+S: Maintained
+F: accel/stubs/hvf-stub.c
+F: target/i386/hvf/
+F: include/sysemu/hvf.h
+
 WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
--=20
2.18.2



