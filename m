Received: from eggs.gnu.org ([2001:4830:134:3::10]:57763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g86nW-0003OH-Vt
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g86nW-0000HH-8X
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:48:22 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-2-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5616e4d4-938c-4e5f-6fe0-64e52d2fe6a7@redhat.com>
Date: Thu, 4 Oct 2018 11:48:06 -0500
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] qemu-img.c: comment typo fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 10/4/18 11:18 AM, Cleber Rosa wrote:
> A trivial comment typo fix.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   qemu-img.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index b12f4cd19b..a96b76c187 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1085,7 +1085,7 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
>   }
>   
>   /*
> - * Returns true iff the first sector pointed to by 'buf' contains at least
> + * Returns true if the first sector pointed to by 'buf' contains at least

NACK.  You're not the first person to propose this change.  However, 
"iff" is an English word (albeit archaic) which is shorthand for "if and 
only if", which has a distinct logical meaning separate from the weaker 
"if".  Spelling it out in longhand instead of calling it a typo is 
probably acceptable, though.

>    * a non-NUL byte.
>    *
>    * 'pnum' is set to the number of sectors (including and immediately following
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
