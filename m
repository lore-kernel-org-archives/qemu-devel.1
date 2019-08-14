Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B06C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C03D2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 10:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C03D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxqUv-0005op-Po
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 06:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1hxqU0-0005Bg-9C
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hxqTy-0008B8-QW
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hxqTy-00088Y-AU
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 06:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4CFD3082B67;
 Wed, 14 Aug 2019 10:26:16 +0000 (UTC)
Received: from kaapi (unknown [10.74.10.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19AED348BC;
 Wed, 14 Aug 2019 10:25:47 +0000 (UTC)
Date: Wed, 14 Aug 2019 15:55:41 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <3a48e557-985d-7274-81d9-fe963f74e59a@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1908141450520.30613@xnncv>
References: <20190809063835.6717-1-ppandit@redhat.com>
 <20190809063835.6717-2-ppandit@redhat.com>
 <nycvar.YSQ.7.76.1908131534020.10397@xnncv>
 <b2944559-264e-cb48-8a04-4f238197f835@redhat.com>
 <3a48e557-985d-7274-81d9-fe963f74e59a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 14 Aug 2019 10:26:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 13 Aug 2019, Paolo Bonzini wrote --+
| After the first instruction is processed, "again" is only reached if 
| s->waiting == LSI_NOWAIT.  Therefore, we could move the Windows hack to the 
| beginning and remove the s->waiting condition.  The only change would be 
| that it would also be triggered by all zero instructions, like this:
| 
| diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
| index 10468c1..9d714af 100644
| --- a/hw/scsi/lsi53c895a.c
| +++ b/hw/scsi/lsi53c895a.c
| @@ -185,6 +185,9 @@ static const char *names[] = {
|  /* Flag set if this is a tagged command.  */
|  #define LSI_TAG_VALID     (1 << 16)
|  
| +/* Maximum instructions to process. */
| +#define LSI_MAX_INSN    10000
| +
|  typedef struct lsi_request {
|      SCSIRequest *req;
|      uint32_t tag;
| @@ -1132,7 +1135,19 @@ static void lsi_execute_script(LSIState *s)
|  
|      s->istat1 |= LSI_ISTAT1_SRUN;
|  again:
| -    insn_processed++;
| +    if (++insn_processed > LSI_MAX_INSN) {
| +        /* Some windows drivers make the device spin waiting for a memory
| +           location to change.  If we have been executed a lot of code then
| +           assume this is the case and force an unexpected device disconnect.
| +           This is apparently sufficient to beat the drivers into submission.
| +         */
| +        if (!(s->sien0 & LSI_SIST0_UDC)) {
| +            qemu_log_mask(LOG_GUEST_ERROR,
| +                          "lsi_scsi: inf. loop with UDC masked");
| +        }
| +        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
| +        lsi_disconnect(s);
...
|
| Does it make sense? 

Yes, this'd also work, but need to return after lsi_disconnect(s), otherwise 
loop would continue.

Should I send a revised patch? (with above change)

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

