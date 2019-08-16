Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEDC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073EA206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073EA206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyivQ-0004ZE-2L
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 16:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1hyiun-00044k-9y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hyium-0005h7-8o
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1hyiuj-0005dP-6X; Fri, 16 Aug 2019 16:33:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EA41762E;
 Fri, 16 Aug 2019 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-60.rdu2.redhat.com
 [10.10.124.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70F331001B08;
 Fri, 16 Aug 2019 20:33:28 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:33:26 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190816203326.GB20950@localhost.localdomain>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b7d55527-2a1a-c171-3a46-7723696d4aba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d55527-2a1a-c171-3a46-7723696d4aba@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 16 Aug 2019 20:33:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 3/6] iotests: Add
 casenotrun report to bash tests
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 08:44:11PM -0400, John Snow wrote:
> 
> 
> On 7/19/19 12:30 PM, Andrey Shinkevich wrote:
> > The new function _casenotrun() is to be invoked if a test case cannot
> > be run for some reason. The user will be notified by a message passed
> > to the function.
> > 
> 
> Oh, I assume this is a sub-test granularity; if we need to skip
> individual items.
> 
> I'm good with this, but we should CC Cleber Rosa, who has struggled
> against this in the past, too.
>

The discussion I was involved in was not that much about skipping
tests per se, but about how to determine if a test should be skipped
or not.  At that time, we proposed an integration with the build
system, but the downside (and the reason for not pushing it forward)
was the requirement to run the iotest outside of a build tree.

> > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > ---
> >  tests/qemu-iotests/common.rc | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> > index 6e461a1..1089050 100644
> > --- a/tests/qemu-iotests/common.rc
> > +++ b/tests/qemu-iotests/common.rc
> > @@ -428,6 +428,13 @@ _notrun()
> >      exit
> >  }
> >  
> > +# bail out, setting up .casenotrun file
> > +#
> > +_casenotrun()
> > +{
> > +    echo "    [case not run] $*" >>"$OUTPUT_DIR/$seq.casenotrun"
> > +}
> > +
> >  # just plain bail out
> >  #
> >  _fail()
> > 
> 
> seems fine to me otherwise.
> 
> Reviewed-by: John Snow <jsnow@redhat.com>

Yeah, this also LGTM.

Reviewed-by: Cleber Rosa <crosa@redhat.com>

