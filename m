Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C502C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16C120838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i86Fk1x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16C120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htD7A-0001Z2-Rt
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htD5V-0000aD-Rm
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htD5U-0002t6-RW
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:33:53 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htD5U-0002ss-K5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:33:52 -0400
Received: by mail-pl1-x643.google.com with SMTP id c14so32300465plo.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TkrSphxYneKXFUxh/j0btPbitaaNXCR+9oMYwQO87ck=;
 b=i86Fk1x5pa0Z3Y/j+PsRvc9OV6zn/voxEg4B05PyTu4PMu21p8ZzURGrocRog/xsYv
 0zOku5eFKMu+9+NogFgQKrJ0guMZpQY4IEvQI49os4tS8iEZLATgxwWcBr6yE2E5/sKA
 LLwv+S0sOxzbxHxFABp8/4mmrdy+C74Srwe1pjZ8izO8UzLKLuibC7Ulv4DuD5MCiqnX
 KYuNInu8zdKAwpQcAU9eFfjLlOlJRTcumYSTFjsdYaBVWtYd3cBllote6HZDOcn1MRRF
 M459AzZ25JIClpn/5hmZI0FeV5nPzFE8pXeqywwOR7aCojwggLBWQblJkj7MaI9nT53F
 7YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TkrSphxYneKXFUxh/j0btPbitaaNXCR+9oMYwQO87ck=;
 b=A7t+9Pzr6vBfQUqT70HlPvYbaDE//7GIVBNie9nBYWQxPCmP9su8gHVwwnpjn4Dq7V
 WP58RPrKMKb2CQGnvpuXDyY4JK+pdbjsno/Jy3XbgzMTJM5bMqduMHzyoBJQ3QATSHDb
 QbcRcjDDld6jG1WyANaSBgwbuy0zxH1/NcHkIEX9vWM8rlJNMadgbQ/O6Zoc5whfvVg8
 5D/z37W6eDRFec0L04IbmFiR5pZ9RVNgjCgMgpgQsMo4P61DDfNo8meRAlbgWAbMQaOq
 42SSakSeaKHTEIxJ3BVFNr5IUHkvTlsz+t8/QtXx77WH2mKosdgkVCPgLEhfOS++Owuw
 tgXg==
X-Gm-Message-State: APjAAAW5oUX9oPK+15klwAfMmaiShKm41EexEe62BFzexH7qOUwr0AmC
 qJyckm0nacpPSekUytcXWgOlVQ==
X-Google-Smtp-Source: APXvYqyuEfgQWk4NYYBw6F4wV+OXXrsM2QNUI/8ulRgpsreftLxMEzfpiBHTm5wwvTbvS7QJFBzSew==
X-Received: by 2002:a17:902:2889:: with SMTP id
 f9mr120021946plb.230.1564673631432; 
 Thu, 01 Aug 2019 08:33:51 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d15sm16318063pjc.8.2019.08.01.08.33.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:33:50 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <264ea427-88c0-227b-bc9c-43d030fe8937@linaro.org>
Date: Thu, 1 Aug 2019 08:33:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v4 12/54] configure: add --enable-plugins
 (MOVE TO END)
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
Cc: bobby.prani@gmail.com, cota@braap.org, aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> This adds the basic boilerplate feature enable option for the build.
> We shall expand it later.
> 
> XXX: currently this patch is included at the start of development to
> aid with incremental building. It should be moved to the end once the
> plugins are feature complete.
> 
> [AJB: split from larger patch]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


