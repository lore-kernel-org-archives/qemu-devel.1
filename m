Received: from eggs.gnu.org ([2001:4830:134:3::10]:57429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxl9M-00025w-PS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 22:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxl9J-0001TL-N7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 22:35:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxl9J-0001Jl-Gt
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 22:35:33 -0400
Date: Fri, 29 Sep 2017 10:35:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170929023450.GE26066@lemon.lan>
References: <20170928084430.17059-1-berrange@redhat.com>
	<20170928084430.17059-3-berrange@redhat.com>
	<20170928094453.GD26066@lemon.lan>
	<20170928095216.GF12919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170928095216.GF12919@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
List-ID: <qemu-devel.nongnu.org>

On Thu, 09/28 10:52, Daniel P. Berrange wrote:
> On Thu, Sep 28, 2017 at 05:44:53PM +0800, Fam Zheng wrote:
> > On Thu, 09/28 09:44, Daniel P. Berrange wrote:
> > > When building the tarball to pass into the docker/vm test image,
> > > the code relies on the git submodules being checked out in the
> > > main checkout.
> > > 
> > > ie if the developer has not run 'git submodule update --init dtc'
> > > most (all?) of the docker tests will fail due to the missing dtc
> > > package in the test images.
> > 
> > Not all, fail only in envs/configs where libfdt devel doesn't exist.
> 
> I didn't test all of them but of the ~5 I did test all failed, so I
> just assumed none contain libftd-devel, since you have patchew
> manually check it out.

Patchew does it just because mingw needs it, this is not required for native
build:

$ git grep libfdt tests/docker
tests/docker/dockerfiles/centos6.docker:    libfdt-devel \
tests/docker/dockerfiles/centos7.docker:    libfdt-devel \
tests/docker/dockerfiles/fedora.docker:    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
tests/docker/dockerfiles/min-glib.docker:RUN yum install -y libfdt-devel ccache
tests/docker/dockerfiles/ubuntu.docker:    libspice-protocol-dev libnss3-dev libfdt-dev \

Fam
