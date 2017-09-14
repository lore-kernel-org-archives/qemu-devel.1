Received: from eggs.gnu.org ([2001:4830:134:3::10]:48262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsW7s-0007Tv-Nc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsW7p-00008X-Gb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dsW7p-00006d-An
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 344F87E439
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 15:32:20 +0000 (UTC)
Date: Thu, 14 Sep 2017 17:32:15 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170914153215.GA9252@vader>
References: <20170908114407.25906-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908114407.25906-1-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv6 0/6] seccomp: feature refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com

On Fri, Sep 08, 2017 at 01:44:02PM +0200, Eduardo Otubo wrote:
> v6:
>     * remove switch-case
>     * invert obsolete option logic at vl.c
>     * remove debug info
> v5:
>     * replaced strcmp by g_str_equal
>     * removed useless goto
>     * fixed style problems
> 
> v4:
>     * include another field on the struct for the modes
>     * remove priority
>     * fixed typos
>     * error handling for prctl
>     * add allow|deny values for all options
>     * error hanlding for wrong values for all options
>     * change how binary values are treated
>     * reformat help text
> 
> v3:
>     * Style problems fixed
> 
> v2:
>     * The semantics of the options "allow/deny" instead of booleans "on/off" remains. 
>     * Added option 'children' to elevateprivileges
>     * Added documentation to docs/
> 
> v1:
>     * First version based on the discussion
>       https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03348.html
> 
> Eduardo Otubo (6):
>   seccomp: changing from whitelist to blacklist
>   seccomp: add obsolete argument to command line
>   seccomp: add elevateprivileges argument to command line
>   seccomp: add spawn argument to command line
>   seccomp: add resourcecontrol argument to command line
>   seccomp: adding documentation to new seccomp model
> 
>  docs/seccomp.txt         |  31 +++++
>  include/sysemu/seccomp.h |   8 +-
>  qemu-options.hx          |  26 +++-
>  qemu-seccomp.c           | 325 ++++++++++++++---------------------------------
>  vl.c                     |  82 +++++++++++-
>  5 files changed, 235 insertions(+), 237 deletions(-)
>  create mode 100644 docs/seccomp.txt
> 
> -- 
> 2.13.5
> 
> 

Daniel or anyone else interested in reviewing, any comment left for
this patchset? If not I'll send the pull request tomorrow.

Best regards,

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
