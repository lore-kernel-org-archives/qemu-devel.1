Received: from eggs.gnu.org ([2001:4830:134:3::10]:45604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUFbL-0002nt-Ih
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUFS3-0007wJ-34
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:29:43 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:41115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUFS2-0007w3-V6
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:29:43 -0500
Received: by mail-ot1-x329.google.com with SMTP id u16so16126068otk.8
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:29:42 -0800 (PST)
MIME-Version: 1.0
References: <154385426086.17724.4390242199797858265.stgit@gimli.home>
	<154385451622.17724.12272989665681200621.stgit@gimli.home>
In-Reply-To: <154385451622.17724.12272989665681200621.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 18:29:30 +0000
Message-ID: <CAFEAcA_C0Mwx8sfzLCbVSEixdzWoAoSCPEC0tAp=b1HYcrW0og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [for-4.0 PATCH v2 8/9] q35/440fx/arm/spapr: Add
 QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Mon, 3 Dec 2018 at 16:28, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> Including all machine types that might have a pcie-root-port.

We should bump the version for every versioned machine
we have, whether it has a pcie-root-port or not.
Otherwise we'll forget at the end of the release
cycle again...

thanks
-- PMM
