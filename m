Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8421C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A76620652
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A76620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi5P4-00076u-Te
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43423)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi3qB-000449-Ir
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi3q9-0007eO-KT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hi3pr-0007YM-GA; Mon, 01 Jul 2019 17:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56B26859FE;
 Mon,  1 Jul 2019 21:27:31 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6A4460852;
 Mon,  1 Jul 2019 21:27:26 +0000 (UTC)
Date: Mon, 1 Jul 2019 18:27:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190701212725.GH5198@habkost.net>
References: <20190627212816.27298-1-jsnow@redhat.com>
 <002c8b04-250e-0f33-b623-7e3fd14e7b80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c8b04-250e-0f33-b623-7e3fd14e7b80@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 01 Jul 2019 21:27:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/3] python: refactor
 qemu/__init__.py
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 05:32:17PM -0400, John Snow wrote:
> I didn't actually mean to retain the RFC tag, but oh well.

I'm queueing patch 1-2 for QEMU 4.1.

Patch 3 will require more careful review.  If you can demonstrate
it fixes a problem in some use cases, we can call it a bug fix
and include it after soft freeze.  ;)

> 
> On 6/27/19 5:28 PM, John Snow wrote:
> > There's a lot of code hiding in what is ostensibly a package
> > configuration file. Let's break that out into something more visible.
> > 
> > V2:
> >  - Retain python 2.7+ compatibility :(
> >  - Refactor shutdown a little more aggressively
> > 
> > John Snow (3):
> >   python/qemu: split QEMUMachine out from underneath __init__.py
> >   machine.py: minor delinting
> >   QEMUMachine: Don't suppress stack traces on close
> > 
> >  python/qemu/__init__.py                   | 502 +-------------------
> >  python/qemu/machine.py                    | 536 ++++++++++++++++++++++
> >  python/qemu/qtest.py                      |   2 +-
> >  scripts/device-crash-test                 |   2 +-
> >  scripts/render_block_graph.py             |   2 +-
> >  tests/acceptance/avocado_qemu/__init__.py |   2 +-
> >  tests/acceptance/virtio_version.py        |   2 +-
> >  tests/migration/guestperf/engine.py       |  22 +-
> >  tests/qemu-iotests/235                    |   2 +-
> >  tests/vm/basevm.py                        |   3 +-
> >  10 files changed, 556 insertions(+), 519 deletions(-)
> >  create mode 100644 python/qemu/machine.py
> > 
> 

-- 
Eduardo

