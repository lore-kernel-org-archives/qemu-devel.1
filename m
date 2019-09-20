Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E13C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 04:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF57320717
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 04:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gZOzeLTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF57320717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBB0B-0000hi-Mg
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 00:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAwO-0006pC-1z
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBArO-0000JF-5a
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:49:34 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBArN-0000Ii-05; Fri, 20 Sep 2019 00:49:33 -0400
Received: by mail-qt1-x842.google.com with SMTP id x4so7196950qtq.8;
 Thu, 19 Sep 2019 21:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Us5aXQGzLrmIIkeQXkb6cvh9sVzCeORLwtOtWfJTk58=;
 b=gZOzeLTlO9EuP5rgy9rBjyb1UwdzmfIIRmSN2AJMp+iH/w2nORcVDfMiHUN/2YkwU5
 nPltxsRVYKUlyq7G1zjriyIHvWbvk33Wpp9SkiL3zIMpAoYkLnY9DrDVgkMEMxlYkGvt
 rpDoqwoVME20DtU8UC0mT0n5tLDNDGv7W4dS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Us5aXQGzLrmIIkeQXkb6cvh9sVzCeORLwtOtWfJTk58=;
 b=Ma5n8c38tqjvTdUMTDkE2eaH6C52EUf60QBmP5HlI05cQJwkqgzmx56xXFR1kDa3e+
 rgeuVXzc4V3nJ960l4A3/sU9sHu7hjqrp+W8I1DTpW7OsHwB9hrNx2He45tpYubi35iy
 3nkXltn2Yp/KGPJMcFW3uvfHEUMSSKKd5HXuS9AlPzjJfU6Z646ijkDj/nKBjmOAmBu4
 /28GqvmTGdB59s+IdbdTWlV44horimYk3Muf6MLWBcesSK0J6sahzrkHtvdh2L8xysjb
 EQV++GPx7z0l3wFk3pmgooJ9+HJCo7ZGlQsYZ7lg+PvjM7pvDMY1PLem4BjFgIb2ZR22
 mg2A==
X-Gm-Message-State: APjAAAWnNTeCEAy02LMAv//D71VtYjbWIswCdhZvZYzdqDcLt7EwNB2E
 81ON5ga2PdOO5j69RAzUoh52yLy/bx39izSAmcU=
X-Google-Smtp-Source: APXvYqyc3tCmuyk/E/uETWZ+y2NXZgYHKnhBkvFlOzSveMIgpp94Fd2GcWIEB9hwYB2QI9fCdUu+XRuwP14SmH7FDb0=
X-Received: by 2002:a0c:a9d3:: with SMTP id c19mr11468897qvb.172.1568954972387; 
 Thu, 19 Sep 2019 21:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-17-clg@kaod.org>
In-Reply-To: <20190919055002.6729-17-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:49:21 +0000
Message-ID: <CACPK8Xe+bDvA2D6eT0ypMBOymkjR2jDdqzEBxiFPEpvL=6nKSQ@mail.gmail.com>
Subject: Re: [PATCH 16/21] aspeed: Introduce an object class per SoC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 05:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> It prepares ground for the AST2600.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

