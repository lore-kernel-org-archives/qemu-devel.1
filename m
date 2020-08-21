Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25262207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBx8GUoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25262207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93yo-0001T7-DT
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k93y2-0000Yb-H9; Fri, 21 Aug 2020 06:08:14 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:46599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k93y1-0007y0-2f; Fri, 21 Aug 2020 06:08:14 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x10so739209ybj.13;
 Fri, 21 Aug 2020 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ihHtQr1Sf+MQb3GVixUkYYl7KZnemtzdyyxzIMhuvXM=;
 b=XBx8GUoeefJrMQkl1QPN+kfMmmvTktCkEsSwl8gFBl6ExraZcldvKr2RJDFiuIcaNb
 rterZR6qPCSzI2KTsH+4I3sF3a5QtX3zY2KbfSoqqh1RSlySox+15lfOfC6E2xT2tntl
 mOtpgMJw9PWSp+9efV7cROCQwRFI7UnkgDEVGgwGzuKH6XRQLhGOeajlNW6C77bN2k8w
 18C5d3SyNxpnwMglZU6IUvLX7l4uPDn4e1Bs3o4ohCQ9xA8ps142kdnXYcc0V3GxnMDq
 gmxX3sauVBRqNfuwLhysQNXBk3N6VXj+vW0SnO0XHZUlVj6lI/HOo6fOU9THUvbpRqxH
 FS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ihHtQr1Sf+MQb3GVixUkYYl7KZnemtzdyyxzIMhuvXM=;
 b=ZGL3zeJcxutP8LYgaY9lA/a0iN/WIQEeyEValTWVIUgv6pdcrd2K7M6+5e8OnrDy7v
 sxbkMSFI0D1/vj7D26x9tUl3qyTN8jQy+Fk9fJ3iBj9Ds1OcmR/ZN5/6qb3Kxmapp6HA
 9Z6c63+x9uqo4DkF1iTOY77nehK1MXlVzw+iIDx+AAJ84U6guowiiYmOvMHeL3zj5lbh
 arM480RfXc8c4uws9+pqXiJw4toCl/QtFNm0AMgXF5y8ICNAg6Eh05vdRmvpJBAvxr2+
 LZLeH4S/xQW6mrY2C3SJW4YLZ6YAy7ewEOhtPvP9lDi1RDazdENE3k/dE4EB7VL0CZ7e
 DiGA==
X-Gm-Message-State: AOAM531dUMS1KeKpoNPcrmuY4xy57dlS0iKyg8BMAyiNRBE5tDDy/gQM
 /KFs0eFuD9KRk53c/tspZwS5DkP8E/iRl9jz98o=
X-Google-Smtp-Source: ABdhPJwQs+pLJaS76RAjNqXTOYNDpWAQJ9r97JhLqE1F6gdiy0i9SzMovYFjuReDdrFpdHF5nLkz5kiuvHnQpZCAqjY=
X-Received: by 2002:a25:f20d:: with SMTP id i13mr2607894ybe.152.1598004491447; 
 Fri, 21 Aug 2020 03:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
 <565d9936-3eda-db2f-b390-05f675cf6644@amsat.org>
 <BY5PR02MB67720168B25F53370840545BCA5C0@BY5PR02MB6772.namprd02.prod.outlook.com>
 <20200821100940.GA30457@xhdsaipava40.xilinx.com>
In-Reply-To: <20200821100940.GA30457@xhdsaipava40.xilinx.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 21 Aug 2020 18:08:00 +0800
Message-ID: <CAEUhbmVX7_+SeVJpn_qPMoeLZXH-E3232ggVnq55UeskK3bDGQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, saipava@xilinx.com,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sai,

On Fri, Aug 21, 2020 at 6:04 PM Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> Hi Philippe,
>
> First two patch of SD look good. Tested them over zynqmp and versal
> platforms.
>

Thanks for testing.

Can I add your Tested-by tag?

Regards,
Bin

