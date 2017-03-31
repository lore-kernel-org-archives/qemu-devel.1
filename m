Received: from eggs.gnu.org ([2001:4830:134:3::10]:43915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu1mQ-0006VL-AK
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cu1mP-0001Zd-FL
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:00:14 -0400
Date: Fri, 31 Mar 2017 15:00:03 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170331190003.GH1135@localhost.localdomain>
References: <20170331120431.1767-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331120431.1767-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9 0/2] curl: Extend and
 fix blockdev-add schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 31, 2017 at 02:04:29PM +0200, Max Reitz wrote:
> Yes, it's yet another episode in our popular
> get-blockdev-add-ready-for-2.9 drama!
> 
> Right now, the schema for the curl block driver is seriously lacking.
> This series improves things at least a bit.
> 
> To improve things seriously, we might want to structure the URL instead
> of it being just a plain string, and we might want to split the cookie
> string into a list of dicts or something similar. However, strictly
> speaking our curl block driver is *not* an (ht|f)tps? block driver but
> just a curl driver. All it does is pass some options to libcurl and then
> send and receive data from it. (We really should have just named it
> "curl" from the start.)
> 
> Therefore, it probably is for the best to leave these options rather
> opaque and let libcurl do the interpretation.
> 
> 
> Max Reitz (2):
>   qapi/curl: Extend and fix blockdev-add schema
>   block/curl: Check protocol prefix
> 
>  qapi/block-core.json | 103 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  block/curl.c         |  10 +++++
>  2 files changed, 104 insertions(+), 9 deletions(-)
> 
> -- 
> 2.12.1
> 
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc.git block

-Jeff
