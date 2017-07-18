Received: from eggs.gnu.org ([2001:4830:134:3::10]:46986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXS3U-000498-6y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXS3Q-0003TC-64
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXS3P-0003Sv-Vu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:56:44 -0400
Date: Tue, 18 Jul 2017 13:56:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718125635.GI11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
	<20170718072351.GB11927@redhat.com>
	<503be976-144b-d468-04b2-12dd99947bf1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <503be976-144b-d468-04b2-12dd99947bf1@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Tue, Jul 18, 2017 at 07:35:58AM -0500, Eric Blake wrote:
> On 07/18/2017 02:23 AM, Daniel P. Berrange wrote:
> >> How would it not help?  Are we using gcc 7 on windows builds?  Adding
> >> the assert is enough to shut up new gcc; old gcc was already silent; and
> >> if mingw is still on old gcc, it doesn't matter whether assert() is
> >> marked noreturn for what this patch is doing.
> > 
> > Mingw isn't using a fork of GCC anymore, its all mainline. Thus Fedora's
> > mingw gcc packages track native gcc packages. IOW i686-w64-mingw32-gcc
> > is already on version 7.1.0 in Fedora
> 
> So I guess that means running 'make docker-test-mingw@fedora' on Fedora
> 26 will find out if we need further tweaks?  Trying it now...
> 
> Nope, didn't get very far :(
> 
> $ make docker-test-mingw@fedora
>   BUILD   fedora
> make[1]: Entering directory '/home/eblake/qemu'
>   ARCHIVE qemu.tgz
> usage: git archive [<options>] <tree-ish> [<path>...]
> ...
> make[1]: *** [/home/eblake/qemu/tests/docker/Makefile.include:35:
> docker-src.2017-07-18-07.35.20.4101] Error 129
> make[1]: Leaving directory '/home/eblake/qemu'
> make: *** [/home/eblake/qemu/tests/docker/Makefile.include:156:
> docker-run-test-mingw@fedora] Error 2
> 
> Am I not doing it right?

That works fine for me - perhaps  V=1 will tell you what's wrong
with the git archive command.

In any case, despite having gcc 7.1.0, I don't see the error
messages in question when running a mingw build. It could be that
the new problems GCC 7 reports are only triggered when combined
with a suitable C library like GCC, to get the symbols annotated
to enable fortify source to check them.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
