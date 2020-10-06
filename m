Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D699C46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A253B2065C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbRiL+qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A253B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPo8i-0004xa-8n
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPo7U-0004Vg-Et
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:39:16 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPo7S-0006hC-Io
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:39:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id i5so832568edr.5
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WnMXZ9LiXZlCDtSAs+IRKp/0UzLiETkoLDakmzKqVUo=;
 b=JbRiL+qZ/rDjJqhFkaOQ+WBZALjVbZ9xO6s+UMHMB2C6eylTLeCV4zJ7TeYl5HxSw7
 e7VIH6qitAeR/gbA6+Sd7raSRBymxNvbXmlCOcSuzfRBUJQ2l9gkhCaj3AxDlRdZTJny
 Q2wbEIYLXkQ6YvKespqu9zy5gRyLHiatkqmftO9MjeJEO8r2OSYFKUTgqur64WiP6ems
 adA4HTJoABbpyq39neNwnqKD5rHSahKXo93WyeC7/encWjx8CbqF7FGM96iQwy4Jmh41
 t9PvL/Ajc6D+p2Ib4MUJEFijk6iNzruguZowmQBDgeRbkGzfrzgTgXwLnS2NzUcEqJ5C
 PeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WnMXZ9LiXZlCDtSAs+IRKp/0UzLiETkoLDakmzKqVUo=;
 b=STbNnsrVjFn9zQEuBpmHaXv87zn8jwGkNLE5yAc2ZcO25N6O+VwaP//PSaMvIfjZwX
 u007LlynEW1apthuQaXZANeudScdXfcPwz2WDwlugoKVI0+mKa8KQUf7LeRtbIaF92ZD
 Ga/AoFlHrWyK975lGBTXkIJlVcRWkaScBLhiWQa9M8wYow5mwqlvsWlk4uq2UgmuSckF
 LMG/vuhoERuJyAQD1ko/9rGnQfuW5cAkTL7ZoESBgruoza4Yh9WVX8h4g+vFpIYyp0Bj
 Nzt5ALZps9mUiuiiipKDn+/Hws03mkNPQ2FKs/KcgjJUI3OKiOYJwYdoacRGaM60VxVU
 PGaQ==
X-Gm-Message-State: AOAM533qOzseFU7FuVCufqBomwXdheb30iu2IzqtH6x2MSKTidxDpCqm
 NWTjqV5alulEFRl5uIPPhdf5MPv6Gqeh5hkhqjXttw==
X-Google-Smtp-Source: ABdhPJyBZm2IOfXHgBzkmmYvup2gUkQp9CiSzvuGg4pN2WkqTB0t9z6jFLcRZw6edG1Ziuqx93LGeHq42SLNXqUQlx4=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr5934441edq.204.1601995148144; 
 Tue, 06 Oct 2020 07:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
In-Reply-To: <20201006143637.GP7303@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2020 15:38:56 +0100
Message-ID: <CAFEAcA97upqUtasSsg+wxLFvak5rz+t3DBD7zMu4dnwvpw73AQ@mail.gmail.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Oct 2020 at 15:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Tue, Oct 06, 2020 at 03:03:57PM +0100, Peter Maydell wrote:
> > Compile failure on OSX:
> >
> > ../../hw/core/numa.c:429:20: error: format specifies type 'unsigned
> > char' but the argument has type 'int' [-Werror,-Wformat]
> >                    node->level - 1);
> >                    ^~~~~~~~~~~~~~~~
> > /Users/pm215/src/qemu-for-merges/include/qapi/error.h:319:35: note:
> > expanded from macro 'error_setg'
> >                         (fmt), ## __VA_ARGS__)
> >                          ~~~      ^~~~~~~~~~~
> > 1 error generated.
>
> Is there a CI system where this is tested?  I'd like to be able
> to detect this kind of failure before sending pull requests.

Currently this is still my ad-hoc setup. I think there is
some CI that tests OSX compiles, though I have no idea how
individual maintainers set up to use it.

thanks
-- PMM

