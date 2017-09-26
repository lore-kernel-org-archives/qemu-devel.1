Received: from eggs.gnu.org ([2001:4830:134:3::10]:51551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwfkF-00009I-OO
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwfkA-0005uc-SI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:37:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwfkA-0005uO-MB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 22:37:06 -0400
Date: Tue, 26 Sep 2017 10:36:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926023658.GG19505@pxdev.xzpeter.org>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170925112917.21340-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] migration: check pre_save return in
 vmstate_save_state
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

On Mon, Sep 25, 2017 at 12:29:13PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Check the return value of pre_save state and fail vmstate_save_state
> if the pre_save failed.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
