Received: from eggs.gnu.org ([2001:4830:134:3::10]:59054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dni9p-0003sH-9o
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dni9l-0000mH-BP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dni9l-0000mA-5U
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:22:29 -0400
Date: Fri, 1 Sep 2017 10:22:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901092222.GD31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<20170831161835.GQ17315@redhat.com>
	<20170901082213.GC4330@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901082213.GC4330@lemon.lan>
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
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri, Sep 01, 2017 at 04:22:13PM +0800, Fam Zheng wrote:
> On Thu, 08/31 17:18, Daniel P. Berrange wrote:
> > Could you add  'check -luks' - it should be passing already with git
> > master.  Ideally it wants password-less sudo enabled, but will skip
> > the appropriate test if that's not there.
> 
> I have this failure:

urgh, someone broke it already :-( that's why we need to run tests
automatically :-) I'll see about a fix


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
