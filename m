Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ABDC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFA4206B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uH9RYjKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFA4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnxz-0006cx-Jn
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHnx1-0005Kt-Oh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:51:19 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:46426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHnwz-0003Tc-L1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:51:19 -0400
Received: by mail-ed1-x541.google.com with SMTP id a12so17414811eds.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4/gEGUyO9Ec/vAWrv/RN0xJHB6eayMADlLAE4Pl3nsM=;
 b=uH9RYjKHiaFqtZl5dVw7E2trJF0rLK9AKIDicKGxYpQ+zsHRISBzTEdbsdHbeGUNvG
 IDmB/gJDGsrXBm9vC7lAa11fZlTYb4JCx1JkKc61b7rhwqXilAF/qyo86w6enzrKtDh5
 wwuHrJqikYrtqnMewnFsvzRGX22cDGDkobJaJX3O+v/K2acOax8la4YGBSuEPorGhc5Y
 9EzXESg94Zd2t3Pe3Q2aIiJD5DDgLfmkwa2v5aKDGeIxkcunJHkdLrcgKfr7llpsZHXz
 HXsr5OYzTPfqkZBWQbTVOhmMdgDLzanDJv/jy+5MJDmG8O+q48INsZ5vMc+Vto6i9ScQ
 mwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4/gEGUyO9Ec/vAWrv/RN0xJHB6eayMADlLAE4Pl3nsM=;
 b=VoDCY/7anvcqERiYBXdRSJiQ1Oz5/jfyDMAE+F63ARkM7g4KrJm0ES7fsfnK91KMbb
 T4MVLgeEPxnirtFCNpn3SWTaW6869EJnX7KDdzmmswyOv3Gl/FB+MSSTUFm5htgRlfI+
 9j6R6zyETQxX4Si+kHN4Xq/Kkke3tjrhZ/PZhyMqhkUn/pMXoZGsdFmV3OIfFtNDCdxW
 gM0fRyhDyOF4CUfjx2SHv/rGLXjKPHrpr4A3fIAA2klySpBY4yMaWzRMOoCfq/NtZM6f
 bsC2EAh3GabCzeSEM5ecTpVdDrStnTSDCOtdad8KEDAb4Py2G5LyS4rBfk0A6PbBW20M
 dh9Q==
X-Gm-Message-State: AOAM533JBQvcT/i2PwnNL1dFcCIwbXMZG39JP0lANLPe8IJ0pOofHfP7
 pIlt4fKKd/UUx0oUfzRW3NPIsGOrxcsLHSkUelNZFw==
X-Google-Smtp-Source: ABdhPJwAN8I/PYY1Z2MmGKN75/rJymP2krPOtZFuXGTGc3YiUhfSusUuRFkJ4hHoSDjinoPgQeSTa0jb0QtX9CXp4KI=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr16603855edw.251.1600087872452; 
 Mon, 14 Sep 2020 05:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200914113809.63640-1-mreitz@redhat.com>
 <CAFEAcA-jN39TufevHy6sng-53NAzqfdm=4NEzGe1Yg+oFzfFQg@mail.gmail.com>
 <450123b0-e56f-57c1-c42b-2618fcaefc77@redhat.com>
In-Reply-To: <450123b0-e56f-57c1-c42b-2618fcaefc77@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 13:51:01 +0100
Message-ID: <CAFEAcA84st9vKnvB7FNiHosq5tN-csZefpdD_ArNXCbih_fYSA@mail.gmail.com>
Subject: Re: [PATCH] iotests: Work around failing readlink -f
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 13:32, Max Reitz <mreitz@redhat.com> wrote:
>
> On 14.09.20 14:31, Peter Maydell wrote:
> > On Mon, 14 Sep 2020 at 12:39, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> On macOS, (out of the box) readlink does not have -f.  If the recent
> >> "readlink -f" call introduced by b1cbc33a397 fails, just fall back to
> >> the old behavior (which means you can run the iotests only from the
> >> build tree, but that worked fine for six years, so it should be fine
> >> still).
> >>
> >> Keep any potential error message on stderr.  If users want to run the
> >> iotests from outside the build tree, this may point them to what's wro=
ng
> >> (with their system).
> >>
> >> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
> >>        ("iotests: Allow running from different directory")
> >> Reported-by: Claudio Fontana <cfontana@suse.de>
> >> Reported-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >> Hi Thomas,
> >>
> >> I thought this would be quicker than writing a witty response on wheth=
er
> >> you or me should write this patch. O:)
> >> ---
> >>  tests/qemu-iotests/check | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> >> index e14a1f354d..75675e1a18 100755
> >> --- a/tests/qemu-iotests/check
> >> +++ b/tests/qemu-iotests/check
> >> @@ -45,6 +45,10 @@ then
> >>      fi
> >>      source_iotests=3D$(cd "$source_iotests"; pwd) || _init_error "fai=
led to enter source tree"
> >>      build_iotests=3D$(readlink -f $(dirname "$0"))
> >> +    if [ "$?" -ne 0 ]; then
> >> +        # Perhaps -f is unsupported, revert to pre-b1cbc33a397 behavi=
or
> >> +        build_iotests=3D$PWD
> >> +    fi
> >>  else
> >
> > This still prints
> >   readlink: illegal option -- f
> >   usage: readlink [-n] [file ...]
> >
> > (you can see it in the build log that Thomas links to).
> >
> >    build_iotests=3D$(readlink -f $(dirname "$0") 2>/dev/null)
> >
> > should avoid that, I think.
>
> I mentioned in the commit message that I find this useful and desirable
> behavior.  Something isn=E2=80=99t working that perhaps users are expecti=
ng to
> work (because it will work on other systems), so I don=E2=80=99t think th=
e error
> message should be suppressed.

I disagree. Either iotests can handle readlink not having '-f',
in which case it should not let readlink spew junk to the log,
or it can't, in which case it should bail out.

If you want to tell the user something, you should catch the
failure and print something yourself, because then you can do
so with a message that will make sense to somebody trying to
run the test suite and point them in the direction of what
they can do to deal with the problem, eg something like
 "readlink version doesn't support '-f'. Assuming that iotests
  are being run from the build tree. If this isn't true then
  we will fail later on: you can either run from the build tree,
  or install a newer readlink."
(fix up the details to suit, or throw away entirely in favour
of some other text if you like).

Printing "readlink: illegal option" is just going to cause
people to assume QEMU's scripts are broken and send us bug
reports, so please don't do that.

thanks
-- PMM

