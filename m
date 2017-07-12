Received: from eggs.gnu.org ([2001:4830:134:3::10]:47012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVHIp-0003JT-9A
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVHIk-0004rZ-DZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:03:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVHIk-0004r9-7O
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:03:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
	<12e6dde67e57a0ecf09fbe6103512543113ca07a.1499774331.git.alistair.francis@xilinx.com>
	<040c4483-73f0-7f3b-d2af-b56bc83b0e53@redhat.com>
	<CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
Date: Wed, 12 Jul 2017 15:03:31 +0200
In-Reply-To: <CAKmqyKP+cpiAXMN5eE5D=Q8ewqZtttnUz=LJY+Hj2TUoGKGE+Q@mail.gmail.com>
	(Alistair Francis's message of "Wed, 12 Jul 2017 14:27:43 +0200")
Message-ID: <87zic96c4c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 8/8] error: Add a 'error: ' prefix to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Max Reitz <mreitz@redhat.com>, philippe@mathieu-daude.net, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Alistair Francis <alistair.francis@xilinx.com> writes:

> On Tue, Jul 11, 2017 at 7:44 PM, Max Reitz <mreitz@redhat.com> wrote:
>> On 2017-07-11 14:07, Alistair Francis wrote:
>>> As we don't regard error messages as a stable API the let's add a
>>> 'error: ' prefix to the original error_report() messages.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> ---
>>>
>>>  util/qemu-error.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> This breaks quite a few qemu-iotests.
>
> Hmmm... Ok, I'll have to dig into that.
>
> I'm traveling at the moment so I won't get a chance to fix this. I'm
> going to send the next version of this series, but remove this patch
> and I can look at adding it again when I get back. There is already a
> few things that have been pointed out that need to be fixed after this
> patch set.

Separating this change from the rest of the series makes sense, because
it lets use get the bulk of your work in more quickly.

> Do people think we should add this prefix or leave the error messages
> as is? I haven't heard a definitive answer if people think this is the
> right path to take.

I'd leave them as is.  More inertia than opposition.  If you think a
prefix solves a problem people have, by all means post a patch.  Please
explain in the commit message why the patch is useful.  The current one
explains only why we can change error messages, not why we *want* to
change them.
