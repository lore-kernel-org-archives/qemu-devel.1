Received: from eggs.gnu.org ([2001:4830:134:3::10]:57947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSMvl-00071V-NQ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSMvh-0006O3-QT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSMvh-0006Ng-K9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:27:45 -0400
Date: Tue, 4 Jul 2017 13:27:38 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704122738.GM3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170704111404.28569-1-berrange@redhat.com>
	<f22d82b6-cd4b-b71c-179e-2f590ddb19b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f22d82b6-cd4b-b71c-179e-2f590ddb19b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jul 04, 2017 at 02:21:28PM +0200, Thomas Huth wrote:
> On 04.07.2017 13:14, Daniel P. Berrange wrote:
> [...]
> >  - Not listing the '-6' and '-e' args to qemu-img create. Those
> >    were never deprecations, because the functionality was
> >    immediately turned into a fatal error.
> How did you come to that conclusion? As far as I can see, the -6 option
> has been added by commit ec36ba14748e140dda2 and that was part of QEMU
> v0.10. The deprecation was done in commit eec77d9e712bd415 and that was
> part of QEMU v0.14.

A 'deprecation' message implies that the functionality continues to
work, but the user gets a warning that its going away. In this case
the user gets a warning, and the functionality is unusable - qemu-img
just exits immediately. This isn't deprecation in any normal sense,
it is just immediate feature removal with an message telling you it
has already been deleted :-(

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
