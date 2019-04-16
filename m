Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1DC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566912054F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="ordkwNFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566912054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGMpD-000140-KB
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:04:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hGMo4-0000Ws-4H
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1hGMny-0000pf-S7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:03:17 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:45556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1hGMnh-0000aa-Cq; Tue, 16 Apr 2019 08:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.uni-paderborn.de; s=20170601;
	h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5ag7lYrSZu1M1G4kPVzNJ2/W4yY4tpZv4apZcI2ccg4=;
	b=ordkwNFscOenmavYMCTFnRwmls
	al/hkLJkzUHY03D1FNdDGEHgUKgQCD+nDVL085qoyE8s6drMuTNwEzRIe1Qs29Kz12tfmdC4caUUS
	ZpHIUJe8WlQPxlrSCctqkqPVi0C1aBwXMDVifmhGcv8aYwMrnyuXMLCWzxF1l65fMtAw=; 
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
Date: Tue, 16 Apr 2019 14:02:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401031155.21293-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
	Antispam-Data: 2019.4.16.115416, AntiVirus-Engine: 5.60.0,
	AntiVirus-Data: 2019.4.10.5600001
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 131.234.142.9
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
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
Cc: qemu-riscv@nongnu.org, palmer@sifive.com, Alistair.Francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416120236.2yvLNo-Xfgu4VKwNxHHNqpvpy2VKr4RoiQfWkzpWSSk@z>


On 4/1/19 5:11 AM, Richard Henderson wrote:
>   
>   # *** RV64C Standard Extension (Quadrant 0) ***
>   c_addi4spn        000    ........ ... 00 @ciw
> -c_fld             001  ... ... .. ... 00 @cl_d
> -c_lw              010  ... ... .. ... 00 @cl_w
> +fld               001  ... ... .. ... 00 @cl_d
> +lw                010  ... ... .. ... 00 @cl_w

This leads to a redefinition of arg_lw and arg_fld for which clang emits 
a warning as found by Peter as he wanted to merge the original pull 
request for RISC-V-dt. The same goes for all other merged args.

Cheers,

Bastian



