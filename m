Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1F2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBE822BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1eoH8/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBE822BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DN2-0000xy-2I
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DMM-0000WP-Gd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:21:26 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DMK-0001jE-Ol
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:21:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id l204so9981646oib.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BeVFloIUjm+PtBPbO4gCy7YKNPHnplcnr35EzlWw88E=;
 b=O1eoH8/Gfsu9doAuQ5MzjUx8c4qPsb52pUfI0MhyReKQ5wqVE/RJxRjDbHYzl1DoYA
 cWG1jUEFdnWviBqGPXuTw3wWiOHuSZzmGYYGzSXgMpg5mW+4FbifSbDHbS0UD6xNlJVf
 pr7hrZOLX2Uv/1gOjpzwnlRvyVqNz+Nt4oAQdvLw8TIKCaeq09BPCx0xngOxTxN0328G
 pVEAUjnA303dPqPo4Pvpe1mkIz8MdUTrY9r8pBB+vlJ/cHzuj8TPECGPtCcs2OC2HF0d
 etKsGMk18UxhvXJtMUt0N8b292hX1FGvCZ6Yxx5YgKqdRUXl5pj7wmrkyNi3/hlGF1vm
 uxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BeVFloIUjm+PtBPbO4gCy7YKNPHnplcnr35EzlWw88E=;
 b=N1yx06ntJaKVE2KPcUzALsf9LufloyBfTWyXidUSkPVX3nT1y1TD8bvHIArjXvcldy
 aiCxDXmh3x5vVR/cGDcIxZfT+wrM1H4i4DMMwd1ssrAZv2Qg+lCk2H78AfjZPpzolgc6
 rzjrEK53EfP1UqgRFQlIPP8AyrkbgqhdQhiFShLd/xoNxpCJPObG3CSZPSt6cAn5Jcve
 UvAAVuY/WuFWA1rdDkzRrgm3hUsFExMpjMn3A5LhA9mcomqAHJk9DB4a1MFvwkkbmQzn
 PXOYTgPJ5QQLUKC2doGrMj5Vl0+7/CxdRDdNroRnjui2nmmM7wJxABk77BldSVAFt6bJ
 w1yw==
X-Gm-Message-State: AOAM533DIa7+NdK+TFVO2omy02Sdd/jxP72K+Mjkv7Vav1fjJthGK5eP
 4Vodap3Sz7qNKo01C5LyGpn2s/z6264pN8f1wKkJuw==
X-Google-Smtp-Source: ABdhPJwWtXGL5pJaXpjxDfq0GdlR1CzMSexR+aYIe5yClyGkglSERXhRAe0+cp6+UpWnzlZT1fkHAA68hz3AVGeOwsY=
X-Received: by 2002:aca:5703:: with SMTP id l3mr613200oib.48.1597087283354;
 Mon, 10 Aug 2020 12:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
 <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
In-Reply-To: <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:21:11 +0100
Message-ID: <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 20:06, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/08/20 20:33, Peter Maydell wrote:
> > Does "build_always_stale: true" do what I guess it does from the
> > name? Does this mean we're discarding the makefile's approach of
> > only running sphinx if it's necessary in favour of always running
> > half a dozen sphinx invocations every build ?
>
> Yes, because the Makefile's approach is not maintainable in my opinion;
> *.rst.inc files were already not included in the Makefile.  I'll look
> into using a Sphinx extension to produce a dependency file.

Yeah, agreed that the makefile approach isn't great. (It lists
some .rst.inc files but we added more without updating the
dependencies, I think.)

If Sphinx can be persuaded to output a dependency file that
would certainly be the nicest approach; I hadn't thought
of trying that.

It would be nice to note in the commit messages where the
conversion has made this kind of "we're going to do it a
different way" design decision rather than just being
a translation of the makefile logic into Meson.

thanks
-- PMM

