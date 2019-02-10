Received: from eggs.gnu.org ([209.51.188.92]:54258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswnQ-0004KV-B3
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswnP-0005vR-MP
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:37:52 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gswnP-0005uj-Hm
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:37:51 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so14399293otk.8
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 13:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190208181226.24052-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Feb 2019 21:37:38 +0000
Message-ID: <CAFEAcA9svK-RARyicVQbyBi+8py6-ZxOTFUjgB4L8Wg_DNTaqw@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Fri, 8 Feb 2019 at 20:44, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Once libslirp has received its first release, we can link with the
> external libslirp library.
>
> The migration data should be compatible with current and older qemu
> versions (same compatibility as today). See "slirp: add state
> saving/loading" patch. However, the content should be treated as a
> blob, as the format may change eventually in the future.

Could you elaborate a bit on what you mean by "the format
might change" ? It's not clear to me what libslirp's API/ABI
guarantees are here to ensure that QEMU can retain cross-QEMU-version
migration compatibility and that QEMU version X with libslirp
version Y can migrate both to and from QEMU version X with
libslirp version Z.

thanks
-- PMM
