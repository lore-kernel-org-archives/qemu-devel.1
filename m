Received: from eggs.gnu.org ([209.51.188.92]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtvtV-0003NW-KJ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtvdj-0003y4-69
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:35:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtvdh-0003Wm-7b
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:35:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so2695842wrt.13
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:35:33 -0800 (PST)
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9891ca3c-6a6f-d189-6b03-ed624d5c402b@redhat.com>
Date: Wed, 13 Feb 2019 15:35:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190206174328.9736-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] chardev: various cleanups and
 improvements (resend)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 06/02/19 18:43, Marc-André Lureau wrote:
> Hi,
> 
> Some chardev-related patches I have accumulated.
> Please review, thanks!
> 
> v2:
> - rebased
> - update commit messages
> 
> Marc-André Lureau (6):
>   char: update the mux handlers in class callback
>   char-fe: set_handlers() needs an associated chardev
>   terminal3270: do not use backend timer sources
>   chardev: add a note about frontend sources and context switch
>   char-pty: remove the check for connection on write
>   char-pty: remove write_lock usage
> 
>  include/chardev/char-fe.h  |  5 ++--
>  include/chardev/char-mux.h |  1 -
>  chardev/char-fe.c          | 11 +-------
>  chardev/char-mux.c         |  5 ++--
>  chardev/char-pty.c         | 56 +++-----------------------------------
>  hw/char/terminal3270.c     | 15 ++++------
>  6 files changed, 17 insertions(+), 76 deletions(-)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Paolo
