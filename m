Received: from eggs.gnu.org ([2001:4830:134:3::10]:37735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLwj-0003Y9-77
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLwi-0007kT-Dv
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:25:17 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8e0ac59-ebd9-a90d-b366-367e1d41599c@redhat.com>
Date: Tue, 20 Mar 2018 13:25:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 04/12] qemu-iotests: Enable 025
 for luks
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
> We want to test resizing even for luks. The only change that is needed
> is to explicitly zero out new space for luks because it's undefined.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/025 | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
