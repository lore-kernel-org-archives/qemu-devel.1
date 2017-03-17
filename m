Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coqUp-0002ro-JV
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1coqUl-0005ax-Sc
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1coqUl-0005aS-JY
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:56:35 -0400
Date: Fri, 17 Mar 2017 11:56:31 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170317115631.GG8050@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On Fri, Mar 17, 2017 at 11:52:01AM +0000, Peter Maydell wrote:
> On 17 March 2017 at 11:49, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
> >> We plan to drop support in a future QEMU release for host OSes
> >> and host architectures for which we have no test machine where
> >> we can build and run tests. For the 2.9 release, make configure
> >> print a warning if it is run on such a host, so that the user
> >> has some warning of the plans and can volunteer to help us
> >> maintain the port if they need it to continue to function.
> >>
> >> This commit flags up as deprecated the CPU architectures:
> >>  * ia64
> >>  * sparc
> >>  * anything which we don't have a TCG port for
> >>    (and which was presumably using TCI)
> >
> > This seems to imply that if we remove supported for these architectures,
> > then TCI is no longer required either, or would there be other reasons
> > to want to keep TCI around, even when all host archs have a TCG port ?
> 
> I've never really seen the point in TCI, but others do, which
> is why it's in the tree.
> 
> >> This list is definitely too all-encompassing, and we should
> >> move at least some of the BSDs into "not-deprecated".
> >> I'm posting the patch for the moment for code review on the
> >> logic and as a placeholder.
> >
> > FreeBSD is the one where I most frequently see developers engaging across
> > the overall virt tools stack (QEMU/libvirt/virt-manager/OpenStack).
> > GNU/kFreeBSD has come up a few times in libvirt, and I don't recall seeing
> > anyone mentioning the remaining BSDs - though perhaps thats because the
> > FreeBSD port fixes are enough to also make other BSDs work.
> 
> Yeah. I'm just struggling with setting up a FreeBSD VM so we
> can compile test that. Interesting that GNU/kFreeBSD has users.

I wouldn't go so far as to say GNU/kFreeBSD has users. It had a few people
who have noticed bits of libvirt didn't compile at times, but I'm not sure
if they actually used the result, or were just building libvirt for sake of
having full platform coverage in Debian packages.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
