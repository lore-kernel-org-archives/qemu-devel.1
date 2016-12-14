Received: from eggs.gnu.org ([2001:4830:134:3::10]:44800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHI5w-0004t1-Nr
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 17:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHI5r-0005uG-Ok
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 17:32:16 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:51765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHI5r-0005tw-GV
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 17:32:11 -0500
Date: Wed, 14 Dec 2016 17:32:09 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <458039301.4070513.1481754729324.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161214222601.GP3808@thinpad.lan.raisama.net>
References: <1481732391-882-1-git-send-email-vlad.lungu@windriver.com>
	<ef1f3b2a-d206-7082-3227-423e0d9d9619@redhat.com>
	<20161214170058.GJ3808@thinpad.lan.raisama.net>
	<abea10db-9da8-d6eb-c6eb-67817b1fadda@redhat.com>
	<20161214175144.GN3808@thinpad.lan.raisama.net>
	<1509132582.4065072.1481751487408.JavaMail.zimbra@redhat.com>
	<20161214222601.GP3808@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vlad Lungu <vlad.lungu@windriver.com>, qemu-devel@nongnu.org, rth@twiddle.net

> > > In other words: this fixes the mb_add_cmdline(kcmdline) case, and
> > > doesn't break comma escaping on the initrd case (because it was
> > > already broken). I don't see a problem with this patch.
> > 
> > ... there is one case of comma escaping that wasn't broken:
> > 
> >     $ qemu-system-x86_64 -kernel foo -initrd '/tmp/one
> >     arg,,with,,commas,/tmp/another arg,,with,,commas'
> > 
> 
> Oh, I didn't notice the whitespace-based split for initrd
> arguments.
> 
> This is messier than I thought. Maybe the simplest solution is to
> inline mb_add_cmdline() at both callers, and change the kcmdline
> one to use memcpy().

Yes, I agree.

Paolo
