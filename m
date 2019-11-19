Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338A3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF225206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKXcbswJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF225206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3ol-0007x4-Jd
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3ns-0006wz-7x
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3nr-00010L-0z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:44:23 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3nq-0000zq-Rd
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:44:22 -0500
Received: by mail-ot1-x341.google.com with SMTP id n23so17838087otr.13
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cF6s7xOGPRCBiWKruItyVajaDcuOUTOJ0DCY2qToMWY=;
 b=jKXcbswJ9xjHv6nLSil+Tk2pyFegYw06rmgF4JIApDjWxfoPpZzH8V4dG1EIy5n4Dr
 YgHvEEZ6g9WchWu5ekJB+nyXySSXie/4bLvBpbohV1Py50akjC7Y0c/dw5yDWnoirTQU
 iM2YNU3DBV7H9WDra94o1Jdaw2oEu26kb2OQfSkZzjexS1AfQWyVW6ANqxvR8ch/P091
 agcmdvYRg6QzGG1VVQJfPmWgbwh5nt5acndZnbRAWPrglOME6kc63seFP4Ap0K1O+gOP
 fRvK0MDXUziABMVhs71epGLikEu8wvwHYnDrQjerJnpoG6blc1HChKpMwLKp+nSTcF3N
 T21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cF6s7xOGPRCBiWKruItyVajaDcuOUTOJ0DCY2qToMWY=;
 b=p93EUBOgonxiEgoWEN55WCuHOe0c7JOXKuGVuoBjDVjz2GZ163tABkQk0dhcfUoSpJ
 fMKgldlCXtJhEuhXOUfesU57tS6zK8BfuI2dOCQexG2HgEhqXpfy4eHKPnewzTMLtU13
 Oc9fg/0QXyS5Ls29In1+/+xZY5SzOKHAYa9oW9lTghemNaKbtge5Dfxe82zIbrCb+F5j
 mbvA/twrlspdOlM9aXpQVR/M0hItl6B0s+m65OIwsegAydcKo29B3D4N7onUAa9HOd+S
 eASMLI0C4ZpkaMjETWZRw22frQkPh7lFd1YqLpEiJZwhTg98xxvjbelxluXGc4RLOHPS
 +uvg==
X-Gm-Message-State: APjAAAW6fTJUOpteppgUlxbVhdur2wbQqGxU3wQ+YtllR4KHrjhIkKPK
 b4GnTY1zsiQXjSvzPwS58BHNyEDRDwW8tjuhLwG2OQ==
X-Google-Smtp-Source: APXvYqxM7G30uAfAQmkpnLNBlNR+ok7yGPUxbJSK0SNZNM6G49V6oQGWdTbug5YLR3xJLmZtMH8NTUCOUQYXnc3vhso=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr3556749otq.221.1574171061592; 
 Tue, 19 Nov 2019 05:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20191113221301.8768-1-joel@jms.id.au>
 <CAFEAcA8AL6865u8KaY3HjRH19mTP=JUJ3FAgf9VezJYPOEbmBg@mail.gmail.com>
 <3dbfb0eb-4ecb-35b4-9c8d-dec3fd6f083f@kaod.org>
In-Reply-To: <3dbfb0eb-4ecb-35b4-9c8d-dec3fd6f083f@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 13:44:10 +0000
Message-ID: <CAFEAcA82Nf=2tEyfgX5=_pi19C7PC8YODX2XCC=NafT6SUP38Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] arm/aspeed: Watchdog and SDRAM fixes
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 14:17, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> We are preparing, and reviewing, the initial 5.0 patchset
> which will contain the I2C pool buffer model plus the fixes
> Joel and I sent.

OK. I currently have in my 'maybe I should do something with this'
list these patchsets:
aspeed/i2c: Add support for pool and DMA transfer modes
arm/aspeed: Watchdog and SDRAM fixes
aspeed: AST2600 SMC fixes and tacoma-bmc machine
aspeed: rework inter model link properties

(I had a quick scan through and there's nothing in any of
them that looked odd to me, though I haven't done a detailed
review). Should I just assume that you'll send out a rollup
patchset with all of those once 5.0 is out ? Alternatively
I could apply them to the target-arm.for-5.0 branch I'm
currently keeping, which will become the first target-arm
pullreq once 5.0 reopens, if you prefer (and if you've
got on-list reviewed-by tags for them all).

thanks
-- PMM

