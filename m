Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7BDC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1448E217F4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1448E217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hveTc-00040J-Bv
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hveSp-00037x-Cw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hveSo-0001MA-AS
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:12:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hveSo-0001LW-3F
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:12:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id p77so3507154wme.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 02:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ElZskvwERerJU+tr/9SIYyO4LOE/R6h8BhQ3W/V7CYc=;
 b=pnnDCpk+AM3f/kBcyezo/HEQdUUD2Kep4R2k+bJ5YkmpUfkPnGiDNT05tvtTOeinvO
 akTlT1MZ5UjJpJAtqU0QZLOprpW/kwJbWQwPlScbN7C/GqbKvuhYdZoYTZRmpebk/q7C
 C1ZUVFonoc2L5023xoWTnAgLJ6pBtnV9ahS7WKmYC4pRBLkJTy7CIPJh9ehEUyWft5Te
 jlwPikNum7W2Pig/aN9Z9k8ghg08ZIVvRzYsLAearBa/VqPz5vfp8i5YO3HXjo/sJ3SO
 fd0hvOZsRN/oz8H3O3hUWZg+8t2kLbkhwrfQQrSIo0iCsSGnWutFMDNYhuR4EmFNIiPF
 vC7A==
X-Gm-Message-State: APjAAAVz5F07MDFKQor+P60GmVc2hJggbjqbZTlsrse7BDgGVF31OOU4
 um2v16FXPGbHktRe900pkZ+rkg==
X-Google-Smtp-Source: APXvYqzPNqy9aBDGCfflNRko6c/MA0y18fLG2hBtsilGXDrXA6El6Hg57eKM+9dV30VB2QmAaysung==
X-Received: by 2002:a7b:c751:: with SMTP id w17mr3281381wmk.127.1565255521031; 
 Thu, 08 Aug 2019 02:12:01 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id x83sm2067954wmb.42.2019.08.08.02.11.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 02:12:00 -0700 (PDT)
To: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <20190808065636.28787-1-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <91ce6c32-a08c-1e92-36fe-c925f0422c97@redhat.com>
Date: Thu, 8 Aug 2019 11:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808065636.28787-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] ide: ahci: add check to avoid null
 dereference (CVE-2019-12067)
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
Cc: John Snow <jsnow@redhat.com>, Bugs SysSec <bugs-syssec@rub.de>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Prasad,

On 8/8/19 8:56 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> AHCI emulator while committing DMA buffer in ahci_commit_buf()
> may do a NULL dereference if the command header 'ad->cur_cmd'
> is null. Add check to avoid it.
> 
> Reported-by: Bugs SysSec <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ide/ahci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 00ba422a48..9fff94075b 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1458,8 +1458,10 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
>  {
>      AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>  
> -    tx_bytes += le32_to_cpu(ad->cur_cmd->status);
> -    ad->cur_cmd->status = cpu_to_le32(tx_bytes);
> +    if (ad->cur_cmd) {

My 2 cents, John will correct me:

This is not a valid condition, so an assert() might be more appropriate
here.

Why is dma_buf_commit() being called with a null command? This check
should go elsewhere to avoid the call.

> +        tx_bytes += le32_to_cpu(ad->cur_cmd->status);
> +        ad->cur_cmd->status = cpu_to_le32(tx_bytes);
> +    }
>  }
>  
>  static int ahci_dma_rw_buf(IDEDMA *dma, int is_write)
> 

