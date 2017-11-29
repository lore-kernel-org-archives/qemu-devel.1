Received: from eggs.gnu.org ([2001:4830:134:3::10]:58101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKBNP-0005vG-2H
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 18:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKBNO-0001qN-EB
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 18:02:47 -0500
References: <20171129224421.18192-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <691790b7-4e9f-ab9c-43eb-9f26a401ef02@redhat.com>
Date: Wed, 29 Nov 2017 17:02:33 -0600
MIME-Version: 1.0
In-Reply-To: <20171129224421.18192-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On 11/29/2017 04:44 PM, John Snow wrote:
> VPC has some difficulty creating geometries of particular size.
> However, we can indeed force it to use a literal one, so let's
> do that for the sake of test 197, which is testing some specific
> offsets.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/197           | 3 +++
>   tests/qemu-iotests/common.filter | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

[Does it show that I seldom run ./check -vpc?]

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
