Received: from eggs.gnu.org ([2001:4830:134:3::10]:47047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXjma-0000tt-GY
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXjmZ-0003qy-QF
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dXjmZ-0003pN-Jj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:52:31 -0400
Date: Wed, 19 Jul 2017 15:46:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170719074643.GA30261@lemon>
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
	<20170717231721.GE2585@lemon>
	<f66c4cb9-e024-d874-8e40-7c42eb489d23@redhat.com>
	<CAFEAcA_dUAasSEPQdeWLBuihaPGQGUcfAz=eRW-s7cdfesNNag@mail.gmail.com>
	<20170718094247.GD11927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170718094247.GD11927@redhat.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 07/18 10:42, Daniel P. Berrange wrote:
> On Tue, Jul 18, 2017 at 10:37:30AM +0100, Peter Maydell wrote:
> > On 18 July 2017 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
> > > Could the test be rewritten to provide a proper timeout handling
> > > instead? Tests should clearly fail after a while instead of hanging
> > > forever...
> > > Or maybe we could add some magic that the troublesome tests are not
> > > executed if a certain environment variable is set, so we could skip them
> > > in these automated setups here?
> > 
> > I think it's always going to be possible that some bug in
> > QEMU results in a test hanging -- so it must be down to
> > the test harness to deal with hanging tests. And then
> > once you have that functionality in the test harness it
> > doesn't matter quite so much whether an individual test
> > has its own timeout handling or not.
> 
> If the tests are all inside a docker container, then dealing with a hanging
> test is no more difficult than waiting a suitable amount of time and then
> telling docker to destroy the container.

Yes, the context here is non-x86 or non-Linux which are not as easy to run
docker.

Running tests in a VM would be great, but the harness is missing.

Fam
