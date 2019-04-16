Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE148C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A172064A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 17:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idSOcG69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A172064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGRt9-0005dE-Ph
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 13:28:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGRsM-0005Kb-K5
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGRsL-000108-MQ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:28:06 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGRsL-0000zd-FK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:28:05 -0400
Received: by mail-oi1-x242.google.com with SMTP id a6so17661273oie.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Mx6AUPV8fWM/gl5GRe9LDMeneGGz7cf9BteWiOAVA0o=;
	b=idSOcG69aAizOhqSE1HKaC2kOYhd7bK0zMzNa/Q4tCtt4tKzPOgjMm4ysOX7e9I9xY
	tTiuXh5cs81QrBjSN9jQ3E/y8sSJO3jzZxs/JhjNJqsHYw8wMsgiyNTkJuLXSh7mPZJo
	VU+xOFyyy0DZCL3byN4YFvmUCRNRoYnnlp9Jw8zj6A5aQ22ayyRSo4lSon/GxM8w0zbo
	S6TnPNyQcPH8tqGnM7b7eUjTnf9wFCkU0HBBmk1qinDv4rfJ/FLGZQZM6GhY6ICAX0+y
	lTjOrI/luhRuCNxA0Glp/8Al2DMB1CXOkw2wXsxl5HW98hz/euYxT/Tx+klaA2VHrqQK
	UA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Mx6AUPV8fWM/gl5GRe9LDMeneGGz7cf9BteWiOAVA0o=;
	b=HYMwAE00DFlY7HgcnZAs1Q2FFQku8IIsmneR7xmNXQd7309vIkTjZwA9JxWBieSPxQ
	4il4akOPIDiDkb9sIx2YlQZZad4S9VeaSvyaFqu57h4dCR4S3WgeF1OJLPeErRQXIOe5
	1BnqkZjcFA6ykiWbHA+7BqosQ5ZY7F1murP0eZzSHszz7iJiD6sCy38G3Z4SkH5npwok
	XzUiT10772b6i7sOAv4VxnFZ7dFO8CNueStiVkBTjMRNuuJ0Dy1Wx3697+1yWBdEkwFo
	LBr4aMM3PDDdXt0i+niO9oNH2PK+Hrx3CzX2sV+rWB8NSAPO0QXdgCtOZsee2bymWqLX
	MJ4g==
X-Gm-Message-State: APjAAAUXMQHZekIrXabzaZ5butma6bTfHxLC0gloTdVujGRda7Vzfmpd
	AixZVBJFmaI8UoPB/bPFdsfSxq9CEIzrXo2DVtUw2w==
X-Google-Smtp-Source: APXvYqxkt96azWxlW+bdbY25FvfrYV8uheEV324ScCZF+DMkivbbDKya7GAdJYWu8nv8kfEGBCe6Jk5GnXiq7RoWJWg=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr22185923oif.48.1555435684048;
	Tue, 16 Apr 2019 10:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
	<CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
In-Reply-To: <CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 18:27:52 +0100
Message-ID:
 <CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416172752.J_NcFEdT4z75a8kJsnZPWEzmOr_4sW5JL0P4wsbi0HE@z>

On Tue, 16 Apr 2019 at 14:35, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 15 Apr 2019 at 16:45, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > Two previous attempts to fix this due to GCC 9 highlighting
> > unaligned data access. My attempt:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html
> >
> > And a previous one:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html
> >
> > There are a number of bugs in the USB MTP usb_mtp_write_metadata
> > method handling the filename character set conversion.
> >
> > The 2nd patch in this series is a security flaw fix since the
> > code was not correctly validating guest provided data length.
>
> Given that we don't seem to be confident in this fix just now,
> and this is a read-only buffer overrun in a not-commonly-used
> feature that only happens if you explicitly enable write support,
> my current thought is that we should not try to put this into 4.0
> (but instead treat it as we would a security issue that had
> occurred after we released 4.0).
>
> Opinions? Maybe we should just apply patch 2/3 for 4.0 ?

Having thought a bit more I think I'd definitely like to apply
just patch 2 for 4.0. Could people try to test that and confirm
that it at least does not make the feature behave any worse?

thanks
-- PMM

