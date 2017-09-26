Received: from eggs.gnu.org ([2001:4830:134:3::10]:50577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwfeh-0006uX-QD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwfec-0003b3-Ts
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwfec-0003a0-OL
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:31:22 -0400
Date: Tue, 26 Sep 2017 10:31:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926023115.GF19505@pxdev.xzpeter.org>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925112917.21340-2-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] migration: pre_save return int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, famz@redhat.com, peter.maydell@linaro.org, cohuck@redhat.com, rth@twiddle.net

On Mon, Sep 25, 2017 at 12:29:12PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Modify the pre_save method on VMStateDescription to return an int
> rather than void so that it potentially can fail.
> 
> Changed zillions of devices to make them return 0; the only
> case I've made it return non-0 is hw/intc/s390_flic_kvm.c that already
> had an error_report/return case.
> 
> Note: If you add an error exit in your pre_save you must emit
> an error_report to say why.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
