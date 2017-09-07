Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dps8C-00054F-63
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dps87-00082f-Fm
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:25:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dps87-00081w-8W
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:25:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 277766146E
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:25:42 +0000 (UTC)
Date: Thu, 7 Sep 2017 10:25:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907102538.15ed780d.cohuck@redhat.com>
In-Reply-To: <7eb83905-41cd-fa32-226c-0849d42bed04@redhat.com>
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
	<20170907081131.GB4461@dhcp-200-186.str.redhat.com>
	<7eb83905-41cd-fa32-226c-0849d42bed04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

On Thu, 7 Sep 2017 10:14:27 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 07.09.2017 10:11, Kevin Wolf wrote:
> [...]
> > But the real reason why I'm replying: Should we add changing the default
> > to "kvm:tcg" to the list of planned 3.0 changes? I am part of the group
> > that intentionally uses TCG occasionally, but I think the majority of
> > users wants to use KVM (or whatever the fastest option is on their
> > system) whenever it is available.  
> 
> If you consider how often people are getting this wrong (they want to
> use KVM but end up with TCG in the first try), I think that's a good idea.

Agreed.

I'm wondering what that means for our tests, though. Some of them work
slightly different under tcg or kvm (cf. iotest 186, as referenced in
the original mail), and sometimes you'll probably explicitly want to
exercise tcg. That does not speak against the change, but we probably
need to look at what we want in more detail.

> Maybe we should start a Wiki page where we collect ideas for QEMU 3.0?

Also a good idea.

[Do we already have any idea about the timeframe for 3.0?]
