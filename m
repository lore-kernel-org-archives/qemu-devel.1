Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRtGs-0005tx-JD
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRtGr-00074N-SJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:15:22 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484279649-22286-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1484279649-22286-2-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7277d5da-dbc4-b76a-c0a7-8af205c8f771@twiddle.net>
Date: Thu, 12 Jan 2017 20:15:17 -0800
MIME-Version: 1.0
In-Reply-To: <1484279649-22286-2-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target-ppc: Add xvtstdc[sp,
 dp] instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 01/12/2017 07:54 PM, Nikunj A Dadhania wrote:
> +    uint32_t match = 0;                                     \
> +                                                            \
> +    getVSR(xbn, &xb, env);                                  \
> +    memset(&xt, 0, sizeof(xt));                             \
> +    dcmx = DCMX_XV(opcode);                                 \
> +                                                            \
> +    for (i = 0; i < nels; i++) {                            \
> +        sign = tp##_is_neg(xb.fld);                         \
> +        if (tp##_is_any_nan(xb.fld)) {                      \
> +            match = extract32(dcmx, 6, 1);                  \

Failing to clear match for each elt.


r~
