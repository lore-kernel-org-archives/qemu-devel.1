Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F1BC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A071206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="Uv8yAFY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A071206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55157 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwzb-0000H2-In
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:05:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hIwyX-0008AO-AO
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hIwyW-0005iw-Dr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:04:49 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:56714
	helo=nylar.uni-paderborn.de)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1hIwyQ-0005bb-H3; Tue, 23 Apr 2019 11:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.uni-paderborn.de; s=20170601;
	h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zKr82EWahjl08KclX7YUdbawq18pfZr4TwUCORBjsZs=;
	b=Uv8yAFY4lG0GgiSAAIRgZ004qQ
	AMJXBfSZOAkTAFf+hT+YccXnhiq+U76aaOCWQ5mLSyYIadNkT9dxwI4hRFYeDVV8eY9O5tpiLY46f
	foDCAs7XXiiKK6M+Bb9HcQ0L7Unge1LtwkRG6DvFLdf39VXqAivG086bJJH+Xn4+rUq8=; 
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190423102145.14812-1-f4bug@amsat.org>
	<20190423102145.14812-3-f4bug@amsat.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <aeea5139-ae69-e7d7-ea0e-7f7855f6ab24@mail.uni-paderborn.de>
Date: Tue, 23 Apr 2019 17:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102145.14812-3-f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
	Antispam-Data: 2019.4.23.145716, AntiVirus-Engine: 5.60.0,
	AntiVirus-Data: 2019.4.23.5600001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.142.9
Subject: Re: [Qemu-devel] [PATCH 2/2] target/tricore: Use tcg_gen_abs_tl
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423150435.VpUZTsMI-14SlUK2XO8oKiFn4CTwHIqfLP6h_xPRh1Y@z>


On 4/23/19 12:21 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   target/tricore/translate.c | 27 +++++----------------------
>   1 file changed, 5 insertions(+), 22 deletions(-)

Reviewed-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>

Cheers,

Bastian


