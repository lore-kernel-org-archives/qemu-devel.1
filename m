Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75619C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 11:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE552073A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 11:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE552073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx7Ja-0005um-Do
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 07:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1jx7Ig-0005UD-B0
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 07:16:10 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:57180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1jx7Id-00085K-VA
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 07:16:10 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 326E1109E;
 Sun, 19 Jul 2020 13:16:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hn6TZsUQQtGu; Sun, 19 Jul 2020 13:16:04 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr
 [86.234.239.11])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 32AC61084;
 Sun, 19 Jul 2020 13:16:04 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1jx7IY-00B1ay-Qw; Sun, 19 Jul 2020 13:16:02 +0200
Date: Sun, 19 Jul 2020 13:16:02 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Ottavio Caruso <ottavio2006-usenet2012@yahoo.com>
Subject: Re: Is traceroute supposed to work in user mode networking (slirp) ?
Message-ID: <20200719111602.2xeu4ise6zlbvf4c@function>
References: <CAEJNuHy+CqveTjiCxpjiLX-D=NczSveUSDSAZyz=D5F0XvL5QQ@mail.gmail.com>
 <CAEJNuHze25wdA_Kjw8ryi+hmg0eLP8nhZMR50_2yqXPu_Jir9A@mail.gmail.com>
 <20200719025055.kkjjiegyn4t6x64v@function>
 <CAEJNuHyYR1Vj4VaDVPLUG1dkSdzHjzbiCqq=Q+2j1tjy7kYBCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEJNuHyYR1Vj4VaDVPLUG1dkSdzHjzbiCqq=Q+2j1tjy7kYBCw@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Received-SPF: softfail client-ip=185.233.100.1;
 envelope-from=samuel.thibault@gnu.org; helo=hera.aquilenet.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 07:16:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ottavio Caruso, le dim. 19 juil. 2020 12:07:21 +0100, a ecrit:
> On Sun, 19 Jul 2020 at 03:50, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > Ottavio Caruso, le mar. 14 juil. 2020 12:15:48 +0100, a ecrit:
> > > I cannot get traceroute to work with standard udp from any of my
> > > guests.
> > >
> > > $ traceroute 8.8.8.8
> > > traceroute to 8.8.8.8 (8.8.8.8), 64 hops max, 40 byte packets
> > >  1  * * *
> >
> > That was because
> >
> > - libslirp was not forwarding the ttl value, thus always set to 64 hops
> > - libslirp was not reporting icmp errors.
> >
> > I had a try at both, and that indeed seems to be fixing the issue:
> > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48
> > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/49
> >
> > > Any clues? Is this intended behaviour? Any workarounds that don't
> > > involve tap/tun/bridges?
> >
> > Not without updating libslirp with the abovementioned patches.
> 
> Thanks Samuel. I've added a comment on the portal, but for the benefit
> of qemu-devel:
> 
> Applying this patch on the latest qemu (5.0.90),

Did you also apply
https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48 ?

Samuel

