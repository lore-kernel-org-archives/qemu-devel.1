Received: from eggs.gnu.org ([2001:4830:134:3::10]:58402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRyp4-0005xS-6K
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRyml-0003lO-LS
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:17:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gRyml-0003l9-Fm
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:17:43 -0500
Date: Wed, 28 Nov 2018 20:17:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181128121738.GA29246@xz-x1>
References: <20181128103308.26755-1-fli@suse.com>
	<20181128103308.26755-4-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128103308.26755-4-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/5] migration: fix the multifd code
 when receiving less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Nov 28, 2018 at 06:33:06PM +0800, Fei Li wrote:
> In our current code, when multifd is used during migration, if there
> is an error before the destination receives all new channels, the
> source keeps running, however the destination does not exit but keeps
> waiting until the source is killed deliberately.
> 
> Fix this by dumping the specific error and let users decide whether
> to quit from the destination side when failing to receive packet via
> some channel.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
