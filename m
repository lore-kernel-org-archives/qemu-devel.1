Received: from eggs.gnu.org ([2001:4830:134:3::10]:35134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP5qx-00073F-35
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP5qt-0007rh-U3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:14:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gP5qt-0007rI-Oy
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:14:03 -0500
Date: Tue, 20 Nov 2018 13:13:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181120131358.GO25047@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <mailman.21030.1541972152.1282.qemu-devel@nongnu.org>
	<4D9A31B6-6136-4ABD-B88D-722BA2D99528@gmail.com>
	<CAFEAcA-pN5F7UaiWC8nmG00NC=PftG6Aw3QfmEu-Dj4b8H4fOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-pN5F7UaiWC8nmG00NC=PftG6Aw3QfmEu-Dj4b8H4fOw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Nov 20, 2018 at 01:09:54PM +0000, Peter Maydell wrote:
> On 13 November 2018 at 12:12, Programmingkid <programmingkidx@gmail.com> wrote:
> >> On Nov 11, 2018, at 4:35 PM, Berkus Decker wrote:
> >> These changes are ought to work on OSX 10.6, although I don?t have a machine handy to test it.
> >
> > I have Mac OS 10.6 available for testing.
> 
> This is perhaps a good point to ask the question: is retaining
> support for 10.6 still worth the effort ? It was released 9
> years ago and has been unsupported by Apple for nearly 5 years.
> 
> qemu-doc.texi's "Supported build platforms" section says:
> # The project supports building with the two most recent versions
> # of macOS, with the current homebrew package set available.
> 
> which would be High Sierra (10.13) and Mojave (10.14) only. If you
> widened that to "all versions still supported by Apple" it would add
> Sierra (10.13) to the list.
> 
> Given how few upstream developers we have who care about OSX,
> I think it is not very useful to spend that effort on trying
> to retain support for ancient versions of it.

Yes, given how little resource there is for OSX, and lack of any serious
automated testing beyond "does it compile", we should focus on host
versions which have biggest benefit to users, per our build platforms
guideline.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
