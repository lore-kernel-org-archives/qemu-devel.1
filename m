Received: from eggs.gnu.org ([2001:4830:134:3::10]:48461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBwtA-000321-5C
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBwt9-0005WS-DD
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:29:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
	<099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
Date: Fri, 27 Apr 2018 08:29:31 +0200
In-Reply-To: <099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com> (Thomas Huth's
	message of "Fri, 27 Apr 2018 08:06:48 +0200")
Message-ID: <87sh7huppw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] qom-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 26.04.2018 13:54, Markus Armbruster wrote:
> [...]
>> Actually, a worse offender in the "waste everybody's time via redunancy"
>> department could be qom-test.
>
> Shall we change qom-test to also only test with the "none" machine in
> the normal "make check" mode and only do the full test with all machines
> in "make check SPEED=slow" ?

I suggest you give it a try and see how much time it saves on "make
check" without SPEED=slow.  If you like the result, find out which
devices this no longer tests, if any.
