Received: from eggs.gnu.org ([2001:4830:134:3::10]:43266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGUBo-0005if-RZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGUBn-0000EY-Pw
	for qemu-devel@nongnu.org; Wed, 09 May 2018 14:51:48 -0400
References: <20180509182002.8044-1-mreitz@redhat.com>
	<20180509182002.8044-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de872504-7edb-585d-92fd-a4756e36a204@redhat.com>
Date: Wed, 9 May 2018 13:51:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180509182002.8044-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qemu-img: Resolve relative backing
 paths in rebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 05/09/2018 01:20 PM, Max Reitz wrote:
> Currently, rebase interprets a relative path for the new backing image
> as follows:
> (1) Open the new backing image with the given relative path (thus relative to
>      qemu-img's working directory).
> (2) Write it directly into the overlay's backing path field (thus
>      relative to the overlay).
> 
> If the overlay is not in qemu-img's working directory, both will be
> different interpretations, which may either lead to an error somewhere
> (either rebase fails because it cannot open the new backing image, or
>   your overlay becomes unusable because its backing path does not point
>   to a file), or, even worse, it may result in your rebase being
> performed for a different backing file than what your overlay will point

Interesting indentation in this paragraph. A maintainer could tweak it.

> to after the rebase.
> 
> Fix this by interpreting the target backing path as relative to the
> overlay, like qemu-img does everywhere else.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1569835
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
