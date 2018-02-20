Received: from eggs.gnu.org ([2001:4830:134:3::10]:47006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eo4E8-00019G-Nh
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eo4E5-0002mi-FX
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:28:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eo4E5-0002mH-AD
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:28:41 -0500
Date: Tue, 20 Feb 2018 09:28:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180220092826.GD6021@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1519113760-4474-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<CAFEAcA8GXtEJof8eiakbu3fDh_SafAnS_ywpPi6oXeT3qtQqJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8GXtEJof8eiakbu3fDh_SafAnS_ywpPi6oXeT3qtQqJg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] util/uri.c formating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Feb 20, 2018 at 09:14:16AM +0000, Peter Maydell wrote:
> On 20 February 2018 at 08:02, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
> >  Formating the code with `clang-format -i util/uri.c`.
> >  My .clang-format file content is:
> >  '''
> >  IndentWidth: 4
> >  BreakBeforeBraces: Linux
> >  '''
> >
> > Then use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
> > to remove pattern like this: "return (1);"
> >
> > checkpatch.pl still rise these two kinds of "ERROR", I'm not sure
> > whether I should also suppress these, so I left it.
> >
> > '''
> > ERROR: braces {} are necessary even for single statement blocks
> > #1803: FILE: uri.c:1803:
> > +            while ((bas->path[cur] != 0) && (bas->path[cur] != '/'))
> > +                cur++;
> >
> > ERROR: braces {} are necessary for all arms of this statement
> > #1805: FILE: uri.c:1805:
> > +            if (bas->path[cur] == 0)
> > [...]
> > '''
> 
> In some places you have put in extra braces, like here:
> 
> > -    if (str == NULL)
> > -        return(-1);
> > +    if (str == NULL) {
> > +        return -1;
> > +    }
> 
> I think if we're going to reformat the file we might as well
> get it checkpatch-clean. Alternatively if you don't want to
> fix up the brace style then we needn't touch them at all.

I agree - lets get it 100% clean for checkpatch.

> One useful split for format-cleanup patches that you might
> consider is to have a patch which contains only whitespace
> cleanups, so that 'git show --ignore-all-space' shows no changes.
> That makes that patch easy to review. Then changes that do
> make non-whitespace changes can go in their own patch, which
> is generally smaller and so easier to review by eye.

Yes, 2 patches would be nicer.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
