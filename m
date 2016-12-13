Received: from eggs.gnu.org ([2001:4830:134:3::10]:35547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cGkzs-0000Gl-AM
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cGkzn-0003pv-7U
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:11:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cGkzn-0003j1-1U
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:11:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so17639161wme.2
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 03:11:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-35-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7d971e2-af70-0ea5-7c0e-8b70c547c2cd@redhat.com>
Date: Tue, 13 Dec 2016 12:10:17 +0100
MIME-Version: 1.0
In-Reply-To: <20161212224325.20790-35-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 34/54] char: create chardev-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 12/12/2016 23:43, Marc-André Lureau wrote:
> This will help to split char.c in several units without having to
> reference them all everywhere.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile               | 3 ++-
>  Makefile.objs          | 4 +++-
>  Makefile.target        | 3 +++
>  chardev/Makefile.objs  | 2 +-
>  tests/Makefile.include | 4 ++--
>  5 files changed, 11 insertions(+), 5 deletions(-)

Any reason to do this instead of keeping common-obj-y?

Thanks,

Paolo
