Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2289EC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 06:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B1820857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 06:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w4Nepg0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B1820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3DsU-0004aS-2b
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 01:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jhogan@kernel.org>) id 1j3Drp-0004As-55
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 01:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jhogan@kernel.org>) id 1j3Dro-0006bQ-5Y
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 01:57:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jhogan@kernel.org>)
 id 1j3Drn-0006ZK-W5; Sun, 16 Feb 2020 01:57:24 -0500
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 75AAB20857;
 Sun, 16 Feb 2020 06:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581836242;
 bh=f9J9WZdz0jNXqOWd3WzaI/Sg4SrVNNC5I0+M1E2CUUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=w4Nepg0+xIg0wQ6rbRvTStSEYPeqriwrJUsSgCNatW7uFhuaWPVMC6GXVLBGYM0oU
 TCI85j+ooMtbyyGXSWUDEQHCjujJ87bbavIrwS+0UdBjRGd82yV0U2/iEE20zOdriC
 r/19Nj5kGoFg/xE5/7VW2zLghbWRsj3MXtPnhBOQ=
Date: Sun, 16 Feb 2020 06:57:17 +0000
From: James Hogan <jhogan@kernel.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
Message-ID: <20200216065717.GA145683@jamesdev>
References: <20191221155306.49221-1-jhogan@kernel.org>
 <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
 <CAL1e-=jdpp2W-B1cERU4srRQUkPTjewM3hVrndoh4nr-vPSRGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=jdpp2W-B1cERU4srRQUkPTjewM3hVrndoh4nr-vPSRGA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philippe@mathieu-daude.net>,
 Paul Burton <paulburton@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 01:34:57AM +0100, Aleksandar Markovic wrote:
> On Wed, Feb 12, 2020 at 7:44 PM Philippe Mathieu-Daud=C3=A9
> <philippe@mathieu-daude.net> wrote:
> >
> > Cc'ing qemu-trivial@ & Paolo.
> >
>=20
> We are in the process of handling this within the company, and this
> patch should go via MIPS tree, not trivial tree - will be updated when
> the opinions are crystallized, and all consultations with others were
> done. There is no rush.

Hi Aleksandar,

I respectfully disagree. In the mean time I am still listed as
maintainer even though this patch has reflected reality for more than 18
months since the 2018 closure of the MIPS UK offices.

If "the company" wish to eventually crystalize their opinion and assign
someone else this role (which they've had at least 6 weeks to do even
since I sent the patch) they can always submit a new patch.

In the mean time I'd appreciate if somebody could take the patch ASAP.

All the best,
James

