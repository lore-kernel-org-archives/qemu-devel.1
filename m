Received: from eggs.gnu.org ([2001:4830:134:3::10]:36623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVf9Z-0002sf-UT
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVf9W-0007W5-De
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:59:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVf9W-0007Vl-8I
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 08:59:22 -0500
Date: Mon, 23 Jan 2017 13:59:15 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170123135915.GF2853@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87pojmjdep.fsf@dusky.pond.sub.org>
	<CAFEAcA9nhd6x+PT5bG0=YqvmUdxJVFPZ6ACiv-2OKrDFJhrqzg@mail.gmail.com>
	<87h94x99e4.fsf@dusky.pond.sub.org>
	<CAFEAcA8vRw=13Lj_98A+3NovSeTg6e0xBopdz9EcdEeUMjjZow@mail.gmail.com>
	<874m0x7ra2.fsf@dusky.pond.sub.org>
	<CAFEAcA_txNPj6JNDavmCREse98XTkQgiFAqx5Vf8KCCu9V-6mQ@mail.gmail.com>
	<878tq93guz.fsf@dusky.pond.sub.org>
	<CAFEAcA-zV8RWCXMCbAHLMEM1oEw7CWT_aDrTc49Xv_wSnMeAyw@mail.gmail.com>
	<CAFEAcA-fSJ5PfpKFaehruzjidBtmQP_435WLqgSLg=cQiETR8Q@mail.gmail.com>
	<878tq5looy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878tq5looy.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 20, 2017 at 04:46:05PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On 17 January 2017 at 16:43, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> In any case, applied this pullreq to master.
> >
> > Although it works fine on my OSX box (with warnings) it seems
> > to have broken the Travis OSX builds:
> > https://travis-ci.org/qemu/qemu/jobs/192750574
> >
> >   GEN     qemu-options.texi
> >   GEN     qemu-monitor.texi
> >   GEN     qemu-img-cmds.texi
> >   GEN     qemu-monitor-info.texi
> >   GEN     qemu-doc.txt
> > qemu-doc.texi:7: warning: unrecognized encoding name `UTF-8'.
> >   GEN     qemu-img.1
> > /Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
> > character [ in @var.
> > /Users/travis/build/qemu/qemu//qemu-options.texi:60: warning: unlikely
> > character ] in @var.
> > /Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
> > character [ in @var.
> > /Users/travis/build/qemu/qemu//qemu-options.texi:61: warning: unlikely
> > character ] in @var.
> > /Users/travis/build/qemu/qemu//qemu-options.texi:630: No matching `@end table'.
> > /Users/travis/build/qemu/qemu//qemu-doc.texi:1419: Cross reference to
> > nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
> > makeinfo: Removing output file `qemu-doc.txt' due to errors; use
> > --force to preserve.
> > make: *** [qemu-doc.txt] Error 1
> 
> @table and @end table are nested correctly in my generated
> qemu-options.texi, and @anchor{bt-hcis} is present.  Can you grab the
> offending qemu-options.texi for me?

I hacked the travis.yml to add "|| cat qemu-options.texi" after the
build fails. The output is here:

  https://travis-ci.org/berrange/qemu/jobs/194471961

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
