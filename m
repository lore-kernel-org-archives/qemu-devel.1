Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNMe-00056B-WD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNMa-0006kz-1d
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvNMZ-0006kD-S4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:47:23 -0400
Date: Fri, 22 Sep 2017 20:47:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922124720.GC32000@lemon>
References: <1506080563-41084-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506080563-41084-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: add installation to build tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org

On Fri, 09/22 13:42, Paolo Bonzini wrote:
> Drop ccache on Fedora, because it fails on RHEL 7.4, it is not used
> by any other distro and it is not particularly useful on throwaway
> containers.

I wonder what exactly failed with ccache? Patchew relies on it to speed up
compiling every series on the list. The ccache db is not throwaway with that in
mind - git grep for CCACHE_DIR.

Fam
