Received: from eggs.gnu.org ([2001:4830:134:3::10]:37052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3YnN-0003Er-QS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3YnK-0002TX-O6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3YnK-0002TN-IX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89E1885541
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:04:33 +0000 (UTC)
Date: Thu, 27 Apr 2017 10:04:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170427020426.GC26792@pxdev.xzpeter.org>
References: <1493205192-26743-1-git-send-email-peterx@redhat.com>
	<20170427011243.GD9205@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427011243.GD9205@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] ramblock: add hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Apr 27, 2017 at 09:12:43AM +0800, Fam Zheng wrote:
> On Wed, 04/26 19:13, Peter Xu wrote:
> > v2:
> > - replace "lx" with "PRIx64" in three places
> 
> ram_addr_t doesn't have a fixed bit width, to keep compilers happy, maybe you
> can stick to PRIx64 in the format string, and cast the parameters.

Will do when there is new version. Thanks!

-- 
Peter Xu
