Received: from eggs.gnu.org ([2001:4830:134:3::10]:37613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwmai-0004d3-Bs
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwmaf-00072r-RN
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:55:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dwmaf-00072T-Kq
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:55:45 -0400
Date: Tue, 26 Sep 2017 10:55:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170926095535.GB2689@work-vm>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-5-dgilbert@redhat.com>
	<20170926024548.GI19505@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926024548.GI19505@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] migration: wire vmstate_save_state
 errors up to vmstate_subsection_save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Sep 25, 2017 at 12:29:15PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Route the errors from vmstate_subsection_save up through
> > vmstate_subsection_save (and back down, all rather recursive).
> 
> I guess here one of the "vmstate_subsection_save" should be replaced
> by "vmstate_save_state"? :-)

Ah yes, fixed.

> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks.

Dave

> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
