Received: from eggs.gnu.org ([2001:4830:134:3::10]:58165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5u8-0001wR-JB
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5u5-0001Kp-Hf
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:48:36 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-7-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ae17aa21-481a-2fc0-554b-fa1b8af211fc@twiddle.net>
Date: Thu, 7 Dec 2017 15:48:29 -0800
MIME-Version: 1.0
In-Reply-To: <20171207165355.7559-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 06/10] s390x/tcg: Implement
 STORE CHANNEL PATH STATUS
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
> Just like KVM does, we should suppress this instruction:
>     When this instruction is not provided, it is
>     checked for privileged operation exception and the
>     instruction is suppressed by the machine
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 1 +
>  target/s390x/translate.c   | 7 +++++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
