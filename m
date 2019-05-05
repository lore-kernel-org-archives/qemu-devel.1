Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C376EC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BC92054F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbTdMMxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BC92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45705 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNO57-0008IJ-Ak
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 16:49:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hNJib-0005fc-5m
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hNJiR-0000Ib-Gc
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:10:17 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:38509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hNJiR-0000HE-0I
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:10:15 -0400
Received: by mail-qk1-x731.google.com with SMTP id a64so661626qkg.5
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ElNsE6XdCijvMOUmvcuTLIec8SVYrJvuY3ni/VKMXic=;
	b=lbTdMMxvGWXBjrG5zJspWnBXGEHjzcyYGe2+rcH3cuMq1lIHooSfRDPmgn8r5rTxL0
	z0qd07ZR1igfyWXZrNYGaPhXqcxlj3aP60GQRMbfuvesj1LXmIr5WpKHwVjYo0U3Q5g2
	rrsUy5665OTosYENi+cIDZmje6avLRFhSvURn1Aa4Ek35qqb7gSi91SEYlpqdB5RjKc0
	GO9SprnPpHXs6RH9dpPjF5eqVkEHusVZcv8NMgX5jsRCGZYSSO0KdkKnS89fZpF05HDv
	VX+stlWRGwU4ZAy66xnt5Tk0Ys77xSwZWBDNR3h04xnVAAcVlj0C+yJKFipZh9TZjs5S
	9brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ElNsE6XdCijvMOUmvcuTLIec8SVYrJvuY3ni/VKMXic=;
	b=q1ZEO2WJEU1vYDyV/P2n+gl8H1B8ETE9ujTuS4jJYic1ZjcXCXIvAoY3Z5FJPNbdnk
	HzSePdCjbZ2AxavTmAWszM0tVi4ODMyK45u06Vpghd3FnVTd/+axFd5MrPcpvE+ViZRx
	P8UNeMA/zgf0piRSSBCVv/Hz7AH8fM35SF+t7DGBQAk051cpmA8QvhNcROOoJshmq0fX
	G23xv+5qfzh/rfMEkNR6RaVWad7pgTt06Oq86q6w/HFSXOeKoTn6EEMHTHcFuiwgZlyI
	/x6TmWyUG+uMn6W5HTTykdk7j76+gTc42Vv6HYlGu6OxvuAVj5ATIYqkncoDN1iqs7zh
	lbnw==
X-Gm-Message-State: APjAAAVROfVzP+7+DK7WEBsx3bS0ewiSaftb0KjZSKms8CY/Hj+cXx4J
	smsqdNwhaAVEsrxYpPNUS3IwEe6cr+Cc4nc0ymY=
X-Google-Smtp-Source: APXvYqwbRJZnhchWN0mSerag86HKyI1S87NO5upK30p42nx2Wrs8FA8t3/wgIuO7zVUquLyqhZhM7rxkyEvTRo1SiHQ=
X-Received: by 2002:ae9:d881:: with SMTP id
	u123mr16256439qkf.294.1557072613372; 
	Sun, 05 May 2019 09:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
	<c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
In-Reply-To: <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 5 May 2019 09:10:00 -0700
Message-ID:
 <CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::731
X-Mailman-Approved-At: Sun, 05 May 2019 16:48:53 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: E.J.C.Robbins@kent.ac.uk, Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>, A.M.King@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505161000.OO-WbwEosYa3tiIhAWPppS2948kfU-b0D0V5pKsks3o@z>

Hi Richard.

I can maintain it

Sent from my cell phone, please ignore typos

On Sun, May 5, 2019, 8:57 AM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 5/4/19 1:36 AM, Sarah Harris wrote:
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> ...
> >
> > +AVR
> > +M: Michael Rolnik <mrolnik@gmail.com>
> > +S: Odd Fixes
> > +F: target-avr/
> > +F: hw/avr/
> > +
>
> This is not how things work.  Michael wasn't up to maintaining the code 2
> years
> ago; that's why it was never committed.
>
> You would need to maintain this yourself, and for more than "Odd Fixes".
>
>
> r~
>
