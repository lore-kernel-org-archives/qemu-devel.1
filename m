Received: from eggs.gnu.org ([2001:4830:134:3::10]:56577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhyYb-0008Gl-FU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhyYa-0001MF-Kg
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:44:57 -0400
References: <20180724084739.580-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bbb762c9-5b7e-757f-9668-ec794bec6f5a@redhat.com>
Date: Tue, 24 Jul 2018 09:44:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180724084739.580-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Fix 226 on _my_ system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 07/24/2018 03:47 AM, Fam Zheng wrote:
> Something has locked /dev/null on my system (I still don't know what to do with
> the annoying incapability of lslocks, or more precisely /proc/locks, on
> inspecting OFD lock information), and as a result 226 cannot pass due to the
> unexpected image locking error.
> 
> Fix the test case by disabling locking, and add a doc text about using test
> images.
> 
> Fam Zheng (2):
>    docs: Describe using images in writing iotests
>    iotests: Don't lock /dev/null in 226
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

>   docs/devel/testing.rst | 11 +++++++++++
>   tests/qemu-iotests/226 |  4 ++--
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
