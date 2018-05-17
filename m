Received: from eggs.gnu.org ([2001:4830:134:3::10]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fJK7f-0006Ko-Bp
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fJK7a-0005UZ-Ul
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:43:15 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fJK7a-0005UP-Pt
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:43:10 -0400
Received: by mail-it0-f67.google.com with SMTP id y189-v6so9110107itb.2
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 07:43:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <229d0059-2ab4-bf2d-cbf5-9dca4ff978bd@redhat.com>
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<229d0059-2ab4-bf2d-cbf5-9dca4ff978bd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 17 May 2018 16:43:08 +0200
Message-ID: <CAMxuvazHGsPv9KWQTp7p6JxaPaLPBdw-NgrPN83ne0=SsodVRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/4] RFC: ovmf: Add support for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: edk2-devel@lists.01.org, qemu-devel <qemu-devel@nongnu.org>, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

Hi

On Wed, May 16, 2018 at 11:29 AM, Laszlo Ersek <lersek@redhat.com> wrote:
> Hi Marc-Andr=C3=A9,
>
> On 05/15/18 14:30, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
>> with TPM2 (I haven't tested TPM1, for lack of interest).
>
> I got the review of this patch series added to my TODO list, but I'll
> have to ask for your patience. :(
>
> From an extremely superficial skim:
>
> * please use the
>
>     TopDirPkg/ModuleName: blah blah blah
>
>   subject format, or more generally, if a module cannot be identified,
>
>     TopDirPkg: blah blah blah
>

done

> * the subject line and the commit message shouldn't be wider than 74
>   chars;
>

that should be ok

> * edk2 uses two spaces for general indentation, and I'm noticing some
>   inconsistency there (4 spaces like in QEMU).

yes, I tried to respect that, but sometime fail (emacs c-basic-offset
2 isn't great with comments)

>
> * Please consider formatting the patches with "--find-copies-harder"
>   (although I can look at them with the same option after fetching the
>   series from your repo). This option is usually helpful for reviewers
>   when cloning and modifying modules cross-package.

Hmm, I didn't know that option, ok

>
> * Please consider adopting the git settings at
>   <https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt=
-git-guide-for-edk2-contributors-and-maintainers>,
>   in particular:
>
>   - "--stat=3D1000 --stat-graph-width=3D20", so that pathnames are not
>     truncated in the diffstats,
>

I use git-publish very often. I had to modify it to pass those options
(https://github.com/stefanha/git-publish/pull/48)

>   - the "xfuncname"-related settings, so that git diff hunk headers @@
>     are useful for DSC and INF files too,
>

This is already in my .git/config, I hope it takes it by default in
format-patch?

>   - the diff order file, so that files are listed in patches in logical
>     order, going from abstract / descriptive (.inf, .h) to concrete /
>     imperative (.c).
>

ok

> Not much of a review, I know; this is all I can offer right now. If you
> have the time to respin just with these superficial changes, that might
> make my life easier. If you prefer to delay them, that's 100% fine too.
>

I am going to resend with the style fixes.
