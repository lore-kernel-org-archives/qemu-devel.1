Received: from eggs.gnu.org ([2001:4830:134:3::10]:33902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUZR-0001bt-78
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUZQ-0003wx-Fy
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:49:57 -0400
References: <20180321173714.14741-1-kwolf@redhat.com>
	<20180321173714.14741-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4cdd83b2-fd95-f159-5f3b-a859f21a0a15@redhat.com>
Date: Fri, 23 Mar 2018 16:49:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180321173714.14741-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2 06/12] qemu-iotests: Test
 invalid resize on luks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/21/2018 12:37 PM, Kevin Wolf wrote:
> This tests that the .bdrv_truncate implementation for luks doesn't crash
> for invalid image sizes.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/210     | 37 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/210.out | 16 ++++++++++++++++
>   2 files changed, 53 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
