Received: from eggs.gnu.org ([2001:4830:134:3::10]:47602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSFAw-0004ZO-UZ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSFAv-0000cp-WF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:38:43 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cSFAv-0000cW-RZ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:38:41 -0500
Received: by mail-pg0-x243.google.com with SMTP id 75so109202pgf.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:38:41 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
	<148434050859.31446.4431621165013524916.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f4460890-f07c-c024-b0d9-63da39eef4fa@twiddle.net>
Date: Fri, 13 Jan 2017 19:38:38 -0800
MIME-Version: 1.0
In-Reply-To: <148434050859.31446.4431621165013524916.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 3/7] trace: [tcg] Delay changes to
 dynamic state when translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 01/13/2017 12:48 PM, Lluís Vilanova wrote:
> This keeps consistency across all decisions taken during translation
> when the dynamic state of a vCPU is changed in the middle of translating
> some guest code.
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  include/qom/cpu.h      |    3 +++
>  qom/cpu.c              |    2 ++
>  trace/control-target.c |   21 ++++++++++++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
