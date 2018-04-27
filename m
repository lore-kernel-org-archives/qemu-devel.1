Received: from eggs.gnu.org ([2001:4830:134:3::10]:35220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fByFo-0000Ic-Cs
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fByFn-0005E1-D6
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:57:16 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:39688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fByFn-0005Dl-8Y
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:57:15 -0400
Received: by mail-oi0-x230.google.com with SMTP id n65-v6so835129oig.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 00:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23266.5953.493587.944766@mariner.uk.xensource.com>
References: <23266.5953.493587.944766@mariner.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 08:56:53 +0100
Message-ID: <CAFEAcA_z1CZY3n+d1Z65HnYZFQYm2iWeu3UhKTgd_LF55UAaYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PULL v9 00/16] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Ian Jackson <Ian.Jackson@eu.citrix.com>, Alistair Francis <alistair.francis@wdc.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>

On 26 April 2018 at 19:15, Ian Jackson <ian.jackson@citrix.com> wrote:
> The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524aeda:
>
>   vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)
>
> are available in the git repository at:
>
>   https://xenbits.xen.org/git-http/people/iwj/qemu.git tags/for-upstream.depriv-2
>
> for you to fetch changes up to 8bbe05d77360b73c1834808023016a778ccf55ca:
>
>   configure: do_compiler: Dump some extra info under bash (2018-04-26 16:29:52 +0100)
>
> ----------------------------------------------------------------
> xen: xen-domid-restrict improvements
>
> This series provides necessary support for running qemu as a Xen
> device model without power equivalent to root.  In particular, it
> makes -xen-domid-restrict effective.
>
> The patches are unchanged since v8, apart from additional reviews, and
> rebasing onto master.  All the patches are now reviewed and/or acked
> apart from the patch to configure, which has a Tested-by from Thomas
> Huth.  I have stripped off the per-patch-series-verson update
> comments.
>

Applied, thanks.

-- PMM
