Received: from eggs.gnu.org ([2001:4830:134:3::10]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBhey-0002KX-BZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBhev-0006NE-5F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:14:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBhev-0006Mr-0d
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:14:05 -0400
Date: Thu, 26 Apr 2018 15:14:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180426141400.GM26812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180426135755.GI29865@localhost.localdomain>
	<dffa77fa-11d7-5f3c-4c1e-7ed25a55fa25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dffa77fa-11d7-5f3c-4c1e-7ed25a55fa25@redhat.com>
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Thu, Apr 26, 2018 at 04:09:55PM +0200, Thomas Huth wrote:
> On 26.04.2018 15:57, Eduardo Habkost wrote:
> > (Starting a new thread, for more visibility)
> > 
> > (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
> > devices with all machines, not only with "none")
> > 
> > On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
> [...]
> >> I don't mind having make check SPEED=slow run more extensive tests.
> >> Assuming we actually run them at least once in a while, which seems
> >> doubtful.
> > 
> > We probably don't do that, but we really must be running a more
> > extensive (and slower) test set at least once before every
> > release.
> > 
> > Maybe some people are running SPEED=slow tests, or even more
> > extensive test suites like avocado-vt once in a while, but we
> > need to know who is running them, and when.
> 
> At least I am running "make check SPEED=slow" manually from time to
> time, especially when we enter the hard freeze period.

Hmm, we could get this done by travis. It has the concept of "cron jobs"
for scheduling builds separately from pushes.

So we could keep the current travis jobs unchanged, but then add an
use of SPEED=slow when TRAVIS_EVENT_TYPE == "cron" in the travis.yml,
so we can get SPEED=slow run once a day. Just have to be careful which
jobs we make slow so we don't hit the 50 minute timeout.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
