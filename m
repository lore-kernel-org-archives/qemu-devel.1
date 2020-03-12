Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88272C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E84206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9tkdPB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E84206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCKpB-0005Az-Gp
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 06:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCKod-0004lB-Jq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCKoc-0003pb-9i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:11:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCKoc-0003pR-3l
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:11:46 -0400
Received: by mail-ot1-x343.google.com with SMTP id t28so2896561ott.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYuC/43+aqzczPwvXcevGnLj4Oj3/YRC9kospWvX1+w=;
 b=Z9tkdPB33pytrv+6s/rnlxWeIC46CscIRVgQbET4lETsNjbrobgfkQWPfFiF7P5K9K
 5trtKShxn7Th2RCuIMtzlRrvlK2YtBwZ1WtCsD/2si1+RStLnIrRwo3hXMPX9bS4aA0U
 M2YdzJaQp6q9oV4puJxc6O/Kzjpdchc6y6Smzz69fqxS1AVwpKoDld0DgI61t0/Bs/gl
 OLXL+8i3tuZp56ctiZ33+fQ3EXazvDZmYLg8VaiTnh+MXCCqqO3UPcmJWzrAGP+/r1DC
 PYfmLCbtjcqucER+vrOjxBwK5N8zNuL39cR3vByiI794S7McyVTCkNi8XSgrTjwg0gdC
 E+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYuC/43+aqzczPwvXcevGnLj4Oj3/YRC9kospWvX1+w=;
 b=Y94MIKqP4kMz0g6e066b5dqfH/FSvVvDNtenDLTrS5unxqsZumViq3/E3J+dXxdG11
 Ujrboa4ud+KgykvizxNrtm45OVo8W9kQmDs+9FYZwYNwAe46NyJQE8qcA28pN/Pf+dzf
 YXRCuGpjkUfX30hxIXVT0uwDg70TQJr7x51P7dAfXKwEbtU7NQHRk6oG2tztgODjXOBK
 OrlxcjHX+lhp7L9ed8bY3eequDJ6mdPcLaV+YjcI9OTcrvaqZzfMRJafeA/04VE9u5cM
 /BbB35KmPRnUD+oFUAK06PkeAuZb6CFzrPu/R5tRTCK9phY+Cg+L4HLlAjN2wHKFPwau
 vMMg==
X-Gm-Message-State: ANhLgQ3YeXfFAwA1q3f+yqGrG0pYFFtj3BfyzhXcNwTVYWMaJGahTT9e
 LSILLys0kRwr29fpWyjTgiZNBM9VoSOY1F/7JklL5A==
X-Google-Smtp-Source: ADFU+vupV6/PzE2jYKxiB5K51dc3YU2ImiskaIxiUCxCxMZoXbGM9NJEDCLXrk9/BbaO49/zRfoObfZs12qGVJ3fwG4=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr5720783otl.135.1584007905058; 
 Thu, 12 Mar 2020 03:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-32-peter.maydell@linaro.org>
 <87blp3x7rr.fsf@dusky.pond.sub.org>
 <CAFEAcA9EEuAeKm8kXtSJUtm6F3=VfyMxOkESvrZzoVt87HwKpw@mail.gmail.com>
 <87sgiertt8.fsf@dusky.pond.sub.org>
In-Reply-To: <87sgiertt8.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 10:11:34 +0000
Message-ID: <CAFEAcA9PrO+=pVyh1DR2Xh=apkZAXw0_aF=RxUmG=kR5VOdeDQ@mail.gmail.com>
Subject: Re: [PATCH v3 31/33] docs: Stop building qemu-doc
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 06:06, Markus Armbruster <armbru@redhat.com> wrote:
> Would it be possible to additionally render a complete manual as one
> humongous .html?  Without an index, there's only search, and the
> ergonomics of searching within a single page are so much better.

There is a "build one big fat HTML page" Sphinx builder,
I think. But again, I'm dubious about increasing the number
of supported output formats -- it's all extra makefile complexity
and more things to get right in 'make install' and so on.

PS: assuming you have js enabled, each HTML manual has a js
search engine built in, eg the 'quick search' box at the bottom
of the LHS navigation bar on
https://www.qemu.org/docs/master/system/index.html

> I'm tempted to write a trivial QAPI doc comment backend to spit out
> minimally processed doc comments as one plain text file just for that.

What would be the difference there compared to just looking
at the manpage? The manpages don't have the full content
of all the HTML manuals, but the QAPI reference manpages
will have all the QAPI content.

thanks
-- PMM

