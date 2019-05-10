Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D296DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0CD20989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 09:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMgRUbLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0CD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP1Ue-0008O7-Nr
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 05:07:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP1TE-00077P-Bm
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP1Sr-0000iI-9T
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:05:36 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP1Sr-0000gs-35
	for qemu-devel@nongnu.org; Fri, 10 May 2019 05:05:13 -0400
Received: by mail-ot1-x32a.google.com with SMTP id c3so4935300otr.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sKgDZ9DgFBG2eBeTJVKL9K3/Blxoh6DfGd7w2BaTP9A=;
	b=bMgRUbLkiq2wiKL2yxRbLhVFbbY/jeadvA/cMA3Q6lLzW1BWgGIwNPMGJUkNC1IYB6
	Ppt/xBOIRckTRkgJcAgM822rYy2mPhF/Ewk5rpbS2/3X3fqalXnS3JGtuGdWXT92elKD
	YguWtqUIXVaDeLw5tly+/7XBwSKzNo4hK7UQ3ZWvni2CxJu9nWQmzXz/LeJTpsJqjQwe
	wRFXe3MldQ6HCM8EslnOpr4TJnpPGvD3ZQO3xXev//9xLV68iOPD77GLrxkThrZEDJDG
	eLs/Zg/7OWYpnk27zDYGjVXylhwtisLorXGXAcrg+KbHi7NV4SZwru6F6dQJXBWHkUdI
	B22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sKgDZ9DgFBG2eBeTJVKL9K3/Blxoh6DfGd7w2BaTP9A=;
	b=P4D/uesU5yTRNuCfTqv0cF3dcpJQoQF4+eWUBD/0/TuBrTODr50Xx5QKntdqtegiwO
	G57GESo2edsslqPIf/IBDO8Oevk0ygXuMVIX5q5t02azj4mods4N5h69f3dlbec6qxpU
	0w1CRtoWzHxjlqH6UVyCmtHVvYSvym3V73/YOsilR0gIRKQ7TlBke2BWzA6ELD5ZfDXE
	vMQoyEn+HgQlf9XKyqyqmebTiEVQ9/Wxc8ie0iHyZjS+t2Z16CRhuoWTsEMtXQc4B/6a
	lw0xna7KKbObpa58GdqFBrcrwltStuIWsTfUuzr6uO3ExqKiUnwnUaHekpa90YOb6Is0
	sDfw==
X-Gm-Message-State: APjAAAX2ZdAipJNqsuDVSCXMRMzC9pk8nw7eGbTDz+9f7nELqDsfbUOy
	Oy80JFEPjbpyqc6sfBFDlTXxmGha7yK4t8C6U5rYDA==
X-Google-Smtp-Source: APXvYqxRDLr8shp18SktnIXQnLeO6wq8Xn5txtAY/filqi13RKONcGu94sVkj0bgjGPaOONobe+KLO1xlYwFNj+T+fc=
X-Received: by 2002:a9d:4793:: with SMTP id b19mr1480743otf.238.1557479112013; 
	Fri, 10 May 2019 02:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190507134521.31044-1-thuth@redhat.com>
	<CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
	<c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
	<CAFEAcA8RoJ-ZSsn3Lhzj5hd3oYOE7Uxy8MvUUWrzhNfBmD=AWQ@mail.gmail.com>
	<a5711506-3f6a-bc5e-f991-9d730d2f7dee@redhat.com>
In-Reply-To: <a5711506-3f6a-bc5e-f991-9d730d2f7dee@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 10:05:00 +0100
Message-ID: <CAFEAcA8dfNqyWrJZEL-h70s6feHtzfaz+cR6toO42UjvDA8O4Q@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32a
Subject: Re: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 08:52, Thomas Huth <thuth@redhat.com> wrote:
>
> On 09/05/2019 18.54, Peter Maydell wrote:
> > Further, if I "touch hw/i386/Kconfig" and then run make, nothing
> > is rebuilt at all, so something seems to be wrong with our
> > makefile dependencies somewhere.
>
> Now that's a good hint. There is definitely something wrong with the
> dependencies here. I can see that I've got a file called
> "x86_64-softmmu-config.devices.mak.d" in my build directory, but
> apparently the Makefile tries to include
> x86_64-softmmu/config-devices.mak.d via the SUBDIR_DEVICES_MAK_DEP
> variable instead. Since that file does not exist, the dependencies are
> completely ignored... Paolo, what was the intention here? Should the
> dependencies always be generated in the *softmmu folders instead?

I think the .mak.d files should live in the foo-softmmu/
subdirectories, because that puts them next to the .mak
files that they're the dependencies for (it also avoids
the slightly aesthetically unpleasing very long filenames
in the root of the build directory).

thanks
-- PMM

