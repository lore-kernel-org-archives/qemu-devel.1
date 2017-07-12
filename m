Received: from eggs.gnu.org ([2001:4830:134:3::10]:56348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dV8Gh-0001Ua-Qg
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 23:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dV8Gc-0001wu-Qk
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 23:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dV8Gc-0001w6-Jp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 23:24:46 -0400
Date: Wed, 12 Jul 2017 11:24:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170712032441.GE29326@pxdev.xzpeter.org>
References: <20170704184915.31586-1-dgilbert@redhat.com>
	<20170704184915.31586-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170704184915.31586-5-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] migration/rdma: Safely convert control
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Tue, Jul 04, 2017 at 07:49:14PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> control_desc[] is an array of strings that correspond to a
> series of message types; they're used only for error messages, but if
> the message type is seriously broken then we could go off the end of
> the array.
> 
> Convert the array to a function control_desc() that bound checks.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
