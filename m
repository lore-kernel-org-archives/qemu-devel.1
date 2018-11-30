Received: from eggs.gnu.org ([2001:4830:134:3::10]:43333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfVh-0005OH-Vj
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfVe-0005Su-Qk
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSfVe-0005ST-Km
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:54:54 -0500
Date: Fri, 30 Nov 2018 09:54:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130095450.GC8101@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Nov 29, 2018 at 02:43:03PM -0600, Eric Blake wrote:
> On 11/29/18 11:45 AM, Paolo Bonzini wrote:
> > gtester is deprecated by upstream glib and it does not support tests
> > that call g_test_skip in some glib stable releases.
> > 
> > glib suggests instead using Automake's TAP support.  We do not support
> > Automake, but we can copy the code that beautifies the TAP output and
> > use it.  I chose to use the Perl copy rather than the shell/awk one,
> > in order to reuse Perl's TAP parsing package, but I'm open to suggestions
> > about which language to use.
> 
> I'm less familiar with the TAP protocol than I'd like to admit, but I did
> find:
> 
> https://blog.gtk.org/2018/07/11/news-from-glib-2-58/
> 
> which corroborates your claim that switching to Automake's TAP parser is
> indeed a recommended approach to avoid the now-deprecated gtester.

FYI, for docs about the TAP protocol see:

   https://testanything.org/tap-specification.html

I've always liked the TAP protocol approach to test output where you print
an ok/not ok  status for each piece of the test, as opposed to assertion
style tests where you just abort at the first piece that fails. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
