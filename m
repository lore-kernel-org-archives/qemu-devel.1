Received: from eggs.gnu.org ([2001:4830:134:3::10]:54825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwg3X-0003ln-C6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwg3T-00071R-GR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwg3T-000711-9R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:57:03 -0400
Date: Tue, 26 Sep 2017 10:56:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926025655.GJ19505@pxdev.xzpeter.org>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925112917.21340-6-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] migration: Route errors up through
 vmstate_save
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

On Mon, Sep 25, 2017 at 12:29:16PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Route the errors from vsmtate_save_state back up through
> vmstate_save and out to the normal device state path.
> That's the normal error path done.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
