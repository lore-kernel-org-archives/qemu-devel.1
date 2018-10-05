Received: from eggs.gnu.org ([2001:4830:134:3::10]:50698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QHk-0004it-2N
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QHg-0003cv-Tl
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:36:52 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QHf-0003WU-0w
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:36:48 -0400
Received: by mail-wr1-f47.google.com with SMTP id w5-v6so13607486wrt.2
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:36:46 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4ebd6e33-e1e7-962f-3ca8-4bae7b7ce425@redhat.com>
Date: Fri, 5 Oct 2018 15:36:43 +0200
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: make 218 executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 18:18, Cleber Rosa wrote:
> Commit 990dc39c made all tests executable at the time, but 218 came in
> later, and missing those permissions.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/218 | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tests/qemu-iotests/218
> 
> diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
> old mode 100644
> new mode 100755

We could add a git pre-commit hook grep'ing for "^#!\
*(/usr/bin/env|/bin/(b?a)?sh)" in the 1st line and then checking the
file perms.
