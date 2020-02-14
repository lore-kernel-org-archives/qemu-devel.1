Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD21AC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3DA24691
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pk71w4ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3DA24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2den-0007x9-Jg
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2de2-0007Kt-Qw
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2de1-0000Jn-G7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:16:46 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34945)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2de1-0000JJ-Ap
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:16:45 -0500
Received: by mail-ot1-x342.google.com with SMTP id r16so9676335otd.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=enDuBYk9z4aFBsO6SJ/P5g1gBiKiqhTdsUm81V+i3Ik=;
 b=Pk71w4ze2F5paEyAS9Rl65Ebb2MiCGJwOrdGuTwNkofVe0S0Pru1qLhpkdXPdCEIVU
 9R0WQGHA7eQm/yDASqjdvTU3HNZBaRnzGUXIwZy7Ht4kC0P6gNcN612eqDKlsbqHOcxs
 ba5UzXfwBlHghEJebSBszMO6edBeBU9vRhJ1vjvLMw4fP+nEJ9SEtJqc7ty5zBa8dbbV
 tMMGcGgeNlu2zty6DQTXefXitG+tHVvCYnAiimuaqghD17rihhQm6Au47NDhphfG4soc
 rcB7/hojkZlBmqHL1QZAYbuXX9Uz5rM4jP8KQpClUW6dQsKPqKHsx6KL9tl7dklVgJZd
 oyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=enDuBYk9z4aFBsO6SJ/P5g1gBiKiqhTdsUm81V+i3Ik=;
 b=KttZ1U2E1gvSROV2GwOsmp1fOgKvsEOSAwGDEgmb2I+2rupew9EOauFrQ6UzTduXUD
 +L5JiE4SPkbloobylWhdCa61gyKOmVDKx5xgs2js8tSAyCDFPWaOF8Iqz6UwaFdRtD45
 q/QcVwMAhJbnyZsCTE67Z2l8uCoIWoimnBTg1XTCgFp8Tqz/PLT8Irdd3bidTUrPBgrQ
 Taneyhd8lRaYtM/3evilfFWdXWBBXI3qXt9vldL4iKcCJ32nFE3fSuIKYHSSOqayU1Kv
 B3qlBfRUD+tdcMulTZmeQLx/YMoIX7lS1C5idoogEhM0u4ACiwvN3fGUJasDxEOytq2g
 WbSQ==
X-Gm-Message-State: APjAAAVd0vx/k1HL47bXyVQhOQ7XfXIZI4hOuYjQ3ZMHnNq8/Nq7Izms
 Vd1lJe2B3tvZcP4ArpaJzMzSfnsF1gcpZcFfqo4yUw==
X-Google-Smtp-Source: APXvYqweQTeENjzCYB5rRPHJKi9fFMirTlUkLA5o/dp5nDkmBvqWPsBMtFxw2+TtidB1ewGBF1dzM+lWI+TIw0fb+0c=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr2746723otq.97.1581697004439; 
 Fri, 14 Feb 2020 08:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-17-peter.maydell@linaro.org>
 <878sl5tf01.fsf@dusky.pond.sub.org>
 <87wo8pqhqv.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo8pqhqv.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 16:16:33 +0000
Message-ID: <CAFEAcA86Ux9aiagyudmUJC63VvwY79HdGpn23nKDWtCz0S-zXg@mail.gmail.com>
Subject: Re: [PATCH v2 16/30] qapi: Add blank lines before bulleted lists
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 16:02, Markus Armbruster <armbru@redhat.com> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> rST insists on a blank line before and after a bulleted list,
> >> but our texinfo doc generator did not. Add some extra blank
> >> lines in the doc comments so they're acceptable rST input.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Hmm, PATCH 06 appears to do the same, among other things.  Sure you want
> this separate?

Patch 6 is qga/; this is qapi/.

This is again a product of my general preference for more
smaller patches rather than larger patches that touch more
files at once.

thanks
-- PMM

