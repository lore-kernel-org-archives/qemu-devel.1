Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRg8n-0003C1-9I
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRg8j-0007yP-2T
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRg8i-0007xR-SP
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:04 -0500
Date: Thu, 12 Jan 2017 22:14:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170112141400.GS4450@pxdev.xzpeter.org>
References: <1484192182-13760-1-git-send-email-peterx@redhat.com>
	<1484192182-13760-3-git-send-email-peterx@redhat.com>
	<5269cdb1-ae12-31af-0e7d-7c8d2b9c6848@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5269cdb1-ae12-31af-0e7d-7c8d2b9c6848@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Thu, Jan 12, 2017 at 01:55:48PM +0100, Paolo Bonzini wrote:

[...]

> > diff --git a/scripts/functions.bash b/scripts/common.bash
> > similarity index 75%
> > rename from scripts/functions.bash
> > rename to scripts/common.bash
> > index ee9143c..2dd7360 100644
> > --- a/scripts/functions.bash
> > +++ b/scripts/common.bash
> > @@ -1,3 +1,12 @@
> > +: ${unittest_log_dir:=logs}
> > +
> > +function run_task()
> > +{
> > +	local testname="$2"
> > +
> > +	RUNTIME_log_file="${unittest_log_dir}/${testname}.log"
> > +	"$@"
> > +}
> 
> This should go in run_tests.sh since that's the only place that uses
> unittest_log_dir.  (The last line then becomes 'run "$@"' and the
> for_each_unittest call must be adjusted).  Done and queued.

Yes, this should be cleaner. Thanks,

-- peterx
