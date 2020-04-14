Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B1C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401C820678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cYvkf2gE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401C820678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOYk-0007Nk-Bx
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOTh-0007iM-2V
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOOTf-0001OC-N4
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:32:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOOTf-0001Nm-Fk
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:31:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id x4so13687673wmj.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GKqExKcqs+QPxwEIDuOuZ/zAfQzKUCe1AzDt+LPzLrA=;
 b=cYvkf2gEO3i9ND3H45zQ3SK1O80rTyVleOiLMlz/B9kWlitqLyUnSTg7ydojHsF0v9
 lEqRYh2HK8txFAZ0pfxOwsEztF6460uuaZV3sC7nAypXHuLzyqwjpf8N3nD6FW+ak6My
 aG8xD29nTmU0C504Cvf4+GqjSNashiWRrtvjoAc/jdPwbnul8L5yb+EsZPq8BqVe81eU
 +f8EkWk7cjTy0jngdESfVbyOTZL18yVY+Ku/kxYrR/xoN57UTijaj6xQyFXd7vRt9ERu
 Dt7hejMf8nHe5VRlnnd48gkl0mk1ox0CKNKTOQh9lRPK3fyDEXWKbVl0k/ZijCGpXQI0
 QdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GKqExKcqs+QPxwEIDuOuZ/zAfQzKUCe1AzDt+LPzLrA=;
 b=MTsinImBryOod20256ZFQ4UAAzXInlGFmp5RGe/BzoJXr1bQxoDec3HBOlF+t60TlZ
 NCoVgmb15vakT+yGU0n4iiGowyegYGTE7fU88yr2q9+xwZVQ2xOveDq4CQ7vLKQmHhXn
 jmVdGXxPnVCepfNMkhVH8+xYIpRPuyUIeYUAPjKTELiv7Erlfd2XvCo9aIZABlYPS7tw
 ZakD5aQKMrZligNa2UPhts59PONXBqLNmgMorzPTlOaBTaW3+bpl8ihx077q59cBus/d
 iSdiB9HAYFMMzqG/noMjuwZsk1iCUUVX1OUsWbCUZz2GcyNYrifXwsmAZSdhHfwIrjHD
 eQyg==
X-Gm-Message-State: AGi0Pub0c2LK+KuJDoVCVUUHZlbC2/XdTe2RKrlwthhjPEXd1E9YNsyO
 ayV9qeLew2Zs5Mtz93P7Y+oTTB/xAHs=
X-Google-Smtp-Source: APiQypJiJukvsjP+RpAE2S5lAjIwKUFZl84o6ICKOhEr7okQ11l1AkYKdoxbVrtyX7UaOIHXRH5uIQ==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr668238wma.26.1586881918372;
 Tue, 14 Apr 2020 09:31:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e5sm20318718wru.92.2020.04.14.09.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:31:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 26BE21FF7E;
 Tue, 14 Apr 2020 17:31:55 +0100 (BST)
References: <20200413162902.7985-1-alex.bennee@linaro.org>
 <c137f5b3-3e93-e497-e2d2-16ced7d2fb42@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] .gitignore: include common build sub-directories
In-reply-to: <c137f5b3-3e93-e497-e2d2-16ced7d2fb42@linaro.org>
Date: Tue, 14 Apr 2020 17:31:55 +0100
Message-ID: <87v9m281vo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/13/20 9:29 AM, Alex Benn=C3=A9e wrote:
>> As out-of-tree builds become more common (or rather building in a
>> subdir) we can add a lot of load to "git ls-files" as it hunts down
>> sub-directories that are irrelevant to the source tree. This is
>> especially annoying if you have a prompt that attempts to summarise
>> the current git status on command completion.
>
> Not a fan.  Why do we encourage putting the build directory in tree anywa=
y?
> IMO any out-of-tree build really should be OUT of tree.
>
> My build directories are always siblings of the source directory in the p=
arent
> directory.


It's not exactly an un-common pattern - especially if you have a lot of
build variants. Keeping them under builds makes it easier to blow the
whole lot away rather than having a messy parent directory which you
have to clean manually.

Personally it also works better with my tooling which can slurp up all
the build directories and present me with a menu of make commands to
build from. That's not a good argument for accepting the patch though.

>
>
> r~


--=20
Alex Benn=C3=A9e

