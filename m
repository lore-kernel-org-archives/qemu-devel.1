Received: from eggs.gnu.org ([2001:4830:134:3::10]:40062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8QT0-0004qA-Tf
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8QSx-0000E8-Li
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:16:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<CAFEAcA9pTyF=xHz_2Dt3XqQrUnKrPthFP+zpjV8ba2PVM-s7iw@mail.gmail.com>
Date: Tue, 17 Apr 2018 15:15:50 +0200
In-Reply-To: <CAFEAcA9pTyF=xHz_2Dt3XqQrUnKrPthFP+zpjV8ba2PVM-s7iw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 17 Apr 2018 13:52:38 +0100")
Message-ID: <874lkadldl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 17 April 2018 at 13:12, Markus Armbruster <armbru@redhat.com> wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>>  In case someone wants to help with creating some bug fix patches
>>>  during the QEMU hard freeze phase: This test can now be used to
>>>  trigger lots of introspection bugs that we were not aware of yet.
>>>  I think most of the bugs are due to wrong handling of instance_init
>>>  vs. realize functions.
>>
>> Yes, that's a common class of bugs.  There's little guidance on what
>> kind of work belongs where, and plenty of bad examples.  Some of the bad
>> examples crash (as you found).  Some work fine, typically because the
>> device doesn't support unplug.
>
> I've been vaguely wondering if we should start to recommend that
> all devices have a correctly implemented code path for destroying
> them post-realize, even if they don't actually implement hotplug...

Possibly crazy idea: make devices implement *cold* unplug.  Not really
useful in practice, but it would make the destroy path testable.
