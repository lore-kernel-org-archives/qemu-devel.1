Received: from eggs.gnu.org ([2001:4830:134:3::10]:35286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0VSu-000565-Ue
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0VSu-0006wX-4M
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:59:25 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:34521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0VSt-0006vz-T2
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:59:24 -0400
Received: by mail-oi0-x22e.google.com with SMTP id u141-v6so16705514oif.1
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 09:59:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ffb62c2e-58a8-2ed4-f6e4-36921140370c@redhat.com>
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
	<9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
	<CAFEAcA8qXbuR+o0h3P5HyGgqLxhn6s9W-jpZp2Cnm-YgSOeNBg@mail.gmail.com>
	<ffb62c2e-58a8-2ed4-f6e4-36921140370c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Mar 2018 17:59:02 +0100
Message-ID: <CAFEAcA-SuZ-aEY5aFpqdrjfGeNH+FoLz5vCxf4crJJdiO6w1jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 March 2018 at 17:54, Eric Blake <eblake@redhat.com> wrote:
> Hmm, on re-reading that, I wonder if shortlog will do the right thing when a
> .mailmap entry exists.  I'm trying to make sure we don't have to go
> lower-level with use of 'git log --format=%ae' (vs. --format=%aE and/or log
> --use-mailmap).
>
> /me goes and experiments with:
>
> diff --git i/.mailmap w/.mailmap
> index cf689b9ec99..a90d7deebe6 100644
> --- i/.mailmap
> +++ w/.mailmap
> @@ -10,6 +10,7 @@ Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl
> <edgar_igl@c046a42c-6fe2-
>  Fabrice Bellard <fabrice@bellard.org> bellard
> <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
>  James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Jocelyn Mayer <l_indien@magic.fr> j_mayer
> <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
> +Julia Suvorova <<jusual@mail.ru> Julia Suvorova via Qemu-devel
> <qemu-devel@nongnu.org>
>  Paul Brook <paul@codesourcery.com> pbrook
> <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
>  Paul Burton <paul.burton@mips.com> <paul@archlinuxmips.org>
>
> Yay - shortlog still lists Julia's commit even with the mailmap in place
> (but with a better spelling of her name), so I don't need to try anything
> fancier.  I'll post a separate patch for mailmap, then leave it up to you
> whether to incorporate my shortlog snippet above into your build script.

Your mailmap change above seems to have a stray extra '<' in it --
was that added by the mailing list server, or is it in the original?

thanks
-- PMM
