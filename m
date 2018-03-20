Received: from eggs.gnu.org ([2001:4830:134:3::10]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyM50-00078F-1S
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyM4z-0004rt-7e
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:33:50 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10dae97f-263b-bc96-e504-5079b742bc22@redhat.com>
Date: Tue, 20 Mar 2018 13:33:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 06/12] qemu-iotests: Test invalid
 resize on luks
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

On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> This tests that the .bdrv_truncate implementation for luks doesn't crash
> for invalid image sizes.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/210 | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)

Missing a change to 210.out?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
