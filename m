Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE416C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FDA20693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FDA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35885 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho2vk-0005dI-U1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 05:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho2vZ-00053n-HE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho2vY-0008L4-CR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:42:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho2vY-0008Jf-4u
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:42:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id f9so27888406wre.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 02:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nTorg+LsFbfhGP1VnBx1NiqIynBWL16WoIpeexEc/9U=;
 b=rTNRlU/xSceaHg0+GGzWryr3nppqmMqIS/w/+XxbJFd52SPwIZ56mIlyvcAj/HCjKy
 MZqynHUiQLDQJI2NXXfmzycycPH+LF8iqk89d91FtB+ZBlBQeE0jkPss0c4EPBJADnTE
 U62lQNdXSbVZUgIBX3+kbWbKw63DbUm3kxg2QZBZOXCP5RyBVcL8W94B6EtopSh7+PFf
 CCDDKlceRLPwdyKYXTIBBgJSYTw8qeUOjq81WxVZxaKZC6FgTt+4/hFXbP/v7vCKmixS
 krCO+iS5poBdnCbCLf+4+Gsne6PbrfXH6cHWtCtAdFXTkc/epbP0wRKlbVSsrc8K0UOt
 uXZQ==
X-Gm-Message-State: APjAAAVEQ2kdsh3a1KQacgCIGUuMK/ZAxrTfxMaobo6pLEKUY17hr2dq
 Q1mikrQsYis/3xBFRB34vl1rnA==
X-Google-Smtp-Source: APXvYqzORqKmjOe/HvULTbu5k/TZgmgwpMr3QGDzs7E1fv2a5iwXkZfeqoy+rhLqYJylabUUkdfgRA==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr5497043wrp.277.1563442935019; 
 Thu, 18 Jul 2019 02:42:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id v65sm27819499wme.31.2019.07.18.02.42.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 02:42:14 -0700 (PDT)
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
 <20190717212703.10205-6-dmitry.fomichev@wdc.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ad5f8529-59da-0fa3-09eb-7fe1066ec83f@redhat.com>
Date: Thu, 18 Jul 2019 11:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717212703.10205-6-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 5/5] hw/scsi: Check sense key before
 READ CAPACITY output snoop
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 23:27, Dmitry Fomichev wrote:
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index a43efe39ec..e38d3160fa 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -238,6 +238,7 @@ static void scsi_read_complete(void * opaque, int ret)
>      SCSIGenericReq *r = (SCSIGenericReq *)opaque;
>      SCSIDevice *s = r->req.dev;
>      int len;
> +    uint8_t sense_key = NO_SENSE;
>  
>      assert(r->req.aiocb != NULL);
>      r->req.aiocb = NULL;
> @@ -254,6 +255,12 @@ static void scsi_read_complete(void * opaque, int ret)
>  
>      r->len = -1;
>  
> +    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
> +        SCSISense sense =
> +            scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
> +        sense_key = sense.key;
> +    }
> +
>      /*
>       * Check if this is a VPD Block Limits request that
>       * resulted in sense error but would need emulation.
> @@ -264,9 +271,7 @@ static void scsi_read_complete(void * opaque, int ret)
>          r->req.cmd.buf[0] == INQUIRY &&
>          (r->req.cmd.buf[1] & 0x01) &&
>          r->req.cmd.buf[2] == 0xb0) {
> -        SCSISense sense =
> -            scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
> -        if (sense.key == ILLEGAL_REQUEST) {
> +        if (sense_key == ILLEGAL_REQUEST) {
>              len = scsi_generic_emulate_block_limits(r, s);
>              /*
>               * No need to let scsi_read_complete go on and handle an
> @@ -281,15 +286,17 @@ static void scsi_read_complete(void * opaque, int ret)
>          goto done;
>      }
>  
> -    /* Snoop READ CAPACITY output to set the blocksize.  */
> -    if (r->req.cmd.buf[0] == READ_CAPACITY_10 &&
> -        (ldl_be_p(&r->buf[0]) != 0xffffffffU || s->max_lba == 0)) {
> -        s->blocksize = ldl_be_p(&r->buf[4]);
> -        s->max_lba = ldl_be_p(&r->buf[0]) & 0xffffffffULL;
> -    } else if (r->req.cmd.buf[0] == SERVICE_ACTION_IN_16 &&
> -               (r->req.cmd.buf[1] & 31) == SAI_READ_CAPACITY_16) {
> -        s->blocksize = ldl_be_p(&r->buf[8]);
> -        s->max_lba = ldq_be_p(&r->buf[0]);
> +    /* Snoop READ CAPACITY output to set the blocksize. */
> +    if (sense_key == NO_SENSE) {

I think we can do better and skip all this snooping and patching if 
sense_key != 0.

In fact, the check for "r->io_header.driver_status & 
SG_ERR_DRIVER_SENSE" where we handle block limits is now duplicate with 
the one we do before setting sense_key.  With the extra cleanup that
ret == 0 has already been checked before, you get:

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index ccb632c476..7f066d4198 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -254,24 +254,28 @@ static void scsi_read_complete(void * opaque, int ret)
 
     r->len = -1;
 
-    /*
-     * Check if this is a VPD Block Limits request that
-     * resulted in sense error but would need emulation.
-     * In this case, emulate a valid VPD response.
-     */
-    if (s->needs_vpd_bl_emulation && ret == 0 &&
-        (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
-        r->req.cmd.buf[0] == INQUIRY &&
-        (r->req.cmd.buf[1] & 0x01) &&
-        r->req.cmd.buf[2] == 0xb0) {
+    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
         SCSISense sense =
             scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
-        if (sense.key == ILLEGAL_REQUEST) {
+
+        /*
+         * Check if this is a VPD Block Limits request that
+         * resulted in sense error but would need emulation.
+         * In this case, emulate a valid VPD response.
+         */
+        if (sense.key == ILLEGAL_REQUEST &&
+            s->needs_vpd_bl_emulation &&
+            r->req.cmd.buf[0] == INQUIRY &&
+            (r->req.cmd.buf[1] & 0x01) &&
+            r->req.cmd.buf[2] == 0xb0) {
             len = scsi_generic_emulate_block_limits(r, s);
             /*
-             * No need to let scsi_read_complete go on and handle an
+             * It's okay to jump to req_complete: no need to
+             * let scsi_handle_inquiry_reply handle an
              * INQUIRY VPD BL request we created manually.
              */
+        }
+        if (sense.key) {
             goto req_complete;
         }
     }

It is essentially swapping the two "if"s in the existing block limits
emulation code, which makes sense.  Looks good?

Paolo

