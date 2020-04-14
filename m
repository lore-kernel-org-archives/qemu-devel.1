Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AED2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61805206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 21:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyBPrVBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61805206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOT1w-000307-Jx
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 17:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOT12-0002Ry-SL
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOT11-0003bH-Us
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:22:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:45362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jOT11-0003ai-Pp
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 17:22:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id w65so527320pfc.12
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AhsSXfOfZ4x767ut4rp3RVZ+v5E8hhvkejA78ac5dmo=;
 b=hyBPrVBRIxLOqGwMNPeVyCnrnRwiXYJRnygcm4CUTekpSJ0w5vLeMfjn6qUuMsW/VT
 SDOtCHm+Mc9es4mQjyTQ3LT6cjAxLaDKREZdScLnvLSs7/qwAF2Cmd2ErRQTp/5SrHVY
 cnSOA6detrG7aXYaZmmR9hjzHVkhxkugRE0xl/WYeylsYRoZAlGX1hxpKOaO7u0CywYr
 1FTppGDINSqIbZHrQRCA8vSEPUUEY9nSizYnCRXpFZaGVtcr5nDlOuiL6MowvG6m1HhN
 C9GzkHUN6V/RvV49eWem6qEgCx9aujd8ADSNv0C4o3BSeBVBmf9UW7DnyxsGhZhVnOSF
 psmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AhsSXfOfZ4x767ut4rp3RVZ+v5E8hhvkejA78ac5dmo=;
 b=pyK3YyIkIi5MOZdwZBlui3WfQCAHehNFVER7sI362oy311ToArDOYXx3WSVoqRS7EG
 bobwjpuDl6ptNm67M5o97cpBv/nNNrlOzI8jubtX/KAFwb+MchOasEFKkXchYKfCVuC+
 4ZK3NmCaZB4njGeqoXGSgd4CJAKIkC2B5vAjoJl6rrQlHHxkYIcF7WaxeRlcBq+c7UFu
 G6pBuzY0Z+dceHwd2hx5TxUWcWfTwcDQovdlIKK1YxGMoaXdjUictaF08l1EwFdXhPzF
 kj4g0ISnop2BoMUG9Uuuefl/8y13sNtAyq5BWSglA/9sFQWjV7WVeqIQTfpiTPI2HfkX
 7m9Q==
X-Gm-Message-State: AGi0PuZrg0BBI2gP/F1dhoOhr2HwF0ZO0qdYk+YzCJ4ioLpbbwqo7WOm
 fJIYh9e5qpUSxw1nRJiZrLjxgg==
X-Google-Smtp-Source: APiQypKg8m8AcGKfsdGTa1aQeJXrnbGdvA+9nv+9rTMAhMMvqNlhPrunNJM5RuGZvlhwq11UbprZzA==
X-Received: by 2002:a63:6f84:: with SMTP id
 k126mr24179934pgc.391.1586899362676; 
 Tue, 14 Apr 2020 14:22:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 6sm11124889pgz.0.2020.04.14.14.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 14:22:42 -0700 (PDT)
Subject: Re: [PATCH v2 14/17] gdbstub: Introduce gdb_get_float64() to get
 64-bit float registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200414200631.12799-1-alex.bennee@linaro.org>
 <20200414200631.12799-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <423d7297-2dc1-ab4b-7969-022a1854400c@linaro.org>
Date: Tue, 14 Apr 2020 14:22:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414200631.12799-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 1:06 PM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> When converted to use GByteArray in commits 462474d760c and
> a010bdbe719, the call to stfq_p() was removed. This call
> serialize a float.
> Since we now use a GByteArray, we can not use stfq_p() directly.
> Introduce the gdb_get_float64() helper to load a float64 register.
> 
> Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200414163853.12164-3-philmd@redhat.com>
> ---
>  include/exec/gdbstub.h          | 11 +++++++++++
>  target/m68k/helper.c            |  3 ++-
>  target/ppc/gdbstub.c            |  4 ++--
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 16 insertions(+), 4 deletions(-)

Not for 5.0, please.

As I mentioned in reply to Phil, this is not a bug fix.  Unlike the float32 sh4
usage, the places changed properly use gdb_get_reg64().


r~

