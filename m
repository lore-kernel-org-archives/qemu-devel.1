Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F8C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B504208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 14:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoLyuCGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B504208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQBUs-0002Bl-Hw
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 10:00:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQBT4-0001Cu-7n
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQBT3-0002DQ-CI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:58:14 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:36803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQBT3-0002D8-6H
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:58:13 -0400
Received: by mail-oi1-x233.google.com with SMTP id l203so9394536oia.3
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mQuQbhCJx/wxzqGlXxOF8tUvze3MH1YJgjiTyoIFX2g=;
	b=QoLyuCGcxl4XOcbi/DLwh6vHSUfS/AmvnhwuaeLJOksFnXm8HIUaF+S43QmxUhSsP+
	rTWAFxzBoDeVbiDNLXtyY7ULX2GhsazMoYMNBToTyKJpyOmPtDsXFNWA/SjpfFDTlSL/
	FaHEXeeWKhGdPj/AFksCTZqe14iXiWgORLCorACRPFDOl97+CPaf8SX+bx9E4L09hqBb
	WWrSCiWe3YPH60uQaEStul9TdyNMXlrGei3nWNzu3GR+O2ZeWKJX5zxE2tRe5b+mHa1p
	Felybm3H+cIc2q1Bqh6UZQkTCVRgGOHMsVDPnYAknjOZamVbZl8RS8/G0OGy6pb2KmYU
	hrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mQuQbhCJx/wxzqGlXxOF8tUvze3MH1YJgjiTyoIFX2g=;
	b=MoyPz7WFpk8CpMVwJfOwhLUmUDE6wynCMbJyZMxpOnvCXANy4sybpB85ysAYS+w15/
	NTqC9NJk8pLWdoUHE5TckzJsR4M+u/PIaQd8gN1ElR/WDc6tiaC8QtLDZG1xS7BiXUaM
	cCkSfRQ6SF5KfmrxJbPiQEozoUvdHEtHAq8cRykIUM61JEGb2PZ4GEYbUpzBSZO4bvVz
	Gsq+3dxKBn46SojVHCa6j6eeoWMaIPB7KUVK97WB/7jwYr/qkT0ln39G4eb834LIiDEO
	yR17vtrp+96sIx6zNaoHBrbRwV+RanXO70I42Kh/DMsJ7JHvhbPEriEH4mCXa9GIGtKh
	v8jw==
X-Gm-Message-State: APjAAAWydiMPAoV0TMO5SnqUNQnoKkfZIy5VcQXYyxykfyeR+cEz/TNR
	+uE4dgKAbygg0zvhAcmBQBHttaQkYEnNurM+q/cxiw==
X-Google-Smtp-Source: APXvYqwTAw9DhliEIRGlvB0JH2wfJkLEojB+IdVbnR3CYdB7Gqj0L+iGdX9o6EKxkUQVm/iOYwgIOpjYODYiZTaq0LY=
X-Received: by 2002:aca:5785:: with SMTP id l127mr12555520oib.48.1557755891953;
	Mon, 13 May 2019 06:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
In-Reply-To: <875zqe7b10.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 14:58:00 +0100
Message-ID: <CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com> wrote:
> Perhaps I should do it just for this file while I touch it anyway.  The
> question to ask: should parse_acl_file() obey the locale for whitespace
> recognition?

I vote for "no".

Q: do we document the format of the ACL file anywhere ?

thanks
-- PMM

