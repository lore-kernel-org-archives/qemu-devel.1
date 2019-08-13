Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F00C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45902067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45902067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXsK-000114-06
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40472)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hxXrb-0000ay-1M
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxXrZ-0008Qq-Ni
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:33:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxXrZ-0008Ny-Hf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:33:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so6032283wrt.4
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 07:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lk/r2uMr996XrCDuIaDpGpf6gPqfUYweIe8yqSgfSHk=;
 b=AySMb8NfGtMPKAihW3RQIc2PfETrB2vDIJRPQi4dLJdAYRFMg9XLpv1+XplGGjrD4v
 I3KoNNdYAVQ5bZrcvzVaWU8kClm1RluXE0Gb7kPH5OfVx5QcQvKPbWbSfYtqYTmMX2n5
 7lPpzadRZ59gcMjMrnfDsCTvm1iahAYLhBLz1Q3Fun5gk8RRig9PXYD4A5NBEzZD4OL+
 Nl7RqX5QOXLupaSXks3t0VSV/jbZZasMVG4WiVF134jwz55RwEnCgY7v3LAOFURv4S4K
 yvzHCMy1E9WGIvyqHpcguNMK81RIa1kQ2CLErsOOClasn6QXatrwy1h5tui3NQi8qNwb
 Sbrg==
X-Gm-Message-State: APjAAAUcSrlLSWWuTeQCo0ugdGxWvgiB9cMTkL/rWIri+6sLOdUsPqAm
 4HgYfzp7krM0raiTMhU446S0Eg==
X-Google-Smtp-Source: APXvYqw1n9gEKGgUzv3YBIaYlwLrXfCibAcvsJjCfG8k+LK8EzyczXo6tvytYYTqw/KoVlHZFiro+A==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr13403218wrr.344.1565706803603; 
 Tue, 13 Aug 2019 07:33:23 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id e13sm2617667wmh.44.2019.08.13.07.33.22
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 07:33:22 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 P J P <ppandit@redhat.com>
References: <20190809063835.6717-1-ppandit@redhat.com>
 <20190809063835.6717-2-ppandit@redhat.com>
 <nycvar.YSQ.7.76.1908131534020.10397@xnncv>
 <b2944559-264e-cb48-8a04-4f238197f835@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3a48e557-985d-7274-81d9-fe963f74e59a@redhat.com>
Date: Tue, 13 Aug 2019 16:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b2944559-264e-cb48-8a04-4f238197f835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 1/2] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Fam Zheng <fam@euphon.net>, Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Bugs SysSec <bugs-syssec@rub.de>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/19 12:31, Philippe Mathieu-Daudé wrote:
>> |  
>> |      s->istat1 |= LSI_ISTAT1_SRUN;
>> |  again:
>> | -    insn_processed++;
>> | +    if (++insn_processed > LSI_MAX_INSN) {
>> | +        trace_lsi_execute_script_tc_illegal();
>> | +        lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
>> | +        lsi_disconnect(s);
>> | +        trace_lsi_execute_script_stop();
>> | +        return;
> My understanding of Marcelo's explanation
> (https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01427.html) is
> we can kill insn_processed.
> 

All zeros is not an illegal instruction, it's just a block move with 
zero transfer count.  It's not clear to me from the spec that the 
behavior of QEMU, skipping the second word, is correct, but I do not 
really dare changing it.

After the first instruction is processed, "again" is only reached if 
s->waiting == LSI_NOWAIT.  Therefore, we could move the Windows hack to 
the beginning and remove the s->waiting condition.  The only change 
would be that it would also be triggered by all zero instructions, like this:

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 10468c1..9d714af 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -185,6 +185,9 @@ static const char *names[] = {
 /* Flag set if this is a tagged command.  */
 #define LSI_TAG_VALID     (1 << 16)
 
+/* Maximum instructions to process. */
+#define LSI_MAX_INSN    10000
+
 typedef struct lsi_request {
     SCSIRequest *req;
     uint32_t tag;
@@ -1132,7 +1135,19 @@ static void lsi_execute_script(LSIState *s)
 
     s->istat1 |= LSI_ISTAT1_SRUN;
 again:
-    insn_processed++;
+    if (++insn_processed > LSI_MAX_INSN) {
+        /* Some windows drivers make the device spin waiting for a memory
+           location to change.  If we have been executed a lot of code then
+           assume this is the case and force an unexpected device disconnect.
+           This is apparently sufficient to beat the drivers into submission.
+         */
+        if (!(s->sien0 & LSI_SIST0_UDC)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "lsi_scsi: inf. loop with UDC masked");
+        }
+        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
+        lsi_disconnect(s);
+    }
     insn = read_dword(s, s->dsp);
     if (!insn) {
         /* If we receive an empty opcode increment the DSP by 4 bytes
@@ -1569,19 +1584,7 @@ again:
             }
         }
     }
-    if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
-        /* Some windows drivers make the device spin waiting for a memory
-           location to change.  If we have been executed a lot of code then
-           assume this is the case and force an unexpected device disconnect.
-           This is apparently sufficient to beat the drivers into submission.
-         */
-        if (!(s->sien0 & LSI_SIST0_UDC)) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "lsi_scsi: inf. loop with UDC masked");
-        }
-        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
-        lsi_disconnect(s);
-    } else if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting == LSI_NOWAIT) {
+    if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting == LSI_NOWAIT) {
         if (s->dcntl & LSI_DCNTL_SSM) {
             lsi_script_dma_interrupt(s, LSI_DSTAT_SSI);
         } else {
@@ -1969,6 +1972,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
     case 0x2f: /* DSP[24:31] */
         s->dsp &= 0x00ffffff;
         s->dsp |= val << 24;
+        /*
+         * FIXME: if s->waiting != LSI_NOWAIT, this will only execute one
+         * instruction.  Is this correct?
+         */
         if ((s->dmode & LSI_DMODE_MAN) == 0
             && (s->istat1 & LSI_ISTAT1_SRUN) == 0)
             lsi_execute_script(s);
@@ -1987,6 +1994,10 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
         break;
     case 0x3b: /* DCNTL */
         s->dcntl = val & ~(LSI_DCNTL_PFF | LSI_DCNTL_STD);
+        /*
+         * FIXME: if s->waiting != LSI_NOWAIT, this will only execute one
+         * instruction.  Is this correct?
+         */
         if ((val & LSI_DCNTL_STD) && (s->istat1 & LSI_ISTAT1_SRUN) == 0)
             lsi_execute_script(s);
         break;

Does it make sense?  Do you have a reproducer, and does the above
patch work?  Also, can the reproducer be modified into a qtest test
case?

Thanks,

Paolo


