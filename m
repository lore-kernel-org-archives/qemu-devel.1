Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FAC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5491207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arRDZcuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5491207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMai-0003pk-Ox
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieMa1-00035z-Do
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieMa0-00075f-AA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:12:17 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieMa0-00075Q-54
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:12:16 -0500
Received: by mail-oi1-x241.google.com with SMTP id l136so7027273oig.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tH3nH9vAR/cevfOzEGeVj+Y0Tvx4fu2zZJXf1Z/dLY0=;
 b=arRDZcuP2Hp4ME7mRW7s3n7rsQXcRLN38tsnkay87lRfhczACMjmhmj6iIYY0vh6EL
 2QLTvbqm/gFjI086ODXh72HFKsx2AmMWfyC1iFF/7AJIQlmIRcV/QFtCneykyM5ZyGvH
 jELCI0BbGmH3exvyfKpTurkN91y+hPwOP61yxOitaEx+CvHc4FIqO5iOujHdX1I57FDr
 E9dMAKsl+4ez2f2kyJ3xWYrjH+q8L8ys6qbPQmJky28Z0wwUJGNWJxz48rJuw7/shnhn
 lp1up09LPdnrbdob0PoPaZMzbq83BDAE0Kq2jp16JmR8mbrx7xLTOXOrf8vpNbg6jJ8T
 L+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tH3nH9vAR/cevfOzEGeVj+Y0Tvx4fu2zZJXf1Z/dLY0=;
 b=boQhg30p21ByZTExmX+/qjFGp0H6xs6fA/kSrjO1qoS9LxgZhDIjQnbw8u0JO9oY+K
 XEvq8BCGbOziMPJGFDuylFK2/IUG+DOjk8B3oo5xLL8MKS0+xivq/A0T1iLkyoNYIWXT
 dvhcbvblD3eWv4rIExOVImqVkGCcXZgcXWqY/9HdvJag+BXJ8TIfsa3qfvvJtQrLH50n
 bxISMTkVO+7Ax83DxRaBVYu4DxNWZ2177d9+VydpzKLfkwkOBxmw6RwkCdFIYSSRCapR
 Ruyg9gKfmu0Gxb2MFY+bXk5FwqVtCkO3TyaGRm/AaNThBHhT0cRQmSP7NM1cYydgw5Gr
 mSFg==
X-Gm-Message-State: APjAAAVHpfVvQbyVAgk91F+yeSV2kOPDEtV/XGokQ9CaBS8HWjd/VhkP
 ooxBIUG052n0Kp9JoKTyop/jiPeIIX9PBSonnN9ZPbDd
X-Google-Smtp-Source: APXvYqyCBGZIcMfYZjm9ciXGlEvXXGwRMAVdHK8EKXD0Ox/1FL5OsaMAUegDzYtwtA4mzeEajWBz70pdCtxpgz10Hk8=
X-Received: by 2002:aca:f484:: with SMTP id s126mr90037oih.48.1575911535333;
 Mon, 09 Dec 2019 09:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20191209160015.20253-1-eblake@redhat.com>
In-Reply-To: <20191209160015.20253-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 17:12:04 +0000
Message-ID: <CAFEAcA82rugwnF7zrgtgTfCaZVM9q4Av7hT_Z6Pnw6htMOSb6g@mail.gmail.com>
Subject: Re: [PULL for 4.2-rc5 0/1] Bitmap fix for 2019-12-09
To: Eric Blake <eblake@redhat.com>
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 at 16:00, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 8350b17be015bb872f28268bdeba1bac6c380efc:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191209' into staging (2019-12-09 11:07:34 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-12-09
>
> for you to fetch changes up to f56281abd957561b30538cbe606c3793b9b4c56d:
>
>   block/qcow2-bitmap: fix crash bug in qcow2_co_remove_persistent_dirty_bitmap (2019-12-09 09:23:04 -0600)
>
> [I know I'm not the usual bitmap maintainer, but John agreed that I could
> get this posted faster than he could: it affects incremental bitmaps
> which is tangentially NBD-related, and we're already on a tight timeline
> given this is 4.2-rc5 material]
>
> ----------------------------------------------------------------
> bitmap fix for 4.2-rc5
>
> - Fix a regression that broke bitmap deletion without a transaction,
> and causes a crash with transaction (only transaction is new to 4.2),
> when a qcow2 file contains persistent bitmaps from prior shutdown
>
> ----------------------------------------------------------------
> Vladimir Sementsov-Ogievskiy (1):
>       block/qcow2-bitmap: fix crash bug in qcow2_co_remove_persistent_dirty_bitmap
>
>  block/qcow2-bitmap.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

