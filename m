Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C97C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72E22076E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKgI69lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72E22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRSb-0002bC-Sl
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKRRj-0001vj-JQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKRRi-0008Qh-9g
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:53:39 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKRRh-0008OY-Tz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 14:53:38 -0400
Received: by mail-ot1-x342.google.com with SMTP id a6so8352812otb.10
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7q3kAl2Xo3H6Gpuy+vZk/Wwly58KQYgVlWD+BzRC/Io=;
 b=PKgI69lRuJKeL96iXoglFGVRioB3OYSA32daM9cUrNwj6eyRcxcNIF1UV67g0WEYBj
 q/X6qzADeVKC4d1V3nJbyYAQF8sscNNUtT1v7Gql3k+kAcWT72dUy3xMjxIBtbfYrB7P
 a481i2LukH4skO6TSg3JxTP9UA9LZFTyg1AvzYg5cwyW5pj5UJYDwIQCU3oKVndDJ5hB
 Io2b8Z6+FxpS++aaYTsptg3gODa+WQlBa0Wa6BjYSHO2rLXyQsA8oHd51g5Tah06KqPN
 stuwl49L7eDGc0/eothnLA5M72MJnrJKYQA/pi99vVg4z3TUgvQKPRTYm3GsCliZGl3h
 Fmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7q3kAl2Xo3H6Gpuy+vZk/Wwly58KQYgVlWD+BzRC/Io=;
 b=DhG/WwwVcW3sYzfdckeEeYDOY6Yb2UvlCifWD9aRd4iLIvuqsnnRFqqxE6OLSGGX+j
 fyz8G+Cfgz8y6jb6q0uAToN1rUNXerXnGGoqHDTyufZ+UlJm6Hp9cGmaQx6jZY+acbOg
 E/MX+R9HoCM4fBqpIlb0zl1Djv4M0WqY6ZsyugrgBW9SRsZqWCWxVT9sGX0oXG7y8CLv
 Bg722vr3I4hgkMIGxDq93pQ2HgotCPGZUNzqGNc4ZBPeXGrLSML0m11+kLmM+g6Dp6wH
 3DLfv3+Q4xrgbOvIQn4A3SXuvRnMAJRTF8oefdd3mTMRMfGhy2212TtQsD5z0dfA7+Sb
 5d2Q==
X-Gm-Message-State: AGi0PuasTNuYGXjRLmSHPZvCS/DONm/bLC0J/EIWp6ftEwIBoEWPCLwH
 cVvcu4qTSgOJvQtQj7MQNZUaynuMvuV3gOxY+RIv4w==
X-Google-Smtp-Source: APiQypJMJMOYsKqzDqjXqvntvphwGQT92i1mT16yIzjaPcoXgl57mmMcv4QOrCmqZp5GgorO595A27HXu9tO4/pmcvQ=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr7814855oth.135.1585940016843; 
 Fri, 03 Apr 2020 11:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200402134721.27863-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 19:53:24 +0100
Message-ID: <CAFEAcA_E9VQSZRoV5rk-QOgj-F_-w-jhBBVb4p8vUx-VY9_-CQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] dma/xlnx-zdma: Bug fixes
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 14:46, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Hi,
>
> This series fixes a couple of bugs we've ran into with some
> proprietary test code and drivers using the Xilinx zDMA.

Thanks; as these are bugfixes I've applied them to target-arm.next
for 5.0. I'd appreciate it if you could take a look at the
endianness bugs I mention in a reply to patch 5 (probably
that is 5.1 work).

-- PMM

