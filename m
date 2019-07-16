Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA8C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277942173C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYAqV6yA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277942173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnP1q-0002gR-3T
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnP1V-0001kR-9y
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnP1T-0007nB-Ha
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:05:45 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnP1T-0007mx-BL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:05:43 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r21so15354879otq.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B6Wl8PTRZwJ8FBJBXJIfSMq/AWfMfkZBMwh0VM166o0=;
 b=TYAqV6yAxFdvOBU/XtB50Ntod5YBBNoK2w77su4/8aSso9b58/nn5tynSDcqzder4r
 n0Ut8tSKIn50p/dJQfiS5OXhzaqqkRBcdgsm/iONbqOj3IssPgQIEIbjzxyX9U+wK453
 45zmJtm1NjMkCjPJwYf32E7cmRhTDGfTIZuxSBbnEITeOhOrwHLEeFvdkHiA9FHxwWfv
 JVhSQuE6r29IqE+ypKhulETyj6WigetgGiamxCNegXY49lx1ZFWZnzLEByG0WUfPnouj
 1XO1fgHgm/Yxo0rewhV0IOXJcDSwWBBcIAMn2dP0uBTH2mWNvzZeScjohkJ66dVeFkoE
 wMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B6Wl8PTRZwJ8FBJBXJIfSMq/AWfMfkZBMwh0VM166o0=;
 b=exJXAYLr7u1sPI2f6UQkHQ7PjUA/j0xqjBS3IzYxfN1RNxT3w6S5/3CigKZ5u0cazm
 MdSheUWGtZY61U+CcRfPXe5GLrVXcY/EWGJj2DRxPZkQhNQ0gRCsnjqs7Fy/CDsZoRKK
 uTrG/wTkKlXpmHR639jjTs3Ihsz11dOdNmbpTHOlaX5C+jgTkUZjIq4ifQT8hibYwU0e
 jWmepB6u+5q3wMGucQ1fuLbFoKFAPmn2xnfd7WErdBncXO8oHdebRFcmHW/GWHWiSvc/
 I0ZW2w1AD88CyWabQiHnG3t6tp5foM8qBwgzag/cGZs1d6/lFNeG4wx2BSW7H1PT5pR1
 QnDg==
X-Gm-Message-State: APjAAAUIHNa8uKAEkvyiHvwnaraJgXEhRusL7PeUctpmJBoHWnvZLNsd
 I+K/NM43oKKIsUS+jcu6e2BLDw7uYRZU0HBhiaLo9Q==
X-Google-Smtp-Source: APXvYqwvUL/FM3+kltEdosPuXezj2q/tQBLTVZ1Uhlfefk5oIqNwwxiBdrWkCJ9dfEMvT8Mq9htwhDQdecncB9FYeOY=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr17921779otr.232.1563289542228; 
 Tue, 16 Jul 2019 08:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 16:05:30 +0100
Message-ID: <CAFEAcA-wdKUyhBAsAzut26u6R9ZSqvd2ZMDgL3Nz+n0hB-hwsw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] [PULL 00/19] Bugfix/cleanup patches for 2019-07-16
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

On Tue, 16 Jul 2019 at 09:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 46cd24e7ed38191b5ab5c40a836d6c5b6b604f=
8a:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-07-12 17:34:13 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 45d8bc3adedeceaf449d758aee1810bfbe6feff4:
>
>   vl: make sure char-pty message displayed by moving setbuf to the beginn=
ing (2019-07-16 09:27:16 +0200)
>
> ----------------------------------------------------------------
> * VFIO bugfix for AMD SEV (Alex)
> * Kconfig improvements (Julio, Philippe)
> * MemoryRegion reference counting bugfix (King Wang)
> * Build system cleanups (Marc-Andr=C3=A9, myself)
> * rdmacm-mux off-by-one (Marc-Andr=C3=A9)
> * ZBC passthrough fixes (Shinichiro, myself)
> * WHPX build fix (Stefan)
> * char-pty fix (Wei Yang)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

