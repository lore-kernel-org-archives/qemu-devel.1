Received: from eggs.gnu.org ([209.51.188.92]:59737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3K8g-0001cH-Uc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1h3K8f-0005cA-N6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:34:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1h3K8e-0005X0-JA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:34:41 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190311123433euoutp02975c868e0fafa998caf4c814537453ec~K55rR0stA0679206792euoutp02U
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:34:33 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <1fa60eac-9718-ee9d-e21c-3331c3bd60ff@samsung.com>
Date: Mon, 11 Mar 2019 15:34:30 +0300
MIME-Version: 1.0
In-Reply-To: <20181127135030.1671-1-i.maximets@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
References: <CGME20181127135037eucas1p18867a9ae8b1f2731ad4ce8d79fddae33@eucas1p1.samsung.com>
	<20181127135030.1671-1-i.maximets@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] memfd fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

Hi.

I'm trying to figure out the state of this patch set.
Is there any chance for it to be accepted?

The first patch needs minor rebase. I could send a new version.

BTW, even without the first patch that raised some discussion
the last three patches are kind of straightforward and useful.

Best regards, Ilya Maximets.

On 27.11.2018 16:50, Ilya Maximets wrote:
> Version 2:
>     * First patch changed to just drop the memfd backend
>       if seals are not supported.
> 
> Ilya Maximets (4):
>   hostmem-memfd: disable for systems wihtout sealing support
>   memfd: always check for MFD_CLOEXEC
>   memfd: set up correct errno if not supported
>   memfd: improve error messages
> 
>  backends/hostmem-memfd.c | 18 ++++++++----------
>  tests/vhost-user-test.c  |  6 +++---
>  util/memfd.c             | 10 ++++++++--
>  3 files changed, 19 insertions(+), 15 deletions(-)
> 
