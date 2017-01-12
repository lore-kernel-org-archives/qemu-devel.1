Received: from eggs.gnu.org ([2001:4830:134:3::10]:46369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRcjm-0007mg-9s
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRcjk-0004Ep-26
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRcjj-0004EQ-SL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:36:03 -0500
Date: Thu, 12 Jan 2017 18:35:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170112103557.GP4450@pxdev.xzpeter.org>
References: <1484192182-13760-1-git-send-email-peterx@redhat.com>
	<1484192182-13760-3-git-send-email-peterx@redhat.com>
	<20170112100405.tyroqjvxpxdxocuc@hawk.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170112100405.tyroqjvxpxdxocuc@hawk.localdomain>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v6 2/3] run_tests: put logs
 into per-test file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Thu, Jan 12, 2017 at 11:04:05AM +0100, Andrew Jones wrote:

[...]

> >  config=$TEST_DIR/unittests.cfg
> > -rm -f test.log
> > -printf "BUILD_HEAD=$(cat build-head)\n\n" > test.log
> > +
> > +rm -rf $unittest_log_dir.old
> > +[ -d $unittest_log_dir ] && mv $unittest_log_dir $unittest_log_dir.old
> > +mkdir $unittest_log_dir || exit 2
> > +
> > +echo "BUILD_HEAD=$(cat build-head)" > $unittest_log_dir/SUMMARY
> > +
> 
> nit: to be 100% correct all the references to the log dir should have
> "'s around them in order to handle spaces, or other shell ambiguous
> characters, in the name. For example, mkdir $log_dir, where $log_dir
> is "my tests" would create two directories, "my" and "tests" without
> the quotes. Anyway, I'm not too worried about someone choosing a
> weird log dir name, nor even changing it from the default.
> 
> Isn't bash fun :-)

It is, as long as it won't break my system... (Once I accidentally did
a "rm -rf /lib" in Bash when I was still using FreeBSD... Bash became
less funny since then ;-).

I'll add them if I'm going to have another spin.

[...]

> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks for reviewing!

-- peterx
