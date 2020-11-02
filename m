Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97896C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291D02225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lp2L0jim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291D02225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcM6-0008NM-7q
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZcL1-0007WH-JD
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:05:43 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:37962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZcKz-0005aq-OR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:05:43 -0500
Received: by mail-ed1-x52f.google.com with SMTP id k9so14904479edo.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BdRc0MKp9M2pZ8UiNIbA6HMTpI++g+KtanP0NFDkjyU=;
 b=lp2L0jimNTabazECfOg7SojTm0CdHFguQNRzipA6nK1gM4T7DrtGSMNVcIW82D6obp
 h3VTZsa6APTtExzW/RPg2u32CMQ+OvcEhYd8ErLcU9UXT46tV/uJt2zDqk4Dto59NqXV
 UWc/BZrTsPczEJtqO6JAuvSHsc1Js3AwngqeIOaWz3eMt/3CQ31PaTNRfeZ0SXyr1j7v
 slx2fvPDb4XY1ICcsaxfivCgiYun/8B1ZWLDFdNwQ/yNyWx2sKej5IlMpjD9C+Dy2AIa
 jvbOt5lGgffV9QaNn6ExYPEBl0SewuOmfd9WHVun98kcGWqV3c0zYXEGdOY0eV0hOOZ1
 QVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BdRc0MKp9M2pZ8UiNIbA6HMTpI++g+KtanP0NFDkjyU=;
 b=g/nrsQ1phFl/+dnbC28/w72LGCBGj2ZmulbmX/kkRMMzqLFWctRaKl6T/GJ+PPs6P8
 m3kDR9yNaSAMqKYz2KGskXs5y5h92q627Ajy8IqPjqtAzwzgm4MnnLtxsOFwmPQeZDqu
 va7vTev5TsXyEG5HIAZWjmGN45KX1QxspV7x5CkES9vPPYNYKlXtCtLaBIA5rM3uG0ao
 UYXMHXbWuSACvi4Tike+5ZVOjGDl6HrKg9XdU8r8tK9RhZIJPCc5v5vaXT/ilXYdcqZ6
 25yLW8XJAUY6QxrtwlxM8bQPuadgFB7AjdUzp+ZnL2l34IPjp9mr93n+Puu28PgM7xRw
 VG0A==
X-Gm-Message-State: AOAM531EpJzErTk1vc6cFiu1/8U/cCRAOiphIMqjPi2PQO2JKzXxZOu3
 7pKMfZer6FRi68dlAPileV5C9e3NFjNRBcoIKjnUOQ==
X-Google-Smtp-Source: ABdhPJzs959xv4oKWG6n/dXX4Bs2+U/MI7e8ZIMf0GDI7ji3cUAshx7xagL6XW7oIH6ix5PgQ10BTa1EyKGMLUyRGPE=
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr7131653edt.100.1604333140035; 
 Mon, 02 Nov 2020 08:05:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604309512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 16:05:28 +0000
Message-ID: <CAFEAcA9zND6SVH0EQm+wTTCH+-hbGKq5g4BZRaSuNyCGk171nw@mail.gmail.com>
Subject: Re: [PULL v3 00/17] 9p queue (previous 2020-10-30)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 09:48, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 2ab6c494339652e69ec405dc779d83c46c8faf98:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201029-pull-request' into staging (2020-10-31 20:32:56 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201102
>
> for you to fetch changes up to 4d0746e2135f56c59c6e61ef42d700b7139065b4:
>
>   tests/9pfs: add local Tunlinkat hard link test (2020-11-01 19:44:29 +0100)
>
> ----------------------------------------------------------------
> 9pfs: only test case changes this time
>
> * Fix occasional test failures with parallel tests.
>
> * Fix coverity error in test code.
>
> * Avoid error when auto removing test directory if it disappeared
>   for some reason.
>
> * Refactor: Rename functions to make top-level test functions fs_*()
>   easily distinguishable from utility test functions do_*().
>
> * Refactor: Drop unnecessary function arguments in utility test
>   functions.
>
> * More test cases using the 9pfs 'local' filesystem driver backend,
>   namely for the following 9p requests: Tunlinkat, Tlcreate, Tsymlink
>   and Tlink.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

