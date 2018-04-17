Received: from eggs.gnu.org ([2001:4830:134:3::10]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Q6W-0000qJ-Dg
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8Q6V-0004fQ-KY
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:53:00 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:37872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8Q6V-0004f3-Fh
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 08:52:59 -0400
Received: by mail-ot0-x22c.google.com with SMTP id y46-v6so21225260otd.4
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 05:52:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87in8qf2w3.fsf@dusky.pond.sub.org>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 13:52:38 +0100
Message-ID: <CAFEAcA9pTyF=xHz_2Dt3XqQrUnKrPthFP+zpjV8ba2PVM-s7iw@mail.gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 17 April 2018 at 13:12, Markus Armbruster <armbru@redhat.com> wrote:
> Thomas Huth <thuth@redhat.com> writes:
>>  In case someone wants to help with creating some bug fix patches
>>  during the QEMU hard freeze phase: This test can now be used to
>>  trigger lots of introspection bugs that we were not aware of yet.
>>  I think most of the bugs are due to wrong handling of instance_init
>>  vs. realize functions.
>
> Yes, that's a common class of bugs.  There's little guidance on what
> kind of work belongs where, and plenty of bad examples.  Some of the bad
> examples crash (as you found).  Some work fine, typically because the
> device doesn't support unplug.

I've been vaguely wondering if we should start to recommend that
all devices have a correctly implemented code path for destroying
them post-realize, even if they don't actually implement hotplug...

thanks
-- PMM
