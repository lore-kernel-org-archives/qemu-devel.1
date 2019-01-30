Received: from eggs.gnu.org ([209.51.188.92]:45826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomW1-00071j-OE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gomVz-0008Jj-I8
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:50:41 -0500
References: <1548255083-8190-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <224f9e1f-34c8-7b21-5cba-f21d92ad9415@vivier.eu>
Date: Wed, 30 Jan 2019 10:50:13 +0100
MIME-Version: 1.0
In-Reply-To: <1548255083-8190-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Don't talk about the LGPL
 if the file is licensed under the GPL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 23/01/2019 15:51, Thomas Huth wrote:
> Some files claim that the code is licensed under the GPL, but then
> suddenly suggest that the user should have a look at the LGPL.
> That's of course non-sense, replace it with the correct GPL wording
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  crypto/afsplit.c           | 11 +++++------
>  include/crypto/afsplit.h   | 11 +++++------
>  include/hw/pci-host/gpex.h |  4 ++--
>  include/hw/pci-host/q35.h  |  4 ++--
>  include/qemu/range.h       | 11 +++++------
>  target/i386/hvf/hvf.c      |  6 +++---
>  util/range.c               | 11 +++++------
>  7 files changed, 27 insertions(+), 31 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
