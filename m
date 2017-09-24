Received: from eggs.gnu.org ([2001:4830:134:3::10]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvx4B-00060z-4Q
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 22:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvx47-0006i6-9D
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 22:54:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvx47-0006fG-3F
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 22:54:43 -0400
Date: Sun, 24 Sep 2017 10:54:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170924025439.GA10444@lemon.lan>
References: <1506080563-41084-1-git-send-email-pbonzini@redhat.com>
	<20170922124720.GC32000@lemon>
	<7a904eeb-f400-5311-e06b-65ced6d2298b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a904eeb-f400-5311-e06b-65ced6d2298b@redhat.com>
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org

On Fri, 09/22 17:52, Paolo Bonzini wrote:
> On 22/09/2017 14:47, Fam Zheng wrote:
> > On Fri, 09/22 13:42, Paolo Bonzini wrote:
> >> Drop ccache on Fedora, because it fails on RHEL 7.4, it is not used
> >> by any other distro and it is not particularly useful on throwaway
> >> containers.
> > 
> > I wonder what exactly failed with ccache? Patchew relies on it to speed up
> > compiling every series on the list. The ccache db is not throwaway with that in
> > mind - git grep for CCACHE_DIR.
> 
> Got it.  For some reason the ccache dir in ~/.cache was owned by root.
> I zapped it and now it works, so I've sent v2.

Hmm, right, root in the container can mess with it if you have NOUSER=1, we
should avoid that.

Fam
