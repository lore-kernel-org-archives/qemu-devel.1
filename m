Received: from eggs.gnu.org ([2001:4830:134:3::10]:59614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwTO5-0008UL-U4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dwTO0-0002Ir-S2
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:25:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dwTO0-0002FW-Lw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:25:24 -0400
Date: Mon, 25 Sep 2017 14:25:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170925132514.GF2656@work-vm>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-2-dgilbert@redhat.com>
	<d831a4f1-2598-66c2-6e84-a9ab93cf3bff@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d831a4f1-2598-66c2-6e84-a9ab93cf3bff@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com

* Richard Henderson (rth@twiddle.net) wrote:
> On 09/25/2017 06:29 AM, Dr. David Alan Gilbert (git) wrote:
> > Modify the pre_save method on VMStateDescription to return an int
> > rather than void so that it potentially can fail.
> 
> What does the int value signify?

0 is success, anything else is a failure; typically -errno.

> Why not a bool?

Consistency with pre_load, post_load, put and get methods
that are already int.

Dave

> 
> r~
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
