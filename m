Received: from eggs.gnu.org ([2001:4830:134:3::10]:39009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5csZ-0007kU-9H
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d5csY-0005og-8k
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:50:31 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d5csX-0005o1-Va
	for qemu-devel@nongnu.org; Tue, 02 May 2017 14:50:30 -0400
Received: by mail-wm0-x22b.google.com with SMTP id r190so31443646wme.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 11:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
In-Reply-To: <1493749518.4241.225.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 02 May 2017 18:50:18 +0000
Message-ID: <CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Ohly <patrick.ohly@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

Hi

On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <patrick.ohly@intel.com> wrote=
:

> On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
> > On 05/02/2017 01:09 PM, Marc-Andr=C3=A9 Lureau wrote:
> > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger <
> stefanb@linux.vnet.ibm.com>
> > > wrote:
> > >
> > >> And who is going to implement that qemu-swtpm? Obviously this
> discussion
> > >> doesn't contribute to progress if nobody is doing that in the end.
> > >>
> > > The same persons who try to push for that emulated TPM code. The
> easiest
> > > approach would be to copy/adapt the swtpm code in qemu, if the licenc=
e
> is
> > > compatible. I can help with that if there is a consensus it's a bette=
r
> > > approach.
> >
> >
> > It's a matter of time and at least I don't have time for that.
>
> Neither do I, and nor (I believe) does Amarnath. The approach with using
> the existing swtpm project seemed attractive to us exactly because it
> avoids having to write and maintain more than just the glue code between
> the two projects.
>

The main argument is not about having more or less code in qemu to
maintain, but yes this is a concern (although giving up that maintenance to
a seperate project with mostly Stefan-alone isn't a much better
alternative). btw, is the project actually used by something else than
qemu? (I am not talking about developpers/testing). If not, then it makes
sense to make it part of qemu.

But it's mostly a technical reason, to avoid having to rely on a foreign
protocol and project with all the compatibility constrains.

In the end, we may decide to start with a separate project, and change it
in the future if it's problematic (that would break some cases, such as
being able to freely switch the helper). Tbh, I am not so happy with the
code quality of swtpm, and I haven't looked closely at libtpms. Having a
qemu-swtpm as part of qemu would probably help improve it too, and bring a
few more developers for maintainance...


--=20
Marc-Andr=C3=A9 Lureau
