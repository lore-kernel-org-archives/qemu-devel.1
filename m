Received: from eggs.gnu.org ([2001:4830:134:3::10]:39200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMZ5w-0006c9-6D
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:51:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMZ5m-0002Um-Ok
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:51:00 -0500
Date: Tue, 13 Nov 2018 13:50:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181113135024.GI14591@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<875zx18geq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875zx18geq.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Tue, Nov 13, 2018 at 10:39:57AM +0100, Markus Armbruster wrote:
> Drive-by comment...
> 
> Cleber Rosa <crosa@redhat.com> writes:
> 
> [...]
> > My impression is that the "infrastructure for block tests" is not that
> > different from the infrastructure needed by other tests, specially other
> > QEMU tests.
> [...]
> 
> Yes.  The actual reason for having a completely separate testing
> infrastructure for block tests is that it predates testing
> infrastructure for anything else.
> 
> Moving the tests to common infrastructure would be a sizable one-time
> effort we can ill afford.  Maintaining multiple testing infrastructures
> is an ongoing effort we can also ill afford.

If we do want to move to a common infrastructure, then IMHO this patch
series should do the work to convert qemu-iotests to use it.

Currently this is simply introducing a 2nd way to write block tests.

We know from bitter experiance that when we introduce a new system in
QEMU without converting the old system, the old system will live forever
increasing our maint burden & creatnig confusion for developers about
which is the preferred approach.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
