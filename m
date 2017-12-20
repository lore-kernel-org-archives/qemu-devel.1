Received: from eggs.gnu.org ([2001:4830:134:3::10]:35692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eRm6w-0006CW-83
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eRm6u-0005rO-Bi
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:41:10 -0500
References: <1513617273-7988-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <11b989ad-59bb-7417-1ce1-2decb079d3e0@redhat.com>
Date: Wed, 20 Dec 2017 16:40:36 -0500
MIME-Version: 1.0
In-Reply-To: <1513617273-7988-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block: Deprecated options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>



On 12/18/2017 12:14 PM, Thomas Huth wrote:
> Remove the deprecated "-drive boot" and "-hdachs" options and properly
> mark some other deprecated options in the deprecation chapter.
> 
> Thomas Huth (3):
>   block: Remove the obsolete -drive boot=on|off parameter
>   block: Remove the deprecated -hdachs option
>   block: Mention -drive cyls/heads/secs/trans/serial/addr in deprecation
>     chapter
> 
>  blockdev.c      | 11 --------
>  qemu-doc.texi   | 29 +++++++++----------
>  qemu-options.hx | 19 ++-----------
>  vl.c            | 86 ++-------------------------------------------------------
>  4 files changed, 19 insertions(+), 126 deletions(-)
> 

Reviewed-by: John Snow <jsnow@redhat.com>

So long, farewell: however, since we forgot to document them, can we
remove them already?
