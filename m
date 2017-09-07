Received: from eggs.gnu.org ([2001:4830:134:3::10]:43106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpsRg-0002DX-9J
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpsRY-00021t-N6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dpsRY-00021U-GZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:45:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E7FB5F7AE
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:45:47 +0000 (UTC)
Date: Thu, 7 Sep 2017 10:45:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907084543.GC4461@dhcp-200-186.str.redhat.com>
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
	<20170907081131.GB4461@dhcp-200-186.str.redhat.com>
	<7eb83905-41cd-fa32-226c-0849d42bed04@redhat.com>
	<20170907102538.15ed780d.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907102538.15ed780d.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] accel: default to an actually
 available accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

Am 07.09.2017 um 10:25 hat Cornelia Huck geschrieben:
> On Thu, 7 Sep 2017 10:14:27 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
> > On 07.09.2017 10:11, Kevin Wolf wrote:
> > [...]
> > > But the real reason why I'm replying: Should we add changing the default
> > > to "kvm:tcg" to the list of planned 3.0 changes? I am part of the group
> > > that intentionally uses TCG occasionally, but I think the majority of
> > > users wants to use KVM (or whatever the fastest option is on their
> > > system) whenever it is available.  
> > 
> > If you consider how often people are getting this wrong (they want to
> > use KVM but end up with TCG in the first try), I think that's a good idea.
> 
> Agreed.
> 
> I'm wondering what that means for our tests, though. Some of them work
> slightly different under tcg or kvm (cf. iotest 186, as referenced in
> the original mail), and sometimes you'll probably explicitly want to
> exercise tcg. That does not speak against the change, but we probably
> need to look at what we want in more detail.

This is a bug in test 186, and probably 172, too. Normally, we use the
options from ./common:

    export QEMU_OPTIONS="-nodefaults -machine accel=qtest"

However, these two test cases overwrite QEMU_OPTIONS and neglect to add
a '-machine accel=qtest' option manually.

Kevin
