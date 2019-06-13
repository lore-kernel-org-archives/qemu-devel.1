Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DE3C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 04:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B478E20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 04:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFCAMsng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B478E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbHIv-0006Ec-JJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 00:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbHHZ-0005lA-Dl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbHHY-0005dV-GJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:24:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:37003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbHHY-0005cV-79
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 00:24:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 19so10128085pfa.4
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 21:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:references:to:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ML1v/FYXJz55enQMtNsVukm4MhK9Q8YP2raly4UUy5M=;
 b=zFCAMsngCgc8XQwIOaOElnfJs4k/EzBR7zF/CVF7OcgW3LZaUdrSQ/6MquiGOT4CLT
 NJHXJmjs/pAa53XoUsjDjJUSJP/VBp9aeyN76gBbLApOEyd7WcLFfGsfjdRRxpwIo63B
 Y/07Y+9Aux3+eezUSn18AqzbZY57Sa3SgqOcG2f/t2sEPJlsD0xA4QizjUBxKmHStCet
 KdlRnw5ker8kZohTVLaq8d2sioW+FaLeoLLvjdkdY+ONipquVDIP62wJpqerPLHEx9CH
 fajS3WU/eS+Qy1MUDpuGr3jdG0sCAJaH5qNcg1VmnckaWERoC0jdqOiDyE9wx7AsaSi4
 Y6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:references:to:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ML1v/FYXJz55enQMtNsVukm4MhK9Q8YP2raly4UUy5M=;
 b=CZwwgldnCpgtA0+o85L2QmtcfUO3UlEjL3PhOI56MPmNcWhznaY//3Qnf+6E9axNHS
 9wC+r8UzbvyAFdT0lLr7ECYCST73GESwxRLMEU+4vld3vAe9LSX4uEdOhUXNB6L97wLC
 tuEqr9YhcRkci+wpjitDEV1f3HeGZ1mfW4+nKyjnnAs5yAu0sboAUYrTbumnjGelhD+z
 8AC6okbml+hGOu8nvOtg8oPHOnA5ytLI6hXZeQOjiltEBFgUz/6q1E5tGgdeCn9ReXGN
 8/fcI4BN6xOYVPY8+Du+83zJXR/kCdVtZVJ5lrv0XPBpQ0CTc09VgW7Mt801TPGSJrf0
 NTHg==
X-Gm-Message-State: APjAAAXZuAOQeJoRUmm2JD5xp5/RUnexHHaGtTpRkQQztjDktR0mDz/x
 VW5QF+yM6zMgpA4U8tNa85YLEg==
X-Google-Smtp-Source: APXvYqxGWkVNdkK132qTVmQzPa21O5hAT2Sj3xvd1mQYtW7ki05+43Yw/X+HJiN22RA75z0b7VSECA==
X-Received: by 2002:aa7:9087:: with SMTP id i7mr33184323pfa.40.1560399849920; 
 Wed, 12 Jun 2019 21:24:09 -0700 (PDT)
Received: from [10.1.2.220] (50-247-96-158-static.hfc.comcastbusiness.net.
 [50.247.96.158])
 by smtp.gmail.com with ESMTPSA id k3sm834745pju.27.2019.06.12.21.24.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 21:24:09 -0700 (PDT)
References: <20190613041619.32102-1-richard.henderson@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
X-Forwarded-Message-Id: <20190613041619.32102-1-richard.henderson@linaro.org>
Message-ID: <b03ab821-e6b1-dd8b-5d61-fb6d28018ee4@linaro.org>
Date: Wed, 12 Jun 2019 21:24:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613041619.32102-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PULL 0/1] tcg: queued patch
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

Dang it, forgot the PULL tag.


r~


The following changes since commit a050901d4b40092dc356b59912c6df39e389c7b9:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612' into
staging (2019-06-12 14:43:47 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20190612

for you to fetch changes up to 899f08ad1d1231dbbfa67298413f05ed2679fb02:

  tcg: Fix typos in helper_gvec_sar{8,32,64}v (2019-06-12 21:08:38 -0700)

----------------------------------------------------------------
Fix vector arithmetic right shift helpers.

----------------------------------------------------------------
Richard Henderson (1):
      tcg: Fix typos in helper_gvec_sar{8,32,64}v

 accel/tcg/tcg-runtime-gvec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

