Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD423C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7814622CAE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4vvp/Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7814622CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBG3S-0007pN-OY
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBG2k-0006pu-Q9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:26:10 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBG2g-00030U-4i
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:26:10 -0400
Received: by mail-ed1-x544.google.com with SMTP id b2so4568912edw.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n2fvNEvJVFGhZsX82sS8ZfWw/uOHiFyQ1KS69MXpzh8=;
 b=Z4vvp/Qc60g8WBnZPknv34rH8KNUzCXRxyoEmleXWAx0NruznH3l/XkZT0oanAQ+en
 fjXp2m330sPBoUVJrS+LOSYC0jpT/c4usyYE3gCdagO5nluGWhB9P7+hZ8hmv10+6jgM
 4u7BEZtq2OZgQt4VVzEVkGfvFgF8gqgCF/DdW6Sl6bvyKiMLJ5XzG8OmHeXN67gPOCgT
 pmNvbcPspCG9cZkYkJhqndr4z27ZxHeQ37EzkH2JYTYb02Fd3mjfzIwIorwtrLVlev+a
 Oksew+bDjuIjkIx4SkBtmAkcMMVufu6kHhSsYEd44+gjkRl/J1eUjAckA1hT90CrsZah
 UBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n2fvNEvJVFGhZsX82sS8ZfWw/uOHiFyQ1KS69MXpzh8=;
 b=COYefMl7jTwb+mm28Uk8Pz0HRR//Q5x0i6ENefpuvI56OYWOCfLVjHu1E4DqkocIUR
 ZhYtzPCVN4wPLnXc9CR4GUNCZgJDAxSPOFRM+gDO0hzSjpnRSijWlkriG4iWtKHgCe4T
 NHEpBlULVdI3JgvDcnXH/UX+zCFnRjt9s1j8eJFpjPwMSj8L3yuJIDvS1Qa/3PjLbMmC
 4IA676nTw4iH/dIn98/nuXQsorH1DNIHlF4rSIx6ft82KWNlLGGskpte4Iv3ugKOVND5
 5cLcGtCi6qHwulaqhrEFk4IWsNg2QSMk9RskFT9VhbufZVEf2wfRJYALFWFiFzFLIjj1
 XLUw==
X-Gm-Message-State: AOAM530tgtHbyRMLXHv+QECgrqrZeIVXUbqu4Mvu0n6jyU6RJVSLzNfS
 yiIwesp9HO3KbZQdY2Fiei2Qe2P13oPu/2rq/FGZDKbA2C5mfg==
X-Google-Smtp-Source: ABdhPJxKjptkjbdqkM5eTceZOSFgDF34nV4pN/i49JS/Hd7eTpw60juot2m4LKLKhXOMfyvEgKoGWxrAww9rIs8+HSM=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr5431833eds.251.1598527564134; 
 Thu, 27 Aug 2020 04:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 12:25:53 +0100
Message-ID: <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 20:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> This series switches all our QAPI doc comments over from
> texinfo format to rST. It then removes all the texinfo
> machinery, because this was the last user of texinfo.
>
> This is largely just a rebase of patchset v4 to current master.

> There are a few things I have left out of this initial series:

I realized there is something I forgot to add to this "left out" list:

Sphinx needs to know what all the input files which go into
a document are, as it builds up dependencies to tell it whether
to rebuild the output or not. The docs/sphinx/qapidoc.py
plugin adds such a dependency on the file that the .rst
docs reference (eg qapi/qapi-schema.json) but it does not
have a mechanism for adding dependencies when that .json
file uses an 'include' to pull in other .json files.

I'm not sure whether the scripts/qapi code supports telling
a consumer of the parsed info about this -- is it sufficient
for QAPISchemaGenRSTVisitor to implement the 'visit_include'
method, find the path to the included .qapi file from the
arguments and call Sphinx's env.notedependency(), or do we
need to do something more complicated to get the list of
all the included .qapi files ?

thanks
-- PMM

