Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72734C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EC2208FE
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4gPwCOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EC2208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU39c-0001MS-LT
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 03:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU38d-0000rP-JC
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 03:29:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:41900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU38b-00086F-O7
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 03:29:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id s9so7892571wro.8
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TW7rJE3+xAIPP83N4rgPAAGTYjslWbc9fN7v4fQ3Zvk=;
 b=s4gPwCOT2zEraKJfpx5dbmPkWaYtIOZm+IeycTqIWTeTSP5XSDN+72A6cpVfl1zgAU
 ZBi/IuK0k6FdXx0NkGy0bqN5UU/qFwUIDRh0B4KcMxRirwGy8aPq5R4jO4F0e79Tg1ui
 ZMzjZAzGnzIaCfwCFi5TKl4r3mHovEOXdYG3nDZcX22zqb2FZNeWMKZlRE17UUzCFIy9
 2CQ9g3rJICc49yMaRmv6n7Iif5PYqjydUOo/CxdmS7QYpIYKHlbpgxeIMlT7T0sQQSrj
 FN1yFO92Ew/4BKN25KXEbTGd/Q2U4F9QB4/AYUgqYKT5igqQLcsSym2L3EgkhkPFAA71
 rUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TW7rJE3+xAIPP83N4rgPAAGTYjslWbc9fN7v4fQ3Zvk=;
 b=DwvvIblNPAmYs1i9LiHUmc1ru7sJuRTWHQuEirswCRKJd/0RofOri61aIVNa01u2P4
 g2l6zur9UbnQEvEh7NY1glFIeXdYxoaM12pfjlqXioZr8MCTHbRadLGKWLQ08+nuIFD+
 Tor7UfkHVTL/mcv8aLkRMCTZt0A0fJfx/ROFmeC/OOpcDVuYUV6sSCvfNIY7j3ajs4Vz
 OlneQFdyWxF4DGcS/+jvNpGLYIaYf0EO/kWrMbAPovg/CXmek2bNZHrEeHge7ios7vIl
 dvz5UzJ1hjwBa+uj1sauv6YuVaZedU8/wbqLytLVUUlHl0f2MYAyfmI1onOV+C8VduLT
 HmZg==
X-Gm-Message-State: AOAM531Un9Uat4Bx3VV41WDXWzIATgw9zagghTTApyiO4+OKE23rZdLa
 G3eN8hX666/oYlSWSwM++gg=
X-Google-Smtp-Source: ABdhPJzWAPZzMVyDd42/+Ahw5ppUzqdVBVsowOah9fb7tThJwMPEIcs+7SmzfqCDcZb20x2dECiF8w==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr13339221wrq.236.1603006191974; 
 Sun, 18 Oct 2020 00:29:51 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id r3sm12395960wrm.51.2020.10.18.00.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 00:29:51 -0700 (PDT)
Subject: Re: [PULL 00/34] QAPI patches patches for 2020-10-10
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201010095504.796182-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7f68ee42-dce8-b304-365a-402c5b37147b@amsat.org>
Date: Sun, 18 Oct 2020 09:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 11:54 AM, Markus Armbruster wrote:
> The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:
> 
>    Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)
> 
> are available in the Git repository at:
> 
>    git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-10-10
> 
> for you to fetch changes up to b4c0aa59aff520e2a55edd5fef393058ca6520de:
> 
>    qapi/visit.py: add type hint annotations (2020-10-10 11:37:49 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2020-10-10

The "GCC check-tcg (user)" is 6 min slower since this pull request,
making Travis-CI fails:

https://travis-ci.org/github/qemu/qemu/builds/734773760
https://travis-ci.org/github/qemu/qemu/builds/734983001

Any remote idea what could be the reason?

> ----------------------------------------------------------------
> John Snow (34):
>        docs: repair broken references
>        qapi: modify docstrings to be sphinx-compatible
>        qapi-gen: Separate arg-parsing from generation
>        qapi: move generator entrypoint into package
>        qapi: Prefer explicit relative imports
>        qapi: Remove wildcard includes
>        qapi: enforce import order/styling with isort
>        qapi: delint using flake8
>        qapi: add pylintrc
>        qapi/common.py: Remove python compatibility workaround
>        qapi/common.py: Add indent manager
>        qapi/common.py: delint with pylint
>        qapi/common.py: Replace one-letter 'c' variable
>        qapi/common.py: check with pylint
>        qapi/common.py: add type hint annotations
>        qapi/common.py: Convert comments into docstrings, and elaborate
>        qapi/common.py: move build_params into gen.py
>        qapi: establish mypy type-checking baseline
>        qapi/events.py: add type hint annotations
>        qapi/events.py: Move comments into docstrings
>        qapi/commands.py: Don't re-bind to variable of different type
>        qapi/commands.py: add type hint annotations
>        qapi/source.py: add type hint annotations
>        qapi/source.py: delint with pylint
>        qapi/gen: Make _is_user_module() return bool
>        qapi/gen.py: add type hint annotations
>        qapi/gen.py: Remove unused parameter
>        qapi/gen.py: update write() to be more idiomatic
>        qapi/gen.py: delint with pylint
>        qapi/types.py: add type hint annotations
>        qapi/types.py: remove one-letter variables
>        qapi/visit.py: assert tag_member contains a QAPISchemaEnumType
>        qapi/visit.py: remove unused parameters from gen_visit_object
>        qapi/visit.py: add type hint annotations
> 
>   docs/devel/multi-thread-tcg.rst |   2 +-
>   docs/devel/testing.rst          |   2 +-
>   scripts/qapi-gen.py             |  57 +++----------
>   scripts/qapi/.flake8            |   2 +
>   scripts/qapi/.isort.cfg         |   7 ++
>   scripts/qapi/commands.py        |  90 ++++++++++++++------
>   scripts/qapi/common.py          | 174 +++++++++++++++++++++-----------------
>   scripts/qapi/events.py          |  58 +++++++++----
>   scripts/qapi/expr.py            |   7 +-
>   scripts/qapi/gen.py             | 180 +++++++++++++++++++++++++---------------
>   scripts/qapi/introspect.py      |  16 +++-
>   scripts/qapi/main.py            |  95 +++++++++++++++++++++
>   scripts/qapi/mypy.ini           |  30 +++++++
>   scripts/qapi/parser.py          |   6 +-
>   scripts/qapi/pylintrc           |  70 ++++++++++++++++
>   scripts/qapi/schema.py          |  33 ++++----
>   scripts/qapi/source.py          |  35 +++++---
>   scripts/qapi/types.py           | 125 +++++++++++++++++++---------
>   scripts/qapi/visit.py           | 116 +++++++++++++++++++-------
>   19 files changed, 764 insertions(+), 341 deletions(-)
>   create mode 100644 scripts/qapi/.flake8
>   create mode 100644 scripts/qapi/.isort.cfg
>   create mode 100644 scripts/qapi/main.py
>   create mode 100644 scripts/qapi/mypy.ini
>   create mode 100644 scripts/qapi/pylintrc
> 


