Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9FBC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7861E208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4aZNLN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7861E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBIYh-0000yv-F5
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBIU5-0007D5-It
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBIU4-00075y-A7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:58:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBIU4-00075n-5f
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:58:00 -0400
Received: by mail-oi1-x241.google.com with SMTP id k20so1654248oih.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hw/nxOeSwaEQgB1OlJ37oku28Y/KOKBb5gBU+JHGn0A=;
 b=z4aZNLN/THSIzbuxq90XhWkDnbUb+EGO1VOE51S5hsT8fYyTX3PKlncMINmGlXk3d7
 mqj4UX+ovH5e1TZNfKpHp2Sdis4Ts27i0DxQecRJK3aQcMv45flVgcXYFNIw2XyxkxRT
 j9j4ZOowviwtnAAq4gSmax4DC9whcgYlV7bNrPsYoJ+Vz4Rziu8dlWJwVSfcO5wwTo76
 uVM9mMSHbAQnBkMLnHR/sIH+b4Z42ffkiutG13ZrdPehoh6roKq2f4rBZkLfCb7R83cR
 F2VVn0PkVCpakmfcb16W3aDHMalf2VgU/70gMxe5LHTQZvpyTUx0+uDtvCBdAibRSXDe
 Hotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hw/nxOeSwaEQgB1OlJ37oku28Y/KOKBb5gBU+JHGn0A=;
 b=K3hrfaZSV7E/6aKq9gcsdEAdTt6M57NKIFXfl/QV40Ft7f73JHaVvxgaNRV72LUmfw
 v5umGOy/sRXQKCbBBLp6vCKILKH5tmro/4oP9of8qoSJGNphXygJBvIOCgPzHrrIgmLZ
 Ouu7yFLHfkv4gScC+cCmv/8AKMr4RYUQGr8Aw/tCgKwjhtBU3qV69gUHxUSXrRIiVHX9
 3XSFXiQaSZgt5TGyCZ9P08V112xkjpKNglWhIQrcqjk1N9crH1FjeGrss3bgncoSt8V3
 5c8RKEd1cRhySiZeIaud6LbQ5rKxby0aH/rm6aoEimbDKIcL0bumpnGDU694DBzs+Gez
 dfoQ==
X-Gm-Message-State: APjAAAVpWaGubJd8XRTMM17IBlN82AjUqIqaZOj4JhaJDZG+cwFqKDkQ
 7EC6MOZqo6u8DvoTE5w6NIHNNxeeQvY4bQLiyafqmg==
X-Google-Smtp-Source: APXvYqxkhhOu2nYyG9M1c+bf+/XUgnF+wyXDtFDKhC6Nb6VuJ1Tpvnp4pNOoNC0f4qvizCwOlkvA+7Klpx+D+LWf0Ok=
X-Received: by 2002:aca:b646:: with SMTP id g67mr2743438oif.163.1568984279330; 
 Fri, 20 Sep 2019 05:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190919213924.31852-1-minyard@acm.org>
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 13:57:48 +0100
Message-ID: <CAFEAcA-wEcsRDSjs-QD2kWspTx=mHmcY9etO7KgPVcyRh_XxUw@mail.gmail.com>
Subject: Re: [PATCH 00/15] ipmi: Bug fixes, add new interfaces
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 22:39, <minyard@acm.org> wrote:
>
> I haven't gotten a lot of commentary on this, but I assume that means
> that everything is ok.  It's been posted a few times and the last time
> I received no issues, just a couple of reviews.  I would like more
> review.  But I'm not quite sure what to do about that, I've been
> hanging on to these changes far too long.
>
> The following changes since commit a77d20bafcd4cb7684168a9b4c6dc2a321aaeb50:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190919-pull-request' into staging (2019-09-19 17:16:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cminyard/qemu.git tags/ipmi-for-release-2019-09-19
>
> for you to fetch changes up to d9b74295c6528fd68cebdea116b283e46543b2a2:
>
>   pc: Add an SMB0 ACPI device to q35 (2019-09-19 14:41:58 -0500)
>
> ----------------------------------------------------------------
> ipmi: Some bug fixes and new interfaces
>
> Some bug fixes for the watchdog and hopeful the BT tests.
>
> Change the IPMI UUID handling to give the user the ability to set it or
> not have it.
>
> Add a PCI interface.
>
> Add an SMBus interfaces.

Hi -- is this intended to be a pull request to be applied to
master? It's in the form of a pullreq but the subject header
says "PATCH" and you seem to be asking for more review, so I'm
not sure...

thanks
-- PMM

