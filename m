Received: from eggs.gnu.org ([2001:4830:134:3::10]:42512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvNqk-0006WX-7j
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dvNqg-0002MV-4k
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dvNqf-0002MH-Tx
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:18:30 -0400
Date: Fri, 22 Sep 2017 14:18:19 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170922131819.GP12725@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.3351.1506066493.14747.qemu-devel@nongnu.org>
	<726A2123-0371-407B-9270-6672DF66D511@gmail.com>
	<20170922124405.GB32000@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922124405.GB32000@lemon>
Subject: Re: [Qemu-devel] [PULL 28/36] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Fri, Sep 22, 2017 at 08:44:05PM +0800, Fam Zheng wrote:
> On Fri, 09/22 08:10, Programmingkid wrote:
> > Could a Darwin test be added? Both x86 and PowerPC versions would be great.
> 
> It's nice to cover macOS in our test, but to be honest I don't know how to do
> it. If there isn't any copyright problem, and if there are instructions
> available in wiki.qemu.org descirbing how to create such a guest step by step
> like [1], we can add one.

AFAICT we can not just provide or host OS-X images and let individual
devs run the without it being a license violation, so best avoided.

IMHO it easier to just rely on Travis' OS-X builders for testing OS-X
platform builds, so that licensing compliance is their responsibility.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
