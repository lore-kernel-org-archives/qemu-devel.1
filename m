Received: from eggs.gnu.org ([209.51.188.92]:54011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h31OT-0008VY-08
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h31OS-0007FW-C6
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h31OS-0007FA-5i
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:33:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<20190307190554.w75ltd6wvnvhzsdh@dhcp-17-118.bos.redhat.com>
Date: Sun, 10 Mar 2019 17:33:39 +0100
In-Reply-To: <20190307190554.w75ltd6wvnvhzsdh@dhcp-17-118.bos.redhat.com>
	(Cleber Rosa's message of "Thu, 7 Mar 2019 14:05:54 -0500")
Message-ID: <87pnqyvgd8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Cleber Rosa <crosa@redhat.com> writes:

> On Thu, Mar 07, 2019 at 01:09:52PM +0000, Peter Maydell wrote:
>> On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > In any case, this wouldn't change; as you suggest below, configure could
>> > remain as a front-end (well, in-srcdir builds are not supported by
>> > Meson, so "../configure && ninja" perhaps).
>> 
>> As an aside, it might be a nice idea to drop the in-srcdir
>> build altogether for QEMU anyway -- it's not really a very
>> good idea and it means our build system has to cope with two
>> different ways of working to no particularly useful end.
>>
>
> THIS.  Please.

Seconded.

If nothing beyond abandoning in-tree builds should come out of this
thread, it will have been totally worth it for me.
