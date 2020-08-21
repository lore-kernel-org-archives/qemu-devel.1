Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08A020791
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8RWzKqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08A020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ESM-0007XM-T2
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 17:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9EMm-0001RR-OV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:14:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9EMh-0003sL-NC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 17:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598044462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDWiPfMsxtT5bahMeMUiPa+jt7EA0KC4bptOVt8TDE0=;
 b=Z8RWzKqXoZIgiJAWKHsRBZ7Zb0cP6SUKThR425WmTAWQQ2AChivK4N2zd2jcl8vlsSn6ZU
 X/vG2ZfS+54Qda9wLpYFkmxdgln5z4W+nCBHaV29vegG92tX+NAWXFIfBmFnfQLSyulR6c
 tcTbWIjTHYCumPtiNJaJjehAiayxq0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-bXTMX6kiMBKgfcBgYxHHow-1; Fri, 21 Aug 2020 17:14:20 -0400
X-MC-Unique: bXTMX6kiMBKgfcBgYxHHow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C4F71074658
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 21:14:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2C705C1D0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 21:14:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] keymaps: update
Date: Fri, 21 Aug 2020 17:14:12 -0400
Message-Id: <20200821211412.17321-7-pbonzini@redhat.com>
In-Reply-To: <20200821211412.17321-1-pbonzini@redhat.com>
References: <20200821211412.17321-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks like update-keymaps has not been run in a while.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/keymaps/ar    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/bepo  | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/cz    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/da    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/de    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/de-ch | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/en-gb | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/en-us | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/es    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/et    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/fi    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/fo    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-be | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-ca | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/fr-ch | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/hr    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/hu    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/is    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/it    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/ja    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/lt    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/lv    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/mk    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/nl    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/no    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/pl    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/pt    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/pt-br | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/ru    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/th    | 242 +++++++++++++++++++++++++++++++++++++++++-
 pc-bios/keymaps/tr    | 242 +++++++++++++++++++++++++++++++++++++++++-
 32 files changed, 7680 insertions(+), 64 deletions(-)

