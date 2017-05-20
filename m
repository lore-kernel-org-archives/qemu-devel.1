Received: from eggs.gnu.org ([2001:4830:134:3::10]:57489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBvFA-0004xa-B7
	for qemu-devel@nongnu.org; Fri, 19 May 2017 23:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBvF9-00046l-Bx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 23:39:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170516001150.11508-1-f4bug@amsat.org>
	<20170517124822.GF8260@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1006af4d-3c51-4c8f-63df-f0e36e81d9bd@amsat.org>
Date: Sat, 20 May 2017 00:39:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170517124822.GF8260@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] oslib: strip trailing '\n' from
 error_setg() string argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>

On 05/17/2017 09:48 AM, Stefan Hajnoczi wrote:
> On Mon, May 15, 2017 at 09:11:49PM -0300, Philippe Mathieu-Daudé wrote:
>> spotted by Coccinelle script scripts/coccinelle/err-bad-newline.cocci
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  util/oslib-posix.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Please send multi-patch series with a cover letter and proper patch
> numbering ([PATCH 0/2], [PATCH 1/2], [PATCH 2/2]).  git-format-patch and
> git-send-email normally do this.  It's important so that patch
> management tools and continuous integration systems can track your
> patches.

Hi Stefan, I intended one command to generate unrelated patches from the 
same branch at once and send them individually without cover letter. I 
didn't noticed they'd go as a serie. I'll double-check next time!

> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block

Hmm I can't see it there maybe this part was not for this patch, I'll 
resend it soon with r-b tags.

>
> Stefan
>

Regards,

Phil.
