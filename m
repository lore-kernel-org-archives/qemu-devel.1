Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA92BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8F720748
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6VIfj8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8F720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKaG-0000CM-0w
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 14:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKZP-0008CJ-BX
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:49:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKZL-0001St-PE
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:49:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id h13so6642504otr.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1JS4km9SBlEnJT4zeza3ZxTcviOU4eLTpqow9LADA/I=;
 b=x6VIfj8+5yYMkvVYWUq+gJm8PAjz3gtrna5BA19TWFLQPcsTCV5K5DwqkKSFUrG27i
 XUa78+WFgWzT9sphMacnMgDn6hzUCg3n2lCOYrwzjX0N93HwL+0ydUl5URScDv+vxlBZ
 GAUdH92hEiAZ7eBSaQ5B88FfDoSierPeC2vEh70oYnWiKqgm4tdkvGRTuRyc3yHjludw
 bKZ+RkOcJ8qVNkdd25VSCHs8udLukIIejErl2PNiMhYZwXnHNe6CGRZE2wc6+ZBuAJvF
 9zRtv9BLog4EQ6eP65RDIXGX4ebnssHQEdnMAKBDjy3St0kboraEuaSN/C3RlBO4G6l9
 L7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1JS4km9SBlEnJT4zeza3ZxTcviOU4eLTpqow9LADA/I=;
 b=f8EmarStPVMcx/gHBxs+wXyXM4R6Du/twCKXhiNV25Qotltncbyvx64Uos9pQ+X1cM
 vK4ZAM2pKS88cCKwzRZzW86WAcztSvh3UNDTSUkRsXYod6wTXv5TMpgbajixOQBCvWJ9
 J6T+YS7C0jc2/7RUNys4hGxV7y5wwR5Yc0EuU/HkGZC5Jwfl7Mv1O4NHsu2+wkFYU0hS
 wZSwXZi+wDYSpQHJRe63GPxkDKDLmR+lOZAkBP7RfydSgMg7zOrVnI7njgXllpmuElI8
 S6pNeAx8mQBVRBM0abu/Pgbr86JlIJR7jje9yQKbSeFI37vz0Z0y8khR+T9J9YCiYVI1
 Vb4A==
X-Gm-Message-State: AOAM531/E+5+lUi1cd4mn84z5a6sWyv/CzGNRbCz8/7jICtk0qCjICN1
 yoCQpKXDg3p06yNAy5jvFs7Q7PxePu4DCNOkXwxV0w==
X-Google-Smtp-Source: ABdhPJzoaEpbt2n05eE2tUh1jGpdxwjmLG7coouBkDalUnLXIgRXSm69kqMQBCqcUrdpCfqbEseCS26ibCsJreM7RKo=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr60553740ota.91.1594493390331; 
 Sat, 11 Jul 2020 11:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200710233433.19729-1-wentong.wu@intel.com>
In-Reply-To: <20200710233433.19729-1-wentong.wu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Jul 2020 19:49:39 +0100
Message-ID: <CAFEAcA9BfSCUi_LyCkvT7+V1cfhWgbUe2X9du0j-KnUf2bswnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/nios2: add DISAS_NORETURN case for nothing
 more to generate
To: Wentong Wu <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Chris Wulff <crwulff@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 16:46, Wentong Wu <wentong.wu@intel.com> wrote:
>
> Add DISAS_NORETURN case for nothing more to generate because at runtime
> execution will never return from some helper call. And at the same time
> replace DISAS_UPDATE in t_gen_helper_raise_exception and gen_exception
> with the newly added DISAS_NORETURN.
>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>

Hi; I'm going to pick these up and get them into master.

A couple of notes below for if you plan to submit more
patches to QEMU in future: these are really just minor
workflow things, but they do help make our lives easier
in getting code submissions into the tree.

If people provide you with a Reviewed-by: tag for a patch,
and you don't change it when you send out an updated
version, it's helpful if you include that tag in the commit
message of the revised version you send out. This saves
people having to remember whether they'd reviewed something
or not, and means that when applying I don't have to go
back and look at old versions to see who reviewed what.

Patch series are much easier for our tooling to deal
with if you send them out with a cover letter email
(a 0/n email which all the other emails are followups to;
git format-patch has a '--cover-letter' option which will
do the right thing here).

We document this kind of workflow stuff here:
https://wiki.qemu.org/Contribute/SubmitAPatch

thanks
-- PMM

