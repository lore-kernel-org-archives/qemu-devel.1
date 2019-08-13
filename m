Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E31C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE5E20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 10:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE5E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxU6w-0006rT-I9
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 06:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxU5k-0005yv-Gs
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxU5j-0000Sf-DZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:31:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxU5j-0000SF-7R
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 06:31:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so107262180wru.13
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 03:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NQhQAvkqAQ3e4ZBRzQyf+7Xdk0a8Bm0Sk5NrWvSer6w=;
 b=F3/sTqcinz0cgBpxKY1UeN3HelirSr9XvWDzzXgXUQw5X+d1O2p7hd2BXmP9C2Ed5j
 NyfRG6+BhAuhpMo1g8zEp+5hSnlOI8ap945Q6ZA3SvxvqqVjUTXpO74U8VC78lkQDyRh
 XXNTkQZGGCqAGpuxmLOVNHqOgNXBgZN+hKqXfVXSMt3oKPKZbBXo5/N0+Kxsv9mhq8re
 CXGyHX126xWDBAf4M23JdcDN5c8UsEFa3QDiTfpLiovDeM4xPWLmyVUHV0hQd9FVrk3R
 CvOIS8k9FRkoroN1xPOQV65UjFWcBbr6VGFNiMtdowSC215QueY8/8XBlErndNVinpYd
 7JoQ==
X-Gm-Message-State: APjAAAVGeTD9v4RdjQ+qJPuQ7zhI8DIyF/0R1hC/kM1frrQan/nUjXIp
 4U+FXiW9GesCvjgxmVgUT5bnjw==
X-Google-Smtp-Source: APXvYqytcmxGhzarOqqNdEEQ5H5g82KncxFEuNlae/rkQe5ksUD32caqUkpvvngLr9Qi/cseO0QAFQ==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr40542929wro.190.1565692306303; 
 Tue, 13 Aug 2019 03:31:46 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id p9sm8899921wru.61.2019.08.13.03.31.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 03:31:45 -0700 (PDT)
To: P J P <ppandit@redhat.com>
References: <20190809063835.6717-1-ppandit@redhat.com>
 <20190809063835.6717-2-ppandit@redhat.com>
 <nycvar.YSQ.7.76.1908131534020.10397@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b2944559-264e-cb48-8a04-4f238197f835@redhat.com>
Date: Tue, 13 Aug 2019 12:31:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1908131534020.10397@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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

Hi Prasad,

On 8/13/19 12:05 PM, P J P wrote:
> +-- On Fri, 9 Aug 2019, P J P wrote --+
> | From: Prasad J Pandit <pjp@fedoraproject.org>
> | 
> | When executing script in lsi_execute_script(), the LSI scsi
> | adapter emulator advances 's->dsp' index to read next opcode.
> | This can lead to an infinite loop if the next opcode is empty.
> | Exit such loop after reading 10k empty opcodes.
> | 
> | Reported-by: Bugs SysSec <bugs-syssec@rub.de>
> | Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> | ---
> |  hw/scsi/lsi53c895a.c | 11 ++++++++++-
> |  1 file changed, 10 insertions(+), 1 deletion(-)
> | 
> | Update v3: raise an illegal instruction interrupt and exit
> |   -> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01427.html
> | 
> | diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> | index 10468c1ec1..e703ef4c9d 100644
> | --- a/hw/scsi/lsi53c895a.c
> | +++ b/hw/scsi/lsi53c895a.c
> | @@ -185,6 +185,9 @@ static const char *names[] = {
> |  /* Flag set if this is a tagged command.  */
> |  #define LSI_TAG_VALID     (1 << 16)
> |  
> | +/* Maximum instructions to process. */
> | +#define LSI_MAX_INSN    10000
> | +
> |  typedef struct lsi_request {
> |      SCSIRequest *req;
> |      uint32_t tag;
> | @@ -1132,7 +1135,13 @@ static void lsi_execute_script(LSIState *s)
> |  
> |      s->istat1 |= LSI_ISTAT1_SRUN;
> |  again:
> | -    insn_processed++;
> | +    if (++insn_processed > LSI_MAX_INSN) {
> | +        trace_lsi_execute_script_tc_illegal();
> | +        lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
> | +        lsi_disconnect(s);
> | +        trace_lsi_execute_script_stop();
> | +        return;

My understanding of Marcelo's explanation
(https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01427.html) is
we can kill insn_processed.

> | +    }
> |      insn = read_dword(s, s->dsp);
> |      if (!insn) {
> |          /* If we receive an empty opcode increment the DSP by 4 bytes
> | 
> 
> Ping...?!
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
> 

