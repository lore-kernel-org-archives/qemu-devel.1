Received: from eggs.gnu.org ([2001:4830:134:3::10]:60450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDZnH-0003Pm-On
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDZnG-0006rn-RI
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:14:27 -0400
References: <20180501165750.19242-1-mreitz@redhat.com>
	<20180501165750.19242-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4bdac138-394d-4ea8-4f65-4fe08056b3d4@redhat.com>
Date: Tue, 1 May 2018 13:14:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180501165750.19242-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test post-backing convert
 target behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 05/01/2018 11:57 AM, Max Reitz wrote:
> This adds a test case to 122 for what happens when you convert to a
> target with a backing file that is shorter than the target, and the
> image format does not support efficient zero writes (as is the case with
> qcow2 v2).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/122     | 42 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/122.out | 18 ++++++++++++++++++
>   2 files changed, 60 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
