Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D720DC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9980A218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 17:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMbz6wSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9980A218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj57D-0000pn-I4
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 13:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj552-0007iJ-8P
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj54z-00011b-MV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:59:31 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:43423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj54z-00010w-9P
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:59:29 -0400
Received: by mail-oi1-x22d.google.com with SMTP id w79so5343882oif.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SRmz2utXvhUSLWe88bsVEOChttydCcdzmeBPO+WDiYM=;
 b=NMbz6wSK0spoMFm6PYDkLlnjhTY2EAostM6ivfELlJnNo4PJrS21kVyfdw21C1pQI9
 gemuvPjU96Q97yUBwsthXAJMybAHTXxFRl0zdHK29h5bImoO4bzSsVDRBaJVL/VqDgUY
 bqzwu1ysWrg4rziRd3oznI5Z+YeYdJ9Tstw0RDexg/HftLepjxW18yAjbi9HLwZb2ekk
 4hzzgDOftBe2xfWq5Jxn65TQk4TFJ5j5zqLTXZ6A1Yg7B+j5S0YM3husQZaOUHWU80Xo
 E7tridHCjsUI3SYIz5qYr8n30R0H0+gIYbt83uiMvhsbadhCvloS8LjLNNGMQBSrIRRH
 PPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SRmz2utXvhUSLWe88bsVEOChttydCcdzmeBPO+WDiYM=;
 b=R35r/OvAAe611NHHGMiz9SIoAU6hWdWEr3QaHtpJCYah14wZCjrBsavwmsXNHFUrpK
 tl7iud5sKHbcJyNTw5DozpsNLtdhEdu1oAH9ECtOj4T5r7E/QIGnvfiimOQAGpzTndzG
 UzlwTFJu7dePsPN9uLUq37U6fjlHQhLehRq55/+6TZ1EEGyhuzA1Nyupp8vZrXlN+3P6
 VofMbvfKRVcyQT09wvXaIQJrDs+Wq0atrMZM8aCcVhbV2pqmva7PjL4Jah3L28MnIsGP
 8x9Not3a22uoO+//AjHqtp8GuAOM5PF85OnpXBo2NW6EsIeHLWetQCjgnzCbHzGDRdi1
 OBHQ==
X-Gm-Message-State: APjAAAV37xo8kDUucNR3sAYz0BGEBnP2I9El/vAY3aoq+Xb8R1FCDMl2
 xSGBsilaMRvIXDQYDR/D6go8D7Sptaq0qZI7QkkKhg==
X-Google-Smtp-Source: APXvYqwUAYGR6dI9Q8Xby9bM29rqKjeWRkCZgGadbBoqU3bRbWSb1cUFu8e4dKYl+VOQ+MV8JiaYktCmTET0MQMey3k=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr334574oic.170.1562259568301; 
 Thu, 04 Jul 2019 09:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190624144740.5338-1-mreitz@redhat.com>
 <20190624144740.5338-7-mreitz@redhat.com>
 <CAFEAcA_jnQj5sUjOiPY5_jaLaWEYVTqKre1TiTVJVBXTaC1vaA@mail.gmail.com>
 <4b210893-e3ac-aa4f-2103-8a183658f483@redhat.com>
In-Reply-To: <4b210893-e3ac-aa4f-2103-8a183658f483@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 17:59:17 +0100
Message-ID: <CAFEAcA9nHvo5U=G044b285TreyvSguKc0NmDikSEe-24=LmW2g@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
Subject: Re: [Qemu-devel] [PULL v2 6/8] vmdk: Add read-only support for
 seSparse snapshots
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 20:46, Max Reitz <mreitz@redhat.com> wrote:
> So it looks to me like Coverity just thinks that *extent may be used
> concurrently.

Or it's just not smart enough to notice that it's assumed
several mutually contradictory things...

>  Short of adding a =E2=80=9Crestrict=E2=80=9D, I don=E2=80=99t know what =
to do
> this but to close the report as a false positive.

OK; I'll mark it a false positive.

thanks
-- PMM

