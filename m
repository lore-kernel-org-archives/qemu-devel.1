Received: from eggs.gnu.org ([2001:4830:134:3::10]:54785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1f5R5K-0007O8-EI
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1f5R5H-0002AT-1y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1f5R5G-00028s-Pj
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:22 -0400
Received: from mail-ot0-f199.google.com ([74.125.82.199])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1f5R5F-0007r0-0w
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:19:21 +0000
Received: by mail-ot0-f199.google.com with SMTP id 11-v6so5268389otj.1
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 00:19:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAATJJ0+snukR5zqeL4v3B+YfcVP8jwxjgjfV6pupeJpoGCeHfA@mail.gmail.com>
References: <1513160272-15921-1-git-send-email-christian.ehrhardt@canonical.com>
	<CAATJJ0+snukR5zqeL4v3B+YfcVP8jwxjgjfV6pupeJpoGCeHfA@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 9 Apr 2018 09:18:49 +0200
Message-ID: <CAATJJ0KK3Ya1RMyAjPDyYOQHbo+2xoWDbnVNup1Yop8Og00eBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-guest-agent: freeze-hook to ignore
 dpkg files as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>

Re-Ping for consideration?

On Mon, Jan 22, 2018 at 3:03 PM, Christian Ehrhardt <
christian.ehrhardt@canonical.com> wrote:

> Hi,
> maybe I missed a formal thing on this submission, but I don't see it right
> away.
> So for now just a ping on any updates in regard to accept this?
>
> On Wed, Dec 13, 2017 at 11:17 AM, Christian Ehrhardt
> <christian.ehrhardt@canonical.com> wrote:
> > The hook already skips a set of rpm upgrade artifacts.
> > Do the same with such files that might be created by dpkg.
> >
> > Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1484990
> >
> > Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> > ---
> >  scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> b/scripts/qemu-guest-agent/fsfreeze-hook
> > index c27b29f..13aafd4 100755
> > --- a/scripts/qemu-guest-agent/fsfreeze-hook
> > +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> > @@ -13,7 +13,7 @@ FSFREEZE_D=$(dirname -- "$0")/fsfreeze-hook.d
> >  # Check whether file $1 is a backup or rpm-generated file and should be
> ignored
> >  is_ignored_file() {
> >      case "$1" in
> > -        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave |
> *.sample)
> > +        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave |
> *.sample | *.dpkg-old | *.dpkg-new | *.dpkg-tmp | *.dpkg-dist | *.dpkg-bak
> | *.dpkg-backup | *.dpkg-remove)
> >              return 0 ;;
> >      esac
> >      return 1
> > --
> > 2.7.4
> >
>
>
>
> --
> Christian Ehrhardt
> Software Engineer, Ubuntu Server
> Canonical Ltd
>



-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
