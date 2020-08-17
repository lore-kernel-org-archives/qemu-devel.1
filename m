Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F5E207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBpzzLPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F5E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hsT-0004SF-RY
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hpO-0008CG-Dc; Mon, 17 Aug 2020 12:17:42 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hpM-0004uj-OY; Mon, 17 Aug 2020 12:17:42 -0400
Received: by mail-io1-xd42.google.com with SMTP id g19so18167119ioh.8;
 Mon, 17 Aug 2020 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JfB27uxKgiitmOZCXEe4t6YbDbTKDrzBtw1c9WaPXlQ=;
 b=JBpzzLPaUEt4XzzoLPOXB8AtZvq1+wTpOHCIpWSYgjjQN5UjGBUukjf3dDderiomya
 fYpITZj4X7U0Z04k+iBhCZ0eK2Z6QBWPfeWqGAt4fIhC2mgUKjJra4JTl2y8EBosoMQW
 Ny59EjPJscK7sontGfO8QkrMVV2Y9xCnlH82cuyw//d5GtPWTG3ssLkuOaovqFWum3J9
 RuPxg28qbEbCVTMMbmjYPYh9YFhDCjBiUpdVcsBQJf0cvPrPuUua7/igtFpBm+O9Kmm6
 Tl1VHMqwZkV0ATx27pUIyKKfQsLYjqPT/p2YeBQJBU505n3oIIJllZOGEBz3o6Z8m8ir
 anNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JfB27uxKgiitmOZCXEe4t6YbDbTKDrzBtw1c9WaPXlQ=;
 b=WbiwdPtfINKn4JXTDkkTK3u75kUqFd/nsHAEEiQAvXp74PZpVVDha+22IxwchdtThJ
 VN2hLeCYI8ZlA6Sds+KablFxl5tvAFWI4eTlAK2rVIHdP/j2BZMRafY8Pp+Q8BMTIPwL
 EaRxHRQKnuptWa3qd2ywXp8bI7/74W2JfIz0PDq3zlH/x9JqLxrICYO0KOJ59uzuRFT+
 yZQTeu8oh0oi6/46Kal17DQn0yBNt/EDS2pKGpXW2Kcx7WfQ7V4G5f9XZHWwWdF6fQzO
 Z5HEQpe3y8lel9omkJ3pF0lQSn6vS3ae88qBqivVvi0pb/T9OBbgUSYcIXe6vE7T0Dbh
 /XfQ==
X-Gm-Message-State: AOAM531TFkFt8AXfteqQa7BbWf3t8UxgSmt9/piPJnYho40eMzvXHVkt
 LKxvnaqBDeUi6YhZ4342Cgu/VBZw3Fi6iLHjRQk=
X-Google-Smtp-Source: ABdhPJyXGoBsk/efe4uwmhB/U/jbD6NT4UMHuOU7d0QgC4FNoXiA8ibW/XzjnTt7IHQU2VPb56LIGUGuf61a/CU3T3A=
X-Received: by 2002:a6b:6016:: with SMTP id r22mr12964699iog.42.1597681059357; 
 Mon, 17 Aug 2020 09:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-6-edgar.iglesias@gmail.com>
In-Reply-To: <20200817140144.373403-6-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 09:07:07 -0700
Message-ID: <CAKmqyKOH-6UmOjR=_=Q=nCPXVxsHH4gBp+J59_PvDTmKY5U2=g@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] configure: microblaze: Enable mttcg
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 7:03 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index 2acc4d1465..2f7adaa6ae 100755
> --- a/configure
> +++ b/configure
> @@ -8162,6 +8162,7 @@ case "$target_name" in
>    microblaze|microblazeel)
>      TARGET_ARCH=microblaze
>      TARGET_SYSTBL_ABI=common
> +    mttcg="yes"
>      bflt="yes"
>      echo "TARGET_ABI32=y" >> $config_target_mak
>    ;;
> --
> 2.25.1
>
>

