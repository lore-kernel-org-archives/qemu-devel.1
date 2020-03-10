Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46097C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171EF24683
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ar3ex5m7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171EF24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbDi-0003Dj-0L
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBbAN-00064f-Qz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBbAL-0002bA-Fu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:27:11 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:46640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBbAL-0002Wv-8O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:27:09 -0400
Received: by mail-oi1-x232.google.com with SMTP id a22so13072366oid.13
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aci+wnW9+Q3rUUgzGFI3lSawmILotb26Yh8Jc7ciVCY=;
 b=Ar3ex5m7E+cZmCz1KsJDb+ZSyOftElKSIiO3+V09YJwRcL6qQDj0I9zUNwfVB/wkGd
 QJerLYZFQ85ep1lMoVp6KnL0Rg/+VTD8eUXvI3V2VATHvdeOmUe0mpCTj0KHPfy1eSMP
 zJiH9mHwBpqhCrHyEyjKz4eSTeH5JyQJCyiR8gyLDRpZIyLD5cTl89JXyQXxCUkShskF
 G4f6fZkku2Rqoe+os8ix4HfSpogcFsjnYIEE1r5yMYuCDaXjG8VJL1IDxGUy1jlHiXtt
 FEC6jo3HzL3gvn/SSctmSSlcY8Kcj2MMAdECDB+UyWmdbcjbt0KJOFVwdaN6eJXgSVXD
 JpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aci+wnW9+Q3rUUgzGFI3lSawmILotb26Yh8Jc7ciVCY=;
 b=ZYXD740so4t6dkDiZTm23x9bsA7QlbgspONHHEdHvWHDFryBBJF+jGOyy1sEFzzR/N
 Vs9AkWlvC+xk81Knr7VLW3UZl1pTgOFaHHRYJBtwJruI+TaPtB9ZkKMLarduN3yXnOmW
 tfZtB5nSVTb+u+K3lRF8BjMhK8b5BbZ+YnIaAt4ssFry++T4naFfZNjE3s+ceti+0cf6
 cLfFI9HY+J9s5qlTykkIoXPsgxKC6Rx3/jGIRJ1SjFMu/E74Vd6QB8/omDWy6SGnNy9o
 zuPLeKpCainae3CuiEcbHiLQ8Yhn5gntf2yoQRalwSMvzqZDoZGouGl95ZeKnYKcu00e
 QInw==
X-Gm-Message-State: ANhLgQ1z6eKgP4NAjX9o5Xcbump8qL2ivMQOcsy5s1cl8tHwdaxi1mN4
 twaQJeZI+sDifVgWkrxMsDNt6cIvOJp3uMLV4YVY6w==
X-Google-Smtp-Source: ADFU+vtW5d6yj1BTJBypiolQhcFhA8iO2yqPcoNB1fh4vc7KrOTQsIJiwD5hx7vfBdmBNGDn6T56RwbGwsBE/yl/CkQ=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr458386oiy.170.1583832426751; 
 Tue, 10 Mar 2020 02:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO79s5ZTWrvheAu=XHrVQO0O_RxLu9LD9=B=k982c8_mC6g@mail.gmail.com>
In-Reply-To: <CADBGO79s5ZTWrvheAu=XHrVQO0O_RxLu9LD9=B=k982c8_mC6g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 09:26:55 +0000
Message-ID: <CAFEAcA9wDGjw_EBg5OxnWAxxJ0M-FS7=dh2A98Aa4LiPfEkaLw@mail.gmail.com>
Subject: Re: Any interest in dwc-otg (aka dwc2) device emulation? For Raspi 3
 and below.
To: Paul Zimmerman <pauldzim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 7 Mar 2020 at 00:34, Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Hi Folks,
>
> I have been working on an emulation of the dwc-otg USB controller
> (host mode only for now), as implemented on the Raspberry Pi 3 and
> below, and on numerous other embedded platforms. I have it to a point
> where it works pretty well with the dwc2 driver in the mainline Linux
> kernel, and with the dwc-otg driver in the Raspbian kernel. Mouse and
> keyboard work fine, and I *think* the usb-net device is working too,
> although I have been unsuccessful in connecting to the outside world
> with it.

Do you have documentation of the hardware? One of the issues
we've had with this in the past is that we couldn't find the
hardare specs for the USB controller, so it was a bit difficult
to tell if a model of it was correct or not.

thanks
-- PMM

