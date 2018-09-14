Received: from eggs.gnu.org ([2001:4830:134:3::10]:45681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0s3i-0002wk-7a
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0s3h-0007Px-Jb
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:39:10 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-12-kwolf@redhat.com>
	<908e08a4-a58a-e4e1-5eb7-fe9d17adfbe3@redhat.com>
	<20180913165954.GB5172@localhost.localdomain>
	<bf0ed459-0c81-82ba-a60d-736170469501@redhat.com>
	<20180914171433.GD4991@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7cd9c3cf-3b94-8620-a00d-6ba8a6e6fe25@redhat.com>
Date: Fri, 14 Sep 2018 19:38:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180914171433.GD4991@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/17] block-backend: Decrease in_flight
 only after callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On 14/09/2018 19:14, Kevin Wolf wrote:
>> As you mention, you could have a nested aio_poll() in the main thread,
>> for example invoked from a bottom half, but in that case I'd rather
>> track the caller that is creating the bottom half and see if it lacks a
>> bdrv_ref/bdrv_unref (or perhaps it's even higher in the tree that is
>> missing).
> I went back to the commit where I first added the patch (it already
> contained the ref/unref pair) and tried if I could reproduce a bug with
> the pair removed. I couldn't.
> 
> I'm starting to think that maybe I was just overly cautious with the
> ref/unref. I may have confused the nested aio_poll() crash with a
> different situation. I've dealt with so many crashes and hangs while
> working on this series that it's quite possible.

Are you going to drop the patch hen?

Thanks,

Paolo
