Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB29DC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C359320883
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C359320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhhO-00073S-2f
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hfhgT-0006aE-DP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hfhgR-0003FY-LO
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:24:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1hfhgR-0003EJ-DG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:24:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so16971870wrl.9
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 02:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=9lGAcAg9fjR59KFRj/dFI9y0S6NbmPeBua+DQBsOvp4=;
 b=q7y1GwRVVa0LzXcUlRO8JQK1ErNxBmmj8CoDRLQ3lCRnGT8TXDneQ6cEFH+tdJ5K+6
 +EELmBImPpiBnR+XS+JsHpWXchZFgg4cSdXRooosWo0mshFM/Xc+dxdKIQJ60jpw0vk+
 N4Mp0SW9C6zEp2SEtBfx06tj17BlCT7BqrVCbOaMikt/YhaE3sOuKxRBMK2m8vkgZhtV
 JuzLILA2E52jXxwdZgC/Da1vEUyrFVFt9ujfiEG/+BrINZdInxQd4aKkRModfkx7pdBS
 ryarE2Rke6pet0fqiQVrAT4xGaEw0ewdKgOhqONWzXqOy+blKSXaltdhFJu1J33RmsTu
 ILrg==
X-Gm-Message-State: APjAAAVAaBk3SZP0HdZejNKdQgaV74+jm/dQXIGw9bralN9ODm0cxW4s
 x/MoX3kttRK1ryojm65rYv87LeQl7IM=
X-Google-Smtp-Source: APXvYqw0a+e+c16+O6ocToIFxYsk21iz48+Wg3ha8wwpSmaAFhB50aowg0JRFKOZJSwrRZpFGNoBaw==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr35802862wrj.37.1561454649038; 
 Tue, 25 Jun 2019 02:24:09 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b6a:1220:e1dd:b35b:b1e3:d497?
 ([2a01:e35:8b6a:1220:e1dd:b35b:b1e3:d497])
 by smtp.gmail.com with ESMTPSA id 11sm1980357wmb.26.2019.06.25.02.24.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 02:24:08 -0700 (PDT)
From: Christophe de Dinechin <dinechin@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Message-Id: <4C5F8F98-D058-46A4-81E7-D9A5D4FEE2EC@redhat.com>
Date: Tue, 25 Jun 2019 11:24:05 +0200
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PATCH] Fix build error when VNC is configured out
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In hmp_change(), the variable hmp_mon is only used
by code under #ifdef CONFIG_VNC. This results in a build
error when VNC is configured out with the default of
treating warnings as errors:

monitor/hmp-cmds.c: In function =E2=80=98hmp_change=E2=80=99:
monitor/hmp-cmds.c:1946:17: error: unused variable =E2=80=98hmp_mon=E2=80=99=
 [-Werror=3Dunused-variable]
1946 |     MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, =
common);
     |                 ^~~~~~~

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c283dde0e9..038614da8e 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1943,7 +1943,6 @@ static void hmp_change_read_arg(void *opaque, =
const char *password,
=20
 void hmp_change(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
     const char *device =3D qdict_get_str(qdict, "device");
     const char *target =3D qdict_get_str(qdict, "target");
     const char *arg =3D qdict_get_try_str(qdict, "arg");
@@ -1952,6 +1951,7 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
=20
 #ifdef CONFIG_VNC
+    MonitorHMP *hmp_mon =3D container_of(mon, MonitorHMP, common);
     if (strcmp(device, "vnc") =3D=3D 0) {
         if (read_only) {
             monitor_printf(mon,
--=20
2.20.1=20


