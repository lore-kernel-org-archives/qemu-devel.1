Received: from eggs.gnu.org ([2001:4830:134:3::10]:58543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVgfh-0000kn-2t
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVgfd-0008JD-Cl
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:36:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVgfd-0008J3-6f
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:36:37 -0500
Date: Mon, 23 Jan 2017 15:36:32 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170123153632.GI2853@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
	<CAFEAcA_NSRk3wj3iZvhTbR5hxyUVe_4V_dgow=-dPb7KPFCeLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_NSRk3wj3iZvhTbR5hxyUVe_4V_dgow=-dPb7KPFCeLQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 0/8] Merge io/ 2017-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 23, 2017 at 02:46:06PM +0000, Peter Maydell wrote:
> On 23 January 2017 at 14:26, Daniel P. Berrange <berrange@redhat.com> wrote:
> > The following changes since commit 598cf1c805271564686f2d732b36f50c3c40dcdd:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-20 16:42:07 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/berrange/qemu tags/pull-qio-2017-01-23-1
> >
> > for you to fetch changes up to 19f3cc22d364b57315e171090ee2e499b58775b4:
> >
> >   io: introduce a DNS resolver API (2017-01-23 11:28:09 +0000)
> >
> > ----------------------------------------------------------------
> > Merge io/ 2017-01-23
> >
> > Daniel P. Berrange (8):
> >   sockets: add ability to disable DNS resolution for InetSocketAddress
> >   io: stop incrementing reference in qio_task_get_source
> >   io: fix typo in docs for QIOTask
> >   io: add ability to associate an opaque "result" with with a task
> >   io: add ability to associate an error with a task
> >   io: change the QIOTask callback signature
> >   io: remove Error parameter from QIOTask thread worker
> >   io: introduce a DNS resolver API
> 
> Fails to build, OSX:
> 
> /Users/pm215/src/qemu-for-merges/io/dns-resolver.c:30:39: error: use
> of undeclared identifier 'PTHREAD_ONCE_INIT'
> static pthread_once_t instance_init = PTHREAD_ONCE_INIT;
>                                       ^
> /Users/pm215/src/qemu-for-merges/io/dns-resolver.c:39:5: error:
> implicit declaration of function 'pthread_once' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>     pthread_once(&instance_init, qio_dns_resolve_init_instance);
>     ^
> /Users/pm215/src/qemu-for-merges/io/dns-resolver.c:39:5: note: did you
> mean 'pthread_kill'?
> /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/signal.h:82:5:
> note: 'pthread_kill' declared here
> int     pthread_kill(pthread_t, int);
>         ^
> 2 errors generated.
> 
> OSX does have pthread_once(), but you need to actually include
> pthread.h (either directly or more likely via qemu/thread.h)
> to get it.

Of course pthread_once Is not available on Win32 at all. What I
should have used was GOnce which is portable from glib, since
QEMU's thread APIs don't provide any once-control wrappers.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
