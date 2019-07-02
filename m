Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B85C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A40D21881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 20:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTr7BMKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A40D21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiPBc-0001KC-MM
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 16:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiN1N-0007zJ-6L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiN1K-00080n-Bw
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:56:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiN1I-0007w9-6Q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:56:46 -0400
Received: by mail-ot1-x343.google.com with SMTP id r6so18112886oti.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6ypybhHTSakSrI0RjCgtTaKbeCzJZMT5B7yDa0CbwfA=;
 b=RTr7BMKT4wIl6urD3cTORJ8Bo0a6ULiQshmAUcEQf8ni07zRzt7k1+WN57ni5EdceS
 0B2Og3jptenvy9/ZWpgVgCEvZpoRUAmESp/hqFelablb3QjTSyX9mJQvO4OO1u95Woi5
 A39l1wu+ESCDJgxYhRdX+TQQOD32wCB06Uc9cbTkV23iwJZLxIbOsb7Ekam+NB93E8Xw
 ZgXXrmkcLpvM09WLRW4OLSiaJ2FNFoyCU6+icvpnpovi0oeSLergNZrXkoxSSk7iDph+
 qsojAMPWcgf9zy5q8oa7bLF0vZM2ZIy/8H9C56zOT8ydyLeCzMiSk7J+uqEkWdx9lLHb
 ISMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6ypybhHTSakSrI0RjCgtTaKbeCzJZMT5B7yDa0CbwfA=;
 b=HQEu1CJxP73gocGbH85oNHw8bvVQWIMp1hi3WgDLP2vhQj4MiU81cxznLmCYXkdqc+
 tR1F59t8pj/Utt12DuYzQg9Y1tkCOT27PrboMIqe+FR5nh0Y5HO051/8/wDvOaCGK4EW
 oPU4vFQFf91mYQB1LCKuEvlKfZJ+pp/119cbTfdcycplJ9u6en2OEQwCrsr8GiH07alP
 5QV78LYEtChW1WZYPnc4/swYO8pOANq0rA52dhr54Rke3645so1butzrBFkT+TERCc1o
 vM2E+v4vSOkg+xnk9Aq8Lzp9Nh+DjVYbxlV9Xnu4jasVBSvUCd8eYVY2fDdtRkNAn9cr
 IWwQ==
X-Gm-Message-State: APjAAAWCulpMJFtVbERHRRpbOr8zmMvCGeyf0RO6CiEuEGd/91geRL3C
 CR3VNU/LTOjYWjcf9L9p6f2dOhuN7ox8/aQiWil7RA==
X-Google-Smtp-Source: APXvYqyrEcfU8HDJwEk1w8npaP+7PxYlX3WbBGNQk5A8QdGMuQrQJin5YCU5RDgzsuBZp4fNRbSPgIm1WS+gm2Ilio4=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr3279771otk.221.1562090197775; 
 Tue, 02 Jul 2019 10:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005912.15905-1-philmd@redhat.com>
In-Reply-To: <20190702005912.15905-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 18:56:26 +0100
Message-ID: <CAFEAcA84dYRwOix4v5PKOF=OwD2S-5w1HigbnvZ1kS=Zga4QWg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/27] pflash-next patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 04:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/pflash-next-20190701
>
> for you to fetch changes up to 3ae0343db69c379beb5750b4ed70794bbed51b85:
>
>   hw/block/pflash_cfi02: Reduce I/O accesses to 16-bit (2019-07-02 02:34:=
55 +0200)
>
> ----------------------------------------------------------------
>
> Implement the following AMD command-set parallel flash functionality:
> - nonuniform sector sizes;
> - erase suspend/resume commands; and
> - multi-sector erase.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

