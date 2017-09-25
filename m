Received: from eggs.gnu.org ([2001:4830:134:3::10]:44913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwciX-0001pf-Vj
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwciU-0003Ek-1Y
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:23:13 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:43770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwciT-0003EZ-SK
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:23:09 -0400
Received: by mail-pg0-x235.google.com with SMTP id u18so4892940pgo.0
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:23:09 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ca3bf22-aa0d-edc4-296c-6bb827791e95@linaro.org>
Date: Mon, 25 Sep 2017 16:23:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/27] target/s390x: factor out handling
 of WAIT PSW into handle_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 08:59 AM, David Hildenbrand wrote:
> This will now also detect crashes under TCG. We can directly use
> cpu->env.psw.addr instead of kvm_run, as we do a
> cpu_synchronize_state().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c   | 28 ++++++++++++++++++++++------
>  target/s390x/internal.h |  1 +
>  target/s390x/kvm.c      | 15 +--------------
>  3 files changed, 24 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
