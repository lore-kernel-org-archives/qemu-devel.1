Received: from eggs.gnu.org ([2001:4830:134:3::10]:58778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8gU-0003nj-78
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8gR-0005Gy-4M
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:31:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<20180529174821.19964-2-f4bug@amsat.org>
	<fba4c1c5-a479-60c6-31e3-99affcacd5b7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5374cfa5-e314-0c4f-92e9-b3ec3bf3bd95@amsat.org>
Date: Wed, 30 May 2018 18:30:58 -0300
MIME-Version: 1.0
In-Reply-To: <fba4c1c5-a479-60c6-31e3-99affcacd5b7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] hw/block/fdc: Replace
 error_setg(&error_abort) by error_report() + abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 05/30/2018 05:23 PM, John Snow wrote:
> On 05/29/2018 01:48 PM, Philippe Mathieu-Daudé wrote:
>> Use error_report() + abort() instead of error_setg(&error_abort),
>> as suggested by the "qapi/error.h" documentation:
>>
>>     Please don't error_setg(&error_fatal, ...), use error_report() and
>>     exit(), because that's more obvious.
>>     Likewise, don't error_setg(&error_abort, ...), use assert().
>>
> 
> Didn't realize this was bad form (Why do we have it?)
> 
>> Use abort() instead of the suggested assert() because the error message
>> already got displayed.
>>
> 
> Update the suggestion?

Fair enough.

>> Suggested-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> Acked-by: John Snow <jsnow@redhat.com>

Thanks!
