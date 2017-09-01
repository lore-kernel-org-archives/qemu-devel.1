Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnirh-0004kX-3k
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnirX-0001PM-KP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnirX-0001PF-Dd
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:07:43 -0400
Date: Fri, 1 Sep 2017 11:07:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901100736.GH31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<09158e7a-0c19-1573-5eaf-e90eed0b59ed@redhat.com>
	<20170901095552.GE4330@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901095552.GE4330@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Sep 01, 2017 at 05:55:52PM +0800, Fam Zheng wrote:
> On Thu, 08/31 11:06, Eric Blake wrote:
> > On 08/31/2017 06:22 AM, Fam Zheng wrote:
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >  tests/docker/test-block | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >  create mode 100755 tests/docker/test-block
> > 
> > 
> > > +cd "$BUILD_DIR"
> > > +
> > > +build_qemu --target-list=x86_64-softmmu
> > > +cd tests/qemu-iotests
> > > +./check -raw
> > > +./check -qcow2
> > 
> > Should we also run ./check -nbd?
> 
> Yes, I can add it, and -g quick to all formats, so that the whole test is not
> lagged too badly, and that writing "quick" tests is encouraged in some degree.

If you also add a "daily" test, you could make the daily one run all tests,
while the per-commit one just uses 'quick'.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
