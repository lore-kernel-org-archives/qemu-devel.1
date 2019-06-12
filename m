Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717AC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6A0206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khs7mC0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6A0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb9Vn-0006Ox-U7
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9QU-0001FE-PQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hb9F7-0006h9-4v
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:49:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hb9F3-0006dm-DK
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 15:49:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id f25so9491210pgv.10
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pb2NIlYiy7cjxxkak5vn5GNpXsFlfz5bEbFWMHRys+M=;
 b=khs7mC0OM1lqmLnT5r96PKmb7A4p9NT5vCG+KOj0rEj6IT9PBeQ+3fxGbHI/6T25Tm
 ASl9HiqYT3sQATpHvtZkB/J9aM+mSrI9NT6jGCd+M2rbxgwsZLUnv4cm0pJDXX1sh5v7
 bWi7sf3uW0T6UM+nTtTmKVaO3bwsZyYdEDPn+s5mdELn2ujSndZlLSKzyn5ytz+IEXlO
 QeVpL3hMEhQVZ0/+NtOFFQ8VcjIHgABJ0/Laj+EE57gY39xluEDnGQsDpyumQdDrDRdH
 V5Cy172/WCRpqTpstXFeoyphHBboq+slyyJR83gegXp8/dFfZ7Nl7T5x+3ta/5MGAixG
 0H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pb2NIlYiy7cjxxkak5vn5GNpXsFlfz5bEbFWMHRys+M=;
 b=EoHUQqg9kOLJDZbwvBSLdhY3f9Jj7HF0H5j161gAWZgHvwf1pTHdn1lHf2cWGLvowR
 iYizklwi029UmSz/ol4LNACFB62/DU4JiVhC5LmHoWF6AFxtS6+KrMfkYJia/ALdQTTU
 ZfVBKYPV0SaKV9y9npUphPwhv8izHGLR4cRwHdHtFDXa+S18CFK3yPliMngXVVI2vdSs
 zRkW6tEYKgqIO3+ndP5C+/WSbpoQ8pb0FfU3oqiJFGHBYAtWBN/VlJBD+E5Pi6qvc4Mu
 p0jQelH+C3+Of/w2rPP+8VYLdp4ghsDncnN7eWMKhd/2W/6Qc82FInUpm+vgsG1wBafx
 D6Kw==
X-Gm-Message-State: APjAAAU9kkzorBysUuVdoTCD+UhBuFW0vKyMULOv6X/yJn/l64u9MpW3
 vzYsYQIz0Zft1sdCT89i+3n7eQ==
X-Google-Smtp-Source: APXvYqxVMw4eaZaYx2FDnK+aD6zFsmviFBxAyjxe4AJq+bjTxnDd4YjKaSQwmmAbDl1hl5czL0KonQ==
X-Received: by 2002:a17:90a:1ac5:: with SMTP id
 p63mr848894pjp.25.1560368943033; 
 Wed, 12 Jun 2019 12:49:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 i25sm365560pfr.73.2019.06.12.12.49.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 12:49:02 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
 gkurz@kaod.org
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-4-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b14ed799-5911-f8e3-6326-59c81bb4e2d7@linaro.org>
Date: Wed, 12 Jun 2019 12:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602110903.3431-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 03/15] target/ppc: remove
 getVSR()/putVSR() from int_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/19 4:08 AM, Mark Cave-Ayland wrote:
> Since commit 8a14d31b00 "target/ppc: switch fpr/vsrl registers so all VSX
> registers are in host endian order" functions getVSR() and putVSR() which used
> to convert the VSR registers into host endian order are no longer required.
> 
> Now that there are now no more users of getVSR()/putVSR() these functions can
> be completely removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/int_helper.c | 22 ++++++++++------------
>  target/ppc/internal.h   | 12 ------------
>  2 files changed, 10 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

