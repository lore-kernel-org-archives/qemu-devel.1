Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CD0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94B320739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBNP5ouL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94B320739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3ED-0005n0-4W
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw3DS-0005Hx-CT; Thu, 16 Jul 2020 08:42:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jw3DQ-0003kK-Ps; Thu, 16 Jul 2020 08:42:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so10164389wmi.3;
 Thu, 16 Jul 2020 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oOd1Aym1uv5KKe0noR2NOU6jCkeQAG1+aul16luO/II=;
 b=jBNP5ouL0+8xKV29EOKkSz3SM9MGHRvLpSfh57q6k0ZmGC6AuoHr5/pRHNZsFha63n
 zAYARYNEzq1JyGWj6cF3Dc31X/7NKIenLGrJT14qD8souxjTj+5T64F0dNSGHP1MyxbH
 AnD6VP9wQpDfjcuG4emJJ3xr5PiBvqldx4mgzyutHq6y8iqW6jBuhhyUOWFXZ+L+zVtc
 8G+0AXHVVtrp6TGrGgDl9ohF6tJ5HiI9oXTEDAPTvB8Zzy5mhBmZGosjMpaEUjC018EY
 Cg0JDZ6Ls7mP0XYf5wglWJSDeJG9vUlXPNgjVB6O3+2f3WvVV+3UmF+KWHMCzH9cQ/Rz
 Czrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oOd1Aym1uv5KKe0noR2NOU6jCkeQAG1+aul16luO/II=;
 b=DTsLMAbuDPNv5G1sB7clsxX2yyG4Q2eefamEzFJNQ8eSWDK3yUgShA8kR6T4jpJJDA
 rLAK02ybb5sif0nDHV9SQ2OPnvLno8KoCwFoweQ+bC5MNFk45y3q7keeLbLnjqhtgBUl
 96wBn2zdTM3GX8Hm/PLoq6i64J44oyYt+a0jYHYYhSkowgoITLae1PbmYOdg14299iuf
 TKozaVgVdHpBu/WH7DU3bhM4H1+6PnyprptplCKO1VVQR8/37Ksf66rVeblGhqEMOvQH
 62z6Wq+Ce48mUJbcLtI6FuJ0+9/QizaS6hEgxlbaCKJsVExTCDU/Lv3IaOpY7j+B8pK1
 9jJQ==
X-Gm-Message-State: AOAM532ZNJDVHRIjf8pdG09J0Rg/4Dliw25mPR0GFiKRMyHH1LRzX1Mn
 ccz+dVd6tTdXQGVcAs+Or40=
X-Google-Smtp-Source: ABdhPJwiubA6N1ZbLaINf6jicEifGqUVKpccq2W4gVLvNYVc0q80pSswMs28W2q5IWZjl2OdrdelKg==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr4078065wme.187.1594903338621; 
 Thu, 16 Jul 2020 05:42:18 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k131sm8613997wmb.36.2020.07.16.05.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 05:42:17 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 v2 1/2] block/block-backend: Trace blk_attach_dev()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200716123704.6557-1-f4bug@amsat.org>
 <20200716123704.6557-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1cdce80f-ef11-b495-98ec-d76dcc6cc729@amsat.org>
Date: Thu, 16 Jul 2020 14:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200716123704.6557-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 2:37 PM, Philippe Mathieu-Daudé wrote:
> Add a trace event to follow devices attaching block drives:
> 
>   $ qemu-system-arm -M n800 -trace blk_\*
>   9513@1594040428.738162:blk_attach_dev attaching blk 'sd0' to device 'omap2-mmc'
>   9513@1594040428.738189:blk_attach_dev attaching blk 'sd0' to device 'sd-card'
>   qemu-system-arm: sd_init failed: blk 'sd0' already attached by device 'sd-card'

Oops, the current error is:

    qemu-system-arm: sd_init failed: Drive 'sd0' is already in use by
another device

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  block/block-backend.c | 1 +
>  block/trace-events    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 0bf0188133..63ff940ef9 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -888,6 +888,7 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
>   */
>  int blk_attach_dev(BlockBackend *blk, DeviceState *dev)
>  {
> +    trace_blk_attach_dev(blk_name(blk), object_get_typename(OBJECT(dev)));
>      if (blk->dev) {
>          return -EBUSY;
>      }
> diff --git a/block/trace-events b/block/trace-events
> index dbe76a7613..aa641c2034 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -9,6 +9,7 @@ blk_co_preadv(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags
>  blk_co_pwritev(void *blk, void *bs, int64_t offset, unsigned int bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %u flags 0x%x"
>  blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
>  blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
> +blk_attach_dev(const char *blk_name, const char *dev_name) "attaching blk '%s' to device '%s'"
>  
>  # io.c
>  bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
> 

