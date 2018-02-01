Received: from eggs.gnu.org ([2001:4830:134:3::10]:56504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehJVc-0006b8-OS
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ehJVX-0002OB-R9
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:22:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ehJVX-0002Lq-JV
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:22:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so7715072wma.5
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:22:47 -0800 (PST)
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
	<20180129032826.16876-13-david@gibson.dropbear.id.au>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b1b39cd-944b-b90f-5d19-61b34edfdf48@redhat.com>
Date: Thu, 1 Feb 2018 13:22:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180129032826.16876-13-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 12/12] target/ppc/spapr: Add H-Call
 H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 28/01/2018 22:28, David Gibson wrote:
> +    switch (safe_indirect_branch) {
> +    case SPAPR_CAP_FIXED:
> +        characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;

Missing "break;" here.

Paolo

> +    default: /* broken */
> +        assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
> +        break;
