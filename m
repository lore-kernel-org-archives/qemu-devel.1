Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6F4C35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD33222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcz2Gz9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD33222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05VQ-0000CA-Rd
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j05Ud-0007MY-Rz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j05Uc-0007PF-JO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:24:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j05Uc-0007Oz-EX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:24:30 -0500
Received: by mail-ot1-x343.google.com with SMTP id r27so2469033otc.8
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PdMFk04YuIMEBCPpV2WSBrx3W/zA2MAVIbopgrOtpxA=;
 b=rcz2Gz9OKnn/OWWi3N0bMZV1P3uLbMFd3djMs+kGS9lEcZeHWMVjDAGUt6YsIVZAPG
 EgXpUZaRLD9j25yDtvCdrZTr2NmJWZv8sUvvj81oLOrky2FBVMtpo2o2yx9/oIdeWG97
 pjDyfGEZp/OHF9JZgVkd/2QMlv4SDgEmncl1ZiOUZEde5vtTNL7mapm57V6IE1kcfP4q
 Ss0nwFltjnW7sYERiW2jCgDWAY5J0/rAkG/Qs0ZjyVYcch1KQK75KA86dMF3zB5gkKS2
 FlmrG8NEy++W6g9X4I6Mbog0VSjCLXo0P825YwCKGputnZVN8nPVSsONwHp7PAoQB973
 GJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PdMFk04YuIMEBCPpV2WSBrx3W/zA2MAVIbopgrOtpxA=;
 b=RvF/wW+TW79Zz9SRdnWV6JyhIFnHdXogiPHqcySAu0SHS6TDjw3CUNfdiyCeSyb9CY
 UKiafd1dzF0nBD7Cj26FFqfIA6kgHe5W4GH6SJpT4qDRtVFWSVc0hKMLtQIKN3h1RcnW
 mqpSeQn2H6VCnahTK98diOF4I6aHRKzeNB1SCPorsz3aQqNSJhi6gEPcI6e3bXo2kalp
 iZegwdAi2+DnPHNZKE4KyL6N6Zwfo7/2TLuc98Vpp+nFcMPFiUUxSpC/GbkAqZT6K2zc
 10bfKW5dVAFAVzYrW6N73xLO6A0/WG3GauHvkuqCRsUMKFEP49s82C9xPlzhpC0WO+1A
 mQ/A==
X-Gm-Message-State: APjAAAV4rfUym4EepvZoyVVRSVvfCJvmoW0JG5RF8zkAMGRfI6CFmVJM
 NolvuF8g6BLB1Lvgu7O89pZCbvRyUcmSfcS92tDwWg==
X-Google-Smtp-Source: APXvYqwycBypCovdquTUWiLrZKrbRbEmdnPPcalpMhdOK/wZrUdZ4jlATLsgLNfXefjAoNCIndmOheHYFrl1WhUR6OI=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3141386otd.91.1581089069274; 
 Fri, 07 Feb 2020 07:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-9-peter.maydell@linaro.org>
 <87pnequ4og.fsf@dusky.pond.sub.org>
 <20200207102433.GC6031@linux.fritz.box>
 <CAFEAcA9a8G=RQASBxQGLMBU32w+G7un-xQwOHv4y56W1TQftPQ@mail.gmail.com>
 <87zhdupiem.fsf@dusky.pond.sub.org>
In-Reply-To: <87zhdupiem.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 15:24:18 +0000
Message-ID: <CAFEAcA9sxz0i2MKoaM+9RPp=4MVA8j8EEZ1yDDnCiU3Sn8ggJA@mail.gmail.com>
Subject: Re: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 14:43, Markus Armbruster <armbru@redhat.com> wrote:


> Here's a style I'd dislike less:
>
>     # @file: Node to create the image format on
>     #
>     # @size: Size of the virtual disk in bytes
>     #
>     # @log-size: Log size in bytes, must be a multiple of 1 MB
>     #     (default: 1 MB)
>     #
>     # @block-size: Block size in bytes, must be a multiple of 1 MB and not
>     #     larger than 256 MB (default: automatically choose a block
>     #     size depending on the image size)
>     #
>     # @subformat: vhdx subformat (default: dynamic)
>     #
>     # @block-state-zero: Force use of payload blocks of type 'ZERO'.
>     #     Non-standard, but default.  Do not set to 'off' when using
>     #     'qemu-img convert' with subformat=dynamic.

The problem with this one is that there's no way for the
doc-comment parser to know how far lines 2,3... are
supposed to be indented. Unlike the block-quote issue, this
is a real problem, because it's not possible to distinguish:

# @foo: - Here's a bulleted list
#         Line 2 of the list item should indent to match the first
# @bar: - A one item list
#       A line not in the list

which is the kind of thing that will show up in real-world
usage. (Unless you wanted to say "always 4-space indent" or something,
which I think would tend to result in a lot of accidental
over-indentation and unintended blockquotes in the output.)

> Or maybe even
>
>     # @file:
>     # Node to create the image format on
>     #
>     # @size:
>     # Size of the virtual disk in bytes
>     #
>     # @log-size:
>     # Log size in bytes, must be a multiple of 1 MB (default: 1 MB)
>     #
>     # @block-size:
>     # Block size in bytes, must be a multiple of 1 MB and not larger
>     # than 256 MB (default: automatically choose a block size depending
>     # on the image size)
>     #
>     # @subformat:
>     # vhdx subformat (default: dynamic)
>     #
>     # @block-state-zero:
>     # Force use of payload blocks of type 'ZERO'.  Non-standard, but
>     # default.  Do not set to 'off' when using 'qemu-img convert' with
>     # subformat=dynamic.

Conveniently this patchset already supports this format :-)
You can write either

# @foo: bar
#       baz
#         indented

or
# @foo:
# bar
# baz
#   indented

and they'll come out to the same thing (the parser.py code
sends the same doc strings to the rST visitor).

thanks
-- PMM

