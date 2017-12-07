Received: from eggs.gnu.org ([2001:4830:134:3::10]:57842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5t5-0001NT-4d
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5t2-0000hu-Nm
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:47:31 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-6-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <08774adb-1821-7f9c-eabd-2878da4acfa5@twiddle.net>
Date: Thu, 7 Dec 2017 15:47:24 -0800
MIME-Version: 1.0
In-Reply-To: <20171207165355.7559-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 05/10] s390x/tcg: wire up SET
 CHANNEL MONITOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 12/07/2017 08:53 AM, David Hildenbrand wrote:
> Let's just wire it up like KVM.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      | 1 +
>  target/s390x/insn-data.def | 1 +
>  target/s390x/misc_helper.c | 9 +++++++++
>  target/s390x/translate.c   | 7 +++++++
>  4 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
