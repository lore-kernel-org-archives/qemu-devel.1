Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABB4C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9698121721
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgCILXxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9698121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEsNp-00064i-TO
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 05:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iEsMo-0005Xy-HD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iEsMn-0007Yi-5T
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:53:18 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39535)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iEsMn-0007YU-0N
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 05:53:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id s22so7735003otr.6
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O+xugMGUChfjgxU/U3b2H0ca9pHJP1OdBZSZQ1thY2o=;
 b=BgCILXxKezNMtkRavn3Aqr5mENxzTRqbpdFu2xyBGp7zqe8x3obvWYFvB8zUSM1Dr5
 OA39odaHpIVjTK1NBYIrs/2CyYfGME1EWH/Uczr47GMn3L4c9pfjP0YiNUg0+Q23LGfm
 3Y7zq/WEKMEnvXa6V0reQsExAU6bcNoMPIhmBI49XXC2BAl9aPYa4q7x/SPf3Xlyn8c+
 8QdpSTaVVIO0fg5FhgeiYPCP3eTG4WvGkLJvVZdPYIFTEYIKEvXCfBR1s+hgSxz3ZqJ0
 mc0weDRcfgIef7fddqjpyF0zweuDJV7YNDZeInXU0FaOs3Sw8ZzpMaAxQ123xWQfN08I
 K/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O+xugMGUChfjgxU/U3b2H0ca9pHJP1OdBZSZQ1thY2o=;
 b=LzZrvV1q07tY7ETo4PNRm8AjdiwdMP7kdPJCKhv33lC1OHHU1/3V9S8axfaLAVs+Jv
 lGzqW8bvnbKEOwAZeSgxW4HdQ+udj5BuicDML29DBwvCcggIOIMYwoE338+38QJ49au3
 xOXwPGG0kEyBRTZNe5RhosFq3UKE7/oRLbQu9WMztqqPtNfmYCGWdGXYowFll7QKjsDx
 8gXdBjJ0S/uFYlZ80tSRwwCXBJn9dHmzDwk8RXsUePL9pVMIHOU6aqNpcBPrhJRb1lLI
 waxDHpnx6JM7pcHX8xA/QkW6OfzWe1DevFLgpUasUBQs7loNvEg7GYU1ArlU3/KIJbOW
 8jdg==
X-Gm-Message-State: APjAAAVoINPvD6dHrnbEav4zRrZ9eMx/pemlbyOWCAWM00JWO9vRmB49
 5a4fd30n+NFNI/ZBFx5puHFKhM8SzJS7WrnXiUN24A==
X-Google-Smtp-Source: APXvYqylTYKeapG6WH1MnYnu1MeFtLcA7BRueYrvAKiHxwR/266bIzm4ktpsRBRH86KYwEbfJHu46O0NyNI1GvhbCvA=
X-Received: by 2002:a9d:562:: with SMTP id 89mr13822384otw.232.1569837195859; 
 Mon, 30 Sep 2019 02:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190927095926.22230-1-berrange@redhat.com>
In-Reply-To: <20190927095926.22230-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2019 10:53:05 +0100
Message-ID: <CAFEAcA9Gyqr_wfQGjPe6YOoPcvCha3O7RPz2saR3uQ7mX0qjzQ@mail.gmail.com>
Subject: Re: [PULL 00/11] Qcrypto next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 14:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit d4e536f336d3d26c9fafa2a2549aaa0b014f5b=
6b:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-09-24-v2=
' into staging (2019-09-26 10:13:39 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/qcrypto-next-pull-request
>
> for you to fetch changes up to befdba9edd20a896f4082adf6dfb613939a24e0c:
>
>   qcrypto-luks: more rigorous header checking (2019-09-26 16:34:02 +0100)
>
> ----------------------------------------------------------------
> Refactoring of LUKS support to facilitate keyslot updates
>
> No current functional change is expected with this series.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

