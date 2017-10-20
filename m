Received: from eggs.gnu.org ([2001:4830:134:3::10]:54567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e5aKR-0006sy-KU
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e5aKQ-0004cS-OL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:39:23 -0400
MIME-Version: 1.0
In-Reply-To: <20171020104739.GC27352@stefanha-x1.localdomain>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<7f741376b50552aa58c943b710fffa3c24f28b2f.1508390588.git.alistair.francis@xilinx.com>
	<51df0812-0119-412e-6017-935a6c226e3a@redhat.com>
	<86f645a2-3640-be98-acff-c37cdaa1d66f@weilnetz.de>
	<4d22f16a-15ce-3ac5-9812-83a4f9197b48@redhat.com>
	<20171020104739.GC27352@stefanha-x1.localdomain>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 20 Oct 2017 09:38:49 -0700
Message-ID: <CAKmqyKNW52EENrjjsu1SV-C=D+bM05uc4ZWdzNpZLRUKA20jxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 42/46] util: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Oct 20, 2017 at 3:47 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, Oct 20, 2017 at 08:27:41AM +0200, Thomas Huth wrote:
>> On 19.10.2017 21:47, Stefan Weil wrote:
>> > Am 19.10.2017 um 19:53 schrieb Thomas Huth:
>> >> On 19.10.2017 18:18, Alistair Francis wrote:
>> >>> Replace a large number of the fprintf(stderr, "*\n" calls with
>> >>> error_report(). The functions were renamed with these commands and then
>> >>> compiler issues where manually fixed.
>> >> [...]
>> >>> diff --git a/util/aio-posix.c b/util/aio-posix.c
>> >>> index 5946ac09f0..29fff51fcf 100644
>> >>> --- a/util/aio-posix.c
>> >>> +++ b/util/aio-posix.c
>> >>> @@ -15,6 +15,7 @@
>> >>>
>> >>>  #include "qemu/osdep.h"
>> >>>  #include "qemu-common.h"
>> >>> +#include "qemu/error-report.h"
>> >>>  #include "block/block.h"
>> >>>  #include "qemu/rcu_queue.h"
>> >>>  #include "qemu/sockets.h"
>> >>> @@ -703,8 +704,8 @@ void aio_context_setup(AioContext *ctx)
>> >>>  {
>> >>>      /* TODO remove this in final patch submission */
>> >>>      if (getenv("QEMU_AIO_POLL_MAX_NS")) {
>> >>> -        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable has "
>> >>> -                "been replaced with -object iothread,poll-max-ns=NUM\n");
>> >>> +        error_report("The QEMU_AIO_POLL_MAX_NS environment variable has "
>> >>> +                "been replaced with -object iothread,poll-max-ns=NUM");
>> >>>          exit(1);
>> >>>      }
>> >>
>> >> The comment in front of this code block indicates that this should
>> >> rather be removed completely. Stefan, do you agree?
>> >
>> > I assume you asked the other Stefan, but I think he'll agree as I do,
>>
>> Right, the code has been introduced by this commit:
>>
>> commit 4a1cba3802554a3b077d436002519ff1fb0c18bf
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Thu Dec 1 19:26:42 2016 +0000
>>
>>     aio: add polling mode to AioContext
>>
>> and apparently the environment variable has never been used in the
>> committed code base, so removing this code block sounds like the right
>> way to go.
>
> Yes, feel free to remove it.
>
> Initially the RFC patches used the QEMU_AIO_POLL_MAX_NS environment
> variable.  When I wrote a proper command-line interface for this setting
> I left the error to help any of the people testing this optimization
> migrate their scripts to the new interface.
>
> ...Then I forgot to remove it for the final non-RFC patch which got
> merged :).

Ok, I will remove it in the next version.

Thanks,
Alistair

>
> Stefan
