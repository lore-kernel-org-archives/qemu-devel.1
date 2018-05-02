Received: from eggs.gnu.org ([2001:4830:134:3::10]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDkNU-0002YJ-Pu
	for qemu-devel@nongnu.org; Wed, 02 May 2018 01:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDkNQ-0007N9-Pv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 01:32:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDkNQ-0007Mx-KZ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 01:32:28 -0400
References: <20180430124651.10340-1-stefanha@redhat.com>
	<20180430124651.10340-2-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2369182-bce5-0af2-d33d-b2450b943ad2@redhat.com>
Date: Wed, 2 May 2018 07:32:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180430124651.10340-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] checkpatch: add a --strict check
 for utf-8 in commit logs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

On 30.04.2018 14:46, Stefan Hajnoczi wrote:
> From: Joe Perches <joe@perches.com>
> 
> Some find using utf-8 in commit logs inappropriate.
> 
> Some patch commit logs contain unintended utf-8 characters when doing
> things like copy/pasting compilation output.
> 
> Look for the start of any commit log by skipping initial lines that look
> like email headers and "From: " lines.
> 
> Stop looking for utf-8 at the first signature line.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Whitcroft <apw@shadowen.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit 15662b3e8644905032c2e26808401a487d4e90c1)
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Conflicts:
>   QEMU does not have CHK(), use WARN() instead.
> 
>   QEMU WARN() only takes one argument, drop the 'type' value in the
>   first argument.
> ---
>  scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
