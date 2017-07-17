Received: from eggs.gnu.org ([2001:4830:134:3::10]:53178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX3r9-0001tg-12
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX3r5-0000nv-0Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:06:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX3r4-0000mB-Qa
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:06:22 -0400
Date: Mon, 17 Jul 2017 12:06:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717110614.GK3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
	<20170717102053.GH3640@redhat.com>
	<CAFEAcA9fzkk6mC+Bz4jNd+7M8nq0xpooVFDNeVb0VcqGDadB8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9fzkk6mC+Bz4jNd+7M8nq0xpooVFDNeVb0VcqGDadB8Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jul 17, 2017 at 12:00:22PM +0100, Peter Maydell wrote:
> On 17 July 2017 at 11:20, Daniel P. Berrange <berrange@redhat.com> wrote:
> > I'm a little concerned about the fact that we've now got three different
> > sets of tests that are being run on pull requests. There are the tests
> > that Peter runs on various combinations at time of merge, the tests run
> > by patchw at time of submissions, and the tests run by travis after
> > merge. Each of them is covering a different set of scenarios with only
> > partial overlap between them.
> 
> I agree -- I have my ad-hoc test system not because I enjoy
> collecting random things to run tests on but because we don't
> have an automated system that does what I need:
>  * wide coverage, focusing on oddball host architectures and OSes
>  * ability to ssh in to a machine where tests have broken if need be
>  * decently fast to complete a test run (travis is terrible for this)
> 
> Note that "fast to complete a test run for me" is in conflict with
> "usable by anybody who wants to submit a pull request" :-)

Not neccessarily. It does mean though that if we had an automated test
system, we would have to reserve some portion of hardware resources for
exclusively jobs triggered by the person responsible for git master and
stable branch merges, so that it can never get delayed by a backlog of
jobs from the mailing list.

OpenStack has this kind of CI system - they have 2 separate job queues,
one testing all patches submitted for code review, and one queue only
processing patches for merge, so the former can't negatively impact the
progress of the latter. Availability of (money/sponsorship for) hardware
though is an obvious limiting factor here.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
