Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erPFi-0006Sm-Np
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erPFf-0000DW-IU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:32:10 -0500
Date: Thu, 1 Mar 2018 14:31:49 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180301143149.GL2450@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
	<151991407407.1290.17872540651248288006@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151991407407.1290.17872540651248288006@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: curl: Proof of concept for
 connecting to oVirt.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

On Thu, Mar 01, 2018 at 06:21:15AM -0800, no-reply@patchew.org wrote:
> /tmp/qemu-test/src/block/curl.c: In function 'curl_open':
> /tmp/qemu-test/src/block/curl.c:770:15: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>      s->cainfo = qemu_opt_get(opts, CURL_BLOCK_OPT_CAINFO);
>                ^

Ooops - frees const data.  I'll fix this in the next iteration.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
