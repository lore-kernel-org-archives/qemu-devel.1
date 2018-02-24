Received: from eggs.gnu.org ([2001:4830:134:3::10]:43018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph0f-0006rI-KC
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph0e-0006b7-OG
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:05:33 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a68784ce-8c78-2043-85e4-6feeac6b0a32@redhat.com>
Date: Sat, 24 Feb 2018 15:05:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/7] qapi: Remove qobject_to_X()
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> They are no longer needed now.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   include/qapi/qmp/qbool.h   |  1 -
>   include/qapi/qmp/qdict.h   |  1 -
>   include/qapi/qmp/qlist.h   |  1 -
>   include/qapi/qmp/qnum.h    |  1 -
>   include/qapi/qmp/qstring.h |  1 -
>   qobject/qbool.c            | 11 -----------
>   qobject/qdict.c            | 11 -----------
>   qobject/qlist.c            | 11 -----------
>   qobject/qnum.c             | 11 -----------
>   qobject/qstring.c          | 11 -----------
>   10 files changed, 60 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
