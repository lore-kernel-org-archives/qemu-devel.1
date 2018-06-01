Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOaZP-0005jA-E4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOaZM-00055d-80
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:17:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOaZM-00053r-3S
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:17:36 -0400
Date: Fri, 1 Jun 2018 11:17:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180601031731.GE14867@xz-mi>
References: <20180515091356.24106-1-peterx@redhat.com>
	<20180531110317.GG27838@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531110317.GG27838@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, May 31, 2018 at 12:03:17PM +0100, Stefan Hajnoczi wrote:
> On Tue, May 15, 2018 at 05:13:56PM +0800, Peter Xu wrote:
> > I stole the printk_once() macro.
> > 
> > I always wanted to be able to print some error directly if there is a
> > buffer to dump, however we can't use error_report() really quite often
> > when there can be any DDOS attack.  To avoid that, we can introduce a
> > print-once function for it.
> 
> I like the idea.  It solves the problem of guest-triggerable error
> messages that we should know about for troubleshooting but can't due to
> DoS.
> 
> Stefan

Thanks for the positive feedback.  Please feel free to have a look on
the latest version:

Subject: [PATCH v4 0/2] error-report: introduce {error|warn}_report_once
Message-Id: <20180524044454.11792-1-peterx@redhat.com>

Regards,

-- 
Peter Xu
