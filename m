Received: from eggs.gnu.org ([2001:4830:134:3::10]:55456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1des4m-0003MN-JA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1des4h-0005KC-KK
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:08:48 -0400
References: <20170803163353.19558-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3fdaf7c5-591e-4702-126d-b6013a12a690@redhat.com>
Date: Mon, 7 Aug 2017 20:08:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170803163353.19558-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-2.10 0/4] improved
 --version/--help tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com



On 08/03/2017 12:33 PM, Eric Blake wrote:
> Not sure if this should go through Kevin's block tree, Paolo's
> miscellaneous patches, or if I should just do a pull request
> myself (since patch 4 includes a change to qemu-nbd)
> 
> since v2: add R-b on 2-4; also sort 'qemu-img --help' create text
> 
> 001/4:[0012] [FC] 'qemu-img: Sort sub-command names in --help'
> 002/4:[----] [--] 'qemu-io: Give more --version information'
> 003/4:[----] [--] 'qga: Give more --version information'
> 004/4:[----] [--] 'maint: Include bug-reporting info in --help output'
> 
> Eric Blake (4):
>   qemu-img: Sort sub-command names in --help
>   qemu-io: Give more --version information
>   qga: Give more --version information
>   maint: Include bug-reporting info in --help output
> 
>  include/qemu-common.h |  5 +++++
>  vl.c                  |  4 +++-
>  bsd-user/main.c       |  2 ++
>  linux-user/main.c     |  4 +++-
>  qemu-img.c            |  2 +-
>  qemu-io.c             |  9 ++++++---
>  qemu-nbd.c            |  2 +-
>  qga/main.c            |  8 +++++---
>  qemu-img-cmds.hx      | 21 ++++++++++++---------
>  9 files changed, 38 insertions(+), 19 deletions(-)
> 

Nothing to keep the commands from going out of order again, it looks
like -- can this be added as a comment or otherwise scripted as a
./hey_it_looks_like_you_are_about_to_release_qemu.sh script that makes
sure we've dotted the 'i's and crossed the 't's?

Lastly, Didn't we fix the certificate issue? (I thought Jeff had) -- and
even if not, it's still the correct address to send people to IMO. Let
people report to us if the SSL certificate appears to be broken.

Eh, regardless of shed coloring:

Reviewed-by: John Snow <jsnow@redhat.com>
