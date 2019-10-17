Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B95FFA3739
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AF02089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AF02089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL3rI-00063j-NT
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL3qX-0005dn-Ju
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL3qV-00059Y-GK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iL3qV-00058s-B7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:21:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A0C46907A;
 Thu, 17 Oct 2019 11:21:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B373160167;
 Thu, 17 Oct 2019 11:21:22 +0000 (UTC)
Date: Thu, 17 Oct 2019 13:21:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] configure: Require Python >= 3.5
Message-ID: <20191017112121.GA9233@localhost.localdomain>
References: <20191016224237.26180-1-ehabkost@redhat.com>
 <7146bebf-6e99-f27a-3753-d48dea1977f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7146bebf-6e99-f27a-3753-d48dea1977f9@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 11:21:30 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.10.2019 um 00:48 hat John Snow geschrieben:
> 
> 
> On 10/16/19 6:42 PM, Eduardo Habkost wrote:
> > Python 3.5 is the oldest Python version available on our
> > supported build platforms, and Python 2 end of life will be 3
> > weeks after the planned release date of QEMU 4.2.0.  Drop Python
> > 2 support from configure completely, and require Python 3.5 or
> > newer.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Seems like a good time and place to mention this. Kevin, you require
> 3.6+ for iotests, which are -- at present -- invoked as part of "make
> check".
> 
> Do we care? Basically, this just means that iotests won't run for
> systems that don't have 3.6+, which would be platforms like Debian 9 --
> which is why ehabkost is choosing 3.5 here.

I think we were aware of this when we made the change to iotests. That
all tests of the current upstream QEMU version are run on Debian
oldstable (with the distro Python version) is, to say the least, not a
priority for me. They must not fail, but I'd say skipping is fine.

And actually, we should still have a reasonable coverage there with the
shell-based test cases.

Kevin

