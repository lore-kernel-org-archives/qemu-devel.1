Received: from eggs.gnu.org ([2001:4830:134:3::10]:59514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPbvt-0006Gj-7h
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPbvp-0004lG-8e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:20:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cPbvp-0004l1-0K
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:20:13 -0500
Date: Fri, 6 Jan 2017 23:20:10 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170106231922-mutt-send-email-mst@kernel.org>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
	<CAFEAcA97bb-LBoPVvm_wqS6GVyYoFhwR6qBRJDPVRLG8sOGqsA@mail.gmail.com>
	<20170106215615-mutt-send-email-mst@kernel.org>
	<3240188c-69b7-bbc9-6121-a75d093f5289@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3240188c-69b7-bbc9-6121-a75d093f5289@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, mlureau@redhat.com, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 06, 2017 at 02:38:32PM -0600, Eric Blake wrote:
> On 01/06/2017 02:04 PM, Michael S. Tsirkin wrote:
> > On Sat, Dec 17, 2016 at 11:18:03AM +0000, Peter Maydell wrote:
> >> On 16 December 2016 at 21:32,  <no-reply@patchew.org> wrote:
> >>> Your series seems to have some coding style problems. See output be=
low for
> >>> more information:
> >>>
> >>> Type: series
> >>> Subject: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
> >>> Message-id: 1481922841-4324-1-git-send-email-mst@redhat.com
> >>
> >>> Checking PATCH 5/9: contrib: add libvhost-user...
> >>> ERROR: Invalid UTF-8, patch and commit message should be encoded in=
 UTF-8
> >>> #75: FILE: contrib/libvhost-user/libvhost-user.c:9:
> >>> + *  Marc-Andr Lureau <mlureau@redhat.com>
> >>>               ^
> >>>
> >>> ERROR: Invalid UTF-8, patch and commit message should be encoded in=
 UTF-8
> >>> #1579: FILE: contrib/libvhost-user/libvhost-user.h:8:
> >>> + *  Marc-Andr Lureau <mlureau@redhat.com>
> >>>               ^
> >>>
> >>> total: 2 errors, 0 warnings, 1950 lines checked
> >>
> >> Michael, could you check the encoding in that file and respin
> >> the patchset if necessary, please?
> >>
> >> thanks
> >> -- PMM
> >=20
> > I have no idea what this means.
>=20
> Look at the headers to patch 5/9:
>=20
> Subject: [PULL for-2.9 5/9] contrib: add libvhost-user
> Message-ID: <1481922841-4324-6-git-send-email-mst@redhat.com>
> References: <1481922841-4324-1-git-send-email-mst@redhat.com>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Diso-8859-1
>=20
> Although that mail body says
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> it was doing so with the single-byte character from the iso-8859-1
> character set, instead of the multibyte UTF-8 character set.
>=20
> Compare that to another recent pull request from Gerd:
>=20
> Date: Wed,  4 Jan 2017 12:21:20 +0100
> Message-Id: <1483528883-1753-9-git-send-email-kraxel@redhat.com>
> In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
> References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: quoted-printable
>=20
> where the mail body says:
> From: Marc-Andr=3DC3=3DA9 Lureau <marcandre.lureau@redhat.com>
>=20
> So somehow, your git settings differ from Gerd, in that your 'git
> send-email' (or however you are sending your pull request) is not
> picking the correct encoding.  The buildbot is NOT seeing UTF-8, but
> ISO-8859-1 characters from your pull request, and is apparently unable
> to run iconv on the result before testing the patches out, resulting in
> the dropped bytes that are not already UTF-8 encoded.  My mail reader,
> on the other hand, is smart enough to recognize both encodings, and my
> mail window sees the name correctly formatted in both mails, with no
> visual indication that the sources for the two mails were in different
> encodings.  Which makes it a rather insidious problem to track down, if
> you don't spot the difference until dealing with some tool that isn't
> smart enough to do automatic conversion.
>=20
> But how to force git to send mail in UTF-8 is not something I've had to
> figure out (I'm relying on my distro's defaults) - you'll have to poke
> around your .git/config (or ~/.gitconfig) and see if you have some
> really old settings from an earlier time, or ask around on freenode's
> #git channel for better ideas.
>=20
> --=20
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20

So the email might be malformed, but git commits are ok I think.
Peter, could you pls merge? I'll investigate my email settings later.

--=20
MST
