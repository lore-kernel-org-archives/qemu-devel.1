Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B1DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4BF206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 09:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4BF206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsOqF-0002Ck-5w
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsOpc-0001QK-2W
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsOpa-0004MH-RS
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:54:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsOpa-0004Ls-LK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 05:54:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so51931998wme.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 02:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5alA7xgJc5SpP2ELPLHjzW8XMsGTtuPaOAkmlk4H0bo=;
 b=PTERrgjfSKZoTVLPpBrWOVVBj4aCCEHbjUBEer8D09iGLKf7moSyykn12UJO47uJI3
 Q+bB8ompjq1XuUCTP63dktjpuByz0ziFJeoyPAGmku1ykwsUPiVsUD0GCBfxIeNiudEt
 +pgL3+crGhH2+xnZVpmc0beq4yup6H2MfyQGPYWYplV53DwJ818EkapczwbvyRyLmHpr
 p/H4S3nShr4tFVpE2y6JK3noKO6DDNheW8zLsrbHzhY7mhDWPzUg22zAxNmWrcqh8UcO
 y9tvmIBiRQxSQMAFQn2GCfn3YisUxsYBgAa4YPB7H0sYr3jC5KH46eeAml+g13nlxY5y
 nkwg==
X-Gm-Message-State: APjAAAUkxeWHk0kC2JNoED9wLDFmMiQmHJuRpxnKVG2q0wcPsg3yOSUu
 0ThzOgHk2VRdnihmK+79rxiSew==
X-Google-Smtp-Source: APXvYqwFpWYubvCY36ahw4Llzqh597rUmEHN1SwsYEksQWsxsACqHaoPsdABvswiJkzQegbzx/a/HA==
X-Received: by 2002:a1c:cc0d:: with SMTP id
 h13mr101986047wmb.119.1564480445589; 
 Tue, 30 Jul 2019 02:54:05 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id y7sm47453858wmm.19.2019.07.30.02.54.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 02:54:05 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190729223605.7163-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7324bc78-1d7b-7b7f-272d-c2932651b007@redhat.com>
Date: Tue, 30 Jul 2019 11:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729223605.7163-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] Revert "ide/ahci: Check for -ECANCELED in
 aio callbacks"
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

On 7/30/19 12:36 AM, John Snow wrote:
> This reverts commit 0d910cfeaf2076b116b4517166d5deb0fea76394.
> 
> It's not correct to just ignore an error code in a callback; we need to
> handle that error and possible report failure to the guest so that they
> don't wait indefinitely for an operation that will now never finish.

Is this 4.1 material? It looks so.

> This ought to help cases reported by Nutanix where iSCSI returns a
> legitimate -ECANCELED for certain operations which should be propagated
> normally.
> 
> Reported-by: Shaju Abraham <shaju.abraham@nutanix.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/ahci.c |  3 ---
>  hw/ide/core.c | 14 --------------
>  2 files changed, 17 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 00ba422a48..6aaf66534a 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1023,9 +1023,6 @@ static void ncq_cb(void *opaque, int ret)
>      IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
>  
>      ncq_tfs->aiocb = NULL;
> -    if (ret == -ECANCELED) {
> -        return;
> -    }
>  
>      if (ret < 0) {
>          bool is_read = ncq_tfs->cmd == READ_FPDMA_QUEUED;
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 6afadf894f..8e1624f7ce 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -722,9 +722,6 @@ static void ide_sector_read_cb(void *opaque, int ret)
>      s->pio_aiocb = NULL;
>      s->status &= ~BUSY_STAT;
>  
> -    if (ret == -ECANCELED) {
> -        return;
> -    }
>      if (ret != 0) {
>          if (ide_handle_rw_error(s, -ret, IDE_RETRY_PIO |
>                                  IDE_RETRY_READ)) {
> @@ -840,10 +837,6 @@ static void ide_dma_cb(void *opaque, int ret)
>      uint64_t offset;
>      bool stay_active = false;
>  
> -    if (ret == -ECANCELED) {
> -        return;
> -    }
> -
>      if (ret == -EINVAL) {
>          ide_dma_error(s);
>          return;
> @@ -975,10 +968,6 @@ static void ide_sector_write_cb(void *opaque, int ret)
>      IDEState *s = opaque;
>      int n;
>  
> -    if (ret == -ECANCELED) {
> -        return;
> -    }
> -
>      s->pio_aiocb = NULL;
>      s->status &= ~BUSY_STAT;
>  
> @@ -1058,9 +1047,6 @@ static void ide_flush_cb(void *opaque, int ret)
>  
>      s->pio_aiocb = NULL;
>  
> -    if (ret == -ECANCELED) {
> -        return;
> -    }
>      if (ret < 0) {
>          /* XXX: What sector number to set here? */
>          if (ide_handle_rw_error(s, -ret, IDE_RETRY_FLUSH)) {
> 

