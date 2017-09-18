Received: from eggs.gnu.org ([2001:4830:134:3::10]:56985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtxFJ-0007sy-8m
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtxFI-0006oK-Ay
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:42:01 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:52262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtxFI-0006mz-55
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:42:00 -0400
Received: by mail-wr0-x231.google.com with SMTP id c23so679005wrg.9
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:42:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87poasgjyh.fsf@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 15:41:38 +0100
Message-ID: <CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 15 September 2017 at 14:39, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
> Peter Maydell writes:
>> This looks like it's exposing too much implementation detail.
>> We should just provide an API for "hook to be called for
>> memory writes" which gets all the information when it
>> is called. I don't think we should expose any kind of
>> "this hook is called at translation time" at all.
>
> The differentiation between translation-time and execution-time is key to
> perform certain analysis efficiently.

It's also exposing internal QEMU implementation detail.
What if in future we decide to switch from our current
setup to always interpreting guest instructions as a
first pass with JITting done only in the background for
hot code?

Sticking to instrumentation events that correspond exactly to guest
execution events means they won't break or expose internals.

thanks
-- PMM
