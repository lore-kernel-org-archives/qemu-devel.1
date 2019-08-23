Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C2EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E1B82082F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1B82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DdZ-0001yW-K2
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i1DZo-0007lw-Fg
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i1DZn-00018q-HD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:42:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i1DZn-00018L-52
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3955A8553A;
 Fri, 23 Aug 2019 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-81.rdu2.redhat.com
 [10.10.124.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3244C5D9CA;
 Fri, 23 Aug 2019 17:42:05 +0000 (UTC)
Date: Fri, 23 Aug 2019 13:42:03 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190823174203.GA25178@localhost.localdomain>
References: <20181109150710.31085-1-crosa@redhat.com>
 <20181109150710.31085-2-crosa@redhat.com>
 <CAFEAcA86JT-3jLV=+aqLntoe1jJr77VYvg1dWn9OBVGA6cPZmQ@mail.gmail.com>
 <20190822211636.GA23027@dhcp-17-173.bos.redhat.com>
 <20190822215420.GO7077@habkost.net>
 <20190823134054.GA3936@localhost.localdomain>
 <CAFEAcA_dE20A+Ys4G6WSC+HfUGgQbYA65K=cmg7f3khwHWyHGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_dE20A+Ys4G6WSC+HfUGgQbYA65K=cmg7f3khwHWyHGg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 23 Aug 2019 17:42:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Julio Montes <julio.montes@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 02:44:15PM +0100, Peter Maydell wrote:
> On Fri, 23 Aug 2019 at 14:41, Cleber Rosa <crosa@redhat.com> wrote:
> > I see it being used by humans, so that brings a lot of subjetivity
> > into the matter.  IMO this is not out of place within the build
> > system, given that a lot of requirements detected by configure will
> > print out their versions (GTK, nettle, spice, etc).
> >
> > But I'm certainly OK with dropping it if no value is perceived by
> > anyone else.
> 
> I'd be happy with keeping it in the human-readable output
> that configure emits: if it's the wrong format there that's
> pretty harmless. But we shouldn't feed it into the makefiles
> unless we really need it, and we shouldn't let the format
> of whatever we do feed into the makefiles be driven by
> the desire to print something human-readable in configure's
> output -- there's no need for the two things to be the
> exact same string.
> 
> thanks
> -- PMM

I couldn't agree more.  The shortcut taken to print both the human
readable version and use that to check the version in the makefile was
unfortunate.

I'll send a fix proposal in a few.

Best,
- Cleber.

