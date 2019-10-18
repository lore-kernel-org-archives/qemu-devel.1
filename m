Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E79CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFC121D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFC121D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUok-000520-HL
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iLUfy-0004UK-0K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iLUfv-00032X-NL
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:00:25 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iLUfu-00031p-So
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:00:23 -0400
X-IronPort-AV: E=Sophos;i="5.67,312,1566856800"; d="scan'208";a="323214373"
Received: from unknown (HELO function) ([193.50.111.121])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384;
 18 Oct 2019 18:00:20 +0200
Received: from samy by function with local (Exim 4.92.2)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iLUfr-0006xf-Sk; Fri, 18 Oct 2019 18:00:19 +0200
Date: Fri, 18 Oct 2019 18:00:19 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Python 2 and test/vm/netbsd
Message-ID: <20191018160019.he52tpvjqolzgswg@function>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net>
 <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
 <20191018104439.c2tojlvi2c5zzesi@sirius.home.kraxel.org>
 <20191018142940.GN4084@habkost.net>
 <a0c2df74-360b-79de-132e-f4d5be5bfc12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0c2df74-360b-79de-132e-f4d5be5bfc12@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.104
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daudé, le ven. 18 oct. 2019 16:58:00 +0200, a ecrit:
> On 10/18/19 4:29 PM, Eduardo Habkost wrote:
> > On Fri, Oct 18, 2019 at 12:44:39PM +0200, Gerd Hoffmann wrote:
> > >    Hi,
> > > 
> > > > > Running with V=1, I see packages being downloaded at reasonable speeds, but
> > > > > there's a huge interval (of various minutes) between each package download.
> > > > 
> > > > I've found the cause for the slowness I'm seeing: for each file
> > > > being downloaded, the guest spents at least 75 seconds trying to
> > > > connect to the IPv6 address of ftp.NetBSD.org, before trying
> > > > IPv4.
> > > 
> > > Ah, that nicely explains why it worked just fine for me.  First, I have
> > > a local proxy configured so the installer isn't going to connect to
> > > ftp.NetBSD.org directly.  Second I have IPv6 connectivity.
> > > 
> > > > I don't know if this is a NetBSD bug, or a slirp bug.
> > > 
> > > Both I'd say ...
> > > 
> > > First, by default slirp should not send IPv6 router announcements
> > > to the user network if the host has no IPv6 connectivity.
> > > 
> > > Second, the recommended way to connect is to try ipv4 and ipv6 in
> > > parallel, then use whatever connects first.  Web browsers typically
> > > do it that way.  wget and curl don't do that though, they try one
> > > address after the other, and I guess this is where the delay comes
> > > from ...
> > 
> > In addition to that, the connect() error should be generating a
> > ICMP6_UNREACH message, and I'd expect the NetBSD guest to notice
> > it instead of waiting for timeout.
> 
> Is this missing in SLiRP?

It was implemented at the time of introduction of IPv6 in SLIRP. Perhaps
NetBSD has a slightly different behavior which makes the implementation
fail to notice the error.

Samuel

