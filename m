Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B22C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35A4204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPaLxqVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A4204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddKp-00011r-Pl
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJb-0006NI-P1; Tue, 26 May 2020 13:24:35 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJZ-0004M7-Qo; Tue, 26 May 2020 13:24:34 -0400
Received: by mail-ej1-x641.google.com with SMTP id a2so24647307ejb.10;
 Tue, 26 May 2020 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ySZN0x/gpW9u9k16b9nqnSd6Xdlq5rvuji37dlolnbk=;
 b=EPaLxqVztq6HHTgASgBqieyKIVpffbusau7Sb4xVVYBjsKVYH2ISfxZ9msqCjvf9Va
 gwi+eDTErWUymz4aH6ZjpT/h4segUpRBy/2cVdb1k6/edjAug9qgflPllShmDEL+0YAw
 +6DPSkzm4IVMNRepwyr99zReUvK6MMgpHWahjvaYo9xBsttDE/dWU7OEHRRZ41TuXXDH
 Hppx6M+QDRIqp7z5t6YdLyTECEhbywVAM4nyNwNzxuRUDCNoQj3z99qGpCkH7MgJX5gH
 r+6KgBG5ml22ttaaujMguaNNYAuL7CtnY/AroPSVojkFdBQx5lm0RlJV03CSAa56WfpS
 keTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ySZN0x/gpW9u9k16b9nqnSd6Xdlq5rvuji37dlolnbk=;
 b=uKqUDAf6C/ZdJy8o+l7o083DKM42IbjQKpBC7KEmDQzZXyWCmvqBGeCdkvp581jzbQ
 4c4f7N8FKjaws3bg1C0yu05S0pNWYOe/nilJ2MG9D+q8gFpt9LNg/PLOCxIuKCbMnsfs
 DEilxuxWVB3EFZMlKV8ZkUfmkSpOLKLsiQ8vC80HqXzJaeZaAd2Jme+0OCEKzMBieA4F
 v8/ySqyLcCZ79wawWOYEuAWa2X1t7Pu6i1MEHpRWklcIZXrFN/fzdlOiITfze/EtNDja
 AUt6Wx2qDIOe0PmbdI9BXLF2dwlhAo1hmK9opCYZRCThBAw7iTjnKdN/bBYKsBQUrVqr
 HUuQ==
X-Gm-Message-State: AOAM533eA4UaNU1RWYkNbA2a4/EH6ylcmy6IIMtiR5X9S9Rvnp/5qWB/
 shoK5xNupdU9he39U5qXtxAxwQYiqE8=
X-Google-Smtp-Source: ABdhPJwnH6TkfWy/1O3rgJT1eVUVOYC1sHpgM286TBTi8I1uW+9Z4O4az89O30KCWjhlPuoIaIivRA==
X-Received: by 2002:a17:906:16d3:: with SMTP id
 t19mr2011617ejd.36.1590513871429; 
 Tue, 26 May 2020 10:24:31 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] sysemu/accel: Restrict machine methods to system-mode
Date: Tue, 26 May 2020 19:24:21 +0200
Message-Id: <20200526172427.17460-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restrict init_machine(), setup_post() and has_memory()
to system-mode.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/accel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 47e5788530..e08b8ab8fa 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -37,10 +37,12 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+#ifndef CONFIG_USER_ONLY
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
+#endif
     bool *allowed;
     /*
      * Array of global properties that would be applied when specific
-- 
2.21.3


