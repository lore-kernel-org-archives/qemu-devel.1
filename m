Received: from eggs.gnu.org ([2001:4830:134:3::10]:53921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfnsx-0003op-5f
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfnsu-0005Ht-3J
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfnst-0005Ha-SW
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:52:24 -0400
Date: Thu, 10 Aug 2017 14:52:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170810135215.GK12980@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
	<a9f3a782-d73c-a5b5-c6f2-7b6d832452b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9f3a782-d73c-a5b5-c6f2-7b6d832452b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com

On Thu, Aug 10, 2017 at 02:13:30PM +0200, Paolo Bonzini wrote:
> On 10/08/2017 12:08, Lan Tianyu wrote:
> > Intel Xeon phi chip will support 352 logical threads. For HPC
> > usage case, it will create a huge VM with vcpus number as same as host
> > cpus. This patch is to increase max vcpu number to 352.
> 
> Even without Xeon Phi, a 24-core, 8-socket system (E7-8890 v4 for
> example) will have 384 physical CPUs.  288 was the biggest we could test
> at the time, but now that the 256 vCPU barrier has been broken I agree
> with going straight to 512.

FWIW, linux allows  8192 CPUs on x86_64 already, due to alledged
existance of SGI machines with 6096 CPUs....

  commit b53b5eda8194214928c8243d711a75dbf51809fc
  Author: Josh Boyer <jwboyer@redhat.com>
  Date:   Tue Nov 5 09:38:16 2013 -0500

    x86/cpu: Increase max CPU count to 8192
    
    The MAXSMP option is intended to enable silly large numbers of
    CPUs for testing purposes.  The current value of 4096 isn't very
    silly any longer as there are actual SGI machines that approach
    6096 CPUs when taking HT into account.
    
    Increase the value to a nice round 8192 to account for this and
    allow for short term future increases.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
