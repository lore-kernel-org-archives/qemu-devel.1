Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1293AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E1A2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reQYbl+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E1A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7exm-0000Nt-3C
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7exC-0008Oa-AM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:13:34 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:45253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7ex9-00049l-Qb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:13:34 -0400
Received: by mail-pg1-x52e.google.com with SMTP id x6so8096055pgx.12
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
 bh=stp/ZT8zPjJtVTvjW63cfMxlxUjj4k1bGebX4Gc00BU=;
 b=reQYbl+/tllaLpEBHxjd6P5rx5oiG9tsQLovxInzBFvuXIMGFB9/4Xlp+s+UWsVuXx
 eNi9+85ITkWG1d7xfkjfLzBscaqFeWX9FPgTzv4dmuCY8IT/nIo8QjeJhW61NkcKE5ke
 Dk2d4SmMv6y9uW06g8knN7sFRbBQlu+rVk7MVBtZgTDGRCjZBCsGKippUippyj0opcz8
 wgdX52ERPnKFtM2LgRwWs64zD0gMl6PFgELmhRL87MslDCsX8Vwo6bWz9FG5BEl5Sqvx
 mIcvSKemv1rYOAA1ZRP/T9Olfge9FZdm0VymAhshSgvfG49Pq3b16CS3XlVSbX8nhZ7D
 FHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=stp/ZT8zPjJtVTvjW63cfMxlxUjj4k1bGebX4Gc00BU=;
 b=mjrurGWeS7jKO2X1AW7yl9gv149vdRqfu5/nAtmtJaKrsu9xuGJ84gKVmM3GZPYxc3
 HXznAq7nUa4rFRVWzTgONYfRu1Y9pWyarLfVnu0p9w4gVxJfUYBvnfcnTSEG7krWda5B
 6k4GIhKIX9ykbe9Q5dVJ9WwiadhjmwndizNbpRHALsn+SKENF1eaETh9jYW3kNHnS8US
 FGfrV3ZMfvhHcPyfsDcR9S08SFHcahQLgtJxppa2arS4Nyw5hKX2DD9hUWhH3eqrWRb5
 TbhzqP7YQTBRtVzmfF7xt8l4NlrVd/ikxDT4+X8TkaALQ+e+6qWhtBiSR6ZMpImkv6tr
 Qv5Q==
X-Gm-Message-State: AOAM533JdkXSlg9AFFub4jopqZlFioa1DAy4UUI2oYTQMdOU6MepHR+V
 /ENoq/P8W3/0xu7HQAf8q4eKJxOr2ZJXexgT
X-Google-Smtp-Source: ABdhPJzHXDNoXfrrS+m6U6vmKKX+To37WvkZgm3SXDuc98KT00o6AR02tIQU2+OLx/tiNC67syj2sg==
X-Received: by 2002:a62:6185:: with SMTP id
 v127mr10842218pfb.259.1597670010035; 
 Mon, 17 Aug 2020 06:13:30 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id fv21sm17364847pjb.16.2020.08.17.06.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 06:13:29 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 17 Aug 2020 21:13:19 +0800
To: qemu-devel@nongnu.org
Subject: Should I delete created coroutines manually?
Message-ID: <20200817131319.hqhchbgkjofbvsuj@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm working on vhost-user block device backend [1]. When I tested my
patches on the latest version of QEMU (commit
d0ed6a69d399ae193959225cdeaa9382746c91cc) with --enable-sanitizer turned
on, the follow error will be thrown out,

     ==46631==ERROR: LeakSanitizer: detected memory leaks

     Direct leak of 312 byte(s) in 1 object(s) allocated from:
         #0 0x55d0a7813921 in calloc (qemu/qemu-storage-daemon+0x646921)
         #1 0x7f8bd6f7b591 in g_malloc0 (/usr/lib/libglib-2.0.so.0+0x4f591)
         #2 0x55d0a815f3fb in qemu_coroutine_create qemu/util/qemu-coroutine.c:75:14
         #3 0x55d0a817321e in vu_client_start qemu/util/vhost-user-server.c:225:23
         #4 0x55d0a816fcf3 in vu_accept qemu/util/vhost-user-server.c:341:5
         #5 0x55d0a7f1293f in qio_net_listener_channel_func qemu/io/net-listener.c:54:9
         #6 0x55d0a7efb0f3 in qio_channel_fd_source_dispatch qemu/io/channel-watch.c:84:12
         #7 0x7f8bd6f7e33f in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0+0x5233f)

I have to call qemu_coroutine_delete to eliminate this kind of errors.

I noticed
     make docker-test-clang@ubuntu SHOW_ENV=1 J=12 TARGET_LIST=x86_64-softmmu EXTRA_CONFIGURE_OPTS=--enable-sanitizers"
won't give the above error while
     "make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=12" would.

And for older commits like commit eea8f5df4ecc607d64f091b8d916fcc11a697541,
this kind of error won't be shown either.

Is this kind of error true a false positve because "ASan doesn't fully
support makecontext/swapcontext functions and may produce false positives in some cases"?

I don't have sufficient knowledge on QEMU coroutine and ASan to reach a
conclusion. Could anyone enlighten me? Thank you!

[1] https://patchew.org/QEMU/20200614183907.514282-1-coiby.xu@gmail.com/

--
Best regards,
Coiby

