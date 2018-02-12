Received: from eggs.gnu.org ([2001:4830:134:3::10]:60164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elK1U-0004vP-SQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elK1T-0003MB-FP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:44:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elK1T-0003LS-AI
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:44:19 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aef0f4e8-ed5b-2db4-dee3-b7d2bf486e6c@redhat.com>
Date: Mon, 12 Feb 2018 13:44:15 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/29] qapi-gen: Convert from getopt to
 argparse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:35 AM, Markus Armbruster wrote:
> argparse is nicer to use than getopt, and gives us --help almost for
> free.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi-gen.py    | 48 ++++++++++++++++++++++++++++++------------------
>   scripts/qapi/common.py | 43 -------------------------------------------
>   2 files changed, 30 insertions(+), 61 deletions(-)
> 

More functionality in fewer lines of code - always a win ;)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
