Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6EFC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD21E2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="OxlTSzKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD21E2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSODB-0000df-Q7
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin@koconnor.net>) id 1iSOBO-0007VD-1c
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1iSOBM-00060r-U8
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:29:21 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29]:34050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1iSOBM-00060K-NA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:29:20 -0500
Received: by mail-qv1-xf29.google.com with SMTP id n12so1662027qvt.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gt/jaFnNiNT1ETRoNb+nOTFUSxgl0Qg0e9HJerXVFK8=;
 b=OxlTSzKlPCyBfbTRE1qltDzg/NoVOtWUBNXtg7Uh3Dftk3+PFdRrJaHz5Z2A68t729
 jbSWtOyU6+/OYlZsU7EStcF3yu0cnkw/uYcE8IZYH7w0hk98iIWYYEZPc7cvp7qXdc2t
 inNUfupltnQphI6Cn0k8y+QCwvoZ7C8CFOAdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gt/jaFnNiNT1ETRoNb+nOTFUSxgl0Qg0e9HJerXVFK8=;
 b=p2eCKWfiZtlnGu8uI/iKEyUwK5vPOSUXMHeYhCHl2j8IC8oayWWJkxmBio/TcT3sAC
 aefGPz1SKQn2YGFhU9WBQ6VbiiyQYZXDE4cqbREykAaMw1EXQcXqHkAhOYzV8QFDEKYX
 8rPdatJaPNVd4cBX0TU/oxI2weXh18+dpIv4N4///HYnlOqNN9RfC0YE1MQ/us8X4xGS
 y+C86M9wbHb3FDyw0VPRxgMukZB9OEGjbxj4Je297ipZ1FZCzeIwUOWxWOKu2CjJd/l+
 o+klYhtiFxzxZ96XgNOTKUN410Z5WWOzCVwV7vI9jtvWLpo8KXNcrkm6CazWWgUPd8rq
 7brA==
X-Gm-Message-State: APjAAAX1xwD46j3cQMnwV2lVREz9gpLwkYMAMoaf6cFoZa5Xz7/6OZSh
 dr0MYrhlARjgt/NhprsmJKRx0w==
X-Google-Smtp-Source: APXvYqzanNSJkZyxGr58RoKiqY8BKksZj7YcV1kjB44rMVsR3+/fPuYf3VeVdaF9zmzc38v5gfbwFw==
X-Received: by 2002:a05:6214:14ac:: with SMTP id
 bo12mr3045397qvb.67.1573057759794; 
 Wed, 06 Nov 2019 08:29:19 -0800 (PST)
Received: from localhost ([64.9.249.132])
 by smtp.gmail.com with ESMTPSA id u1sm8068923qkf.136.2019.11.06.08.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:29:19 -0800 (PST)
Date: Wed, 6 Nov 2019 11:29:18 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [SeaBIOS] Re: 1.13 release?
Message-ID: <20191106162918.GC19095@morn.lan>
References: <20191016104412.ut3jxjwjf64qsjbk@sirius.home.kraxel.org>
 <20191106111255.aladyvsumr2kw47b@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106111255.aladyvsumr2kw47b@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f29
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
Cc: seabios@seabios.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 12:12:55PM +0100, Gerd Hoffmann wrote:
> On Wed, Oct 16, 2019 at 12:44:12PM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > Almost a year since 1.12.0 was tagged (Nov 17th to be exact),
> > time to plan the 1.13 release I think ...
> > 
> > How about freeze in a week or two, release by mid-november?
> > 
> > Pending stuff I'm aware of is the disk geometry patch series.
> > The corresponding qemu series is still waiting to be merged.
> 
> It's finally merged in qemu now.  Going to push the seabios
> series and prepare a seabios update for qemu, so upcoming
> seabios release gets some more test coverage.

Okay, thanks.

If we're going to update that in SeaBIOS, then we may wish to push
back the SeaBIOS release by a few weeks.

-Kevin

