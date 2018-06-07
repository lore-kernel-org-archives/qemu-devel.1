Received: from eggs.gnu.org ([2001:4830:134:3::10]:50286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQwEw-0003Al-DZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQwEv-00015v-AV
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:50:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<87lgbqvha8.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4294f0f1-3b40-c886-dda8-a5638ddf1b94@amsat.org>
Date: Thu, 7 Jun 2018 11:49:58 -0300
MIME-Version: 1.0
In-Reply-To: <87lgbqvha8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 06/07/2018 10:48 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Hi,
>>
>> This series converts error_setg(&error_fatal) to error_report() + exit() as
>> suggested by the "qapi/error.h" documentation.
> 
> Appreciated!
> 
> The series actually converts two anti-patterns.
> 
> 1. From
> 
>     if (COND) {
>         error_setg(&error_fatal, ...);
>     }
> 
> to
> 
>     if (COND) {
>         error_report(...);
>         exit(1);
>     }
> 
> This is exactly what error.h asks for.
> 
> 2. From
> 
>     if (COND) {
>         error_setg(&error_abort, ...);
>     }
> to
> 
>     if (COND) {
>         error_report(...);
>         abort();
>     }
> 
> error.h asks for
> 
>     assert(!COND);
> 
> instead.  See my reply to PATCH 1 for why.

My bad, I misread your "error.h" explanation.

These patterns are now cleaned from the codebase.

Your examples are clearer and might be added in the header comments if
we keep using the bad patterns.

Regards,

Phil.