diff --git a/pc-bios/keymaps/ar b/pc-bios/keymaps/ar
index f62b297c54..32049d86e9 100644
--- a/pc-bios/keymaps/ar
+++ b/pc-bios/keymaps/ar
@@ -772,9 +772,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/bepo b/pc-bios/keymaps/bepo
index 2292cbc499..99d280ca74 100644
--- a/pc-bios/keymaps/bepo
+++ b/pc-bios/keymaps/bepo
@@ -763,9 +763,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/cz b/pc-bios/keymaps/cz
index 29cf2b05d8..60ac603489 100644
--- a/pc-bios/keymaps/cz
+++ b/pc-bios/keymaps/cz
@@ -819,9 +819,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/da b/pc-bios/keymaps/da
index 547d8c716b..4e42d9ece2 100644
--- a/pc-bios/keymaps/da
+++ b/pc-bios/keymaps/da
@@ -818,9 +818,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym 0x0edd0160)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym 0x0edd0270)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/de b/pc-bios/keymaps/de
index 261243edbc..7be0030dde 100644
--- a/pc-bios/keymaps/de
+++ b/pc-bios/keymaps/de
@@ -816,9 +816,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/de-ch b/pc-bios/keymaps/de-ch
index ed3da058e4..4aad312922 100644
--- a/pc-bios/keymaps/de-ch
+++ b/pc-bios/keymaps/de-ch
@@ -818,9 +818,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/en-gb b/pc-bios/keymaps/en-gb
index 18d8fce4d4..0fd8198b3e 100644
--- a/pc-bios/keymaps/en-gb
+++ b/pc-bios/keymaps/en-gb
@@ -817,9 +817,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/en-us b/pc-bios/keymaps/en-us
index 06762cfc6c..70cc7a2e62 100644
--- a/pc-bios/keymaps/en-us
+++ b/pc-bios/keymaps/en-us
@@ -729,9 +729,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/es b/pc-bios/keymaps/es
index fde441492d..b8fe3dc90f 100644
--- a/pc-bios/keymaps/es
+++ b/pc-bios/keymaps/es
@@ -817,9 +817,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/et b/pc-bios/keymaps/et
index a5dcbd18ab..946e388836 100644
--- a/pc-bios/keymaps/et
+++ b/pc-bios/keymaps/et
@@ -727,9 +727,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/fi b/pc-bios/keymaps/fi
index 816749421e..c8e943b8e7 100644
--- a/pc-bios/keymaps/fi
+++ b/pc-bios/keymaps/fi
@@ -792,9 +792,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/fo b/pc-bios/keymaps/fo
index 8bb6f97bba..20791e1f1f 100644
--- a/pc-bios/keymaps/fo
+++ b/pc-bios/keymaps/fo
@@ -819,9 +819,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/fr b/pc-bios/keymaps/fr
index 82ca812c7e..f865512758 100644
--- a/pc-bios/keymaps/fr
+++ b/pc-bios/keymaps/fr
@@ -819,9 +819,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/fr-be b/pc-bios/keymaps/fr-be
index f225f179a2..e680abb319 100644
--- a/pc-bios/keymaps/fr-be
+++ b/pc-bios/keymaps/fr-be
@@ -818,9 +818,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
index f264d0a9c3..e0b741adc3 100644
--- a/pc-bios/keymaps/fr-ca
+++ b/pc-bios/keymaps/fr-ca
@@ -750,9 +750,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/fr-ch b/pc-bios/keymaps/fr-ch
index bdd944da1c..fe200ea39c 100644
--- a/pc-bios/keymaps/fr-ch
+++ b/pc-bios/keymaps/fr-ch
@@ -818,9 +818,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/hr b/pc-bios/keymaps/hr
index 252936c3ae..f936a256e4 100644
--- a/pc-bios/keymaps/hr
+++ b/pc-bios/keymaps/hr
@@ -819,9 +819,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/hu b/pc-bios/keymaps/hu
index 853147610a..bef6c19f90 100644
--- a/pc-bios/keymaps/hu
+++ b/pc-bios/keymaps/hu
@@ -818,9 +818,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym 0x0a865600)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym 0x0a865710)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/is b/pc-bios/keymaps/is
index c88fa603aa..115c2d09bb 100644
--- a/pc-bios/keymaps/is
+++ b/pc-bios/keymaps/is
@@ -819,9 +819,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/it b/pc-bios/keymaps/it
index df00156cf8..66f46e7ae3 100644
--- a/pc-bios/keymaps/it
+++ b/pc-bios/keymaps/it
@@ -822,9 +822,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/ja b/pc-bios/keymaps/ja
index 6eb2e7bc20..4589dd29b7 100644
--- a/pc-bios/keymaps/ja
+++ b/pc-bios/keymaps/ja
@@ -733,9 +733,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/lt b/pc-bios/keymaps/lt
index db9b24f611..141286f0af 100644
--- a/pc-bios/keymaps/lt
+++ b/pc-bios/keymaps/lt
@@ -817,9 +817,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/lv b/pc-bios/keymaps/lv
index 54997ce092..240d8d3e85 100644
--- a/pc-bios/keymaps/lv
+++ b/pc-bios/keymaps/lv
@@ -792,9 +792,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/mk b/pc-bios/keymaps/mk
index cb362b6d39..d331b23bba 100644
--- a/pc-bios/keymaps/mk
+++ b/pc-bios/keymaps/mk
@@ -729,9 +729,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/nl b/pc-bios/keymaps/nl
index 1579829eef..d6522d117b 100644
--- a/pc-bios/keymaps/nl
+++ b/pc-bios/keymaps/nl
@@ -819,9 +819,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/no b/pc-bios/keymaps/no
index cd634e7b90..631f4dc1a7 100644
--- a/pc-bios/keymaps/no
+++ b/pc-bios/keymaps/no
@@ -833,9 +833,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym 0x00408160)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym 0x00408270)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/pl b/pc-bios/keymaps/pl
index 30d93ca727..6a966f5392 100644
--- a/pc-bios/keymaps/pl
+++ b/pc-bios/keymaps/pl
@@ -823,9 +823,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/pt b/pc-bios/keymaps/pt
index c34d6e3761..31c1dccc2c 100644
--- a/pc-bios/keymaps/pt
+++ b/pc-bios/keymaps/pt
@@ -816,9 +816,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/pt-br b/pc-bios/keymaps/pt-br
index 2d409c0bc0..0bac9e34a3 100644
--- a/pc-bios/keymaps/pt-br
+++ b/pc-bios/keymaps/pt-br
@@ -816,9 +816,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/ru b/pc-bios/keymaps/ru
index 9502ba1269..9f3492ef5d 100644
--- a/pc-bios/keymaps/ru
+++ b/pc-bios/keymaps/ru
@@ -730,9 +730,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/th b/pc-bios/keymaps/th
index b8298d902b..2c4a17f0e5 100644
--- a/pc-bios/keymaps/th
+++ b/pc-bios/keymaps/th
@@ -729,9 +729,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
diff --git a/pc-bios/keymaps/tr b/pc-bios/keymaps/tr
index 8ef60a60c1..2f5bd621a3 100644
--- a/pc-bios/keymaps/tr
+++ b/pc-bios/keymaps/tr
@@ -812,9 +812,247 @@ XF86AudioMedia 0xed
 
 # evdev 245 (0xf5): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
 
-# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 246 (0xf6): no evdev -> QKeyCode mapping (xkb keysym XF86WWAN)
 
-# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym Invalid)
+# evdev 247 (0xf7): no evdev -> QKeyCode mapping (xkb keysym XF86RFKill)
+
+# evdev 248 (0xf8): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 249 (0xf9): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 250 (0xfa): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 251 (0xfb): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 252 (0xfc): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 253 (0xfd): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 254 (0xfe): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 255 (0xff): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 256 (0x100): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 257 (0x101): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 258 (0x102): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 259 (0x103): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 260 (0x104): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 261 (0x105): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 262 (0x106): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 263 (0x107): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 264 (0x108): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 265 (0x109): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 266 (0x10a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 267 (0x10b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 268 (0x10c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 269 (0x10d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 270 (0x10e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 271 (0x10f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 272 (0x110): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 273 (0x111): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 274 (0x112): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 275 (0x113): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 276 (0x114): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 277 (0x115): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 278 (0x116): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 279 (0x117): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 280 (0x118): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 281 (0x119): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 282 (0x11a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 283 (0x11b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 284 (0x11c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 285 (0x11d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 286 (0x11e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 287 (0x11f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 288 (0x120): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 289 (0x121): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 290 (0x122): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 291 (0x123): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 292 (0x124): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 293 (0x125): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 294 (0x126): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 295 (0x127): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 296 (0x128): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 297 (0x129): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 298 (0x12a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 299 (0x12b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 300 (0x12c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 301 (0x12d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 302 (0x12e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 303 (0x12f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 304 (0x130): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 305 (0x131): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 306 (0x132): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 307 (0x133): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 308 (0x134): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 309 (0x135): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 310 (0x136): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 311 (0x137): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 312 (0x138): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 313 (0x139): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 314 (0x13a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 315 (0x13b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 316 (0x13c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 317 (0x13d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 318 (0x13e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 319 (0x13f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 320 (0x140): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 321 (0x141): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 322 (0x142): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 323 (0x143): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 324 (0x144): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 325 (0x145): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 326 (0x146): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 327 (0x147): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 328 (0x148): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 329 (0x149): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 330 (0x14a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 331 (0x14b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 332 (0x14c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 333 (0x14d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 334 (0x14e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 335 (0x14f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 336 (0x150): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 337 (0x151): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 338 (0x152): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 339 (0x153): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 340 (0x154): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 341 (0x155): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 342 (0x156): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 343 (0x157): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 344 (0x158): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 345 (0x159): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 346 (0x15a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 347 (0x15b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 348 (0x15c): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 349 (0x15d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 350 (0x15e): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 351 (0x15f): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 352 (0x160): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 353 (0x161): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 354 (0x162): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 355 (0x163): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 356 (0x164): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 357 (0x165): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 358 (0x166): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 359 (0x167): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 360 (0x168): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 361 (0x169): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 362 (0x16a): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 363 (0x16b): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 364 (0x16c): no evdev -> QKeyCode mapping (xkb keysym XF86Favorites)
+
+# evdev 365 (0x16d): no evdev -> QKeyCode mapping (xkb keysym NoSymbol)
+
+# evdev 366 (0x16e): no evdev -> QKeyCode mapping (xkb keysym XF86Keyboard)
 
 #
 # quirks section start
-- 
2.26.2


