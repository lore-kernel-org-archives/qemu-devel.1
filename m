Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606EC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FDC205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Txmkxqi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FDC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipB4I-0002Ny-0W
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ipAj5-0006fO-Gr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ipAj3-0004qA-OV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:46:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ipAj3-0004pg-G1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578487577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIiMM6Pf4/QASnshpSy0W4cEb84s+FeC+lukYms/+NQ=;
 b=Txmkxqi/xBdNtWc+yztvJ1iJM8uQPdpuaRLQO0gHC+qbDqDCwnR2xxZjRTqB45EhjkM2Y2
 lKQd8alw4n2fZTKycfKC3GvpFZGAjXg57oaOuq/xvVPbEPqN4Y4o/wi20FcINcjC+n9ZZ6
 nuv12GDlkeSNhqYwGBzpagqJT1e+spo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-fzbetnrYOUCRm0uHMNpk2w-1; Wed, 08 Jan 2020 07:46:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E15593A1;
 Wed,  8 Jan 2020 12:46:12 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A35519C58;
 Wed,  8 Jan 2020 12:46:11 +0000 (UTC)
Date: Wed, 8 Jan 2020 13:46:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 37/59] s390x/event-facility.c: remove unneeded labels
Message-ID: <20200108134608.17c8c76c.cohuck@redhat.com>
In-Reply-To: <20200106182425.20312-38-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-38-danielhb413@gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: fzbetnrYOUCRm0uHMNpk2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Jan 2020 15:24:03 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> 'out' label from write_event_mask(), handle_sccb_read_events()
> and write_event_data() can be replaced by 'return'.
> 
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Halil Pasic <pasic@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/s390x/event-facility.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 6afe278cad..f3b9661f32 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -182,11 +182,11 @@ static void write_event_data(SCLPEventFacility *ef, SCCB *sccb)
>  {
>      if (sccb->h.function_code != SCLP_FC_NORMAL_WRITE) {
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
> -        goto out;
> +        return;
>      }
>      if (be16_to_cpu(sccb->h.length) < 8) {
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> -        goto out;
> +        return;
>      }
>      /* first do a sanity check of the write events */
>      sccb->h.response_code = cpu_to_be16(write_event_length_check(sccb));
> @@ -196,9 +196,6 @@ static void write_event_data(SCLPEventFacility *ef, SCCB *sccb)
>          sccb->h.response_code =
>                  cpu_to_be16(handle_sccb_write_events(ef, sccb));
>      }
> -
> -out:
> -    return;
>  }

I'm fine with the changes to write_event_data().

>  
>  static uint16_t handle_sccb_read_events(SCLPEventFacility *ef, SCCB *sccb,
> @@ -262,7 +259,7 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
>  
>      if (be16_to_cpu(sccb->h.length) != SCCB_SIZE) {
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
> -        goto out;
> +        return;
>      }
>  
>      sclp_cp_receive_mask = ef->receive_mask;
> @@ -280,18 +277,15 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
>              (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
>              sccb->h.response_code =
>                      cpu_to_be16(SCLP_RC_INVALID_SELECTION_MASK);
> -            goto out;
> +            return;
>          }
>          break;
>      default:
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
> -        goto out;
> +        return;
>      }
>      sccb->h.response_code = cpu_to_be16(
>              handle_sccb_read_events(ef, sccb, sclp_active_selection_mask));
> -
> -out:
> -    return;
>  }

I think read_event_data() is still a bit confusing, even if we get rid
of the 'out:' label, as the flow remains the same. How about something
like the following, which makes it clear that we handle the sccb events
for unconditional read and for a selective read with a valid mask:

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 6afe278cad15..877721d6601e 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -262,17 +262,17 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
 
     if (be16_to_cpu(sccb->h.length) != SCCB_SIZE) {
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
-        goto out;
+        return;
     }
 
-    sclp_cp_receive_mask = ef->receive_mask;
-
-    /* get active selection mask */
     switch (sccb->h.function_code) {
     case SCLP_UNCONDITIONAL_READ:
-        sclp_active_selection_mask = sclp_cp_receive_mask;
+        sccb->h.response_code = cpu_to_be16(
+            handle_sccb_read_events(ef, sccb, ef->receive_mask));
         break;
     case SCLP_SELECTIVE_READ:
+        sclp_cp_receive_mask = ef->receive_mask;
+        /* get active selection mask */
         copy_mask((uint8_t *)&sclp_active_selection_mask, (uint8_t *)&red->mask,
                   sizeof(sclp_active_selection_mask), ef->mask_length);
         sclp_active_selection_mask = be64_to_cpu(sclp_active_selection_mask);
@@ -280,18 +280,14 @@ static void read_event_data(SCLPEventFacility *ef, SCCB *sccb)
             (sclp_active_selection_mask & ~sclp_cp_receive_mask)) {
             sccb->h.response_code =
                     cpu_to_be16(SCLP_RC_INVALID_SELECTION_MASK);
-            goto out;
+        } else {
+            sccb->h.response_code = cpu_to_be16(
+                handle_sccb_read_events(ef, sccb, sclp_active_selection_mask));
         }
         break;
     default:
         sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_FUNCTION);
-        goto out;
     }
-    sccb->h.response_code = cpu_to_be16(
-            handle_sccb_read_events(ef, sccb, sclp_active_selection_mask));
-
-out:
-    return;
 }
 
 static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)


>  
>  static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
> @@ -303,7 +297,7 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>      if (!mask_length || (mask_length > SCLP_EVENT_MASK_LEN_MAX) ||
>          ((mask_length != 4) && !ef->allow_all_mask_sizes)) {
>          sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_MASK_LENGTH);
> -        goto out;
> +        return;
>      }
>  
>      /*
> @@ -328,9 +322,6 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
>  
>      sccb->h.response_code = cpu_to_be16(SCLP_RC_NORMAL_COMPLETION);
>      ef->mask_length = mask_length;
> -
> -out:
> -    return;
>  }
>  
>  /* qemu object creation and initialization functions */

The changes to write_event_mask() look fine to me as well.


