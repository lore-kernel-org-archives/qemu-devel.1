Received: from eggs.gnu.org ([2001:4830:134:3::10]:32997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1csNOp-0002Qa-O0
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1csNOj-0004Bk-Rm
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:41:03 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49916)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1csNOj-0004An-Be
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 01:40:57 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
	<1488382850-19252-2-git-send-email-kraxel@redhat.com>
	<874lyiya3i.fsf@linaro.org>
In-Reply-To: <874lyiya3i.fsf@linaro.org>
Date: Mon, 27 Mar 2017 08:40:55 +0300
Message-ID: <003e01d2a6bc$b4214f30$1c63ed90$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL v3 1/3] replay: add record/replay for audio
 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Gerd Hoffmann' <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> > From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >
> > This patch adds recording and replaying audio data. Is saves =
synchronization
> > information for audio out and inputs from the microphone.
> >
> > v2: removed unneeded whitespace change
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > Message-id: 20170202055054.4848.94901.stgit@PASHA-ISP.lan02.inno
> >
> > [ kraxel: add qemu/error-report.h include to fix osx build failure ]
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  audio/audio.c            |  9 ++++--
> >  audio/audio.h            |  5 +++
> >  audio/mixeng.c           | 32 ++++++++++++++++++++
> >  docs/replay.txt          |  7 +++++
> >  include/sysemu/replay.h  |  7 +++++
> >  replay/Makefile.objs     |  1 +
> >  replay/replay-audio.c    | 79 =
++++++++++++++++++++++++++++++++++++++++++++++++
> >  replay/replay-internal.h |  4 +++
> >  8 files changed, 142 insertions(+), 2 deletions(-)
> >  create mode 100644 replay/replay-audio.c
> >
> <snip>
> > diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> > index c26d079..ed66ed8 100644
> > --- a/replay/replay-internal.h
> > +++ b/replay/replay-internal.h
> > @@ -29,6 +29,10 @@ enum ReplayEvents {
> >      /* for character device read all event */
> >      EVENT_CHAR_READ_ALL,
> >      EVENT_CHAR_READ_ALL_ERROR,
> > +    /* for audio out event */
> > +    EVENT_AUDIO_OUT,
> > +    /* for audio in event */
> > +    EVENT_AUDIO_IN,
> >      /* for clock read/writes */
> >      /* some of greater codes are reserved for clocks */
> >      EVENT_CLOCK,
>=20
> Well one thing I noticed while I was trying to work out the difference
> between pre/post mttcg replay problems is the log format ABI has
> changed. REPLAY_VERSION needs to be bumped to prevent confusion.

Right, I missed that while sending the patches.

Pavel Dovgalyuk
