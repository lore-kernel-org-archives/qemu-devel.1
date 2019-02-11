Received: from eggs.gnu.org ([209.51.188.92]:59753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gt9rY-0001hr-9G
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gt9rX-0006hs-EY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:35:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gt9rX-0006hk-9Z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:34:59 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so11610812qtm.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:34:59 -0800 (PST)
MIME-Version: 1.0
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
	<20190211110907.GP27585@redhat.com>
In-Reply-To: <20190211110907.GP27585@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Feb 2019 12:34:47 +0100
Message-ID: <CAMxuvaz4w75CmN1o0E4y4+pTLk5cks-oGu+FnyUWUbvBqC-jUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi

On Mon, Feb 11, 2019 at 12:09 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Fri, Feb 08, 2019 at 07:12:26PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Once libslirp has received its first release, we can link with the
> > external libslirp library.
> >
> > The migration data should be compatible with current and older qemu
> > versions (same compatibility as today). See "slirp: add state
> > saving/loading" patch. However, the content should be treated as a
> > blob, as the format may change eventually in the future.
>
> How are we going to manage live migration compat if libslirp changes
> the blob content ?
>
> Bear in mind that we need to support all existing QEMU releases live
> migrating to effectively all future QEMU releases, with all future
> libslirp releases, in *both* directions. ie arbitrarily newer
> libslirp needs to be able to emit a blob format that can be read
> by arbitrarily older slirp inside QEMU.


Right, this is all supported currently with the proposed patch set,
since it is effectively the same code.

So register_savevm_live() get passed slirp_state_version() (currently =3D=
=3D 4)

& slirp_state_load() get the version_id from QEMU.

>
> Normally we tie data format changes to the machine type. How are
> we going to achieve such machine type associations with an external
> libslirp ?

Is this relevant for slirp? I don't see any version tied to machine
type. Am I missing something?

thanks

>
> It seems to me that if a libslirp wants to change live migration
> format, it will need to support both the old and new formats
> indefinitely, and the new format must be an opt-in. QEMU can
> then tell libslirp which migraiton format based on the machine
> type.
>
>

ok

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
