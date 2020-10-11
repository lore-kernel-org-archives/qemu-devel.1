Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60AAC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEBF2145D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7OQZQXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEBF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRh74-0004xN-JQ
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5X-0002dR-4w; Sun, 11 Oct 2020 15:32:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRh5V-0006rw-LN; Sun, 11 Oct 2020 15:32:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so16557288wrq.11;
 Sun, 11 Oct 2020 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=owliHLOWbWXpZmpPZaYeHDfZXoImwW9/yfAFwtcxj6M=;
 b=g7OQZQXcv3KXHokyULyGv+Ywkf4wWXZ5c7oE+RwQzJcG0si14dbQfekusSJzoJ9MgO
 5XG1W9SlmtpG6HEQ1jCYywVYL56I+FZfIsGyjfwCliqv2NABM0sHdW4IAlPQlLM6r8tW
 sZcbmbj/Q7dqKpHmk5BE+K74LQTsNYlD8fw4vTGhcSeCb3CGaCebhkpwVrY5cL2oOhrH
 LMwOiWy4+DkMbJ+kABjF34uAOHxMoCAE0IFnEpvFFSBYRsj40oWg1bxYwcSO+ScI77uv
 njgAZgZx0+u9xZ3YtutxvbVzPcaBBuWtr0XXy+ZtePPG3QVPFU5IKXylmBHrfRIrEjRQ
 698w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=owliHLOWbWXpZmpPZaYeHDfZXoImwW9/yfAFwtcxj6M=;
 b=myXgMfLp80yANrDXVR4hbtTb6NbBzolGpBeaXJpEOxDnulyilXBVWNEvNLDWGKNk6G
 3YQJq6c5f1Ocb8XDTgs5uBrCCStXBJHaMvYw/IQyMhV7GBSporWLY7xgEi5waevvG5DX
 2r087cnz0iHKxeJnT/S/MgyiCJia9IEmC8n/+hQ+pJa+POgUEAOpdq5z4phdvMe8elEU
 kYeo6BGbpbOVQFKjnKxP8gMAy7QGwnSHLyAc9mIGm315r5NJQlKCoaHgcQY92UQWmGQg
 M72b8kyBb4rdT3w9po/2+we8rTb9LW+6jdNWvHquZBFecdYxjqD9iTvdubDgYfk8TSpJ
 kN7g==
X-Gm-Message-State: AOAM532t137p/7vlUjZgruY+5S7bVTd9H5bASd+h/xc+BNap3Y48H6GK
 N6tGFNXunzoZbIE2FatJB5q7z0fgz+o=
X-Google-Smtp-Source: ABdhPJxy68Wf0o+etONuXcLIVKe+JDROsKLnvKm0eP9LYZzuySddD8NjhEjBnsX/mx3QpFlm9+JN1Q==
X-Received: by 2002:adf:fa06:: with SMTP id m6mr20571534wrr.253.1602444774960; 
 Sun, 11 Oct 2020 12:32:54 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w1sm22162629wrp.95.2020.10.11.12.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:32:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] hw/isa: Add the ISA_IRQ_TPM_DEFAULT definition
Date: Sun, 11 Oct 2020 21:32:23 +0200
Message-Id: <20201011193229.3210774-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011193229.3210774-1-f4bug@amsat.org>
References: <20201011193229.3210774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TPM TIS device uses IRQ #5 by default. Add this
default definition to the IsaIrqNumber enum.

Avoid magic values in the code, replace them by the
newly introduced definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/isa.h   | 1 +
 hw/i386/acpi-build.c   | 2 +-
 hw/ipmi/isa_ipmi_bt.c  | 2 +-
 hw/ipmi/isa_ipmi_kcs.c | 2 +-
 hw/tpm/tpm_tis_isa.c   | 2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 519296d5823..e4f2aed004f 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -11,6 +11,7 @@
 enum IsaIrqNumber {
     ISA_IRQ_KBD_DEFAULT =  1,
     ISA_IRQ_SER_DEFAULT =  4,
+    ISA_IRQ_TPM_DEFAULT =  5,
     ISA_NUM_IRQS        = 16
 };
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 45ad2f95334..2b6038ab015 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1886,7 +1886,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                     Rewrite to take IRQ from TPM device model and
                     fix default IRQ value there to use some unused IRQ
                  */
-                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
+                /* aml_append(crs, aml_irq_no_flags(ISA_IRQ_TPM_DEFAULT)); */
                 aml_append(dev, aml_name_decl("_CRS", crs));
 
                 tpm_build_ppi_acpi(tpm, dev);
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index b7c2ad557b2..13a92bd2c44 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -137,7 +137,7 @@ static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
 
 static Property ipmi_isa_properties[] = {
     DEFINE_PROP_UINT32("ioport", ISAIPMIBTDevice, bt.io_base,  0xe4),
-    DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
+    DEFINE_PROP_INT32("irq", ISAIPMIBTDevice, isairq, ISA_IRQ_TPM_DEFAULT),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 7dd6bf0040a..c956b539688 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -144,7 +144,7 @@ static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
 
 static Property ipmi_isa_properties[] = {
     DEFINE_PROP_UINT32("ioport", ISAIPMIKCSDevice, kcs.io_base,  0xca2),
-    DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
+    DEFINE_PROP_INT32("irq", ISAIPMIKCSDevice, isairq, ISA_IRQ_TPM_DEFAULT),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 6fd876eebf1..5a4afda42df 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -91,7 +91,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
 }
 
 static Property tpm_tis_isa_properties[] = {
-    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
+    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, ISA_IRQ_TPM_DEFAULT),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.26.2


