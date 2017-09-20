Received: from eggs.gnu.org ([2001:4830:134:3::10]:36569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVQT-0005OL-Fv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duVQQ-0000Zt-BO
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duVQQ-0000Xd-4V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 23:11:46 -0400
Date: Wed, 20 Sep 2017 11:11:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170920031139.GE18491@lemon>
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-5-famz@redhat.com>
	<dbb8a1c1-a2a8-fb7d-1fea-f66da7417a89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb8a1c1-a2a8-fb7d-1fea-f66da7417a89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 04/13] tests: Add a test key pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 09/19 10:18, Eric Blake wrote:
> On 09/19/2017 02:27 AM, Fam Zheng wrote:
> > This will be used by setup test user ssh.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/keys/README     |  6 ++++++
> >  tests/keys/id_rsa     | 27 +++++++++++++++++++++++++++
> >  tests/keys/id_rsa.pub |  1 +
> >  3 files changed, 34 insertions(+)
> >  create mode 100644 tests/keys/README
> >  create mode 100644 tests/keys/id_rsa
> >  create mode 100644 tests/keys/id_rsa.pub
> > 
> > diff --git a/tests/keys/README b/tests/keys/README
> > new file mode 100644
> > index 0000000000..f381ac0698
> > --- /dev/null
> > +++ b/tests/keys/README
> > @@ -0,0 +1,6 @@
> > +This folder contains a well-known key pair used in QEMU tests.
> 
> s/key/ssh key/ ?

Yup.

> 
> > +
> > +Some guests require the key to exist prior to provisioning the guest; also,
> > +reusing a pre-built key avoids consuming entropy every time the testsuite is
> > +run.  Because the private key is well-known, care must be taken to use the key
> > +ONLY in situations that cannot be compromised by external network clients.
> 
> Thanks; that helps.
> 
> > +++ b/tests/keys/id_rsa.pub
> > @@ -0,0 +1 @@
> > +ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCikC46WYtXotUd0UGPz9547Aj0KqC4gk+nt4BBJm86IHgCD9FygSGX9EFutXlhz9KZIPg9Okk7+IzXRHCWI2MNvhrcjyrezKREm71z08j9iwfxY3340fY2Mo+0khwpO7bzsgzkljHIHqcOg7MgttPInVMNH/EfqpgR8EDKJuWCB2Ny+EBFN/3dAiff0X/EvKle9PUrY70EkSycnyURS8HZReEqj8lN9J5kXzA8F6jBo/0Q42Ttv6e4k5YcaDrwmLrBWLra2PCXZLNyHqXEiFkGmdXtA1Eox9gc/p4jIXim6xrPNmpN6WyrrEjaCF5xYvNv8wXkD6uSWwbHYU24lIAn qemu-test
> 
> Let's make the comment even longer (I think you can use 'ssh-keygen -C
> "some useful comment"', but
> https://serverfault.com/questions/442933/add-comment-to-existing-ssh-public-key
> has more information): maybe along the lines of:
> 
> ssh-rsa AAAAB...IAn well-known key for qemu-test, do not use on any
> machine exposed to an external network

OK.
