Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4448C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D6C206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 14:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D6C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5sPx-0002M3-IN
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5sP2-0001Tr-IL
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5sP1-0007K5-6w
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5sP0-0007Js-VG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 10:06:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 177F03007C5E;
 Thu,  5 Sep 2019 14:06:22 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76645601B7;
 Thu,  5 Sep 2019 14:06:19 +0000 (UTC)
Date: Thu, 5 Sep 2019 11:06:18 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190905140618.GE4617@habkost.net>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190830175648.GE3694@habkost.net>
 <20190831014834.GC12065@umbus.fritz.box>
 <20190904195717.GA2311@localhost.localdomain>
 <20190905020924.GB2120@umbus.fritz.box>
 <20190905133824.GA12364@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905133824.GA12364@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 05 Sep 2019 14:06:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 05, 2019 at 09:38:24AM -0400, Cleber Rosa wrote:
> On Thu, Sep 05, 2019 at 12:09:24PM +1000, David Gibson wrote:
> > On Wed, Sep 04, 2019 at 03:57:17PM -0400, Cleber Rosa wrote:
> > > 
> > > Hi David,
> > > 
> > > I've pushed a branch here (most of the commits have already been sent
> > > separately):
> > > 
> > >    https://github.com/clebergnu/qemu/tree/ppc64
> > > 
> > > I've tested on a RHEL 8 ppc64le Power 9, and it seems to work for me.
> > > My steps for building QEMU:
> > > 
> > >   - Configured with: '/home/cleber/src/qemu/configure' '--enable-slirp=git' '--python=/usr/bin/python3' '--target-list=x86_64-softmmu,ppc64-softmmu,arm-softmmu,aarch64-softmmu,mips-softmmu,mipsel-softmmu,mips64-softmmu,mips64el-softmmu,sh4-softmmu,s390x-softmmu,alpha-softmmu,m68k-softmmu,riscv64-softmmu'
> > >   - make
> > >   - make check-acceptance
> > > 
> > > Would you be able to test if that branch works smoothly for you?
> > 
> > So, with this tree I'm no longer getting problems if openssl-devel is
> > not installed, so that much looks good.
> > 
> > I am getting some different errors - I was seeing this before (with
> > openssl-devel installed) sometimes, but only sometimes.  I haven't yet
> > worked out a pattern for when they appeared.  They also don't appear
> > to be fatal, the rest of the tests seem to be running ok.  Any ideas?
> > 
> >  VENV    /home/dwg/qemu/build/rhel8/tests/venv
> >   PIP     /home/dwg/qemu/tests/requirements.txt
> >   AVOCADO tests/acceptance
> > Error running method "run" of plugin "html": 'Namespace' object has no attribute 'get'
> > Error running method "run" of plugin "varianter_cit": 'Namespace' object has no attribute 'get'
> 
> Hi David,
> 
> Yes, those should not be fatal.  Anyway, they are caused by two things:
> 
>  1) A second set of Avocado plugins installation with different versions
>     than the Avocado installation on QEMU's tests venv
> 
>  2) The tests' venv, which is created with "--system-site-packages",
>     option that is described as "Give the virtual environment access
>     to the system site-packages dir."
> 
> The motivation to have "--system-site-packages" is that, if the user
> had any of the "requirements.txt" depedencies installed system wide,
> the venv would simply use it and skip downloads.  Maybe we should make
> that an optional feature, disabled by default, so that the test's venv
> is better isolated and more predictable by default.
> 
> Eduardo,
> 
> I remember we discussed #2, so your opinion is appreciated here.

I think I was the person who insisted for --system-site-packages.
Considering that we're often using very recent versions of
Avocado, maybe trying to use system-provided Avocado modules by
default wasn't a good idea after all.

Making --system-site-packages optional and not enabling it by
default sounds like a reasonable workaround.

-- 
Eduardo

