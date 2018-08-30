Received: from eggs.gnu.org ([208.118.235.92]:59970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSsd-00011E-Ss
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvSqZ-0003i3-Ia
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 15:43:16 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-7-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7a3db5c5-661b-42e5-a7c3-1a1959051612@twiddle.net>
Date: Thu, 30 Aug 2018 12:43:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/9] s390x/tcg: check for AFP-register,
 BFP and DFP data exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08/30/2018 05:27 AM, David Hildenbrand wrote:
> With the annotated functions, we can now easily check this at a central
> place.
> 
> DXC 1 is to be injected if an AFP register is used (for a HFP instruction)
> when AFP is disabled.
> DXC 2 is to be injected if a BFP instruction is used when AFP is
> disabled.
> DXC § is to be injected if a DFP instruction is used when AFP is
> disabled.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
