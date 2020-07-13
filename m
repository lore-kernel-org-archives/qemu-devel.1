Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEA8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:34:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0769E20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABqOGlL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0769E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxfK-00047D-Ad
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juxef-0003Oc-Ol
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:33:57 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juxee-0001Ii-2j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:33:57 -0400
Received: by mail-ed1-x543.google.com with SMTP id b15so13466320edy.7
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0MCnmD5spmFtnZ9JvwOK+WdcjXgeT9QNxHDaBZ4uaqs=;
 b=ABqOGlL1q5wDm4M3HDB1UFye+kSm4vS7u6OI377PyyjqYxk31XQLyqC6vqWaxjy5e5
 sxV5JXg+O4uDneqxbXtR1P+WvmWE8BpKLWAagc4JLcL3LZCCmMfkbaGtFQvl4zaK+NNK
 BzPiRZijrBkBA6I/s6PtnS88mBX8ZI70KQbwboIjzm2p9Rm0xOURkcKyMv/aHwv8qbKp
 z/4S/P74Rv33TvvXl58Hw9/CAk5DscGLKp1JKUQ/XaE6JP6X57y+2uiY3IUwNAFlDSv0
 3mCacddamd/BUBU1FbhyKi1t2f46rqAMBjzLcmQ/xmZsZNj0twxtURHe2IpR0VOVQaUU
 tTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0MCnmD5spmFtnZ9JvwOK+WdcjXgeT9QNxHDaBZ4uaqs=;
 b=s9MV4bs3waal+eMlUrAZqAXMiefBnMwSQtIa7aQDHmr6Jky/CGa8S+pPtw1g07Pn+L
 uCoyOYyymKbuLUWB4xhlI7fqg7PLknea9Rip0oq5qdq1oEWZaiJBmuP/8Lez7vMC8cB7
 YlhKevDGnnhQyNUF8WiU804IF6T6KbHY1rY8xjBLhqPadbWuKju/BnjUxQgpVjwF3627
 feAQ0kKMCw+bvNeJyqu02P+NBV2NmXBWMA+P/yLRJuUBkxTJjaXhRCATvhY0Xs/i0Jub
 Lcd06jwo+rNkSX7PWR98RqYppvYN5L4hUlz/DCl6zgqGtE0mhG8O+qJ3sJnKrzJmZh9/
 5laA==
X-Gm-Message-State: AOAM532v5wi1JOL2JOk0VcvCrWAakyDsEOydO38wjKINGea4CzkzMR8a
 l6YV1sqFL1B9A0BdaLqUjKo=
X-Google-Smtp-Source: ABdhPJzU5JIC0QP32sbQZhH4+8U1aQU5brhIs9NFBxHjzmR/Ljvo2eVkqaDZq0QWybPztukKpZAbjg==
X-Received: by 2002:aa7:d297:: with SMTP id w23mr87397925edq.49.1594643634554; 
 Mon, 13 Jul 2020 05:33:54 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id bs18sm11466356edb.38.2020.07.13.05.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 05:33:53 -0700 (PDT)
Subject: Re: [PATCH 3/3] migration/migration.c: Remove superfluous breaks
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20200713122345.9289-1-quintela@redhat.com>
 <20200713122345.9289-4-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <484534ba-04b1-0331-ae18-cb5eb6e1d783@amsat.org>
Date: Mon, 13 Jul 2020 14:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713122345.9289-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 2:23 PM, Juan Quintela wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I hadn't reviewed this patch, but now I did ¯\_(ツ)_/¯

> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 08519de56f..2ed9923227 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -986,7 +986,6 @@ static void fill_source_migration_info(MigrationInfo *info)
>          /* no migration has happened ever */
>          /* do not overwrite destination migration status */
>          return;
> -        break;
>      case MIGRATION_STATUS_SETUP:
>          info->has_status = true;
>          info->has_total_time = false;
> @@ -1105,7 +1104,6 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      switch (mis->state) {
>      case MIGRATION_STATUS_NONE:
>          return;
> -        break;
>      case MIGRATION_STATUS_SETUP:
>      case MIGRATION_STATUS_CANCELLING:
>      case MIGRATION_STATUS_CANCELLED:
> 

