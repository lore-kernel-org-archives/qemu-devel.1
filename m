Received: from eggs.gnu.org ([2001:4830:134:3::10]:32883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4p3Y-0008Q5-Fp
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4p3V-0003xh-QU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:10:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e4p3V-0003xV-Jj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F3B5883D2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 14:10:44 +0000 (UTC)
Date: Wed, 18 Oct 2017 22:10:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171018141041.GB22872@lemon>
References: <1508331989-142364-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508331989-142364-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: allow running from srcdir !=
 builddir build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 10/18 15:06, Paolo Bonzini wrote:
> The new script uses "git submodule", which is picky about being invoked
> from the top of the git checkout.  Invoke the script from $(SRC_PATH)
> to avoid git's wrath.
> 
> Fixes: b7f404201e45e99da23b9764dec27ce5f965cdcd
> Cc: Fam Zheng <famz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Queued, thanks!

Fam
