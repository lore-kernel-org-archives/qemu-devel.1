Received: from eggs.gnu.org ([2001:4830:134:3::10]:47953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0V4-0007TZ-Qr
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC0V4-0003XW-0J
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:21:10 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:45268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC0V3-0003X9-Rr
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:21:09 -0400
Received: by mail-oi0-x235.google.com with SMTP id b130-v6so1116900oif.12
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 03:21:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
	<099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 11:20:48 +0100
Message-ID: <CAFEAcA_VAckXDgARe5dJdxe9N19quUD5Dn+Dseuj=itLbFmG0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] qom-test (was: [RFC PATCH]
 tests/device-introspect: Test devices with all machines,
 not only with "none")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 April 2018 at 07:06, Thomas Huth <thuth@redhat.com> wrote:
> On 26.04.2018 13:54, Markus Armbruster wrote:
> [...]
>> Actually, a worse offender in the "waste everybody's time via redunancy"
>> department could be qom-test.
>
> Shall we change qom-test to also only test with the "none" machine in
> the normal "make check" mode and only do the full test with all machines
> in "make check SPEED=slow" ?

We definitely want something that tries to instantiate every
machine, because that does catch bugs.

thanks
-- PMM
