Received: from eggs.gnu.org ([2001:4830:134:3::10]:47749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePozy-0005FX-IM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePozr-0006st-I3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:21:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePozr-0006pe-Bi
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:21:47 -0500
Date: Fri, 15 Dec 2017 12:21:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171215122139.GC11724@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1511426872-13980-1-git-send-email-jianjay.zhou@huawei.com>
	<20171205195816.GH2405@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171205195816.GH2405@work-vm>
Subject: Re: [Qemu-devel] [PATCH] docs/devel/migration.txt: keep functions
 consistent with the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org, quintela@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com

On Tue, Dec 05, 2017 at 07:58:16PM +0000, Dr. David Alan Gilbert wrote:
> * Jay Zhou (jianjay.zhou@huawei.com) wrote:
> > Since the commit 11808bb0c422134bf09119f4aa22c59b0ce84bf3 removed
> > the put_buffer callback and using an iovec based write handler instead,
> > the docs should be sync with the code too.
> > 
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> 
> Lets check with Dan (added to cc) since he wrote 11808bb;
> it might be best just to rever to migration/qemu-file.h for an
> explanation of each function.

The updates look ok, but I tend to think this entire section of
migrate.txt should be deleted, in favour of the inline APIs
docs in mijgration/qemu-file.h   As a developer the header file
is where I would look for this kind of API description. The
migration.txt can just point epople to the header file for API
docs.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
