Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764DCCA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1CC21D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1CC21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPlX-0001z7-97
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLPkX-0000yy-Bt
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLPkW-00047D-CY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLPkW-00046Q-6V
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:44:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 697FB19D04A;
 Fri, 18 Oct 2019 10:44:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2B21001B03;
 Fri, 18 Oct 2019 10:44:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 54BEC16E08; Fri, 18 Oct 2019 12:44:39 +0200 (CEST)
Date: Fri, 18 Oct 2019 12:44:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Python 2 and test/vm/netbsd
Message-ID: <20191018104439.c2tojlvi2c5zzesi@sirius.home.kraxel.org>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net>
 <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017225548.GL4084@habkost.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 18 Oct 2019 10:44:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Running with V=1, I see packages being downloaded at reasonable speeds, but
> > there's a huge interval (of various minutes) between each package download.
> 
> I've found the cause for the slowness I'm seeing: for each file
> being downloaded, the guest spents at least 75 seconds trying to
> connect to the IPv6 address of ftp.NetBSD.org, before trying
> IPv4.

Ah, that nicely explains why it worked just fine for me.  First, I have
a local proxy configured so the installer isn't going to connect to
ftp.NetBSD.org directly.  Second I have IPv6 connectivity.

> I don't know if this is a NetBSD bug, or a slirp bug.

Both I'd say ...

First, by default slirp should not send IPv6 router announcements
to the user network if the host has no IPv6 connectivity.

Second, the recommended way to connect is to try ipv4 and ipv6 in
parallel, then use whatever connects first.  Web browsers typically
do it that way.  wget and curl don't do that though, they try one
address after the other, and I guess this is where the delay comes
from ...

cheers,
  Gerd


