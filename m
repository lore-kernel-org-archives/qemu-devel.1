Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A0C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D274020665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D274020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTgx-00062v-Tl
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hxTgX-0005dI-T0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hxTgW-0007Hk-Rg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hxTgW-0007H6-Mc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:05:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E5547E437;
 Tue, 13 Aug 2019 10:05:42 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE26D6E701;
 Tue, 13 Aug 2019 10:05:29 +0000 (UTC)
Date: Tue, 13 Aug 2019 15:35:26 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
In-Reply-To: <20190809063835.6717-2-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1908131534020.10397@xnncv>
References: <20190809063835.6717-1-ppandit@redhat.com>
 <20190809063835.6717-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 13 Aug 2019 10:05:42 +0000 (UTC)
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
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 9 Aug 2019, P J P wrote --+
| From: Prasad J Pandit <pjp@fedoraproject.org>
| 
| When executing script in lsi_execute_script(), the LSI scsi
| adapter emulator advances 's->dsp' index to read next opcode.
| This can lead to an infinite loop if the next opcode is empty.
| Exit such loop after reading 10k empty opcodes.
| 
| Reported-by: Bugs SysSec <bugs-syssec@rub.de>
| Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| ---
|  hw/scsi/lsi53c895a.c | 11 ++++++++++-
|  1 file changed, 10 insertions(+), 1 deletion(-)
| 
| Update v3: raise an illegal instruction interrupt and exit
|   -> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01427.html
| 
| diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
| index 10468c1ec1..e703ef4c9d 100644
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
| @@ -1132,7 +1135,13 @@ static void lsi_execute_script(LSIState *s)
|  
|      s->istat1 |= LSI_ISTAT1_SRUN;
|  again:
| -    insn_processed++;
| +    if (++insn_processed > LSI_MAX_INSN) {
| +        trace_lsi_execute_script_tc_illegal();
| +        lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
| +        lsi_disconnect(s);
| +        trace_lsi_execute_script_stop();
| +        return;
| +    }
|      insn = read_dword(s, s->dsp);
|      if (!insn) {
|          /* If we receive an empty opcode increment the DSP by 4 bytes
| 

Ping...?!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

