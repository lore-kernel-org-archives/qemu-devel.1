Received: from eggs.gnu.org ([2001:4830:134:3::10]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duMGV-0008BK-JV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duMGS-0000AZ-L0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:24:55 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:55573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duMGS-0000AG-FB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:24:52 -0400
Received: by mail-io0-x230.google.com with SMTP id z187so729959ioz.12
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:24:52 -0700 (PDT)
References: <20170919142654.16369-1-david@redhat.com>
	<20170919142654.16369-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94236fbd-5c7b-42d3-ea63-49395c7bab7a@linaro.org>
Date: Tue, 19 Sep 2017 12:24:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170919142654.16369-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390x/tcg: move wrap_address() to
 internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 09/19/2017 09:26 AM, David Hildenbrand wrote:
> We want to use it in another file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/internal.h   | 14 ++++++++++++++
>  target/s390x/mem_helper.c | 14 --------------
>  2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
