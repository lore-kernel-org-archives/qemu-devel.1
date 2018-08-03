Received: from eggs.gnu.org ([2001:4830:134:3::10]:57222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flWNM-0003v2-8n
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flWNH-0001pw-FP
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:28:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8966138a-1663-fdcf-e49e-df7e9c802c3e@redhat.com>
References: <20180724121753.5753-1-lbloch@janustech.com>
	<20180724121753.5753-2-lbloch@janustech.com>
	<8966138a-1663-fdcf-e49e-df7e9c802c3e@redhat.com>
Date: Fri, 03 Aug 2018 11:27:48 +0200
Message-ID: <w51in4rlrzf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 24 Jul 2018 04:52:17 PM CEST, Eric Blake wrote:
>>   @item refcount-cache-size
>>   The maximum size of the refcount block cache in bytes
>>   (default: 1/5 of the total cache size)
>
> Alberto, looks like we missed this documentation in your changes to
> the defaults.

Oh, indeed!

Berto
