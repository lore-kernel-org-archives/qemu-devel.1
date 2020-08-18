Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D835922BEA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP1uKUt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D835922BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83zj-00022A-0l
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k83PK-0006Hu-7u
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:20:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:43713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k83PI-0000EN-05
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:20:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id y206so10102449pfb.10
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XuUPEjKibg7eOjJ1mVeW5oOcsgH677Gp/l+5UAOux5A=;
 b=NP1uKUt8b1qGRpeXHpvR6OOVitckmVp7avnQM8nygNbYkVz1sDBFTik4yD+ZkQTNGI
 MqG7BPpCa2RW8igiHzXW0XiF7P3m87wrYi03tsf6c3xzioi/g4BOhZaRuoI+kR8/+pq7
 dcC3AOLrQ6VTBo8nM+MM5tZIpja7inc/fO2XGO5ooGYOfBvRd31sbk8BPB0bL2gZMkdm
 hmNtp9OB7Xvc5q372ma4o8TU6Uz0pGw5MvxPxT+QSJrIK66+B3xn7nSzZffRHzs8gOei
 04dxpHViIKzHRehKVLDb8YgAgXAMdjmzxC6/pK6REFjcgr3ixGs/xkIpaDFCgoITStlk
 l4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XuUPEjKibg7eOjJ1mVeW5oOcsgH677Gp/l+5UAOux5A=;
 b=UvpORXwWTwZXbmChBqGpmVQqvJZxgA7I5ubl8fFlwU7EaJF1A6qv/B5jJltPwujZ+L
 aX2dqWPWxEJr0k3aGDU8RsZFrewW1cM+x5DyMGz+96cb7mJKryFMvAHORb8KdrXRu2Zc
 E1GWalaNRAp4ojWSUKIC/TnK4oP6IM3yIjDlMIq47bppQIYvLiGljwsNYy9nO1GJ+El3
 fXzGA8FNgSH/Dkac/iION8sHulKWh6ytuNNUuFEJVS4dtewXb+KEd01QY77Sfr854jx+
 IFbcHt2rVSn9Tkbm/gjtxbOuB0HcuWZeBJ78B0tBcbp5OADweZK8oAGAUyYMPwjtTJe4
 qWiQ==
X-Gm-Message-State: AOAM533Ddzml32QKmzBoPGkOimaR0Eaf7ocQKoGl8r1MH5lnIH8I+4Gk
 CF4IYsUCMDsHmx27hBdu0ND9a+kgJZCznpDTeEs=
X-Google-Smtp-Source: ABdhPJywx/b0O8X93LGSY6jnaJNdp517BTKcQmZBEuPyiRRMCUHJ15Apm1wdPyMx7gaCCa7YUq9tqiNKjVQ7QJ1Ykpc=
X-Received: by 2002:a63:ec04:: with SMTP id j4mr13568849pgh.393.1597764010107; 
 Tue, 18 Aug 2020 08:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200817131319.hqhchbgkjofbvsuj@Rk>
In-Reply-To: <20200817131319.hqhchbgkjofbvsuj@Rk>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 18 Aug 2020 16:19:58 +0100
Message-ID: <CAJSP0QVCKovhA_ZJPMO52F3Wc_pCGK=_A4BX9wZsKC-51AL4NA@mail.gmail.com>
Subject: Re: Should I delete created coroutines manually?
To: Coiby Xu <coiby.xu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=stefanha@gmail.com; helo=mail-pf1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 2:13 PM Coiby Xu <coiby.xu@gmail.com> wrote:
> I'm working on vhost-user block device backend [1]. When I tested my
> patches on the latest version of QEMU (commit
> d0ed6a69d399ae193959225cdeaa9382746c91cc) with --enable-sanitizer turned
> on, the follow error will be thrown out,
>
>      ==46631==ERROR: LeakSanitizer: detected memory leaks
>
>      Direct leak of 312 byte(s) in 1 object(s) allocated from:
>          #0 0x55d0a7813921 in calloc (qemu/qemu-storage-daemon+0x646921)
>          #1 0x7f8bd6f7b591 in g_malloc0 (/usr/lib/libglib-2.0.so.0+0x4f591)
>          #2 0x55d0a815f3fb in qemu_coroutine_create qemu/util/qemu-coroutine.c:75:14
>          #3 0x55d0a817321e in vu_client_start qemu/util/vhost-user-server.c:225:23
>          #4 0x55d0a816fcf3 in vu_accept qemu/util/vhost-user-server.c:341:5
>          #5 0x55d0a7f1293f in qio_net_listener_channel_func qemu/io/net-listener.c:54:9
>          #6 0x55d0a7efb0f3 in qio_channel_fd_source_dispatch qemu/io/channel-watch.c:84:12
>          #7 0x7f8bd6f7e33f in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0+0x5233f)
>
> I have to call qemu_coroutine_delete to eliminate this kind of errors.

qemu_coroutine_delete() is an internal API and shouldn't be called directly.

If you are sure that the coroutine terminated (returned from its entry
function) then the leak is probably caused by the following:

util/qemu-coroutine.c has a pool of Coroutine objects that are reused.
It's likely that the "leaked" object is in that pool.

I'm surprised that this issue hasn't been reported before, but
release_pool should be cleaned up when the program terminates.

Stefan

