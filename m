Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE95C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D9B208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQZ1GzqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D9B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyCgA-0002YS-M5
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyCfW-00027y-OO
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyCfV-000057-O3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:07:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyCfV-0008WV-J6
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:07:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id g17so3917281otl.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 03:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=8soe89XEknHJKTwe5ivdGcOcgmYp/kGew91S/WhCp8I=;
 b=MQZ1GzqJmtwOdd9QUju6BR3LImZRoPBhUV6PfyCHptaD0oiEqULUjFDzUaEMzB1Roq
 QV/lLwsUiW8UWvMkXMiKsMpjqC5PuqOYXE0XbV74vD0EuEHFZ+UoDLuZeSUp/9fvyI1p
 plvPIti0TXzZLPsPLwNc27HxnAGTLPmpM8UbbLh1da7dodKJWcaFzKUyz/F8ruF4+7kn
 2JLajFThB+pSaAZ10Mfhcp7ZWuWBybxHwCMExumRmDjl5ent2nJ9MVRm8InwOzd2L/LA
 rLbQrVxZUT7R4j4B8oEG3LsRJC6Xqx1Qfm2Tg+F9dKGtlQTXP7ZbAn9gTc5XWrpW52El
 clhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=8soe89XEknHJKTwe5ivdGcOcgmYp/kGew91S/WhCp8I=;
 b=JWU4HT6uvLKn2WAU8RXh4uIEETN7SwhXTtmANI+JauByGp6HCBi8hfv6802+BNfEzD
 mld5lXz4AkD9cZMUmgWQiehRKXrYxf4byjXWGblDWlUh0fDfJ0EjBvDyOJYAvl9vQSg2
 pbv4rnh0tp09ZxcL+lDryqlA//dZhdmagneavLj1f88x5TuXiwJFqt6djlD98ca5p6UJ
 g93tTaDUjuUcRTEY84xvEzEe0kE7R9fqaqw6LtA2qOiIbPthKaBixzttY5g3UUBN8x8L
 vy36jLZk35OwlI/q9Ioeo5SpAw7+zQzo27Tc62R+F93AlqMsftaE7pcRSbh0hava0m0r
 FN6Q==
X-Gm-Message-State: APjAAAXokajEZDEkJdtoJyjCIEazOmhcSGDZsh/310KzoNDuB9mY978N
 zHI5xqmFSO+Rx13m0wRjnPru8pMWD6LHIJBQkBw=
X-Google-Smtp-Source: APXvYqxDNTaAh/Gy+8zfifjrYPeREY3ZnJzAKP8+W9k+Km7smCbYBNxztD0ubdlmNMqhYRwncHgsDIEsl9TsICeiF24=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr2580088oti.121.1565863660658; 
 Thu, 15 Aug 2019 03:07:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 03:07:40
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 03:07:40
 -0700 (PDT)
In-Reply-To: <9240f24b-3f3c-531c-5c7d-06f359c26fd1@linaro.org>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-47-jan.bobek@gmail.com>
 <CAL1e-=gZF1+=Gduqm4TwS0p-G6rvb4q+rw+hL9nzAz3P-r3+BQ@mail.gmail.com>
 <9240f24b-3f3c-531c-5c7d-06f359c26fd1@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 12:07:40 +0200
Message-ID: <CAL1e-=g8X+BOJfj=pwc3MbrfL_b1QbJ4uha8CikKs=z4wegchA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v3 46/46] target/i386: introduce SSE3
 instructions to sse-opcode.inc.h
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.08.2019. 11.55, "Richard Henderson" <richard.henderson@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 8/15/19 8:02 AM, Aleksandar Markovic wrote:
> > A question for you: What about FISTTP, MONITOR, MWAIT, that belong to
SSE3, but
> > are not mentioned in this patch?
> >
>
> They are also not vector instructions, which is the subject of this patch
set.
>

The subject of the patch and the patch set says "SSE3", not "vector", read
it again.

>
> r~
