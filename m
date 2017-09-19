Received: from eggs.gnu.org ([2001:4830:134:3::10]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duIHN-0003vF-TE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duIHJ-0008QY-QY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:09:33 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:47736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duIHJ-0008Pn-JE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:09:29 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 13so5108805wmq.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:09:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d16o53xr.fsf@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 14:09:07 +0100
Message-ID: <CAFEAcA9pc8Q4THRK8P3y_5OFPsJt9qYg9zNG5Wh6m_LYhTAyag@mail.gmail.com>
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

On 18 September 2017 at 18:09, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
> TCI still has a separation of translation-time (translate.c) and executio=
n-time
> (interpreting the TCG opcodes), and I don't think that's gonna go away an=
ytime
> soon.
>
> Even if it did, I think there still will be a translation/execution separ=
ation
> easy enough to hook into (even if it's a "fake" one for the cold-path
> interpreted instructions).

As a slightly more immediate and practical example, I'm currently
implementing the v8M "SG" instruction. This is a somewhat weird
corner-case of an instruction (it's the only instruction you can
execute in non-secure state from a code region that's secure).
I'm implementing it in the exception-handling code path: if we
detect "NS execute from S memory" we throw a QEMU internal exception,
and in the cpu_do_interrupt code we either (a) identify that this
is the SG instruction and execute it or (b) generate the right guest
CPU exception.

That's definitely executing an instruction, and there's no translation
time for it...

thanks
-- PMM
