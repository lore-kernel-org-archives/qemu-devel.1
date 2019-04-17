Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD0BC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 00:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B3F20821
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 00:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="cx3H55bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B3F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGYsI-0000mV-9O
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 20:56:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGYrQ-0000MJ-SP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGYrP-0001n9-VL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:55:36 -0400
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGYrP-0001mW-ON
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 20:55:35 -0400
Received: by mail-it1-x12d.google.com with SMTP id y10so1797069itc.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=+BQ4ulsEbegWudLY6CiTHTPm8mbvLyuYR8uCnW5CktM=;
	b=cx3H55bJ+IyGWKPxu23IUKE5bb2JwOM5y4chwWRCzISprgeUm41BHYpgYPc1iIRvMC
	+3nFnkcw6+eX8NBaiuOoEwtfPVGtgCpiZADSoJu6NWyh2JqGGH24TO7c5rCLXBPcWbZA
	CcuJB1jD+M3IASy2uxFnLmrmqK5MRFWeeQoRtjczZK6gPLtnOPoJxgHrBB54KLqHfvql
	UrBFqjGxRy8iZ1m5ej5pAxgt+mbSfjnbLVAlYRCh2opBa2nk7As24IeXWQmlHxQFNO3l
	hWRbjGcN0UAcZQyYTBxfz3Nges8Rvoz9ev0S2Xee44wAIS839KpGx5LHOeKbv3keAIh5
	EVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=+BQ4ulsEbegWudLY6CiTHTPm8mbvLyuYR8uCnW5CktM=;
	b=JqzsiguC9zrwPgZPdw64pQF5Z9MwZBpumqVK4s/xNyH1giDavQkjVSpqz5XaIJxOXn
	6UuA5jSsE0k3kcRZTFfuy5BGIBx7jMoLkVz1llOoYw+ynMsmwMoMA+NTJ6Mp+PDyv6Ie
	D7IZF+XecuEpz1K1Zt6Ztl+igl/X4Uu6gdSQI1CpEaom+98iCaI+ExS7Bwxii2PvtZJo
	dqtogvxGGQJdMI1T5qNSCInNdQFKrB+Y1BYk1cKG41eQ2OiaYC1Xu7u6Chk0ZefzY+Y3
	L2hbyhjecyTd/fvEtYSuSsJoPuywvteeoAw2vCfavzBtqBZU/754bUw/9GUyh80ymSdj
	jJnA==
X-Gm-Message-State: APjAAAUA529f9Bc9F8zflWoooYKx9cFskcgvhEb9kJog5quYvZHD/5Re
	KndYmh/jF8yWwPspsLVT/ct7tw==
X-Google-Smtp-Source: APXvYqy4xf7QoaQ2126adGE2bQCYCySLuxw6k2p3qbndMgmSyZc/R3WSTxvFPuaLUoXwJ+9b+zK5Gg==
X-Received: by 2002:a02:b097:: with SMTP id v23mr58410904jah.42.1555462534968; 
	Tue, 16 Apr 2019 17:55:34 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	w184sm577780ita.9.2019.04.16.17.55.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 17:55:34 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
Date: Tue, 16 Apr 2019 20:55:33 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BCE3056-7CA2-4DAB-8F7F-87E9E1F481D4@oberlin.edu>
References: <20190305051007.56009-1-stephen.checkoway@oberlin.edu>
	<52a82d3a-3b79-c61d-93fa-f087af45f6fb@redhat.com>
	<1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::12d
Subject: Re: [Qemu-devel] [PATCH] hw/char/escc: Lower irq when transmit
 buffer is filled
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>,
	=?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417005533.uHtchgIMDhAxqrUvgGxMVKjxU16CBJlLfJwBd7wvQLc@z>



> On Apr 10, 2019, at 16:01, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> So your description and patch makes sens.
> What worries me is the controller could have other pending IRQs to
> deliver and you are clearing them. Shouldn't we only clear the
> INTR_TXINT bit, and call escc_update_irq() which should lower the IRQ =
if
> no bits are pending?
>=20
> Maybe as:
>=20
>    s->wregs[W_INTR] &=3D ~INTR_TXINT;
>    escc_update_irq(s);

I just sent a v2 patch (but it looks like I failed to include Philippe, =
sorry about that!)

I used

    s->txint =3D 0;
    escc_update_irq(s);

which appears to do the right thing in my tests.

Thank you,

Steve

--=20
Stephen Checkoway






