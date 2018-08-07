Received: from eggs.gnu.org ([2001:4830:134:3::10]:52390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn3Lg-00076R-1Q
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fn3Lf-0003Q9-59
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:52:36 -0400
References: <20180807043349.27196-1-jsnow@redhat.com>
	<20180807043349.27196-20-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83f634a8-ddab-2eb1-419a-fd2e8a6b815f@redhat.com>
Date: Tue, 7 Aug 2018 09:52:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180807043349.27196-20-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/21] qapi/block-commit: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 08/06/2018 11:33 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockdev.c           | 8 ++++++++
>   qapi/block-core.json | 3 ++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 

> +++ b/qapi/block-core.json
> @@ -1518,7 +1518,8 @@
>   { 'command': 'block-commit',
>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str', '*top': 'str',
>               '*backing-file': 'str', '*speed': 'int',
> -            '*filter-node-name': 'str' } }
> +            '*filter-node-name': 'str',
> +            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }

Missing documentation, including a 'since 3.1' tag.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
