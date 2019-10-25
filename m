Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B8CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB66021D81
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urfZz+We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB66021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0EX-0001p4-T1
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO05p-0001Xb-Ec
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO05o-00051b-7p
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:57:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO05o-00050s-0s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:57:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id z11so2431423wro.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KsWG17FeiMUkH9h/+2HrRqD7NubKOg67f5Kra7pm6AQ=;
 b=urfZz+WeiiB5KAFaJDFglpSvfAydEaS2VQuSrn28cUESSEs5DSwdM7atnqdSE/xiXr
 9xt2xWuz0H8bwuGDMRBUgkU/wHBxOnialTXHq+gylEwcTU5ffu0+c6r5t8OkS1jdkBV2
 jg4sd2RTAeHl1CuQDv4tIibiBWR+NLu0zMJwbFPNMnwQB7H7Iz2qgsF2iTZEh0Krl+mt
 tSF/l+/F2JvHXICRQoL6aQO9TaHrq1rHM/070+Qtq00k8Gj8g47okBy8njd0JfnwvChH
 R6+Ew0zaf9e0JBpkdOO3J1GamhR71HQAKd0y5KSMgtor+iTEavp04Pinq0UGWrnn4fEh
 PH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KsWG17FeiMUkH9h/+2HrRqD7NubKOg67f5Kra7pm6AQ=;
 b=ADW8fFq9bUeLIp9Y1wGBIBnF/f0yQ8HQhOqgHQuSezjzhuKWB0DXIsf5qPoDjWP8JU
 CwBnaJZoUq5wTgwabYNVjqIzBPflvCbGvuI/D/BQ1rFMobHjrpjsmdUEQaq9j3jVuP77
 9n6Vv7cUL3i1gk94ywoBPf1wl90zugEMngcdnDP+1fi1Mx2NxEaCA53DbVLksELvUgPk
 Z+POUn87P5nkB13N2W4T7xqNQTviPXspbE/Ylo7iGn4R4QOMzoFYwsyFuz1obmAI4XwI
 cJ3VJTCTHJrODDpHEHP6A/JkR+pfWXFL1grlIG2RcGLv4K9n3BiFkxC2Xl6ARJpJTk3B
 BKdQ==
X-Gm-Message-State: APjAAAWqqkDRlSnxc8tjayJ9QcDjSb+jIxWc+izuvlMMQzLG7BfuWI74
 A7FCrObfnNYJZj9PXDZOdaWRqw==
X-Google-Smtp-Source: APXvYqy1MLqW7fgYCorB5mGTmkIyG0van5AK3oAh2x5RtzK0O+bxeBrgcgGUCAJx/6VdyiCgXp7wnA==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr3095542wrt.21.1572011846604; 
 Fri, 25 Oct 2019 06:57:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm3199447wrg.63.2019.10.25.06.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 06:57:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3AEDF1FF87;
 Fri, 25 Oct 2019 14:57:25 +0100 (BST)
References: <20191023154505.30521-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/7] exec: Improve code for TARGET_PAGE_BITS_VARY
In-reply-to: <20191023154505.30521-1-richard.henderson@linaro.org>
Date: Fri, 25 Oct 2019 14:57:25 +0100
Message-ID: <87zhhpkjwa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Changes since v1:
>   * Replace my patch for TARGET_PAGE_ALIGN with Wei Yang's.
>   * Detect __attribute__((alias)) support in configure.
>     If unsupported, as for Apple Xcode9, use preprocessor trickery.
>     Passes travis build tests for xcode9.
>
> Link for v1:
>   https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04519.html
>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

FWIW POW2_ROUND_UP is a better name than it currently has.

>
> r~
>
>
> Richard Henderson (6):
>   exec: Split out variable page size support to exec-vary.c
>   configure: Detect compiler support for __attribute__((alias))
>   exec: Use const alias for TARGET_PAGE_BITS_VARY
>   exec: Restrict TARGET_PAGE_BITS_VARY assert to CONFIG_DEBUG_TCG
>   exec: Promote TARGET_PAGE_MASK to target_long
>   exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
>
> Wei Yang (1):
>   cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
>
>  Makefile.target        |   2 +-
>  include/exec/cpu-all.h |  33 +++++++++----
>  include/qemu-common.h  |   6 +++
>  exec-vary.c            | 102 +++++++++++++++++++++++++++++++++++++++++
>  exec.c                 |  34 --------------
>  configure              |  19 ++++++++
>  6 files changed, 151 insertions(+), 45 deletions(-)
>  create mode 100644 exec-vary.c


--
Alex Benn=C3=A9e

