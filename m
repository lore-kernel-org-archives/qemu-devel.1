Received: from eggs.gnu.org ([2001:4830:134:3::10]:38198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHnbE-0002bh-Na
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHnbB-0007El-Kx
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:19:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHnbB-0007E8-C3
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:19:41 -0400
References: <20180718104836.18488-1-michael@walle.cc>
	<20180718104836.18488-2-michael@walle.cc>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34069906-b8f8-05da-477e-b2b81fc0fd58@redhat.com>
Date: Wed, 31 Oct 2018 11:19:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180718104836.18488-2-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: new functions for pulsed IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 18/07/2018 12:48, Michael Walle wrote:
>  /**
> + * get_irq_latched:
> + * @num: Interrupt to observe.
> + *
> + * Returns: The latched level of the @num interrupt.
> + */
> +static inline bool get_irq_latched(int num)
> +{
> +    return qtest_get_irq_latched(global_qtest, num);
> +}
> +
> +/**
> + * clear_irq_latch:
> + * @num: Interrupt to operate on.
> + *
> + * Clears the latch of the @num interrupt.
> + */
> +static inline void clear_irq_latch(int num)
> +{
> +    return qtest_clear_irq_latch(global_qtest, num);
> +}
> +
> +/**
>   * irq_intercept_in:
>   * @string: QOM path of a device.
>   *
> 

Just one thing, I think an atomic test-and-clear is a better API.  I
understand that what you have works, because
get_irq_latched+clear_irq_latch don't have any intervening access to the
qtest socket.

Paolo
