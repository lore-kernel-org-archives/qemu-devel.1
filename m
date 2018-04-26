Received: from eggs.gnu.org ([2001:4830:134:3::10]:38398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBkgf-0002mI-8Y
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBkge-0004xY-8i
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:28:05 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:38868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBkge-0004wC-3t
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:28:04 -0400
Received: by mail-ot0-x230.google.com with SMTP id j27-v6so30168800ota.5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 10:28:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 18:27:42 +0100
Message-ID: <CAFEAcA9cumr=t7mRZ-9KtLMWAK-9nVGmRsnXjJ+pc899ePxfVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v9 00/16] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:X86" <xen-devel@lists.xenproject.org>, Alistair Francis <alistair.francis@wdc.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>

On 26 April 2018 at 16:56, Ian Jackson <ian.jackson@eu.citrix.com> wrote:
> From: Ian Jackson <Ian.Jackson@eu.citrix.com>
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> The following changes since commit b8846a4d6352b2a1d2012f8b3b9115640524aeda:
>
>   vl.c: new function serial_max_hds() (2018-04-26 13:58:29 +0100)
>
> are available in the git repository at:
>
>   https://xenbits.xen.org/git-http/people/iwj/qemu.git for-upstream.depriv-2

Hi -- my apply-pullreq script thinks this isn't a signed tag:

error: remotes/iwj/for-upstream.depriv-2: cannot verify a non-tag object of
type commit. Does not appear to be a signed tag

We only apply signed-tag pull requests these days; could you
create and sign a tag and resend the pullreq, please? (You
only need to resend the cover letter, not the whole set of
patches.)

(https://wiki.qemu.org/Contribute/SubmitAPullRequest
is our process documentation on pull requests, but I think
everything else with this one is fine.)

thanks
-- PMM
