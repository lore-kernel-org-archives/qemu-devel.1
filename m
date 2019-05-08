Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08211C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDADA216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDADA216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOPVI-0001rG-1v
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:33:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOPTn-0001BH-BC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOPTl-0005fA-Sl
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:31:39 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOPTl-0005cs-JH
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:31:37 -0400
Received: by mail-wr1-f52.google.com with SMTP id f7so17717510wrq.1
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Hmkky42F2qyHPZi6E2CFktizZo2+KGtVO5ega4ivqPU=;
	b=OCLKIXSDsgTGEG1+VlslU2PGGyXlWLe3cIcWnUT7b1sdCz6IphBVFsrWwtlwSpq2hB
	aFZWYDwdvNQg7lD6dgAFWxHTDqvHd8GKnooDXTQH0VMKKYqo+8cKIAn3LJsV/481fWoG
	u80kh203nLnSUQXcqRYJhf5DXnZ5eXw6ugN+9yVEBXKPiSxBbPHQDxvJuZFTO3J2pJsF
	QXZ5bUkcDe2uQdYE1rwCxmvPRsSLDZ75eoweodz6yV/IYxP1XiWA3XCQSfafvJW4P3xm
	nnZOHV2DK1egU6v878pf1Bc3sb3huROcugpyi0INKhZJ0nlYd/ojj/HQrETKB7XzQSPh
	O+rw==
X-Gm-Message-State: APjAAAVgCxPrFpWyhQNnsgiutF5JGqN6xnn2zxLRLwAdZvGytPvGl0HE
	pFs47PtDtAyTxn1CG/V5dzmdXw==
X-Google-Smtp-Source: APXvYqz2DWKJLpXaLZ8i1GHcBasmDJL3Ja2GK0Cpp5oXHazkwgvSD5hM3SpGmuo86rLgDWEdpkSUiQ==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr18973836wrt.95.1557333095926; 
	Wed, 08 May 2019 09:31:35 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id f3sm3723603wmb.1.2019.05.08.09.31.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 09:31:35 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-8-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9e1bfb33-d681-e883-f9da-07818a19710e@redhat.com>
Date: Wed, 8 May 2019 18:31:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-8-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.52
Subject: Re: [Qemu-devel] [PATCH v10 07/13] hw/timer: RX62N internal timer
 modules
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 4:56 PM, Yoshinori Sato wrote:
> renesas_tmr: 8bit timer modules.
> renesas_cmt: 16bit compare match timer modules.
> This part use many renesas's CPU.
> Hardware manual.
> https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01uh0033ej0140_rx62n.pdf
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/timer/renesas_cmt.h |  33 +++
>  include/hw/timer/renesas_tmr.h |  46 +++++
>  hw/timer/renesas_cmt.c         | 277 +++++++++++++++++++++++++
>  hw/timer/renesas_tmr.c         | 458 +++++++++++++++++++++++++++++++++++++++++
>  hw/timer/Kconfig               |   6 +
>  hw/timer/Makefile.objs         |   3 +
>  6 files changed, 823 insertions(+)
>  create mode 100644 include/hw/timer/renesas_cmt.h
>  create mode 100644 include/hw/timer/renesas_tmr.h
>  create mode 100644 hw/timer/renesas_cmt.c
>  create mode 100644 hw/timer/renesas_tmr.c

Errors on 32bit host:

  CC      hw/timer/renesas_tmr.o
In file included from qemu/hw/timer/renesas_tmr.c:24:0:
qemu/hw/timer/renesas_tmr.c: In function 'tmr_read':
qemu/hw/timer/renesas_tmr.c:186:23: error: format '%lx' expects argument
of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long
long unsigned int}' [-Werror=format=]
                       "renesas_tmr: Invalid read size %08lx.\n", offset);
                       ^
qemu/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
qemu/hw/timer/renesas_tmr.c:239:23: error: format '%lx' expects argument
of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long
long unsigned int}' [-Werror=format=]
                       "renesas_tmr: Register %08lx not implemented\n",
                       ^
qemu/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
qemu/hw/timer/renesas_tmr.c: In function 'tmr_write':
qemu/hw/timer/renesas_tmr.c:267:23: error: format '%lx' expects argument
of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long
long unsigned int}' [-Werror=format=]
                       "renesas_tmr: Invalid write size %08lx.\n", offset);
                       ^
qemu/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
qemu/hw/timer/renesas_tmr.c:291:23: error: format '%lx' expects argument
of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long
long unsigned int}' [-Werror=format=]
                       "renesas_tmr: Register %08lx not implemented\n",
                       ^
qemu/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
  CC      hw/timer/renesas_cmt.o
In file included from qemu/hw/timer/renesas_cmt.c:24:0:
qemu/hw/timer/renesas_cmt.c: In function 'cmt_read':
qemu/hw/timer/renesas_cmt.c:127:19: error: format '%lx' expects argument
of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long
long unsigned int}' [-Werror=format=]
                   "renesas_cmt: Register %08lx not implemented\n",
                   ^
qemu/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
qemu/hw/timer/renesas_cmt.c: In function 'cmt_write':
qemu/hw/timer/renesas_cmt.c:171:27: error: format '%lx' expects argument
of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long
long unsigned int}' [-Werror=format=]
                           "renesas_cmt: Register %08lx not implemented\n",
                           ^
qemu/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
cc1: all warnings being treated as errors

