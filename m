Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8EC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D532137B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCN5KekU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D532137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAgE-0001xf-14
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEAfJ-00016p-W2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:18:02 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEAfH-0001t9-9w
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:18:01 -0400
Received: by mail-ed1-x541.google.com with SMTP id i1so5745953edv.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pQoD7ZH/jCVuuSu8wMCYjocRWyq+rsp5S2vxCbNz1BI=;
 b=kCN5KekUFZ6EqUSXQmf5FuQV8TlcBIujt702aD5DbTfiMUbRXRii20PUO+xVJc4i6n
 70J7qq0GNyQVQ6M/eLTjTdGIUYy+Vr5n+ABoVGPJ46rm7ibbN5VDnHcXGNr7Ypwa1WdO
 IBo0XkE42caHVWeINcC8v1cEb2Rp0kuqE0Tpxs55wQMpkY1sbIq61xUfrp5u+6Lz4FcI
 4lDfXy0n334wXYiqD7jAhY0qTjygJQ0VLdVaNHORkDJayB16ew+Y+G0x13IKd8iqMxCd
 1X0ZE32oshhIdNZ3wKop3jRCEpizo1u71KOj0Tvn7U9MPkmlfIqdcROyePwTVL6oyB+8
 fvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pQoD7ZH/jCVuuSu8wMCYjocRWyq+rsp5S2vxCbNz1BI=;
 b=U6MiIgX4f5+jsyJ1yY+N7n/zdxp6744M4JokNo6IabBLO6Z3fe8bdN7dRua0Gcsf2D
 7665DnCxa03q4iHvxk3juz5fsZOatckXcKXDWeQU/imo+sQJK/hpJ+Dp+Qx5TKbXnEgk
 45P4KjOmNanJJ9/RpJ4dha9rJodtXwfZDciMq0CUMJe/9hhrClXIUJvXpDXWcx2/CpRw
 jra7kxQZr6PhoucEBE3Ptcx0Qf7QSQRjn6D1ZqRV7H5BcGBcs94QTABuar/rhWWMziV+
 bLUGOy0eCtGqlR+eFVHyTDvqWSFuX9r2ZLThEzzvn0Ie1aUGv5pGJbXI36aImQAfrdPW
 BQww==
X-Gm-Message-State: AOAM530OGKX2AY5VgYdz45vx1hnJYlVN8P2t85UUcVtHOedAfdE+ZUeB
 +rnHYYd05OMZxKRxIuG6C6SHfJEtlDtC3/eZ9FbrjQ==
X-Google-Smtp-Source: ABdhPJytjNld7iYCz+099jF/T7Ky4apdILNXoMNSAalwlSS9orY3Tcb+YSNQRDYkpVGf9GPwECZ3vLVY45FuzSO7csQ=
X-Received: by 2002:a50:da44:: with SMTP id a4mr8480351edk.36.1599221877011;
 Fri, 04 Sep 2020 05:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-7-peter.maydell@linaro.org>
 <87k0xac68c.fsf@dusky.pond.sub.org>
In-Reply-To: <87k0xac68c.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 13:17:45 +0100
Message-ID: <CAFEAcA8Cntj-ac732Tj1HizGeuCS240h3p5=EeKB01n0_89h1Q@mail.gmail.com>
Subject: Re: [PATCH v5 06/20] tests/qapi/doc-good.json: Prepare for qapi-doc
 Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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

On Fri, 4 Sep 2020 at 09:10, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > doc-good.json tests doc comment parser corner cases.  We're about to
> > largely replace it by a Sphinx extension, which will have different
> > corner cases.  Tweak the test so it passes both with the old parser
> > and the Sphinx extension, by making it match the more restrictive
> > rST syntax:
> >
> >  * in a single list the bullet types must all match
> >  * lists must have leading and following blank lines
> >  * indentation is important
>
> Actually, indentation has always been important, but the conversion to
> rST changes where and how it matters.  Perhaps:
>
>    * the rules on when and where indentation matters differ

The commit message text here is the text you recommended in your
review of v4 of this series...

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00988.html

thanks
-- PMM

