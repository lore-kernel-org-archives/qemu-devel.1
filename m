Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC0DC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C91E206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C91E206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzhc-0007Gm-EN
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:11:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJza1-00088I-Vs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJzLf-00013l-Fl
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:49:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJzLf-00013M-AJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 533171244DF;
	Fri, 26 Apr 2019 11:48:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 15D8D6606F;
	Fri, 26 Apr 2019 11:48:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 4FBB011AAF; Fri, 26 Apr 2019 13:48:57 +0200 (CEST)
Date: Fri, 26 Apr 2019 13:48:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Lin Ma <lma@suse.com>
Message-ID: <20190426114857.jrso2nox5tdgtp5k@sirius.home.kraxel.org>
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
	<20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
	<ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 26 Apr 2019 11:48:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] About pt-br keyboard layout
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
Message-ID: <20190426114857.QGKTSDPHbkH53OY-0TTHaJpBpDGwkmRzHkWwrS7td4o@z>

> > So -k must match the *hosts* keyboard layout.
> So, that means, If I launch qemu with -k pt-br on a host, I need to ens=
ure
> the keyboard layout
> must be pt-br as well onthathypervisorhost,Then when I connected to thi=
s vnc
> server(qemu)
> throughvncviewer on mylaptop(us keyboard layout), I type shift + 6, I c=
an
> get=A8(diaeresis)
> character, am I right?

No.  I've simplified a bit, assuming both vncviewer and qemu run on the
host machine.  -k $layout must match the keyboard layout of the machine
running vncviewer.  So, in your case it should be us (the laptops
layout).

cheers,
  Gerd


