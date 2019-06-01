Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACCC28CC1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 09:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2CA271CE
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 09:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyDonpZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2CA271CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hX0ii-0006sD-Vz
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 05:54:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hX0hl-0006Jo-Qq
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 05:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hX0Vl-0003gZ-Ju
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 05:41:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hX0Vl-0003f3-8M
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 05:41:13 -0400
Received: by mail-oi1-x243.google.com with SMTP id b20so5984131oie.12
	for <qemu-devel@nongnu.org>; Sat, 01 Jun 2019 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=OyUncQWuC08e2sp/rFTLIQ/A4TeV+nXqHCw5HdY5vb8=;
	b=QyDonpZLae3Wi9OBqK3+qYu+BFdGsro9wUOt1sj4o/EtO4M5bnVPofUs3rUK4OpZ3R
	AJTGQW3ySU3F7w+bWzpeja47O+f7Nokdoc5gp68lKDQyZWd3maOihtcPmn2dPttXse0g
	BZJ4A5LUw6H0CPYVrmPTCiPYn24U3k3QjeiWe/TDsE6o4ghPxlkvW2uVc879K2aU8ci5
	pndCY1RCRGi/ux8BWH9YUcYR+/hYqv845J5vyct12LpoUazelGS4bjYrxIrd6Ddrp1sA
	9d7baKytIFARbVbDpcqiYExR1ZPc8c4ATUMsde08Ga2dW68OrpNcdjvORDYfwLmZqvm8
	zU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=OyUncQWuC08e2sp/rFTLIQ/A4TeV+nXqHCw5HdY5vb8=;
	b=fCqWE8otfuqWkkhcp+AGHvf9hNsrSW3QQ/CRNtxNPZXbSs5j148e+peuienm4SlJYF
	d80Y7rOm4px8GzBpD94pMYvJxnUVrqZ9uBJvjbrMEWzu7nvX8enIRGhdaSKJc5z6YOTX
	4P1i0fjRMnuDia144PhBkOit1VOglv6A7zLWRWcs7pzFWrJNYxkd5s/wqOPfBSg0CYyR
	MmVf8IP+YPm2Z28qhlKWpWteSMSiwAjPjaVV4Xa4WI6YuNFrhaJZ/BVrvB806ob+JYZc
	zxOcp84Q8qRVD+dLQLIItGmT54Fqg8FiPqzdrWiMeKJCy6s1LmV1eNz5EsYuvoiigar5
	AuOQ==
X-Gm-Message-State: APjAAAUljBtyQWDP7rxSSbVTaxe3zRWDiECIagjD1MEV2hPkKBB74DL/
	dXaHV/jZdLUvv36fKuza2sWPoHf1Q/1SGmDWb/dukQ==
X-Google-Smtp-Source: APXvYqwR0YYSNGuYMUwi4bf4oidZ/wpUgurceVuHhW7+R4GNzSCV4ikULZoJ1fLHluUwarAJZbCWhrqstj13uuNZF3k=
X-Received: by 2002:aca:6cc1:: with SMTP id h184mr1748680oic.170.1559382071628;
	Sat, 01 Jun 2019 02:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
	<947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
	<431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
	<CAFEAcA_KKH62rK2pbR8dWXOCJWe1X8wif5whc+y0_e-hTpmoRQ@mail.gmail.com>
	<87lfyl8x8e.fsf@zen.linaroharston>
In-Reply-To: <87lfyl8x8e.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Jun 2019 10:41:00 +0100
Message-ID: <CAFEAcA9W315__M3rGxarUOKkGo9PyqrDPa6bG7MWOv1jC0sFhw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 1 Jun 2019 at 10:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Semihosting is a feature that works on all Arm CPUs
> > regardless of which machine model you're using (or whether
> > you're using softmmu or linux-user), so I think
> > the machine's Kconfig fragment is the wrong place to try
> > to pull it in.
>
> Although amusingly it doesn't work in kvm but perhaps it should?

It would be nice if it did, but the problem IIRC is that semihosting
hooks either SVC or HLT instructions, and inside KVM both of
those go to EL1, ie to the guest, and can't be trapped to KVM.

thanks
-- PMM

