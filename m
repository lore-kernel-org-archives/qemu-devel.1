Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F1C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1547120866
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OdgGlY6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1547120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBMBS-0007F7-Ac
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 13:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBMAp-0006pf-Da
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBMAo-0002NS-97
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:26:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBMAo-0002NK-3e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 13:26:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id a6so2463771otb.10
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AEb3busSxAVllEZyGA9W7FuRu3xQjAX1PcyIxALwIoU=;
 b=OdgGlY6ZdbeJQpCqqGEDjh/e0HuYZPaYe+qDeLQZh07KgO1B51QR5iH2ixjG7xs5bg
 RdLisrwYs2CYBCNCpiQsYl47KLi/YUHZnOisxtBgakiYt2BvRRL929Sk92A9yINTUXUQ
 MYXRG16WR0Z7wnODy1J9+g1eYDsvs+2m/FSGDoUuZoV7KikiPBsjWhgKM7Y8lps5geXt
 QI8S97Vb4/RMGxYI4T/jg2xZ+Bsq9Fdg0yd/UAM/qCutrII4fiePPYtOtzNiZatz8MOF
 LCMWhLYqeZgKrtL7DHjI2nZN4c6wpAfjGXBSTdCO1CScm7/eOVMQ+1y/+afzhQPS+eOG
 W41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AEb3busSxAVllEZyGA9W7FuRu3xQjAX1PcyIxALwIoU=;
 b=c2T3DY9KYxdf3ouPe4MMIvVpwhWk7E9iR/l9fb06Q68VFFIHOnd/Ee7OeTAr87BQ3C
 TuqMWdz57eFYKqcya5Q2fJrg1UwALiO5360Fs7kE3o6PqUqsGtCIswxj5n67TIECLZt2
 8lCy+rKv/NAGGNN31qGzv463ebsu27l0fCpAsYIC/BW1/HET9R5QU+Ff6WcTKLP9EsUf
 4ADOscyLLC1UDKFNPdQ5+2uCO3B/q2UFJyqOqSTK4YE4Og03+cvX5OeMqAsJb/mUIqcq
 7yk1GH7m2AEUJwYU0k/k+UqEvCJiKww6MFd7fwDSWciIMCgbek3wP+YI4HaxCa6mJ1ci
 ZVZQ==
X-Gm-Message-State: ANhLgQ2Ii6ofRooVxA3Qxg1EDUe3Fz0CxLOGCsndY4pt6EoPPdMpP7Ns
 CwE882AAGj9I/5NQduWTML9iacvLvMMGMHkYsnYX8A==
X-Google-Smtp-Source: ADFU+vt5OT5nmVZEwODfKvFr/PjFFizSeiwTr8y7zdoLWN7wpdl2rNMSey2zlgOQ6VdHbolEJJGlGvyIi0jcIKfT/zs=
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr6261209ott.97.1583774797080; 
 Mon, 09 Mar 2020 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200306134751.2572-1-peter.maydell@linaro.org>
 <70e18816-1d16-93a1-5e49-2f54132602fb@redhat.com>
 <CAFEAcA_wowY8fhsLXGZeHbdRP+1G58KmDUsLbB5WYw91KoF8+w@mail.gmail.com>
 <5d9f2189-fa75-32ab-2042-14eeab92fbf7@redhat.com>
In-Reply-To: <5d9f2189-fa75-32ab-2042-14eeab92fbf7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 17:26:25 +0000
Message-ID: <CAFEAcA_-sUFHBnZPTKkveZasWvavf8EyLHc1TGeuGksqetfbQg@mail.gmail.com>
Subject: Re: [PATCH] qemu.nsi: Install Sphinx documentation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 15:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 3/6/20 3:54 PM, Peter Maydell wrote:
> > On Fri, 6 Mar 2020 at 14:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
> >>
> >> On 3/6/20 2:47 PM, Peter Maydell wrote:
> >>> The old qemu-doc.html is no longer built, so update the Windows
> >>> installer to install the new Sphinx manual sets.
> >>>
> >>> We install all five of the manuals, even though some of them
> >>> (notably the user-mode manual) will not be very useful to Windows
> >>> users, because skipping some of them would mean broken links
> >>> in the top level 'index.html' page.
> >>>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> As this patch unbreaks patchew:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks. Stefan, I've applied this to master as it unbreaks
one of the patchew configs, but feel free to let me know if
there are changes you'd like me to make and I'll send a
followup patch.

-- PMM

