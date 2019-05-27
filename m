Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F46C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95112075E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95112075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVEwG-0000fh-E4
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:41:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tony@atomide.com>) id 1hV9Bq-0004x1-HA
	for qemu-devel@nongnu.org; Mon, 27 May 2019 02:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tony@atomide.com>) id 1hV9Bp-0006Xt-KF
	for qemu-devel@nongnu.org; Mon, 27 May 2019 02:32:58 -0400
Received: from muru.com ([72.249.23.125]:58780)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tony@atomide.com>) id 1hV9Bp-0006Wd-GQ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 02:32:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTPS id 70E5880F3;
	Mon, 27 May 2019 06:33:13 +0000 (UTC)
Date: Sun, 26 May 2019 23:32:50 -0700
From: Tony Lindgren <tony@atomide.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190527063250.GI5447@atomide.com>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 72.249.23.125
X-Mailman-Approved-At: Mon, 27 May 2019 08:40:09 -0400
Subject: Re: [Qemu-devel] Running linux on qemu omap
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	linux-omap@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

* Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> [190523 12:01]:
> What I use as reference for testing ARM boards [*] is the work of
> Guenter Roeck:
> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-q=
emu-arm.sh

I think Guenter also has v2.3.50-local-linaro branch in his
github repo that has support for few extra boards like Beagleboard.
Not sure what's the current branch to use though.

Regards,

Tony





