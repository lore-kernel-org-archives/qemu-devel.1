Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13186C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924DB2339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="aPGCqvHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924DB2339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Qje-0004Zq-JQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin@koconnor.net>) id 1i0QiP-0003xx-9V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1i0QiO-0003hp-53
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:31:53 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:40570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1i0QiN-0003hB-SN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:31:52 -0400
Received: by mail-qt1-x844.google.com with SMTP id e8so2986326qtp.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=icNxAc3SJueTdCbiNprq6upBLcZecAhITMBd7lM/ujA=;
 b=aPGCqvHYCm26qX0bssHIC0HiWYJ/x/lIWWzWiJkRSnpa6Jg7Ilcsm18ogL+TiuO4Ya
 GJKz60dmGsalHSBK7vXbLGWpdH/tSxYYqLvpNc/p8vGAWLvZ6iDbfhE4+TWpmqRoZg2h
 m9srNhqjZtwF5CQShBjyoqiM/8YohdLeuKDC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=icNxAc3SJueTdCbiNprq6upBLcZecAhITMBd7lM/ujA=;
 b=e7HSrbvY46UKrXz+VL0uKDKpwtqHYnYdELK6fBUGc+CqPCqRKnLEH3nyzSr2DsXHxg
 gxpbZWHBB4vuhVgE9Utbk4Jyp7tqDZF4gxHz6lD14xcXDDQ//GsYMwDZiiyAXbhIHmtO
 sT9DmR73l1Kcx2e7yxLHDHsjnz9bnkWLb+bWXvde67cCUC4WjXFiTKX8woWsiYR+O0Gz
 D8T3LKEunhb3CEu3BU8EPMPrnQFiY1lO7fMmXkfk5lFonkkOOpSP5AGDxaDpnz/XQpra
 skyuI9EKFDA84yBlbjSiQd9NbpMtnKH/gV8ORA3wezSoXPKEGMb7DIkuNUO5BCyQBSnf
 cYMw==
X-Gm-Message-State: APjAAAUY2iAdsBK7r4jbtEWsCTJVGJV9KOPGlF3kpyvE3LIykU87+oYf
 XPdZEbDF99F3xXSYsW0GW65wBg==
X-Google-Smtp-Source: APXvYqyj1hRK6P1i97kIqjrjSPz8+/Z7lu2uePM/zJPDbdfv/i1N6XuP/n4MfBaDrQEnLGsK8ltfyA==
X-Received: by 2002:ad4:560d:: with SMTP id ca13mr3745423qvb.44.1566394310621; 
 Wed, 21 Aug 2019 06:31:50 -0700 (PDT)
Received: from localhost ([64.9.249.146])
 by smtp.gmail.com with ESMTPSA id 136sm10634706qkg.96.2019.08.21.06.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 06:31:49 -0700 (PDT)
Date: Wed, 21 Aug 2019 09:31:48 -0400
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190821133148.GA20226@morn.lan>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <7f6e8a5c-8262-ae39-333a-e8f18b3174f0@redhat.com>
 <20190821064208.eckikvttpdc3zjmd@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821064208.eckikvttpdc3zjmd@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [SeaBIOS] Re: Regression with floppy drive
 controller
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
Cc: Alex <coderain@sdf.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 seabios@seabios.org, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 08:42:08AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > Using the default QEMU config, we build SeaBIOS to use the TSC timer:
> > 
> > builds/seabios-128k/.config:CONFIG_TSC_TIMER=y
> > builds/seabios-256k/.config:CONFIG_TSC_TIMER=y
> 
> > Do we need a cpu with TSC support to run SeaBIOS?
> 
> Hmm.  seabios uses pmtimer if available.  isapc has no pmtimer though,
> so it uses TSC instead.

But, SeaBIOS should have automatically detected no TSC and then fallen
back to the PIT.  And the check does work correctly with "-cpu 486" in
my tests.

Is the PIT not working for some reason in the original setup?  (Any
time I attempt to run with "-M isapc" I just get an "Unable to unlock
ram - bridge not found" error.)  The PIT seems to work okay in my
setup.

-Kevin

