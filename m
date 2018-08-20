Received: from eggs.gnu.org ([2001:4830:134:3::10]:43875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frhpb-0007IJ-Nb
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frhpY-0000Ll-IT
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:54:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1frhpY-0000In-Bx
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:54:40 -0400
Received: from mail-oi0-f69.google.com ([209.85.218.69])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1frhpW-0002vH-Qi
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:54:38 +0000
Received: by mail-oi0-f69.google.com with SMTP id 20-v6so13775337ois.21
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 03:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <1513160272-15921-1-git-send-email-christian.ehrhardt@canonical.com>
	<CAATJJ0+snukR5zqeL4v3B+YfcVP8jwxjgjfV6pupeJpoGCeHfA@mail.gmail.com>
	<CAATJJ0KK3Ya1RMyAjPDyYOQHbo+2xoWDbnVNup1Yop8Og00eBw@mail.gmail.com>
	<d0b421e2-2c0b-db08-5f6e-d05e11bbc007@amsat.org>
	<791e86e2-c278-13cf-0c3a-05b53e30aa08@amsat.org>
In-Reply-To: <791e86e2-c278-13cf-0c3a-05b53e30aa08@amsat.org>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 20 Aug 2018 12:54:11 +0200
Message-ID: <CAATJJ0+6X4YLLGq-wLCwTOx2sOKjEPqi+Gj71MgoXUR8Y79DXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: f4bug@amsat.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, alex.bennee@linaro.org

On Thu, May 10, 2018 at 8:47 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Hi Paolo,
>
> On 04/24/2018 10:01 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Christian,
> >
> > On 04/09/2018 04:18 AM, Christian Ehrhardt wrote:
> >> Re-Ping for consideration?
> >>
> >> On Mon, Jan 22, 2018 at 3:03 PM, Christian Ehrhardt <
> >> christian.ehrhardt@canonical.com> wrote:
> >>
> >>> Hi,
> >>> maybe I missed a formal thing on this submission, but I don't see it
> right
> >>> away.
> >
> > You missed to Cc the maintainer of this file:
> >
> > $ ./scripts/get_maintainer.pl -f scripts/qemu-guest-agent/fsfreeze-hook
> > Michael Roth <mdroth@linux.vnet.ibm.com> (maintainer:QEMU Guest Agent)
> >
> > (I Cc'ed him).
> >
> > See
> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
> >
> >>> So for now just a ping on any updates in regard to accept this?
> >>>
> >>> On Wed, Dec 13, 2017 at 11:17 AM, Christian Ehrhardt
> >>> <christian.ehrhardt@canonical.com> wrote:
> >>>> The hook already skips a set of rpm upgrade artifacts.
> >>>> Do the same with such files that might be created by dpkg.
> >>>>
> >>>> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1484990
> >>>>
> >>>> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Can you take this patch via your MISC tree?
>

Even after Philippe back then helped to make sure CCs are better nothing
happened.
Therefore kindly re-ping for this to be included.


>
> >>>> ---
> >>>>  scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> >>> b/scripts/qemu-guest-agent/fsfreeze-hook
> >>>> index c27b29f..13aafd4 100755
> >>>> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> >>>> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> >>>> @@ -13,7 +13,7 @@ FSFREEZE_D=3D$(dirname -- "$0")/fsfreeze-hook.d
> >>>>  # Check whether file $1 is a backup or rpm-generated file and shoul=
d
> be
> >>> ignored
> >>>>  is_ignored_file() {
> >>>>      case "$1" in
> >>>> -        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave |
> >>> *.sample)
> >>>> +        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave |
> >>> *.sample | *.dpkg-old | *.dpkg-new | *.dpkg-tmp | *.dpkg-dist |
> *.dpkg-bak
> >>> | *.dpkg-backup | *.dpkg-remove)
> >>>>              return 0 ;;
> >>>>      esac
> >>>>      return 1
> >>>> --
> >>>> 2.7.4
>


--=20
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
