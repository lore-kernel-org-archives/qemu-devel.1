Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5492C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A98520723
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbKcEL0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A98520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzMh-0000M1-W7
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWzIH-0004Mb-GR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:00:01 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kWzIF-00049l-NE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:00:00 -0400
Received: by mail-ed1-x542.google.com with SMTP id x1so8602226eds.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yWPGiz+en+QDTJfj33gEX/zxs5gcfs8+iWAunjrTK/w=;
 b=PbKcEL0sEWzazqlBjHie4HhK2seCPzukTHy/djIOVJirSYSammtIHuKVNLSVTSj42+
 CR8yMnzNTSu4A8BPdwd8+CbHfN9zMcxnFcPytc3O7Z9LXwOK278MlW02SM5bwuK7h7Dz
 SSOCaX9OqhW918g+ocLDymV3x16aTiWxEFlHW0LnbrOqukIznlB8q9z1dfkBkMlFR1BE
 nUpY3S77kCLdjA0lsRfvQBiDACUvwZIaF+vAVJMcnelMj+wJgakWhnlFWQm/jyX8OOEB
 WawlCgrRu99Tq24AnnxzAe4J3+7mAusuVWJquNS36TQ1u3JRiKYhMw+YUUx0kGi+LM9I
 ZryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yWPGiz+en+QDTJfj33gEX/zxs5gcfs8+iWAunjrTK/w=;
 b=IIO8ldMjh+IjVCIumKYlKcfd5qx9LU2l78D6h4axFWRgFzCssWH6sq3iSoZ0W1Apyw
 flniBjG44WXxDudE2+7mS+UdgAJ6+/lIJFnEBLiHOqk/yHAv4izn+OB4ZiDVwv14KbF6
 i+dt1PI4g6uHxKwNiPHiSZDscVUSAf4dHaPTdHFK9/sQF/3lTkHFPgw3K/AFCSHoEUZ5
 2d20EwmZoeXs1T0fGZqvb6T2RzwZIqsydepURoW4jHAh1e0Ed7CXtD6Ex4eRR0w7gobQ
 iNC9HPmDybMQELHBe+7Ke4RxwWgihE5ioSHF9Y/fpA6MZ0qf7BwQ22JHZpdRI8WuUbvU
 R6WQ==
X-Gm-Message-State: AOAM532kW4zDisR3rKVwxLjaYM+VGEUqsmnW340WcQZYTvy1WoUHFDvq
 YU81pLwJKVOq0bHEOHe7tDolqHFivTq+c30iG0ynPw==
X-Google-Smtp-Source: ABdhPJzHYsMk4ziERi+FgchpQik+FT18jGWyWW4AlkhNIyovv11UrBuwoLx9H+es2ynkY7Wy4DLSlh88d+PHFy4Dgbg=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr15386619edf.52.1603706398205; 
 Mon, 26 Oct 2020 02:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201021060550.1652896-1-ppandit@redhat.com>
 <38575304-e5ff-c93e-c1e8-997d4148e579@redhat.com>
 <nycvar.YSQ.7.78.906.2010211440290.1506567@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2010211440290.1506567@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 09:59:47 +0000
Message-ID: <CAFEAcA-sSk+4v5XDUTapV8qKu-Lv2v87q7+_NUqtxoM50PQnAg@mail.gmail.com>
Subject: Re: [PATCH v3] net: remove an assert call in eth_get_gso_type
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Jason Wang <jasowang@redhat.com>, Gaoning Pan <pgn@zju.edu.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 at 10:23, P J P <ppandit@redhat.com> wrote:
>
> +-- On Wed, 21 Oct 2020, Jason Wang wrote --+
> | It should not be a guest error, since guest is allowed to send a packet
> | other than IPV4(6).
>
> * Ah...sigh! :(
>
> * I very hesitantly used guest_error mask, since it was g_assert-ing before.
>   To me both guest_error and log_unimp seem mismatching. Because no GSO is
>   also valid IIUC. That's why in patch v2 I used plain qemu_log(). But plain
>   qemu_log is also not good it seems.

Well, as I said last time round, the right function depends on what
is going on here. If this is "the fallback code path is fine, it
might just be a bit inefficient", then either no logging or use
a tracepoint. If this is "the guest is allowed to send this packet
but we're going to mishandle it" then use LOG_UNIMP.

thanks
-- PMM

