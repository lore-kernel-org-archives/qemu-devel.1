Received: from eggs.gnu.org ([2001:4830:134:3::10]:50207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNl0L-00067H-Mw
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNl0I-0000mp-Ig
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:46:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNl0I-0000md-B4
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 15:46:14 -0500
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
	<20181024094051.4470-2-maozhongyi@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <573ca1df-3680-009a-5f62-fdf76038cc61@redhat.com>
Date: Fri, 16 Nov 2018 14:46:10 -0600
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
> 
> sed -i 's/`pwd`/$PWD/g' $(git grep -l "\`pwd\`")
> sed -i 's/$(pwd)/$PWD/g' $(git grep  -l "\$(pwd)")
> 
> The remaining small parts are manually modified.
> 

> +++ b/tests/qemu-iotests/common.config
> @@ -25,7 +25,7 @@ HOSTOS=`uname -s`
>   arch=`uname -m`
>   [[ "$arch" =~ "ppc64" ]] && qemu_arch=ppc64 || qemu_arch="$arch"
>   
> -export PWD=`pwd`
> +export PWD=$PWD

This is now pointless.  I'm deleting the line instead.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
