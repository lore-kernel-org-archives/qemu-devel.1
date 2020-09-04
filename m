Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2E4C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA6C20770
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWZsdoDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA6C20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kED5g-0007Aa-0g
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kED59-0006iQ-PM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:52:51 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kED58-0006nM-2Y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:52:51 -0400
Received: by mail-ej1-x642.google.com with SMTP id i22so8992194eja.5
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TKh0f3vnw+aCa5uY7X5FI7UVEFpPDQk8VQhVsRxxvVI=;
 b=LWZsdoDCY7NsufQMfmA/H5nPS9ivrK9EybBheDxK3RhqucViPcs8LRLQ6U+90a3WBE
 eO2XywZQSn8mND6KEgRlBi/E/RjE8SlA6trC2wGlVTvIew0PV4xx4l4DmPkoOxRN3QLB
 jpI5n+o6f5lrcwt4lDSn7oJF52nregmOv8I+Z5m4aJ9AAp+OcyhH3BCzrU0kbciOcOO6
 wL19UpYqYQUl/dSZ9+HykKJSctAjRBQ2dBYCbvgYqdx3iTBkLoi2/qU/+58AdGVn0DnJ
 oDL0/XCkDgL9aqZknmXqI6VTboVo7ipg+cx/J1r/x7JD5vQ8T+8IHsNGVu3V+GEcID7P
 7xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TKh0f3vnw+aCa5uY7X5FI7UVEFpPDQk8VQhVsRxxvVI=;
 b=QESOkmcNGkmRlGkkog+TtSsxH5esIyrFoQvgECu01eybdIarWLX1uz44IaVUWAae4C
 lzJ+GyK1z2gbFl4OS3XLlc4jLztuFu7U8N/oSrvkcxnxk114mjD45UMLOvzUTvGv7RcA
 VnZhx8ev7HsgPLWX1ESkZmh50IIYRFTGX0Kxp3mEeySPuRk39ixXkvYKSkIg+gd+TMVu
 kEaJ6nUzJ24dAerFB7V08AfEBLSbZcRPRALRmrmv0x7UKhzNJlU0TA4FvzMtKJ7ujJ82
 Cle4tA3QPQOXFUnETCgh0GB/tyBJX807/mq17FJe9TI3wNB0Ppd+Xlmmm4/wCIcq8Xu5
 U/qQ==
X-Gm-Message-State: AOAM533MTGrO8ObnhFup7O3O8/HKj2gbtjhmBue1v8oKFeMAPwAf3+Ii
 C1nbQaRFM3xX5feRInxsofkP+0USC7YrqhV44hyuiw==
X-Google-Smtp-Source: ABdhPJw+V/IhSrNurXeQSfmb/ySwtWcCjWzkaAjn9PK3XQxDwmGaEOfe8hjn0oWxHnMUPi9lox7DD38EaxNg97pR0ic=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr7538769ejb.407.1599231168293; 
 Fri, 04 Sep 2020 07:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <87eenh38lp.fsf@dusky.pond.sub.org>
In-Reply-To: <87eenh38lp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 15:52:37 +0100
Message-ID: <CAFEAcA-sc2QyzCNjAR7ZnYzdDUDm=U-eY7qtGDtXeTVg5yXe=Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 15:44, Markus Armbruster <armbru@redhat.com> wrote:
>
> $ pycodestyle docs/sphinx/qapidoc.py
> docs/sphinx/qapidoc.py:42:1: E302 expected 2 blank lines, found 1
> docs/sphinx/qapidoc.py:50:1: E302 expected 2 blank lines, found 1
> docs/sphinx/qapidoc.py:74:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:388:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:391:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:430:1: E302 expected 2 blank lines, found 1
> docs/sphinx/qapidoc.py:489:80: E501 line too long (80 > 79 characters)
> docs/sphinx/qapidoc.py:495:1: E302 expected 2 blank lines, found 1

Those seem like easy fixes.

> $ PYTHONPATH=scripts pylint docs/sphinx/qapidoc.py
> ************* Module qapidoc
> docs/sphinx/qapidoc.py:36:4: E0611: No name 'AutodocReporter' in module 'sphinx.ext.autodoc' (no-name-in-module)
> docs/sphinx/qapidoc.py:45:10: R1708: Do not raise StopIteration in generator, use return statement instead (stop-iteration-return)
> docs/sphinx/qapidoc.py:104:4: R0201: Method could be a function (no-self-use)
> docs/sphinx/qapidoc.py:253:4: R0201: Method could be a function (no-self-use)
> docs/sphinx/qapidoc.py:34:4: C0412: Imports from package sphinx are not grouped (ungrouped-imports)
>
> ------------------------------------------------------------------
> Your code has been rated at 9.64/10 (previous run: 8.85/10, +0.79)
>
> Use your judgement.

I'm pretty sure I remember running this or something with very
similar output at some point. IIRC they're mostly largely
unavoidable (in particular 1 and 5 are not satisfiable because
we're trying to handle multiple versions of Sphinx which present
different sets of importable symbols.)

thanks
-- PMM

