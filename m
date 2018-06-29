Received: from eggs.gnu.org ([2001:4830:134:3::10]:50508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYviZ-00066e-OK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYviZ-0007YT-0b
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:53:51 -0400
References: <152956038747.819.14972444362425747616@d39dc562802a>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cce24450-9dc9-d5d6-584a-5da11cb7db29@redhat.com>
Date: Fri, 29 Jun 2018 10:53:39 -0500
MIME-Version: 1.0
In-Reply-To: <152956038747.819.14972444362425747616@d39dc562802a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/client: add x-block-status hack for
 testing server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

On 06/21/2018 12:53 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.

>    CC      crypto/hmac-nettle.o
> /tmp/qemu-test/src/nbd/client.c: In function 'nbd_negotiate_simple_meta_context':
> /tmp/qemu-test/src/nbd/client.c:738:28: error: implicit declaration of function 'strchrnul'; did you mean 'strchr'? [-Werror=implicit-function-declaration]
>       uint32_t context_len = strchrnul(context, ';') - context;
>                              ^~~~~~~~~
>                              strchr

If I keep the semicolon-separated string (which I really don't want to 
do in v2), then I'd obviously have to rebase this on top of the proposed 
patch adding qemu_strchrnul.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
