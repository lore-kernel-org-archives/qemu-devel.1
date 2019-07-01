Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50363C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E8421721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E8421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8jI-0005aZ-F0
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi5rk-0000Xu-Sb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 19:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi5ri-0002p2-Vw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 19:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hi5r2-0002V6-Te; Mon, 01 Jul 2019 19:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 175547FDCD;
 Mon,  1 Jul 2019 23:36:31 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60C811001B01;
 Mon,  1 Jul 2019 23:36:25 +0000 (UTC)
Date: Mon, 1 Jul 2019 20:36:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190701233624.GL5198@habkost.net>
References: <20190627212816.27298-1-jsnow@redhat.com>
 <002c8b04-250e-0f33-b623-7e3fd14e7b80@redhat.com>
 <20190701212725.GH5198@habkost.net>
 <7bbbb0fd-2aff-d1bf-bc59-abe62b0a6a04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbbb0fd-2aff-d1bf-bc59-abe62b0a6a04@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 01 Jul 2019 23:36:31 +0000 (UTC)
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

On Mon, Jul 01, 2019 at 07:17:39PM -0400, John Snow wrote:
> 
> 
> On 7/1/19 5:27 PM, Eduardo Habkost wrote:
> > On Thu, Jun 27, 2019 at 05:32:17PM -0400, John Snow wrote:
> >> I didn't actually mean to retain the RFC tag, but oh well.
> > 
> > I'm queueing patch 1-2 for QEMU 4.1.
> > 
> > Patch 3 will require more careful review.  If you can demonstrate
> > it fixes a problem in some use cases, we can call it a bug fix
> > and include it after soft freeze.  ;)
> > 
> 
> Right.
> 
> Mostly, it's that it ignores things like ctrl^c -- it ignores ANY
> failure. I don't think that it should.

Agreed.

> 
> In cases where QEMU crashes, the caller will now get an exception -- but
> the cleanup will still faithfully execute. There are some exceptions we
> may genuinely wish to suppress here, but it's hard to enumerate which
> ones without going too broadly.
> 
> It's fine to exclude this for now, but I think it's still something we
> want eventually.

We just need to ensure all callers of shutdown() are ready for
this change.  I know that scripts/device-crash-test expects
shutdown() to not raise an exception if QEMU crashed, inside
checkOneTestCase().  Maybe that's the only caller that needs to
change.

-- 
Eduardo

