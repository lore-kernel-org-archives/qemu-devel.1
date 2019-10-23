Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB30CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D6E21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 19:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NucpxCK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D6E21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLtJ-0001S2-V6
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 15:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKVL-0003bm-Lh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKVK-0001ek-Jq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKVI-0001eC-I1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571851980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RTteADGfpM4YBMydoONN1yiclwUwAxdyyctis1vQqE=;
 b=NucpxCK+ZXrJypjzDWQ5M7Wzpka81imEnNipuWG5ffIc/FQt4R5RLFobN2HOUIh0SpbBmt
 IYUsL4YQDsQjC0mTbZquLFhzzv14PbDovxIYbWfEd36NSO//UPLNW1hwQLPfMpKG84ez8W
 cBAOFvKqaeJi7NNkVyMeLLqbm/RgV5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Dna11Fl4OdaSv9tgO5c6Iw-1; Wed, 23 Oct 2019 13:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31F031800E01;
 Wed, 23 Oct 2019 17:32:53 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4956D6CE40;
 Wed, 23 Oct 2019 17:32:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/33] sysbus: remove outdated comment
Date: Wed, 23 Oct 2019 19:31:24 +0200
Message-Id: <20191023173154.30051-4-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Dna11Fl4OdaSv9tgO5c6Iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The init callback is no more since commit
817a17fc60f44e29a1944b60d32f45ea127f0cf9 ("core/sysbus: remove the
SysBusDeviceClass::init path")

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/sysbus.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 2eb0484388..c4a1c0adfa 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -24,10 +24,6 @@ typedef struct SysBusDevice SysBusDevice;
=20
 /**
  * SysBusDeviceClass:
- * @init: Callback function invoked when the #DeviceState.realized propert=
y
- * is changed to %true. Deprecated, new types inheriting directly from
- * TYPE_SYS_BUS_DEVICE should use #DeviceClass.realize instead, new leaf
- * types should consult their respective parent type.
  *
  * SysBusDeviceClass is not overriding #DeviceClass.realize, so derived
  * classes overriding it are not required to invoke its implementation.
--=20
2.23.0.606.g08da6496b6


