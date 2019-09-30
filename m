Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72879C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A7121855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 14:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A7121855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEwjH-0002DO-CZ
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 10:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEwgz-0000fb-HE
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEwgy-00060O-6M
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 10:30:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEwgt-0005z4-AU; Mon, 30 Sep 2019 10:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89FD53086246;
 Mon, 30 Sep 2019 14:30:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A006961F22;
 Mon, 30 Sep 2019 14:30:14 +0000 (UTC)
Message-ID: <a9fecf03a42dcc9287126feb3284b189c0830a3a.camel@redhat.com>
Subject: Re: [PATCH 07/18] iotests: Replace IMGOPTS= by -o
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Mon, 30 Sep 2019 17:30:13 +0300
In-Reply-To: <bc672333-6b9c-dd36-1e87-14792f63bcde@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-8-mreitz@redhat.com>
 <e31504bf97e8944b9317546ebad75a669c6a2b90.camel@redhat.com>
 <bc672333-6b9c-dd36-1e87-14792f63bcde@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 30 Sep 2019 14:30:18 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-30 at 15:00 +0200, Max Reitz wrote:
> On 29.09.19 18:33, Maxim Levitsky wrote:
> > On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> > > Tests should not overwrite all user-supplied image options, but only add
> > > to it (which will effectively overwrite conflicting values).  Accomplish
> > > this by passing options to _make_test_img via -o instead of $IMGOPTS.
> > > 
> > > For some tests, there is no functional change because they already only
> > > appended options to IMGOPTS.  For these, this patch is just a
> > > simplification.
> > > 
> > > For others, this is a change, so they now heed user-specified $IMGOPTS.
> > > Some of those tests do not work with all image options, though, so we
> > > need to disable them accordingly.
> > > 
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/031 |  9 ++++---
> > >  tests/qemu-iotests/039 | 24 ++++++------------
> > >  tests/qemu-iotests/059 | 18 ++++++-------
> > >  tests/qemu-iotests/060 |  6 ++---
> > >  tests/qemu-iotests/061 | 57 ++++++++++++++++++++++--------------------
> > >  tests/qemu-iotests/079 |  3 +--
> > >  tests/qemu-iotests/106 |  2 +-
> > >  tests/qemu-iotests/108 |  2 +-
> > >  tests/qemu-iotests/112 | 32 ++++++++++++------------
> > >  tests/qemu-iotests/115 |  3 +--
> > >  tests/qemu-iotests/121 |  6 ++---
> > >  tests/qemu-iotests/125 |  2 +-
> > >  tests/qemu-iotests/137 |  2 +-
> > >  tests/qemu-iotests/138 |  3 +--
> > >  tests/qemu-iotests/175 |  2 +-
> > >  tests/qemu-iotests/190 |  2 +-
> > >  tests/qemu-iotests/191 |  3 +--
> > >  tests/qemu-iotests/220 |  4 ++-
> > >  tests/qemu-iotests/243 |  6 +++--
> > >  tests/qemu-iotests/244 | 10 +++++---
> > >  tests/qemu-iotests/250 |  3 +--
> > >  tests/qemu-iotests/265 |  2 +-
> > >  22 files changed, 100 insertions(+), 101 deletions(-)
> 
> [...]
> 
> > > diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> > > index 325da63a4c..99563bf126 100755
> > > --- a/tests/qemu-iotests/039
> > > +++ b/tests/qemu-iotests/039
> > > @@ -50,8 +50,7 @@ size=128M
> > >  echo
> > >  echo "== Checking that image is clean on shutdown =="
> > >  
> > > -IMGOPTS="compat=1.1,lazy_refcounts=on"
> > > -_make_test_img $size
> > > +_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
> > 
> > Any reason for compat=1.1 here? Other that it was before like that.
> 
> Lazy refcounts only work with qcow2 v3 (compat=1.1).
Agree, sorry for not noticing this.

Best regards,
	Maxim Levitsky

> 
> Max
> 



