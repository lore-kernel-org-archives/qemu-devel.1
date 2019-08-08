Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF314C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17F6217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17F6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hveSi-0002dF-1x
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hveSA-0002BO-Kj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hveS9-000161-Jr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:11:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hveS9-00015g-DR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:11:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so94136558wru.13
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 02:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DcwF8GGG/I41bA8g3Y3sJtDmy4LVCG6FtPrE5RChCR0=;
 b=JkdQ7GP0Y6u0fy2fiOvx+mvCelQmHwKbJEj/rNezx8NLvaaxNNcLZRHIa3gGvLoHej
 8g2S+kKc10bO/JigKcsVHId/LCaO/h9XpLIbjZAZ++HaCEBKioAtHency4loslA+If6H
 bWwvX9qFjG145064zxhKRvlswuvLoMTOHG4+p38cEqHCxRE/n2i3au8WNqE4QRFz7Wzz
 tcDj+Y8KvmbrStgIymzxeyMaokSePSlFW3yIj1buo3cDlT9nhIU5DRy3p9cpHRUF4zQh
 t9Vhiwf9iEnLHGJ1QuJirU6/Mfi8jc2TtfvLULRVV5sah1DTEtcsRqlbDaywKVEHuv0e
 5Q+w==
X-Gm-Message-State: APjAAAURQJ8d0ci/sRDJAxG9qhFB4ZKkYCvkvbSstDKr2f3OdeYcPiji
 EEjAg35kCs5+ntHxPGVEIoXBjw==
X-Google-Smtp-Source: APXvYqx8F4DsSfvKq/H+1KNTbd9WF3T9znLLzEjmgztaoW6g8hgryHd3zKYwQ7qufF9IEp0Icg6uZw==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr3051897wrw.45.1565255480260; 
 Thu, 08 Aug 2019 02:11:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b42d:b492:69df:ed61?
 ([2001:b07:6468:f312:b42d:b492:69df:ed61])
 by smtp.gmail.com with ESMTPSA id 91sm193425712wrp.3.2019.08.08.02.11.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 02:11:19 -0700 (PDT)
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20190808063340.23833-1-ppandit@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <aa654255-8124-8a76-56c8-47c8bdf19a08@redhat.com>
Date: Thu, 8 Aug 2019 11:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808063340.23833-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] scsi: lsi: exit infinite loop while
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
Cc: Fam Zheng <fam@euphon.net>, Bugs SysSec <bugs-syssec@rub.de>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/08/19 08:33, P J P wrote:
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
>  hw/scsi/lsi53c895a.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 10468c1ec1..c23a40525e 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1132,7 +1132,10 @@ static void lsi_execute_script(LSIState *s)
>  
>      s->istat1 |= LSI_ISTAT1_SRUN;
>  again:
> -    insn_processed++;
> +    if (++insn_processed > 10000) {
> +        s->waiting = LSI_NOWAIT;
> +        goto exitloop;
> +    }
>      insn = read_dword(s, s->dsp);
>      if (!insn) {
>          /* If we receive an empty opcode increment the DSP by 4 bytes
> @@ -1569,6 +1572,7 @@ again:
>              }
>          }
>      }
> +exitloop:
>      if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
>          /* Some windows drivers make the device spin waiting for a memory
>             location to change.  If we have been executed a lot of code then
> 

I am not sure this is worth a CVE.  The kernel can cause QEMU to break,
but is there a practical case in which an unprivileged user can do that?

Paolo

