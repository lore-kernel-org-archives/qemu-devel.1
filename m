Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFjYk-000759-QV
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFjYk-0008AR-2E
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:22 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:43315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFjYj-00089e-Tn
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:22 -0400
Received: by mail-oi0-x233.google.com with SMTP id p62-v6so25762891oie.10
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 10:04:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87h8njtnok.fsf@dusky.pond.sub.org>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
	<20180507135330.GS25013@localhost.localdomain>
	<87h8njtnok.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 May 2018 18:04:00 +0100
Message-ID: <CAFEAcA_Hmrr4v3HW17WyCFz=dmfLMqZCyu4fGpFqcsfocUKetQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH] tests/device-introspect:
 Test devices with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 May 2018 at 17:50, Markus Armbruster <armbru@redhat.com> wrote:
> I propose:
>
> * Stuff that's required for QEMU to run is not suppressed by -nodefaults
>
> * Stuff that a real machine has soldered on is also not suppressed
>
> * Stuff that can be pulled out of a real machine may be suppressed, even
>   when that means the guest won't run
>
> Does that make some sense?

We might also want
 * Stuff that you can't add back in with an appropriate command line
   argument is not suppressed

though we might optimistically hope that the category is empty :-)

thanks
-- PMM
