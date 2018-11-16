Received: from eggs.gnu.org ([2001:4830:134:3::10]:46035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhMz-00024j-G8
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhMy-0001Ze-A3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:53:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNhMy-0001ZC-27
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:53:24 -0500
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
	<20181024094051.4470-2-maozhongyi@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff59cbf9-95ef-b581-34ad-a11f73f76f77@redhat.com>
Date: Fri, 16 Nov 2018 10:53:21 -0600
MIME-Version: 1.0
In-Reply-To: <20181024094051.4470-2-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: convert `pwd` and
 $(pwd) to $PWD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

On 10/24/18 4:40 AM, Mao Zhongyi wrote:
> POSIX requires $PWD to be reliable, and we expect all
> shells used by qemu scripts to be relatively close to
> POSIX.  Thus, it is smarter to avoid forking the pwd
> executable for something that is already available in
> the environment.
> 
> So replac it with the following:

s/replac/replace/

> 
> sed -i 's/`pwd`/$PWD/g' $(git grep -l "\`pwd\`")
> sed -i 's/$(pwd)/$PWD/g' $(git grep  -l "\$(pwd)")
> 
> The remaining small parts are manually modified.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> Cc: kwolf@redhat.com
> Cc: mreitz@redhat.com
> Cc: eblake@redhat.com
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>   configure                        | 2 +-
>   tests/check-block.sh             | 6 +++---
>   tests/qemu-iotests/001           | 2 +-

However, this is a LOT of churn, since patch 2 then removes many of 
these lines. I'd like to swap the two patches, and then am considering 
them going through the NBD tree.

> +++ b/tests/qemu-iotests/001
> @@ -24,7 +24,7 @@ owner=hch@lst.de
>   seq=`basename $0`
>   echo "QA output created by $seq"
>   
> -here=`pwd`
> +here=$PWD
>   status=1	# failure is the default!
>   


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
