Received: from eggs.gnu.org ([2001:4830:134:3::10]:49061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKR1S-0005uO-1c
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKR1P-0002vI-Sm
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:45:10 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8735179d-af0f-3d4f-d592-2874ae8a3fd7@redhat.com>
Date: Thu, 30 Nov 2017 09:44:52 -0600
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/17] iotests: Drop format-specific in
 _filter_img_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

On 11/22/2017 08:08 PM, Max Reitz wrote:
> _filter_img_info should remove format-specific information, too.  We
> already have such a filter in _img_info, and it is very useful for
> query-block-named-block-nodes (etc.), too.
> 
> However, in 198 we need that information (but we still want the rest of
> the filter), so make that filtering optional.  Note that "the rest of
> the filter" includes filtering of the test directory, so we can drop the
> _filter_testdir from 198 at the same time.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/198           |  6 ++++--
>   tests/qemu-iotests/common.filter | 29 ++++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 3 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
