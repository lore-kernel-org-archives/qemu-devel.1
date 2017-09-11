Received: from eggs.gnu.org ([2001:4830:134:3::10]:34663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1drM4r-0002A5-14
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1drM4n-0004p6-Vg
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1drM4n-0004or-Po
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:36:25 -0400
Date: Mon, 11 Sep 2017 18:36:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170911103614.GL23040@pxdev.xzpeter.org>
References: <20170906115428.GP15510@redhat.com>
	<20170907081341.GA23040@pxdev.xzpeter.org>
	<87inguaclr.fsf@dusky.pond.sub.org>
	<20170907132259.GM30609@redhat.com>
	<87h8weo186.fsf@dusky.pond.sub.org> <20170907180900.GV2098@work-vm>
	<87k219fuq5.fsf@dusky.pond.sub.org> <20170908093212.GA2095@work-vm>
	<87efrhcsve.fsf@dusky.pond.sub.org>
	<20170911103203.GK23040@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170911103203.GK23040@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On Mon, Sep 11, 2017 at 06:32:03PM +0800, Peter Xu wrote:

[...]

> I think this OOB solution should work for us, though I'm still trying
> to digest this whole thing.  Thanks Markus for this design, much
> appreciated.  Meanwhile, sorry to have troubled you on this. I really
> didn't mean to!
> 
> Considering that we may still have some commands (like what Fam has
> mentioned in block layer) that may need to be run only in main thread,
> I think a first attempt may need to have one IO/parser thread (parses
> monitor input stream, and also responsible to run out-of-band
> commands), plus no worker thread, then I'll feed the dispatching work
> back to main thread again to make sure that assumption still keeps.
> 
> Dan, do you think this will work from libvirt POV?  I won't try to
> prototype anything if without your confirmation as well.
> 
> Thanks!

CC Daniel.

-- 
Peter Xu
