Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9220C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67087206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Go9N0m8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67087206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kED1l-0004o7-Hr
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kED1F-0004NQ-E7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:48:49 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kED1D-0006Gu-Mc
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:48:49 -0400
Received: by mail-ej1-x644.google.com with SMTP id e23so8996288eja.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dPec95zuR/HwypauuMTN4RUEHK0c0bPqm/uHe/H0QFk=;
 b=Go9N0m8Ui302kPnKcsxHm4/I2BsCFJFVxdCOey7KGHfQcNU/kINNZ6Gzk+XqjklKjh
 OYYc9vZdRP/tpL7t3pVZbr4px3wLASMKjqObUCa8huswgf7BYTs0D/J/MZ9VaUDUkIAa
 tBwax1EN3butMpVyOZ4VKgOaMaQBF0dc6tkn0iWfAdY1E5C/CwiA6ZCU4nn8Cow4S/JV
 hX7kiEIP4+fZ9z3Wo3+bl7YVLI3YdONu5+l0bybXjG6zh3ABNRbe1SAPgeL2fzlzYLP0
 WCTl+GhLH5VIdTQ4Wv1Ba6rLTz5kmaKwHdPZvzpg/coNt9FtlVUg4h6CzoeM5m+XbGkz
 RGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dPec95zuR/HwypauuMTN4RUEHK0c0bPqm/uHe/H0QFk=;
 b=NZxRRCEMGMeIP+vT7iKkTCrSdzS6yVLZbqbJ203RqUqNJZJvuMCnJVngIgY/cI/4Sy
 RsE1Ydmt+BPkk36abWWToGLFR5VYXnkaGKD9rTlEEG35M6aAOpZLFl+BGbUh7PaV/oXn
 xtdJayl2zqTEKZsSTT6c/bWsMWa0qOjo2ZMiU4pAfhYu4hvy+QWJRYC2QBugOsije0XW
 3lh2FKOYvsh5FGF2t+R8d+F1SFDbe9LNkfwF32+g6Y8ryFQts+OoEeXdRB0khW6yPleR
 TZsFZJO53OLjNeZZBVmC1Pu7dNNyyeAq3gnOWk3MNy7a6/4bR5G8Jm7cZo4kj+VoAwLT
 jU5A==
X-Gm-Message-State: AOAM532BSrQJK/ERDkNAPoaEzM6dfGZmwebZ0H9Q0m50+9xI6LVq1z2g
 8dK2JQ/oLXLLrwzVNGtmzq1mk/5xQ1sgO99YH97ZxQ==
X-Google-Smtp-Source: ABdhPJwByOj1OO/OE6Izd1x2+oym8ntn16+0eTj25SUylulrzMb5npXttqO/IrglJ4y5eHNQDdcEQaicN5mJhxl/Ik0=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr7520957ejb.407.1599230926129; 
 Fri, 04 Sep 2020 07:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
 <87d0314nmp.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0314nmp.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 15:48:35 +0100
Message-ID: <CAFEAcA9ABUwa_TnyczsO+TtSncX0hHwN7_zgyGGWP6nWtEkdDQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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

On Fri, 4 Sep 2020 at 15:34, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > I'm not sure whether the scripts/qapi code supports telling
> > a consumer of the parsed info about this -- is it sufficient
> > for QAPISchemaGenRSTVisitor to implement the 'visit_include'
> > method, find the path to the included .qapi file from the
> > arguments and call Sphinx's env.notedependency(), or do we
> > need to do something more complicated to get the list of
> > all the included .qapi files ?
>
> Visitors can implement visit_include() to see include directives.
> QAPISchemaModularCVisitor does, to generate #include that mirror the
> source schema.  This is not what your want.

Why not? Surely "see include directives" is exactly what I want?
Any time the QAPI parser opens a file that's different from the
initial one we want to know about it.

> You want visit_module().  The appended hack makes qapi-gen.py spit out
> the modules when it generates types, e.g.:
>
>     $ python3 -B scripts/qapi-gen.py -o scratch tests/qapi-schema/qapi-schema-test.json
>     ### None
>     ### 'qapi-schema-test.json'
>     ### 'include/sub-module.json'
>     ### 'sub-sub-module.json'

What's a "module" here ? Does this still produce output if the
top level .json file includes a sub-json file that doesn't actually
have any contents ? (We still want to generate the dependency
then, so we update the docs if the included file is edited to
add content.)

thanks
-- PMM

