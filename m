Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1298BECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9F8217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARNNc0Iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9F8217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKJjY-0001JI-UV
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKJaY-0004vT-94
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKJaW-0005y7-D5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:57:57 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:46522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKJaW-0005xr-81
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 05:57:56 -0400
Received: by mail-ot1-x32f.google.com with SMTP id 89so16334980oth.13
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rGDRpST5sieXiVLkqxlJk2ENwgXbiyOjDZ1Qgf6nsnk=;
 b=ARNNc0Iu/vb60tOyhT6mUvKVX+0JXLfxjWdEvLr1JthyVrwlUktBrmWbNSyy2hlOsJ
 tdTC29hhnyQCs5WeMRKo1csEE46+freOFErR3kfgOFLUw8RdvRwrJRTgkffSXdF3SWMB
 j8sZaXwK0+Bjh7qcZjCe3I3/psUjst4kHk5/qqS3EAy6Au3zHEt+qTYrbasl7GxFPiPH
 YFSkEKZRwDb/xmZpdt1HOwJ9ZOWYEgrho7seIbJnCzv27pzsEdelb0+B9Do5rR1KDq5I
 nrHUxzavEeVna4Iw18xG/dQ3MKGMOrgSIgnhmJbxVfDrge/GXy1eYGfRa32AugxZgV95
 tLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rGDRpST5sieXiVLkqxlJk2ENwgXbiyOjDZ1Qgf6nsnk=;
 b=lQROOcH78wdDJG3rYgW2kuhGWzVpNn+ySfplLqmh2+Ytv+yN02vD3dDlcZvol29qJq
 ZvtkmbzD8lokgXgurNLQmVFlVJAwPpg9Kw+Vsht5N/SaO6uNuOcWZPCuWRFFraKLKMI1
 eVeTzE62uuG7kWCwbL/6gArf1RkLOPGScbd9FH3MWPIhxvpWfTbCUSC277eSOAkXaKkv
 0b1iiXNPNEqtOGNMhQkvRipKGRrYLalhtPF3svMfQ7e3dBQRUzKn3LI245UCHwT7ZPJ7
 6TO/OfJFGWTVgiiVI1U8YtXcoiz5z+VtWReDp2HvVK1OnSTvU1uhDgrVQ14OL4o3xVuk
 hcGw==
X-Gm-Message-State: APjAAAVi/rwBlc2AyWnvSRnQSlMxjokGUtnFytAnsLVQq1lEYD1WIQXY
 nCG4bFZBTiPuKr1J/BiJW4tTyskbew2Bl7eJ0lFOaA==
X-Google-Smtp-Source: APXvYqwFXfyOKCuHuz5/hhYNzZkNFglhTnWY1NNfSfCMriD2nHlgvG6jSZynQmPY6QMWgKlFRu9WmmGVllDCBRM62VQ=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr28412069otg.91.1571133475325; 
 Tue, 15 Oct 2019 02:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <CALvKS=E-t1c+BVDn=0RbM8nBry8GcYOXh-PrziQO7XhS7W2NUw@mail.gmail.com>
 <CALvKS=GB1-zDnkKxei6Dn5MNyr5kwj+vEtD_3MZyVNfzqQuRZg@mail.gmail.com>
 <CAFEAcA-gLHm0D6vR0Rvpbi_bbVWpKspvm8YLSVPHpCVP6HmDUg@mail.gmail.com>
 <20191015082708.GB22859@redhat.com>
 <0a4262f8-df07-e83e-0928-b6cf4e12800d@redhat.com>
 <20191015084722.GD22859@redhat.com>
 <CAJ+F1CJACARosH6agtDQoyo6VoubYfrRm5z6DpiiV+fdw0U8aQ@mail.gmail.com>
 <20191015091444.GE22859@redhat.com>
In-Reply-To: <20191015091444.GE22859@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 10:57:44 +0100
Message-ID: <CAFEAcA8_MSHnGhr0R=YDqT7kZJTSOh-U5KmqGAJ5A3XuqV=-Qw@mail.gmail.com>
Subject: Re: RFC: Why dont we move to newer capstone?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 10:14, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Oct 15, 2019 at 11:02:43AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > I suppose the same applies to dtc (1.4.2 required by qemu, but xenial
> > has 1.4.0... so we have to wait until April 26, 2020? 18.04 LTS
> > release date + 2y).
>
> Possibly - depends on scope of changes between 1.4.0 & 1.4.2 - maybe it
> is easy to conditionally support 1.4.0 too.

We need fdt_first_subnode() and fdt_next_subnode() which only
came in in 1.4.2.

thanks
-- PMM

