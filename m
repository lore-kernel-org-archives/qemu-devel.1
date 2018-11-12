Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gML6b-0006T3-Nk
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gML6b-0000R9-0t
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:54:53 -0500
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78c11753-83c8-5308-e347-bbe51c7b092b@redhat.com>
Date: Mon, 12 Nov 2018 16:54:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/11] iotests: Add tests for mirror
 @replaces loops
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

On 8/9/18 5:31 PM, Max Reitz wrote:
> This adds two tests for cases where our old check_to_replace_node()
> function failed to detect that executing this job with these parameters
> would result in a cyclic graph.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/041     | 124 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |   4 +-
>   2 files changed, 126 insertions(+), 2 deletions(-)
> 

With your followup amendments to allow qed testing (hmm, you mention 
you'd be posting a v3),

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
