Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE8FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3E9246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJOlaAiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3E9246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7iKQ-0002fR-G2
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7iIT-0007kV-RT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7iIS-0006PR-PE
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7iIS-0006PH-LN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582906528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAbf6Xk4iOWYyl7F2sdd+EDJE3ppod0snPr2a8tOFFs=;
 b=OJOlaAiU/tYwlWTLg+jp8P2Wwh3nPzVNyPvxldVjWmioG9nRP+5+rNvc37Y02dglfCms0h
 zNQTMzswAUMqpSuAThkJgaOlGOyDRAfaVXKXLKxmvQA+YU4LtjV2M5tln37zR8m2PMsUXz
 FfXBXHTlBh0XJ7yiiRrFh791IOyfhWI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-i8i8limWPCi_8cAc4CJjlg-1; Fri, 28 Feb 2020 11:15:26 -0500
X-MC-Unique: i8i8limWPCi_8cAc4CJjlg-1
Received: by mail-qt1-f199.google.com with SMTP id o24so3277975qtr.17
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2pYteEERbnpshws/vnpLsSSgy0J+668YOCAjLaOgJUQ=;
 b=U9CI+o1OA+xfCVJBa5sVqutvMrbLnd+PfNnfbUtAs64NettlmflBc/PaRnt5b96/dv
 EfzwoUaqQKCGzbxByCp8jJXT9fO9masicTzdjiOPJr2qGIE8G/uVpSDuDeZyj+6JZCkq
 Yz+qhZwXiBkRhOYiuKiNEwfrGHoaHhDZ8wgR590TVTS5eyfGwQxyzjT7SuMQSorgTl06
 tMrsX6/NZHJ0Ct6Vwx5HdWwEHXysYLWUbH0/inma74uOVT+U3e7rKzaZfKwi68K5zSeb
 TFN7lZ75hUAgSKiczx1ZmLp1/R/NlT83EjNW46zJ3hVBI7Re+P5xHTZ2UUFUmmAJGm80
 MLBg==
X-Gm-Message-State: APjAAAU9+UD/5MxbmSUjv1rOJcRtJheDfELi0oDZe00B0GVXyOyvjNo1
 nGGfmb9c3wmobwKKr+2mzUKvL18bCbjcAV8nnZu3ZaXnYptei5oUdQLnbyOt2KyfUmPvDKcLx1o
 VOAQhbTNN6+JU1uY=
X-Received: by 2002:ac8:7b45:: with SMTP id m5mr5044313qtu.360.1582906523755; 
 Fri, 28 Feb 2020 08:15:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaPZje3agvO21Nn6toxdqXRjqIQnZ0tY+UbrlE4c798qJnVTHBDfs8uSpJlnpkKxmngOn56Q==
X-Received: by 2002:ac8:7b45:: with SMTP id m5mr5044148qtu.360.1582906521714; 
 Fri, 28 Feb 2020 08:15:21 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id i64sm3529920qke.56.2020.02.28.08.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:15:20 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] KVM: Pass EventNotifier into kvm_irqchip_assign_irqfd
Date: Fri, 28 Feb 2020 11:15:01 -0500
Message-Id: <20200228161503.382656-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228161503.382656-1-peterx@redhat.com>
References: <20200228161503.382656-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, peterx@redhat.com,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So that kvm_irqchip_assign_irqfd() can have access to the
EventNotifiers, especially the resample event.  It is needed in follow
up patch to cache and kick resamplefds from QEMU.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 439a4efe52..d49b74512a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1628,9 +1628,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int vi=
rq, MSIMessage msg,
     return kvm_update_routing_entry(s, &kroute);
 }
=20
-static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int rfd, int virq=
,
+static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
+                                    EventNotifier *resample, int virq,
                                     bool assign)
 {
+    int fd =3D event_notifier_get_fd(event);
+    int rfd =3D resample ? event_notifier_get_fd(resample) : -1;
+
     struct kvm_irqfd irqfd =3D {
         .fd =3D fd,
         .gsi =3D virq,
@@ -1735,7 +1739,9 @@ int kvm_irqchip_add_hv_sint_route(KVMState *s, uint32=
_t vcpu, uint32_t sint)
     return -ENOSYS;
 }
=20
-static int kvm_irqchip_assign_irqfd(KVMState *s, int fd, int virq, bool as=
sign)
+static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
+                                    EventNotifier *resample, int virq,
+                                    bool assign)
 {
     abort();
 }
@@ -1749,15 +1755,13 @@ int kvm_irqchip_update_msi_route(KVMState *s, int v=
irq, MSIMessage msg)
 int kvm_irqchip_add_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                        EventNotifier *rn, int virq)
 {
-    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n),
-           rn ? event_notifier_get_fd(rn) : -1, virq, true);
+    return kvm_irqchip_assign_irqfd(s, n, rn, virq, true);
 }
=20
 int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
                                           int virq)
 {
-    return kvm_irqchip_assign_irqfd(s, event_notifier_get_fd(n), -1, virq,
-           false);
+    return kvm_irqchip_assign_irqfd(s, n, NULL, virq, false);
 }
=20
 int kvm_irqchip_add_irqfd_notifier(KVMState *s, EventNotifier *n,
--=20
2.24.1


