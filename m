Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74730C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0780523600
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNfMrzfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0780523600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgni-0008Ei-Ow
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKgmd-0007Mn-D2
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:48:33 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKgmZ-0002gz-8V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:48:30 -0400
Received: by mail-ed1-x541.google.com with SMTP id b12so15796214edz.11
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hP/DruU+mByH4uX7BoWUw+pj+pPhyF5aKpARooI59iw=;
 b=iNfMrzfCDR+LvkW9sYkezaDGwY+CvqFkU13MrKRsyBXoOEpSxTlof1EiZA3yqfv9aP
 dthjAkjyiINQM3eN4UPYIdj1zDm1EuFiVqRsuZwXG+tRxhDdpOV2WN1bcOAC8yWtPNP/
 UxSDcdcjvfzs2OIMWXOGbTP1qOmnsTzaLS7OklOJbp+ZfXeH4+RQ70wQFs5HZPY5BKxJ
 8BIR5no3iQQ97q3lNfxumFglaChNf90OfBkASATYf4CqySY4p4xcG/gO6J3V8eWJyvMb
 7TKIETa23YlT8pokA9E5e1UBiY3XIPRmpHvV7ijxlqznSVSl/iqqFupuVbWUkBkg5TPm
 pa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hP/DruU+mByH4uX7BoWUw+pj+pPhyF5aKpARooI59iw=;
 b=N5X0bDt4l7PrWpVZSuSSIDnROgwO0bR1duzGknUDSWJdo85kYF2/W3fX/lde1tTx9j
 FHspxnieEEuNS2xb/fVJt1E++8R+2qbD19f1cWA+kha35Z9Qoqjnqo5feXcyFK2J7dcp
 tYxYPR85HinTUFjNGAqKv3gIQ3t/UiEIv68/1cM0/fssBdgTxk8ip0tcSIzdkOFrg0wT
 iinh/5zRImTHnVrbCcKbhdT8nYEB17Li244WT49HlansixUinf6CuQ9ZSXH0ef8Z1Ai+
 9D2tQ5SDbcO1BKNdDwAvbRHpakJLsQ9wCDwzzL6hvCuQ4mxGBujkHnRcsANfQN+2oeji
 A0pw==
X-Gm-Message-State: AOAM530y3UnT8jgMkfh8sy0oDBrtaz+68g1ViqGcSJbepYWcNg9ergvt
 0VlREaTZjpA1+j1bTxV73nBrryLlscA7JICYs/0t8A==
X-Google-Smtp-Source: ABdhPJxS0eC2nJzDLuV8/vRBn4SjshlsY0XBUdI7uJI3tUI2/bkMkNO5Wo7SASyWoOeDc6Xg1frQ6Fs94HC+6G5Nd3Q=
X-Received: by 2002:a50:f1cf:: with SMTP id y15mr3512153edl.204.1600775304634; 
 Tue, 22 Sep 2020 04:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-9-peter.maydell@linaro.org>
 <87wo19c3rr.fsf@dusky.pond.sub.org>
 <CAFEAcA_LEKRON2EUUCfXoAXmTGQSrqvFG_waBf1S-tsn8fJ6bA@mail.gmail.com>
 <87o8lytgoh.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8lytgoh.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 12:48:13 +0100
Message-ID: <CAFEAcA8+aPwyZEu8k8XL7F6eWvdhdP1ZZpv+6ZZXZr5vH4Lfzw@mail.gmail.com>
Subject: Re: [PATCH v5 08/20] scripts/qapi/parser.py: improve doc comment
 indent handling
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

On Tue, 22 Sep 2020 at 08:27, Markus Armbruster <armbru@redhat.com> wrote:
> How does
>
>   @foo:  bar
>          baz
>   @frob: gnu
>          gnat
>
> behave?

The rST fragments would be:

 bar
 baz

gnu
gnat

So you get what rST does with that. We do actually have examples
of this in the existing QAPI doc comments. It ends up treating it
as a definition list where the term is 'bar' and the
definition is 'baz' (which I don't entirely understand, I was
expecting a block-quote). That renders sufficiently close to correct
that I hadn't noticed it.

It would be a fairly small change to determine the indent level by
looking for the first non-ws character on line 1 after the colon.
Since we have a fair amount of this style in the code and it's
as you say a natural-seeming thing to write that seems the best
thing. (If you really wanted to start the option documentation with
some rST that required an initial indent, probably because you're
writing a literal-text Examples section, then you'd need to use the
"nothing after the : on line 1, rST fragment begins on line 2 in
column 0" style. Which would be the most natural way to write
that literal text anyway.)

I guess at this point I'll potentially create work for myself
by drawing your attention to the rST syntax for field lists
and option lists:
https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#field-lists
which are kind of similar to what we're doing with @foo: stuff
markup, and which handle indentation like this:

:Hello: This field has a short field name, so aligning the field
        body with the first line is feasible.

:Number-of-African-swallows-required-to-carry-a-coconut: It would
    be very difficult to align the field body with the left edge
    of the first line. It may even be preferable not to begin the
    body on the same line as the marker.

The differences to what I have implemented in this series are:
 * indent of lines 2+ is determined by the indent of line 2, not 1
 * lines 2+ must be indented, so anything that currently uses
   "no indent, start in column 0" would need indenting. (This would
   be a lot of change to our current docs text.)
 * it doesn't say in the spec, but I guess that spaces between
   the colon and start of line 1 text are not significant.

The advantage would be a bit more consistency with rST syntax
otherwise; the disadvantage is that we have a *lot* of text
that uses the "start in column 0" format, like this:

# @QCryptoBlockOptionsBase:
#
# The common options that apply to all full disk
# encryption formats

and we'd need to reindent it all. My view is that trying to
look more like rST indent isn't sufficiently useful to be
worth having to change all that.

> This is something people may actually write.

Indeed, they have :-)

thanks
-- PMM

