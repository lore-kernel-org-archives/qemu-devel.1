Received: from eggs.gnu.org ([2001:4830:134:3::10]:57847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3XzI-0002JD-Ql
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3XzF-0006lH-Mp
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d3XzF-0006jy-Fv
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 21:12:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C63321919
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:12:47 +0000 (UTC)
Date: Thu, 27 Apr 2017 09:12:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427011243.GD9205@lemon.lan>
References: <1493205192-26743-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493205192-26743-1-git-send-email-peterx@redhat.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, 04/26 19:13, Peter Xu wrote:
> v2:
> - replace "lx" with "PRIx64" in three places

ram_addr_t doesn't have a fixed bit width, to keep compilers happy, maybe you
can stick to PRIx64 in the format string, and cast the parameters.

Fam
