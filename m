Received: from eggs.gnu.org ([209.51.188.92]:35948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjNE8-00012d-Bu
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjNE7-0001Zc-I9
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:49:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjNE7-0001ZK-BW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 06:49:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so2972766wml.2
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 03:49:51 -0800 (PST)
References: <20190115111007.27159-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47717208-d514-b7dc-4ebb-844951938cce@redhat.com>
Date: Tue, 15 Jan 2019 12:49:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190115111007.27159-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] qcow2: include LUKS payload overhead
 in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 1/15/19 12:10 PM, Stefan Hajnoczi wrote:
> The LUKS payload has a significant size (>1 MB).  It must be included in the
> qemu-img measure calculation so we arrive at the correct minimum image size.
> 
> Stefan Hajnoczi (2):
>   qcow2: include LUKS payload overhead in qemu-img measure
>   iotests: add LUKS payload overhead to 178 qemu-img measure test
> 
>  block/qcow2.c                    | 51 +++++++++++++++++++++++++++++++-
>  tests/qemu-iotests/178           |  8 +++++
>  tests/qemu-iotests/178.out.qcow2 | 24 +++++++++++++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
