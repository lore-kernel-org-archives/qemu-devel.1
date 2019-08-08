Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED651C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FC92173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FC92173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvelh-0003Ct-51
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvelH-0002f2-If
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvelG-0002zL-58
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:31:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvelF-0002z1-VD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:31:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so1700481wme.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 02:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Re9TnnEQp9ZEEl2gdC3Pom7E9eq3hLjygIm0ednaP3U=;
 b=QdhT81e2HAAQgF5Vpnpd43Gw3azhcn40JKAFC1HCjnin8ARI1eiKXZ9Kxugl+A1Cfp
 0dACnrq0vXpuC05jEehAtaSFmoEspGU+NkikRhpNVPMWYpbWWb40LAoSLyIIc+eMm94b
 nHVxCeNfTrxTrXQo+RvnOO5am4Spo+ZGTWuj2BovxYRqwG9cXcgPiA8Tprkgg/HJsmD9
 wdA3s7GWmfiHZlo9fQDQ6klfIMeQCcTO49pEGri/TW7aKLmxbWf9PeXEF88O2rXqAgLU
 vB+X67met1xPNJcLK2XJ4goqvltKsX2/JBKw9WOs6CzfE2xNtLVUn8QJOaoop9g+UFU3
 NQ1g==
X-Gm-Message-State: APjAAAXhqgvEpzoR4Jn8L9fNd0S2BoqEqMalkeu5PXyx0QJ+3QVr+pUH
 MF+PDa1qmnK1wYGAMh2fGVgh5g==
X-Google-Smtp-Source: APXvYqwoW7GCuHoW1G/bNOdmFkLdzdwlGQPb0Gy0iYJvZre3C+aXlD/J7OpzoD4o5LcvtZzFQ1reBg==
X-Received: by 2002:a05:600c:218d:: with SMTP id
 e13mr3282886wme.29.1565256664453; 
 Thu, 08 Aug 2019 02:31:04 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id o7sm59803445wru.58.2019.08.08.02.31.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 02:31:03 -0700 (PDT)
To: P J P <ppandit@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20190808090652.2478-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <39a5c98f-f402-2985-2d49-800e73f53f4f@redhat.com>
Date: Thu, 8 Aug 2019 11:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808090652.2478-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2] scsi: lsi: exit infinite loop while
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
Cc: Fam Zheng <fam@euphon.net>, Prasad J Pandit <pjp@fedoraproject.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Bugs SysSec <bugs-syssec@rub.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 11:06 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When executing script in lsi_execute_script(), the LSI scsi
> adapter emulator advances 's->dsp' index to read next opcode.
> This can lead to an infinite loop if the next opcode is empty.
> Exit such loop after reading 10k empty opcodes.
> 
> Reported-by: Bugs SysSec <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/lsi53c895a.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Update v2: define LSI_MAX_INSN 10000
>   -> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01370.html
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 10468c1ec1..2adab341b1 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -185,6 +185,9 @@ static const char *names[] = {
>  /* Flag set if this is a tagged command.  */
>  #define LSI_TAG_VALID     (1 << 16)
>  
> +/* Maximum instructions to process. */
> +#define LSI_MAX_INSN    10000
> +
>  typedef struct lsi_request {
>      SCSIRequest *req;
>      uint32_t tag;
> @@ -1132,7 +1135,10 @@ static void lsi_execute_script(LSIState *s)
>  
>      s->istat1 |= LSI_ISTAT1_SRUN;
>  again:
> -    insn_processed++;
> +    if (++insn_processed > LSI_MAX_INSN) {
> +        s->waiting = LSI_NOWAIT;
> +        goto exitloop;
> +    }

If I understand the datasheet correctly, the model should set the
DSTAT.IID bit.

  Illegal Instruction Detected

  This status bit is set any time an illegal or reserved
  instruction opcode is detected, whether the LSI53C895A
  is operating in single step mode or automatically
  executing SCSI SCRIPTS.

We already have:

    trace_lsi_execute_script_tc_illegal();
    lsi_script_dma_interrupt(s, LSI_DSTAT_IID);

Cc'ing Marcelo Tosatti since it is hard to understand the "Windows SCSI
driver hack":

$ git show ee4d919f30f
commit ee4d919f30f1378cda697dd94d5a21b2a7f4d90d
Author: aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
Date:   Mon Sep 22 16:04:16 2008 +0000

    LSI SCSI: raise UDC on infinite loop (Marcelo Tosatti)

    Raise UDC (Unexpected Disconnect) when a large enough number of
    instructions has been executed by the SCRIPTS processor. This "solution"
    is much simpler than temporarily interrupting execution.

    This remedies the situation with Windows which downloads SCRIPTS code
    that busy loops on guest main memory. Their drivers _do_ handle UDC
    appropriately (at least XP and 2003).

    It would be nicer to actually detect infinite loops, but until then,
    this bandaid seems acceptable.

    Since the situation seems to be rare enough, raise the number
    of instructions to 10000 (previously 1000).

    Three people other than myself had success with this patch.

    Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
    Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

$ git show 64c68080da4
commit 64c68080da429edf30a9857e3a698cb9ed335bd3
Author: pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
Date:   Mon Sep 22 16:30:29 2008 +0000

    Add comment to windows SCSI hack.

diff --git a/hw/lsi53c895a.c b/hw/lsi53c895a.c
index e45eefaef7..53a2add0df 100644
--- a/hw/lsi53c895a.c
+++ b/hw/lsi53c895a.c
@@ -1199,6 +1199,11 @@ again:
         }
     }
     if (insn_processed > 10000 && !s->waiting) {
+        /* Some windows drivers make the device spin waiting for a memory
+           location to change.  If we have been executed a lot of code then
+           assume this is the case and force an unexpected device
disconnect.
+           This is apparently sufficient to beat the drivers into
submission.
+         */
         if (!(s->sien0 & LSI_SIST0_UDC))
             fprintf(stderr, "inf. loop with UDC masked\n");
         lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);

>      insn = read_dword(s, s->dsp);
>      if (!insn) {
>          /* If we receive an empty opcode increment the DSP by 4 bytes
> @@ -1569,7 +1575,8 @@ again:
>              }
>          }
>      }
> -    if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
> +exitloop:
> +    if (insn_processed > LSI_MAX_INSN && s->waiting == LSI_NOWAIT) {
>          /* Some windows drivers make the device spin waiting for a memory
>             location to change.  If we have been executed a lot of code then
>             assume this is the case and force an unexpected device disconnect.
> 

