Received: from eggs.gnu.org ([2001:4830:134:3::10]:54280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqCbq-0003NO-3R
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqCbn-0001ue-1P
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:50:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eqCbm-0001uZ-SX
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:49:58 -0500
References: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1519533358-13759-4-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eff138d4-b83b-80f0-34c7-90bbf002f0b3@redhat.com>
Date: Mon, 26 Feb 2018 07:49:46 +0100
MIME-Version: 1.0
In-Reply-To: <1519533358-13759-4-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 RFC 3/3] util/uri.c: wrap single
 statement blocks with braces {}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, boxafox@163.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 25.02.2018 05:35, Su Hang wrote:
> For this patch, using curly braces to wrap `if` `while` `else` statements,
> which only hold single statement. For example:
> '''
> if (cond)
>     statement;
> '''
> to
> '''
> if (cond) {
>     statement;
> }
> '''
> 
> And using tricks that compare the disassemblies before and after
> code changes, to make sure code logic isn't changed:
> '''
> git checkout master
> make util/uri.o
> strip util/uri.o
> objdump -Drx util/uri.o > /tmp/uri-master.txt
> git checkout cleanupbranch
> make util/uri.o
> strip util/uri.o
> objdump -Drx util/uri.o > /tmp/uri-cleanup.txt
> diff -u /tmp/uri-*.txt
> '''
> 
> With that, all complaints raised by checkpatch.pl have been suppressed.  
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
> ---
>  util/uri.c | 463 +++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 294 insertions(+), 169 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

I've also checked again with the "objdump" trick that there are no
differences in the generated code, and indeed, looks good now, so I
think I can also say:

Tested-by: Thomas Huth <thuth@redhat.com>

Thank you very much for cleaning up that huge file!

 Thomas
