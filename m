Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF30FC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA1F2464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA1F2464D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwXh-0005Is-Sj
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 14:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevans@freebsd.org>) id 1icwQ9-0001JO-47
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevans@freebsd.org>) id 1icwQ7-0003sQ-KX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:04:12 -0500
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2]:46366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevans@freebsd.org>) id 1icwQ7-0003np-EM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:04:11 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id 9F8E67E1DE
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 19:04:08 +0000 (UTC)
 (envelope-from kevans@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 47TQB0313kz4XQG
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 19:04:08 +0000 (UTC)
 (envelope-from kevans@freebsd.org)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
 (Authenticated sender: kevans)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 3FB9014EC7
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 19:04:08 +0000 (UTC)
 (envelope-from kevans@freebsd.org)
Received: by mail-qk1-f180.google.com with SMTP id i18so4247010qkl.11
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 11:04:08 -0800 (PST)
X-Gm-Message-State: APjAAAUj0b5KJYjHDVPJ48pOafAluKqEGByoNzUGOD4Md87ukpuZ8kbs
 3OXynffDzlfSbBCeISaxWCJTfaDvz2CwnQMwA4A=
X-Google-Smtp-Source: APXvYqxfFIPcDJ29F9aUfkgImdDkv/s0rqyuBJytKmmo/JWcUP/cV/aDtLR139A+6saqL94yNicQkbK9m373KBlxK60=
X-Received: by 2002:ae9:eb53:: with SMTP id b80mr10254574qkg.430.1575572646731; 
 Thu, 05 Dec 2019 11:04:06 -0800 (PST)
MIME-Version: 1.0
References: <20191029000757.r2ma5qt3zoic5ynd@shiva.audeuro.com>
In-Reply-To: <20191029000757.r2ma5qt3zoic5ynd@shiva.audeuro.com>
From: Kyle Evans <kevans@freebsd.org>
Date: Thu, 5 Dec 2019 13:03:55 -0600
X-Gmail-Original-Message-ID: <CACNAnaGw0NoWyW66T=YAABj+WDaZvJdw3N6miX+d_pycMaOEEg@mail.gmail.com>
Message-ID: <CACNAnaGw0NoWyW66T=YAABj+WDaZvJdw3N6miX+d_pycMaOEEg@mail.gmail.com>
Subject: Re: safe_syscall design guidance
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2610:1c1:1:606c::19:2
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
Cc: Warner Losh <imp@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 7:08 PM Kyle Evans <kevans@freebsd.org> wrote:
>
> Hi,
>
> We're working on improving bsd-user in a local tree and rebasing forward
> to get our work suitable for upstreaming. I'm porting the safe_syscall stuff
> over to bsd-user, and would like to get some design guidance as it may best
> be implemented with some refactoring of linux-user.
>
> Below is an example of the refactoring my initial approach takes. I'm
> omitting !x86_64 in this e-mail because it's all along the same lines and
> only including the part relevant to linux-user. Effectively, linux-user/host
> is moved to qemu-user/host along with ^/linux-user/safe-syscall.S.
>
> Some bits specific to FreeBSD, also likely other *BSD but I've not yet
> verified, are sprinkled throughout host/*/* parts; this is the main point I
> suspect may be objectionable. FreeBSD indicates syscall error differently
> than Linux, and *context bits are also different. Other OS-specific bits
> for other arch are similar to the diff below.
>
> A full version of this can be found in my tree, currently only available on
> GitHub: https://github.com/kevans91/qemu-bsd-user/tree/safe_syscall -- this
> is applied to our version, currently based on qemu 3.1.
>
> Thoughts?
>

We've settled on duplicating the linux-user side over to bsd-user for
now to make progress, and make another attempt to solicit design
feedback later when we've rebased the rest of our work forward to
modern qemu.

Thanks,

Kyle Evans

