Received: from eggs.gnu.org ([2001:4830:134:3::10]:46422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elLJG-0003Uz-Bx
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elLJD-0004dh-3x
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:06:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elLJC-0004dV-VL
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 16:06:43 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-20-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c208052a-4c1c-758f-bb77-879e7c868b27@redhat.com>
Date: Mon, 12 Feb 2018 15:06:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/29] qapi: Make code-generating
 visitors use QAPIGen more
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
> The use of QAPIGen is rather shallow so far: most of the output
> accumulation is not converted.  Take the next step: convert output
> accumulation in the code-generating visitor classes.  Helper functions
> outside these classes are not converted.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/commands.py   | 71 ++++++++++++++++------------------------
>   scripts/qapi/common.py     | 13 ++++++++
>   scripts/qapi/doc.py        | 74 ++++++++++++++++++++----------------------
>   scripts/qapi/events.py     | 55 ++++++++++++-------------------
>   scripts/qapi/introspect.py | 56 +++++++++++++-------------------
>   scripts/qapi/types.py      | 81 +++++++++++++++++++---------------------------
>   scripts/qapi/visit.py      | 80 +++++++++++++++++++--------------------------
>   7 files changed, 188 insertions(+), 242 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
