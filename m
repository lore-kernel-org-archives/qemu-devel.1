Received: from eggs.gnu.org ([2001:4830:134:3::10]:59708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejyMD-0004UH-DS
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 21:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ejyM8-0007C3-F2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 21:24:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ejyM8-0007BC-A2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 21:24:04 -0500
Date: Fri, 9 Feb 2018 10:24:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180209022401.GL24289@lemon.usersys.redhat.com>
References: <20180208162343.30809-1-marcandre.lureau@redhat.com>
	<20180208162343.30809-3-marcandre.lureau@redhat.com>
	<8be47d97-4a09-eb4f-0ee2-624404b43100@redhat.com>
	<CAJ+F1C+TFo96++C61fkp-_GdD43VHj1=zimnFSnEUkx+e=HRZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+TFo96++C61fkp-_GdD43VHj1=zimnFSnEUkx+e=HRZQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] build-sys: enable sanitizers by
 default with --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Thu, 02/08 20:03, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, Feb 8, 2018 at 6:46 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> > On 08/02/2018 17:23, Marc-Andr=E9 Lureau wrote:
> >> The original commit 247724cb302af5d70c8853154b640dfabf2bbb56 was mea=
nt
> >> to enable sanitizers by default when --enable-debug, but failed
> >> because of a gcc static linking bug. Try to enable it back now that
> >> there is a stronger check.
> >>
> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > I'm more afraid that there are quite a few reports from sanitizers.  =
I
> > wonder if that makes --enable-debug unusable; as a non-user of
> > --enable-debug I'm a bit wary of pushing this patch.
>=20
> I understand the concern, but at the same time, people should care
> about fixing those. If they want to keep ignoring them (for bad
> reasons), they can --disable-sanitizers. At least, I would want to
> reach a point where no ASAN regression get introduced in x86 target.
> It would be nice if patchew warn on new ASAN reports for example.

Could you write a docker test for that?

Fam
