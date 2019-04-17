Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84048C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 07:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F03120675
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 07:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F03120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48207 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGeiu-00018C-1s
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 03:11:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGei9-0000nH-Fc
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGei7-0000nn-0t
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGei3-0000lz-A8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28E6830ADBD3;
	Wed, 17 Apr 2019 07:10:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com
	[10.36.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B568E5D9D6;
	Wed, 17 Apr 2019 07:10:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 4D4301747B; Wed, 17 Apr 2019 09:10:12 +0200 (CEST)
Date: Wed, 17 Apr 2019 09:10:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Joachim Durchholz <jo@durchholz.org>
Message-ID: <20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
	<00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 17 Apr 2019 07:10:15 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417071012.0XxbenhqjTapry79Fz_XS1_012czgfa5JXUsZoXv9pA@z>

  Hi,

> Then I don't understand why it just ran fine.
> I don't expect fullscreen output to work perfectly anyway;

If you don't expect the output to actually work,
then fine, feel free to comment out that check.

I don't consider that being a sane approach though.

> just enough so I can use qemu expect-style.
> 
> Also, is qemu -curses actually using all the terminal shenanigans?
> I don't think so. If it is, it's not really needed it seems, things work
> fine.

The curses library depends on them, sure.  How else do you think the
curses UI manages to work correctly no matter how big your terminal
window is?

> > > > I can see another scenario when this is problematic: Unit testing code
> > > > that directly writes to the console. E.g. testing BIOS code, or testing
> > > > operating systems when using the serial port is not an option.
> > 
> > seabios can work with the serial console just fine, try "qemu -nographic"
> 
> Well, can you tell me how convince any *BSD to talk to seabios intead of to
> the terminal...

All boot loaders I've seen so far actually talk to seabios.  Which is
enough to enable the kernel's serial console support.  The general
approach is the same on any unix-ish guest operating system.  The
details may vary of course.

FreeBSD:
 (1) qemu-system-x86_64 -nographic -cdrom FreeBSD-11.0-RELEASE-amd64-disc1.iso
 (2) At the bootloader menu hit '3' (Escape to loader prompt).
 (3) set console=comconsole
 (4) boot

Figuring the procedure for other guests is left as an exercise to the
reader.

cheers,
  Gerd


