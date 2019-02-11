Received: from eggs.gnu.org ([209.51.188.92]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gt99W-00057U-Ca
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:49:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gt99V-0001ge-Ae
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:49:30 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gt99V-0001au-4z
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:49:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id 2so11553416qtb.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 02:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
	<CAFEAcA9svK-RARyicVQbyBi+8py6-ZxOTFUjgB4L8Wg_DNTaqw@mail.gmail.com>
In-Reply-To: <CAFEAcA9svK-RARyicVQbyBi+8py6-ZxOTFUjgB4L8Wg_DNTaqw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Feb 2019 11:49:09 +0100
Message-ID: <CAMxuvazBdkHYWwQRAj1aP4=oJwBhcFAGTeCmEVQ+kZyyUnQvJg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi

On Sun, Feb 10, 2019 at 10:37 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
>
> On Fri, 8 Feb 2019 at 20:44, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Once libslirp has received its first release, we can link with the
> > external libslirp library.
> >
> > The migration data should be compatible with current and older qemu
> > versions (same compatibility as today). See "slirp: add state
> > saving/loading" patch. However, the content should be treated as a
> > blob, as the format may change eventually in the future.
>
> Could you elaborate a bit on what you mean by "the format
> might change" ? It's not clear to me what libslirp's API/ABI
> guarantees are here to ensure that QEMU can retain cross-QEMU-version
> migration compatibility and that QEMU version X with libslirp
> version Y can migrate both to and from QEMU version X with
> libslirp version Z.

So far, the migration code should be 1:1 with existing qemu code. It's
tricky to tell the compatibility on existing code, but the saved
bitstream version_id is 4, and it can load some older versions (I am
not sure all the way down to original migration code).

QEMU bitstream version shouldn't be relevant here, as qemu will get
and provide a binary blob.

libslirp should aim at keeping compatibility with its own older
bitstreams. A newer version will fail to be read with a library that
doesn't support it.

Does that sound correct?

thanks
