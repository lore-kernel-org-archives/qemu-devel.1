Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE9C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BD7206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="lHnRFsDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BD7206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasQc-0006Nu-55
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hasO9-0004M9-Ip
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hasHM-0003ER-C6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:42:21 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:38617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hasHL-0003E7-Dj; Tue, 11 Jun 2019 21:42:19 -0400
Received: by mail-qk1-x741.google.com with SMTP id a27so8984319qkk.5;
 Tue, 11 Jun 2019 18:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k3JgUsX15SkJ630nXUVbg1RHuzGleq7PmIfGXOQzOIo=;
 b=lHnRFsDLDU90zodG0YPba/0O+2rnIOAwXZsNy485E5Xkqr0Ngg9CbbPag8XD02qpJY
 kiYeFpGF4faMpljuAmUw7Rt+ASlukJsFyqJsiA5cia1hobu+yS3UEiJGaMr8DxntCyOn
 uqrZ+D2n7VQaWeSZaSHoUGEsZGFlIaml8iN7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k3JgUsX15SkJ630nXUVbg1RHuzGleq7PmIfGXOQzOIo=;
 b=DkfUPY55IF1bwqiCSJjzMPdNp5iH2p2f/vZXH/dQ31iF/+pOKCfgDEpKwblSGdu0dg
 6x4WMZSam/ObBpibIfRKola5lfO3PDNjfyzl37+kPv2pg208t1DhPb5NGpuJrk9tqjaK
 Ki0iBghlq6FZ/0emja717kE4MxI0UwtXrw74hoF+pTbvSpMIGokOaJGrOUC9ovX6e+Bt
 mzvFV+EISZdYSIGqSiNa8J4fdjRLlIfYXf8wuyEzvS+e5gxyz7xZJVNGl+dNdbB9F9F7
 2PSm2d4O+/L/aTIQMtuiODIGKP1nnh04EFD0A18BeC33TIqSapAMC1Upzp8FPgVmshty
 7Yrg==
X-Gm-Message-State: APjAAAWiQBiml1IucjJY8OIRRmSy+QsN0GP1nNrDwAZBNCZoNPQfpWyH
 opqE5hcZTmOWWJAy9jbx06wWV6zXeBWNU3e7+oc=
X-Google-Smtp-Source: APXvYqydlTAhP1PKm5IyM/o/cgMYxjRe3UoCU6KTymbqANx3QyxPLyMsaLCOdOFkz/ebHy6qnWgFFE9krII0pYnCM5I=
X-Received: by 2002:a37:a10b:: with SMTP id k11mr65043557qke.76.1560303738544; 
 Tue, 11 Jun 2019 18:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
 <20190525151241.5017-20-clg@kaod.org>
In-Reply-To: <20190525151241.5017-20-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 12 Jun 2019 01:42:07 +0000
Message-ID: <CACPK8XdQR3J_mEES11_JT=FBSSzSOPUmrJ0m_jjXfj=YRLtKcA@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: Re: [Qemu-devel] [PATCH 19/19] aspeed/smc: Calculate checksum on
 normal DMA
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Christian Svensson <bluecmd@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 May 2019 at 15:15, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: Christian Svensson <bluecmd@google.com>
>
> This patch adds the missing checksum calculation on normal DMA transfer.
> According to the datasheet this is how the SMC should behave.
>
> Verified on AST1250 that the hardware matches the behaviour.
>
> Signed-off-by: Christian Svensson <bluecmd@google.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

