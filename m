Received: from eggs.gnu.org ([209.51.188.92]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cgz-0006Gf-TM
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2cgx-0005Kw-Lf
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:11:13 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2cgx-0005K8-EO
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:11:11 -0500
Received: by mail-ot1-x341.google.com with SMTP id n71so275822ota.10
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 06:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20190308211557.22589-1-alex.bennee@linaro.org>
In-Reply-To: <20190308211557.22589-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 14:10:58 +0000
Message-ID: <CAFEAcA-bOvwPJOtL5pYXR5jE9k8ysc-haqm_f4HvTjA2=iEYWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docs/booting.rst: start documenting
 the boot process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>

On Fri, 8 Mar 2019 at 21:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> While working on some test cases I realised there was quite a lot of
> assumed knowledge about how things boot up. I thought it would be
> worth gathering this together in a user facing document where we could
> pour in the details and background to the boot process. As it's quite
> wordy I thought it should be a separate document to the manual (which
> can obviously reference this). So far I've managed almost a thousand
> words and haven't actually related anything to QEMU's options yet.
>
> So going forward:
>
>   - is this a useful document to have in docs?
>   - are there any other areas to mention?
>     - out auto-magic -bios selection seems like something worth covering
>   - should we have some worked examples of command lines?
>     - I was thinking for example of read-only and pflash examples
>   - we should also describe why direct kernel boots exits
>     - and also the fact they are not that direct (some code executes
>       before a kernel - even if it's less than a full firmware)
>
> Submitted for comment....
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/booting.rst | 127 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 docs/booting.rst

We're trying to move towards having no documents in
the root docs/ directory, but instead having them all
in one of the various subdirectories that will each
be one of our five manuals:
https://wiki.qemu.org/Features/Documentation

thanks
-- PMM
