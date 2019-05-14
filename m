Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34685C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EDD2084A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POiQkJF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EDD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51540 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQb2x-0000L0-7k
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:16:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQb1r-0008Ca-Or
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQb1q-0004w9-OS
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:15:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQb1q-0004u3-Ff
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:15:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id r4so20078461wro.10
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=uSQmekUfpD7+rcDFA9B68Vfcr/8kNqcRlQG27Zm4D/s=;
	b=POiQkJF2vvKklQP3lI9ay8t4RlcqKTcc0Mws3U5Kr/WdnMeS4g4OLxPhlANbDvq/mM
	P4Il0Mjky/vfxttRzVuSQ2AzywtokuVcFvbl+ySVowsFeDWbAeqLJGf1QnPfvZtgfXmT
	xIHB6syqH8frslrqs6HlCGvd9jeRT9lY21VzB2nqqWGfROsohc9TZEF2pr5/dbVw4YzA
	YDVdxy8LFG/SQkTlm4FV0iWPyog0rT3aONamspNb+2A8WmttWI3JzuH4VeAr2arVigu6
	dZHv/iX74BK/rUwbnCq1GijRkJYUiAml4Dz7TKh89BQnlDtJn6unrLiocF1f+42uf5iA
	OV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=uSQmekUfpD7+rcDFA9B68Vfcr/8kNqcRlQG27Zm4D/s=;
	b=g7U5af7dDysLZoTjseevr5/s4ls26YGmZRp20m6jq8on/4+o+3wbViHntCZLoXuniH
	SrBIWgtSkhLwW8BfROUt0rD5qMnkh8sxQccGlK/SL+vgrVXnDdxh+2SaqTo5FpJICTrs
	qE8484ipYIBjOoLH1sxJZGVbismJwXH6AmA439r0X4PCGpo1Dr1lNrhp2EmUv/2QSWyJ
	VkWNKOsTfk/PdzZakNAu2s3Xz5cVNrUgKhEHZ17awj2syANxAb3/h+68ASNzF7/GSZIp
	3LzUOPGi4+40EJrw6DunMvE2hZfHvbFhlobRJ4gNqE0K6D2DLb6QvSKB60uOwuqx1XY9
	4uoQ==
X-Gm-Message-State: APjAAAXGsw9hcobmRuSqPqi1SnmdWSggIsT82vowreIIdJhuoYT80N3+
	e0VYB94/89U07LyMdge0q7KHdjZf1y0=
X-Google-Smtp-Source: APXvYqys0Fd/NBX7H5qGK5EnJS7uZ0oPVEAfkIjv7YXiFIGIEmUJmSJHt/AI6cUtjYh9k3nWvJva0A==
X-Received: by 2002:adf:c188:: with SMTP id x8mr11860795wre.256.1557854148129; 
	Tue, 14 May 2019 10:15:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	g185sm3280036wmf.30.2019.05.14.10.15.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 10:15:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 18:15:45 +0100
Message-Id: <20190514171545.24961-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can have
 no parent
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
some qbus buses not being connected to qdev devices -- if the
bus has no parent object then we register a reset function which
resets the bus on system reset.

Nearly a decade later, we have now no buses in the tree which
are created with non-NULL parents, so we can remove the
workaround and instead just assert that if the bus has a NULL
parent then it is the main system bus.

(The absence of other parentless buses was confirmed by
code inspection of all the callsites of qbus_create() and
qbus_create_inplace() and cross-checked by 'make check'.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
While I was reviewing Damian's reset patchset I noticed this
code which meant that we theoretically had multiple 'roots' to
the set of things being reset, so I wondered what was actually
using it. It turns out nothing was :-)

Commit 80376c3fc2c38fdd453 also added a TODO in vl.c suggesting
that there is the wrong place to register the reset function
which effectively resets the whole system starting at the
root which is the main system bus:
   qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
I don't understand why vl.c is a bad place to put that, and I'd
rather not move it to qdev.c (where in qdev.c?) because that
would reshuffle reset ordering which seems liable to cause
regressions. So maybe we should just delete that TODO comment?

---
 hw/core/bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index e09843f6abe..e50287c2b35 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -96,10 +96,9 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
         bus->parent->num_child_bus++;
         object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
         object_unref(OBJECT(bus));
-    } else if (bus != sysbus_get_default()) {
-        /* TODO: once all bus devices are qdevified,
-           only reset handler for main_system_bus should be registered here. */
-        qemu_register_reset(qbus_reset_all_fn, bus);
+    } else {
+        /* The only bus without a parent is the main system bus */
+        assert(bus == sysbus_get_default());
     }
 }
 
-- 
2.20.1


