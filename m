Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D4C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4073620652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWbr2UEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4073620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48263 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLUAh-0004jh-Ir
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:55:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLU9K-0003j8-U6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLU9K-0006gQ-2v
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:54:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLU9J-0006fe-TX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:54:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id u15so12133949otq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=fe85NQgEPctR6hv2f5PevigENLCdm3EecXi182qnPXU=;
	b=hWbr2UEwlPDxRYKoul08cAXoJieeE/SaHGI35AdZPLWaYdLKvEvDwRwUFO61V1NArn
	wEYjbRQcN3GcKh9XUqy9RkkVZPC/IGndiDCgiM9GJbECpqoUPjuIHUTpnLcbxuZwPmLK
	UTk9ZG8L7KrcMLb5N9YuWyWKb6AcFcbO05OjK02xF+kofSY7qUw8Yn6v4kNngplMztHJ
	6ycq+3GXXONk68WwLdJNeaHf689A3CYyvyE2jp36N5vFOKYGhG8l0Q508nqVwnYAhywr
	oRFH2BsQOaEhkamdOdHYwkXfjQ7ScXBvQXw3CIJtnvsPia4gBFfDL5S9iO2Y2m90gTk8
	XHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=fe85NQgEPctR6hv2f5PevigENLCdm3EecXi182qnPXU=;
	b=AF/lNz51HgEX99DcBBoBHSwrad9wu/xPmCmzzi5zAl6Lx6nzkkUd1QZHlam9SNE+Dx
	2Mbw3zSVRbOEOUz39KH4s2YpevQP18dTf/ybb0gBhnQC9XRIHKgMpXNac4J+9wzSHtvl
	SKt81xULNSVmlk+ObWxGP28k+xhqW45urAt9f5kEz1Bbe6hyrVS7MrSA8MC/eJoSjuRU
	ZSvehbrK0T3QvnZ2Yxjtuc5UuAnPvXGlvPi6lj0popcLkd1rkOCDxzsePaSQikjCzIaK
	/mmcZwboM6bguW+BRtGivjaqE40KghNX44JnBEppj6ckvjXCKbNp77I7Rkj+jmuykj+Z
	nx/Q==
X-Gm-Message-State: APjAAAUCPhWV+mKdD5gSbsLJb3EOg0O+B+hJoyLHz8YUfTNLLYgFoj2T
	5Js98YGBGAPaWA8TsIALKMhvNW9OQuVzGiprVoW7MA==
X-Google-Smtp-Source: APXvYqx5ykz41vzLTD6fpxjDSbifmqIsIVSWRkV95pXWk1dmnPgEp2YhXAqcaozREnpUHwO4ACySg83mD5HDZb58VkM=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr16396392otb.238.1556636063416;
	Tue, 30 Apr 2019 07:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190416091348.26075-1-armbru@redhat.com>
In-Reply-To: <20190416091348.26075-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 15:54:12 +0100
Message-ID:
 <CAFEAcA-9aXpYTarSUw2r49PEeihZ4eyQub7f+DdcwqcJ8GXXGw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw/arm/virt: Support firmware
 configuration with -blockdev
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430145412.lkMVoLZb4E0V14RXy8hNr2LCcSD7BWfolajVSrxTIiY@z>

On Tue, 16 Apr 2019 at 10:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> L=C3=A1szl=C3=B3 asked for feature parity with the PC machine types.
>
> v2:
> * PATCH 1: Split off PATCH 2 [L=C3=A1szl=C3=B3]
> * PATCH 2: Factor out the loop body, not the whole loop
> * PATCH 3: Rebase on previous change
>            More detailed commit message [L=C3=A1szl=C3=B3]
>
> Markus Armbruster (3):
>   pc: Rearrange pc_system_firmware_init()'s legacy -drive loop
>   pflash_cfi01: New pflash_cfi01_legacy_drive()
>   hw/arm/virt: Support firmware configuration with -blockdev

I appreciated the commit message on patch 3, it was very helpful.
Applied to target-arm.next, thanks.

-- PMM

