Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A7C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3C421479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjhrNzoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3C421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1Jz-0008R7-Vt
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:44:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT1Ik-0007ur-MQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT1Ij-0000Dm-RH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:43:18 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT1Ij-0000DK-Mn
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:43:17 -0400
Received: by mail-ot1-x32e.google.com with SMTP id c3so15764881otr.3
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=qgACjJMI4UGz6boZnESsF6c5zVdauroRUyHseWFPNwM=;
	b=WjhrNzoO8zX70B31qv2GyawLKde1V4ruc2e0RACTQgBUPpzZjPEyh4klvi+zWGY5aB
	9cV6O16/Rvafn6pYKbb/ndjh2pwXLNXlTfEHidivkjN0Nle3qM2WwHy7J2jczRHLaDHX
	Ad9vE/CIm1QorGyqWygPY5nj/2r82EaaIfzkvUrbWp8hm50FPiAgx06YB+jmfOvLsOon
	DYRSVhbkrvHV2MpR6qK9G/IzKD1vLSekoOQcJMcq1E35WaqwOl4aY4LvwzTIu5fp+q2H
	Nx8FGTDPZbdWzE23uepsbwjuTwEmxZ1BQhbr52PhclUY2dybxQ3FKiFKRlFr792GYNmu
	wpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=qgACjJMI4UGz6boZnESsF6c5zVdauroRUyHseWFPNwM=;
	b=T2VVgzyQgqNlPqyK18QFVC09v8U0tMfIlPHFI8FqaclvouVSJu0snh/VWS8YA/xZPn
	CnzirxQrTwkn+QOMDNP6ciRy/Qx0zh6GXnKOPyDs3f66rUEqokkqIXINpbSUkw038cwe
	OXPqVmR2iTKYTpD4BW02xWtA44cOSfOvFSYpECn+u0YjE+2vgOLOTN21X4eT8sPgYZvs
	k+nMrd6b3WOxDp7vHfaznLC5S/de6yZeBmWS2ZvjNvFiT8UsmriSppIEq4WI71Du12RQ
	Dr4RPO8gxDw50BN76Z1559GjUUe+CxNoX81p+WcHAIOl1kQjVXiUgpMa05If6R7iM546
	EHMg==
X-Gm-Message-State: APjAAAWLmJJ5VfI/omxNXUPHlvHaEX6jRABhMAtGImhprLL9Lc8vm9Uc
	hEiMUL9WrYEvffqLYMC07gRM9ajoRzIZse5lbPx4jg==
X-Google-Smtp-Source: APXvYqwEmSfp/LpgrGLsO4BeeEBcYvKy9B+ZCPjD1k+YwpcZuNVv1902s4/BH/DDuj7/qsEbHNwloQ6fTPGIO5WKQq0=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr11951800otp.91.1558431796886; 
	Tue, 21 May 2019 02:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
In-Reply-To: <20190521085350.GF25835@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 10:43:04 +0100
Message-ID: <CAFEAcA8bs0M4Ofdq1tt8uZvWHK49PNRFz3SQhxEHT_uPGmBHOQ@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 09:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Hawkmoth seems pretty attractive in its output format, but doesn't appear
> to be part of either Debian or Fedora distros, so we would have to bundle
> it in QEMU I expect.  My big concern there is that there have only been
> 2 contributors to Hawkmoth in its entire 3 year existance, which makes
> me fear for its long term viability if the main author gives up.

The dependency on clang 6 and the python bindings to it might also
be awkward for bundling it with QEMU...

thanks
-- PMM

