Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F6C04AA8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711322089E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711322089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7g0-00024S-Oh
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:06:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7es-0001EK-CL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hM7eq-0002y6-BB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:05:38 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:50883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hM7ei-0001lm-OT; Thu, 02 May 2019 05:05:30 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Mof1D-1gy1EI046r-00p5iu; Thu, 02 May 2019 11:04:35 +0200
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers
	<qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
	qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
	<marcandre.lureau@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
Date: Thu, 2 May 2019 11:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K/XF6stn8BMcZvX/doC5zSKfa1n7bx2uxJ0kOFmbjL9p2XnYdtk
	hA/1kTcDlG4kGG22wN9vjIYz3SeCUiqTR/DwU+XKxlCbr6GkuFQABga3TtIqZs5YW8zofN5
	PqGlMZ5jbStSummOfv6G27EnPz4fj4AL3UEGFFNp+GAT1HuVs2tIraF5lvoqvyTsXQuFjy7
	78BQFx7prmbRbz2OZpJdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vtjwTng5OGo=:ZJIKji/GNFiJua2NnTa1iw
	tQHKJR/ZPYjr2m+7woXYXla/OHdT7okFZHmgXxOEgUFoXNvYnarPgFbWiGaYzH4cQ2/7EfF29
	qJZZsqx4SPRJmh7eI0shCBtVWBZ29E4jLyaXQiLkT5JNC6i3GOQkgasaxfWqM0k9xLLVb0sB3
	z4XPo8A/WfHDQW2DGghNcyHF8r5ES8JOVr72XIgzrQfQOw/9Qy1zJlef/uEN9GZp/g6JMDEIL
	CFVUBYHmCh3wrm7mhZYh/+xtUCzJDoGOwOK4LrhXyK4x9QfVwsFcNbVXT1IEQu0g0ceBTSn/z
	y2tBclrjNWL7a9Kc5vR6U3+hrDBXs9Cdrcn3nQxJ96laZwNgTGln/Fy6U8nPWwc5/LVwAppgo
	aOg4h/x3AvaQh6i75zti5OTx88RtWMMWpMvpJvwOulGAhoeJNhyT2LJB4pNdwK77oNgAI78VJ
	qXkxH2HCBLMrHfMOqmj3KwZwi01v760gE7z8ZNm0cXvUJWaGjnRBRSlhlnXftBggB0mc0bapg
	YBqtN725t+8aFaCPaOX+s6k+AXSsmsOjqXbW2nsgqAPQ/vHIK6vVZzq9pCOrHt4HLo3iXY8fC
	F0lsTtknJ+IgXlGGnpbp97x5i571iTIua07s3X5Wy8dG1eyLPK9ka+75eIJ4Tr9ytG60TuRfQ
	zrhRa6rExbwWi3+RQ+jrTFSe5kiFrYCpjiTtPNzVRHcK4A4kpWDpoy0un+E6HftU0jV4ijELm
	d8TVJkJVxI2UDRSVypEq8hMdb4IjRN/2QMFPS6Z9ReX/R8cBAjcoJbWYf7s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] hw/char/escc: Lower irq
 when transmit buffer is filled
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502090433.KZiWpLYq1pmH3OhiKUSsaI-sEX-3TpimWfF6eJHZguc@z>

On 19/04/2019 17:40, Stephen Checkoway wrote:
> The SCC/ESCC will briefly stop asserting an interrupt when the
> transmit FIFO is filled.
> 
> This code doesn't model the transmit FIFO/shift register so the
> pending transmit interrupt is never deasserted which means that an
> edge-triggered interrupt controller will never see the low-to-high
> transition it needs to raise another interrupt. The practical
> consequence of this is that guest firmware with an interrupt service
> routine for the ESCC that does not send all of the data it has
> immediately will stop sending data if the following sequence of
> events occurs:
> 1. Disable processor interrupts
> 2. Write a character to the ESCC
> 3. Add additional characters to a buffer which is drained by the ISR
> 4. Enable processor interrupts
> 
> In this case, the first character will be sent, the interrupt will
> fire and the ISR will output the second character. Since the pending
> transmit interrupt remains asserted, no additional interrupts will
> ever fire.
> 
> This behavior was triggered by firmware for an embedded system with a
> Z85C30 which necessitated this patch.
> 
> This patch fixes that situation by explicitly lowering the IRQ when a
> character is written to the buffer and no other interrupts are currently
> pending.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> 
> I added a sentence about the Z85C30 necessitating this to the commit message.
> 
>  hw/char/escc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 628f5f81f7..c5b05a63f1 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -509,6 +509,13 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>          break;
>      case SERIAL_DATA:
>          trace_escc_mem_writeb_data(CHN_C(s), val);
> +        /*
> +         * Lower the irq when data is written to the Tx buffer and no other
> +         * interrupts are currently pending. The irq will be raised again once
> +         * the Tx buffer becomes empty below.
> +         */
> +        s->txint = 0;
> +        escc_update_irq(s);
>          s->tx = val;
>          if (s->wregs[W_TXCTRL2] & TXCTRL2_TXEN) { // tx enabled
>              if (qemu_chr_fe_backend_connected(&s->chr)) {
> 


Applied to my trivial-patches branch.

Paolo, Marc-André, if you disagree with this change or prefer to take it
through one of your queues, I can remove it from mine. Let me know.


Thanks,
Laurent

