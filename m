Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE73C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1F32070B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1F32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxbr-0008Ih-PJ
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdxNj-0004Gi-Aj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdxNb-00037o-Sy
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:45:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdxNb-00036g-Ki
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:45:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD7BB307FBCB
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 13:45:26 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B73E5C1A1;
 Thu, 20 Jun 2019 13:45:26 +0000 (UTC)
Date: Thu, 20 Jun 2019 10:45:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190620134524.GH3300@habkost.net>
References: <20190618142931.1694-1-imammedo@redhat.com>
 <20190619132924.GA32240@localhost.localdomain>
 <20190620111103.297277bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620111103.297277bc@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 20 Jun 2019 13:45:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qmp: make qmp-shell work with python3
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 11:11:03AM +0200, Igor Mammedov wrote:
> On Wed, 19 Jun 2019 09:29:24 -0400
> Cleber Rosa <crosa@redhat.com> wrote:
> 
> > On Tue, Jun 18, 2019 at 10:29:31AM -0400, Igor Mammedov wrote:
> > > python3 doesn't have raw_input(), so qmp-shell breaks.
> > > Use input() instead and override it with raw_input()
> > > if running on python2.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  scripts/qmp/qmp-shell | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> > > index 7776c7b141..8c49b39afa 100755
> > > --- a/scripts/qmp/qmp-shell
> > > +++ b/scripts/qmp/qmp-shell
> > > @@ -308,7 +308,11 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> > >          @return True if execution was ok, return False if disconnected.
> > >          """
> > >          try:
> > > -            cmdline = raw_input(prompt)
> > > +            try: # attempt to set Python2 override
> > > +               import __builtin__;
> > > +               getattr(__builtin__, 'raw_input', input)
> > > +            except ModuleNotFoundError: pass  
> > 
> > Something like:
> > 
> >    if sys.version_info[0] == 2:
> >        input = raw_input
> > 
> > Also does the job, and may be considered simpler and easier to read.
> 
> that causes scope issues on python3

Which issues?  It should work if you set it at the module top
level.  We had done this before in other scripts.  e.g.:

$ git grep -1 'range = xrange'
tests/qemu-iotests/044-if sys.version_info.major == 2:
tests/qemu-iotests/044:    range = xrange
tests/qemu-iotests/044-
--
tests/qemu-iotests/163-if sys.version_info.major == 2:
tests/qemu-iotests/163:    range = xrange
tests/qemu-iotests/163-


-- 
Eduardo

