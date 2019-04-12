Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86034C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480BF20869
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLHNls8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480BF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39471 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEygy-00052e-0I
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:06:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEydl-00031F-6G
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEydk-0000Ha-C5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:02:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEydk-0000HC-6g
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:02:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id k21so8854334otf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=payCiHsOuwB/s23xUuaFpesubHn3V5EZoSI/pitSNVU=;
	b=kLHNls8REg/zihx39ZXOTfpavzsTUM5fCdiNS9LRkphs3EjpJ/boxiS6BaVE3ADOsi
	7mQ2xqX3K4JQJX0SnY0TGpOC1Bbsi9PVTQtbyDUapk8bu3aDjQgmGdjHhkz+2sKAIA5Y
	dyI3/ZdkN2G7FvKwgmXyB93BZDA+zEAgbpf1JUsi2ZN0mT3SZUk9CAf5rHkbkfEkvmxn
	DqnQUsLsYmN003EyCnMKFo3akdl5+XtbcdQ/u3dA6DfpgCRMbwGeOjdQmRJg7rYvDlwP
	Wi3oU584ASayZG+UtIs0vBjGOkt38GDhlU+8tPilcIZ/yrgB47cWz+6f3ImIjayBnPWs
	mG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=payCiHsOuwB/s23xUuaFpesubHn3V5EZoSI/pitSNVU=;
	b=tmeCUNRPcoGJcPhUPDgv26kUEQMyA8+LNaBL3S9/+RituRgMVpvdAcm9JOnkYiDJVy
	/c5T+uv5WDVHGoDN767sMq86QXaiJSyDQxTJcddaVAMr0SaebiB/rY7LUYWUSk0maaye
	DE7lLS4h1V9fYN5PB6f7mtqXUqYyAd10G31BAy9Kf5BF78+to9qBNH7ahX8QnZnJhFVf
	5BavsPaAub/3oNt1m4gTJtdOhfoGIpyKTOSTyDjCGPVjFZrMUFL4ha/25iY+sPHf6TBl
	StUXyUwAWHMgJqXUbh7BKXlf2lVmvp7dsg9vlxDOxcACuJjcnUVyE+qY+8EqyeWGFM02
	FVyA==
X-Gm-Message-State: APjAAAUZiTz1W8wX+PtgwPxVHOEG2tVuYB2ia9V2/+vRRMD9Q205+aLh
	GtQJTqI+3YsqFUTisdyyvwFaiGOHNMDPOZC4wPnung==
X-Google-Smtp-Source: APXvYqzVJT06wsMeSfxkzKkFADzQK/+oLAcU6+mmNdqQrngr/it/4LCwtALY+m+ek09EzeX8J+HQ/+u0OLaP3PK03rk=
X-Received: by 2002:a9d:3b44:: with SMTP id z62mr38722152otb.319.1555084974604;
	Fri, 12 Apr 2019 09:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190412152619.23542-1-thuth@redhat.com>
In-Reply-To: <20190412152619.23542-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 17:02:43 +0100
Message-ID:
 <CAFEAcA9kXdUH3vkGLfEe+CFuD=S9XFEaWGNETre7gYOx5epFpQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
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
Cc: Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412160243.jYFoDSDMVm4Rd5tVdZGw3rGGGbWsI9mjQi1uDpnJakg@z>

On Fri, 12 Apr 2019 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>
> These machines depend on the deprecated bluetooth subsystem. In case we
> finally decide to remove the bluetooth subsystem, we likely need to
> remove the n800 and n810 machines, too, so mark them now as deprecated.

...we could just remove the bluetooth devices from the boards?

thanks
-- PMM

