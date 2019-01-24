Received: from eggs.gnu.org ([209.51.188.92]:36686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmZeo-0005bj-Pm
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmZem-0004yO-Jk
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmZek-0004ng-4T
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:42:36 -0500
Date: Thu, 24 Jan 2019 08:42:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124074224.vuwxr6gith4txvmj@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<da5485bb1a115b2cfd3a4484cb5f351c026ae4db.1547681517.git.DirtY.iCE.hu@gmail.com>
	<20190117092212.ccv7zv4snnuanxtw@sirius.home.kraxel.org>
	<75f937a5-4ab7-fdf5-f14c-e1ec87226c4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75f937a5-4ab7-fdf5-f14c-e1ec87226c4a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/50] audio: reduce glob_audio_state
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 23, 2019 at 09:16:07PM +0100, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2019-01-17 10:22, Gerd Hoffmann wrote:
> > On Thu, Jan 17, 2019 at 12:36:48AM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=
=C3=A1n wrote:
> >> Remove glob_audio_state from functions, where possible without break=
ing
> >> the API.  This means that most static functions in audio.c now take =
an
> >> AudioState pointer instead of implicitly using glob_audio_state.  Al=
so
> >> included a pointer in SWVoice*, HWVoice* structs, so that functions
> >> dealing them can know the audio state without having to pass it arou=
nd
> >> separately.
> >>
> >> This is required in order to support multiple simultaneous audio
> >> backends (added in a later commit).
> >=20
> > I think it makes sense to split the series into smaller pieces, here
> > would be a good place for the split (i.e. patches 1-14 which introduc=
e
> > -audiodev will be the first batch, this patch starts the next batch).
>=20
> Alright, I think this series is pretty useless without at least the
> multiple simultaneous backends part, but if it's easier to review in
> smaller chunks, let's do it.

Also start merging stuff even though later in the series there are still
open issues to be tackled (coreaudio breaking for example).

So, I think with the first part the only open issue is whenever we go
with the nested types (i.e. patch #1 as-is) or not.  Given that the
one-element-structs added in that patch will get additional fields I
think the nesting makes sense.

cheers,
  Gerd
