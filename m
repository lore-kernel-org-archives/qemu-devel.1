Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA7C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEA4206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEA4206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIT9-0004b1-AH
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:25:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGISL-0004H2-Os
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGISK-0005U7-RD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGISK-0005So-JB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:24:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 694DA81105;
	Tue, 16 Apr 2019 07:24:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com
	[10.36.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB7260C43;
	Tue, 16 Apr 2019 07:24:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id A05161747C; Tue, 16 Apr 2019 09:24:30 +0200 (CEST)
Date: Tue, 16 Apr 2019 09:24:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 16 Apr 2019 07:24:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Joachim Durchholz <jo@durchholz.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416072430.92OXVfxl5peeNeLtwgYAHgSpZ4kcf5AQXQJnr-oudxs@z>

On Mon, Apr 15, 2019 at 03:10:09PM -0400, John Snow wrote:
> <CC'ing curses maintainer>
> 
> On 4/13/19 5:02 AM, Joachim Durchholz wrote:
> > Hi all,
> > 
> > what's the reasoning behind "We need a terminal output" in curses.c?

curses needs a terminal.

> > I don't really see a scenario where it's problematic if qemu emits
> > escape sequences to a pipe.

It's not about sending escape sequences.  A pipe simply doesn't support
all the tty ioctls (query terminal size, turn echo on/off, set all kinds
of terminal modes, ...).

> > I can see another scenario when this is problematic: Unit testing code
> > that directly writes to the console. E.g. testing BIOS code, or testing
> > operating systems when using the serial port is not an option.

seabios can work with the serial console just fine, try "qemu -nographic"

cheers,
  Gerd


