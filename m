Received: from eggs.gnu.org ([209.51.188.92]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyLx-0005u5-Pr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmyLw-0007kS-O5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:04:49 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmyLw-0007hv-FI
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:04:48 -0500
Received: by mail-ot1-x344.google.com with SMTP id w25so7990382otm.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:04:47 -0800 (PST)
MIME-Version: 1.0
References: <003301d4b494$775585c0$66009140$@ru>
In-Reply-To: <003301d4b494$775585c0$66009140$@ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 10:04:34 +0000
Message-ID: <CAFEAcA8fQCR=dLaTs2k7rB2uBwU859ANoA1Yc=hRT1ZDnNWWiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Querying possible -cpu variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?0KTRg9GA0YHQvtCy0LAg0J3QsNGC0LDQu9C40Y8=?= <Natalia.Fursova@ispras.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, 25 Jan 2019 at 09:59, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> To fill the combo box in CPU selection form we run QEMU with "-cpu help" command and parse its
> output.
>
> The format of this list depends on target. Therefore our parsing code does not look good (and also
> may corrupt someday).
>
> Is there a better way of requesting this information?

Yes, and you list it below...

> Or we should do one of the following:
>
> 1.       Patch all targets and make the uniform "-cpu help" output format
>
> 2.       Add QMP command for requesting this list.

...you should use QMP. The whole point of that protocol is to
be a guaranteed-not-to-break-or-change-format machine readable
way to query properties of QEMU. Don't try to hand-parse
the human-readable help output, please.

thanks
-- PMM
