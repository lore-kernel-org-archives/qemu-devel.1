Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DD3C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63EF206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+nabrQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63EF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41811 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGTs0-0005yE-R3
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 15:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGTqN-00058N-L4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGTqM-00039N-FL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:34:11 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGTqJ-00033F-NH
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:34:09 -0400
Received: by mail-ot1-x343.google.com with SMTP id d24so18592952otl.11
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ERmO+zpn6or7z4dPmnai7x6M8oSivOzpA/I2Km5+P8c=;
	b=u+nabrQOLA291EzpY45kUPTMgmg/3FdJJ3cmmwQ6tDkARvSlgPQsdIMDlW05xci+dW
	WMkLDneCxMPGh207J1tH9l5BNRJj1GxT0afl1FCvMvkC4WU/dR++TbQjxf4MLW1Wl1ec
	StiLazpNZ2je5lBfDeiEDAf3wycmwC7ogaJc9dC1/+iQSNOydKCm2CYIxOYGt9TCJFln
	GqszWRPLqJN5WtbNb08I2te56Q4bMzZ/XFJkSPs7XTxxhmMbH7s3kteYnd4xqZW+qpd1
	DK8NQqKlfPsu/zz9grLFRY9eHovuLxSpKQhPpQw/GZmZ9DZxMTyVNrlYGMHPWMmxtWxK
	hdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ERmO+zpn6or7z4dPmnai7x6M8oSivOzpA/I2Km5+P8c=;
	b=EC3HPXXvQGGOIU0+IvWp/VI51ry+hBc5ay7jTqk3fQWeP9uHZbFStxlH/I8Zwu98u1
	LlP9h2p0rP9ZDetYCpM6S6P0otGEWn8SDO0keU2Rh60gV1FhR2SbVIKERvu3IUFQ9D9W
	MkWj/yHTNLAOuGSFGRcW1eb4C8bijI7AOxzjvZI3saqRZP9ofTP+Pww9NOyZfsruuxOM
	vJbV5ygrCZtF1h3xMo6JoWqV72z/m2cM4oNIkwSMA8ApAp3nrOeEDMBQl4qcECJbPwbP
	EnDXmUUdIbIpvKISzI9bOmnGwzwQH/eP+y2yNWdX8Ve4Tg8oCunn21tY16wQMtWihDWw
	nIWQ==
X-Gm-Message-State: APjAAAXRuWVvnuKXv3vpd1kNBa5vYIwOMG7Zh0Cv8ruB4xJ6QYw0xX+T
	CdXmlLYJ8WYJ46mlO4z265v5tbLR+UMKILZkxgTG1w==
X-Google-Smtp-Source: APXvYqzCF0wRto1yu+hHei2dP33ql1PpC9lUHfIFONvZwE6rpjppY9CDzCafnaAoBSq4YGQX9h3v6iBW11jaxIXPXuQ=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr54019993otr.323.1555443241260; 
	Tue, 16 Apr 2019 12:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
	<CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
	<CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
In-Reply-To: <CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 20:33:49 +0100
Message-ID:
 <CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416193349.KQZBVioZjF-mDuPwycG9AdzALqX64ZY5mEzwmA7At_w@z>

On Tue, 16 Apr 2019 at 18:27, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Tue, 16 Apr 2019 at 14:35, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 15 Apr 2019 at 16:45, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > Two previous attempts to fix this due to GCC 9 highlighting
> > > unaligned data access. My attempt:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html
> > >
> > > And a previous one:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
> > >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html
> > >
> > > There are a number of bugs in the USB MTP usb_mtp_write_metadata
> > > method handling the filename character set conversion.
> > >
> > > The 2nd patch in this series is a security flaw fix since the
> > > code was not correctly validating guest provided data length.
> >
> > Given that we don't seem to be confident in this fix just now,
> > and this is a read-only buffer overrun in a not-commonly-used
> > feature that only happens if you explicitly enable write support,
> > my current thought is that we should not try to put this into 4.0
> > (but instead treat it as we would a security issue that had
> > occurred after we released 4.0).
> >
> > Opinions? Maybe we should just apply patch 2/3 for 4.0 ?
>
> Having thought a bit more I think I'd definitely like to apply
> just patch 2 for 4.0. Could people try to test that and confirm
> that it at least does not make the feature behave any worse?

I've done a tentative merge test of patch 2, which is OK.
I'd like to push that either today or tomorrow (uk time):
objections?

thanks
-- PMM

