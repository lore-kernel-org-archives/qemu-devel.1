Received: from eggs.gnu.org ([2001:4830:134:3::10]:60839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdaKd-00025d-1Q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdaKc-0000H5-9A
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:04:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-T_d2kEU+Pb72=pJQhpvqvN1owgi4RLNtNY=L4t_1Z2g@mail.gmail.com>
	<5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com>
Date: Thu, 12 Jul 2018 14:04:12 +0200
In-Reply-To: <5d0c7195-ffbf-1618-6106-ef6c82df3bd7@redhat.com> (Thomas Huth's
	message of "Tue, 10 Jul 2018 00:03:39 +0200")
Message-ID: <87601koe2r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 09.07.2018 23:42, Peter Maydell wrote:
>> On 9 July 2018 at 22:03, Thomas Huth <thuth@redhat.com> wrote:
[...]
> Hmm, maybe we need a qtest that first executes "info qtree", then runs
> 'device-list-properties' for all devices and finally checks "info qtree"
> again ... since 'device-list-properties' should not change the qtree,
> the output of the "info qtree" should be the same.

Lovely idea.

>                                                    Currently this is not
> the case :-/

Less than lovely, but I can't claim to be surprised.  As Peter remarked
elsewhere in this thread, QOM is underdocumented, and is too easy to
misuse.

On documentation: we sorely lack documentation tying everything
together.  GDK-Doc function comments alone can't cut it for something as
complex as QOM.

Even with adequate documentation, bad examples in the source will
continue to multiply.  We'll have to get rid of them.
