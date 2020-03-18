Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD90C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF9A20767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 17:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfBGWECb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF9A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEcxW-0000Av-4z
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 13:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEcwj-00085w-Br
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEcwh-00032g-Vp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:57:37 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:42466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEcwh-0002xJ-PG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 13:57:35 -0400
Received: by mail-oi1-x236.google.com with SMTP id 13so17804028oiy.9
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0l8jVPBg4yhcbRev/CvsHSb+Z8iTevGoH21sPOkchJo=;
 b=nfBGWECbSb9ih6y6rByq4r7u5rB76QxIHQZAhY3NDXYdl5fC4mt4hT5xPb3OkeyXYq
 7dhWGYKlqaBoRCmCw7xEuBPKauvvIxYJR4WZ1MHLC1PLy/kvQGLs69faZNMXtLEwXlaD
 7RlQ5NExDhzTrirZF7vPxInUTtGpLFsrg+nfhTS1Da07dtOP6qWkXbsRGqtoGkcz+8Ec
 kzosYXmd+i0nD/h41+NhTb/uKpAZjt1KVAnnF+sae0FjJpmOmkGvDD3ZmyyV8rucrMMq
 mrjDKxFMITSFBZXbtHW03FMcWH9Fl7B9UDf+KTaAEn+rRpgfRXOd4wu1zKdpSKL8/YmB
 +Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0l8jVPBg4yhcbRev/CvsHSb+Z8iTevGoH21sPOkchJo=;
 b=bORSkHvj1YhlsTf8zM2ouM6Imb2AyZuFlQlNnxU52NATMsuiCHefDDWil2Dzknscg1
 d+Xn8K239CS4DBTVnJH0G5tfMm899uPOMIplbc1r0JKowCRQ1dbuW42UwkWISL5FjkD5
 7adwIiHz9orqPehBOmGU3NrjRfXj+Sk+UDgEYi+gDYJeuKsNHv0ce2jTrXK06nc+1WV0
 ahu9++pXdkUlv1KicWGk0OSF8ufp+fijIxK0mnAbTlukJJMfvfoYr9Fxupg/CuO9KX85
 YkupB0pvv95+zXnDuoJmGUdeocRLoKphElhI7Luhxsncs2ToeyI3NBFugoPe5krv0SBR
 2o8g==
X-Gm-Message-State: ANhLgQ1YcxKmLw6KGGo3BIVYxoU+bA638BngUJK2v1Oa4j5lFD8XCEiF
 Ol48xZKbxwHBoM3h3PpSKNFS+L6cQjc8h6lAre73Pw==
X-Google-Smtp-Source: ADFU+vvcMJVvwE81Z9JoaimnzfyDZpb/BcSzOUBNCWXl6h4faovyCeFPLjo7hiEKCP+NHAc2Tq5hxWibGWxjZlbyRgU=
X-Received: by 2002:aca:c608:: with SMTP id w8mr4213145oif.163.1584554254815; 
 Wed, 18 Mar 2020 10:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2020 17:57:23 +0000
Message-ID: <CAFEAcA8P+sy0vqYxTAnUzzmd7VoTZDb_3T1f+_orF7Mo-TBteg@mail.gmail.com>
Subject: Re: [PULL 00/45] ppc-for-5.0 queue 20200317
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 10:04, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200317
>
> for you to fetch changes up to 6961eae79f58385482775dc0a6c3d553f633662d:
>
>   pseries: Update SLOF firmware image (2020-03-17 17:00:22 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-03-17
>
> Here's my final pull request for the qemu-5.0 soft freeze.  Sorry this
> is just under the wire - I hit some last minute problems that took a
> while to fix up and retest.
>
> Highlights are:
>  * Numerous fixes for the FWNMI feature
>  * A handful of cleanups to the device tree construction code
>  * Numerous fixes for the spapr-vscsi device
>  * A number of fixes and cleanups for real mode (MMU off) softmmu
>    handling
>  * Fixes for handling of the PAPR RMA
>  * Better handling of hotplug/unplug events during boot
>  * Assorted other fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

