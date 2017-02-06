Received: from eggs.gnu.org ([2001:4830:134:3::10]:47489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafz7-0007Dv-41
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafz4-0006HQ-0B
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:53:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cafz3-0006HI-QS
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:53:17 -0500
References: <1485540693-31723-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1485540693-31723-2-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <acb85411-eeda-418f-5c69-3bf8e884fe08@redhat.com>
Date: Mon, 6 Feb 2017 10:53:13 +0100
MIME-Version: 1.0
In-Reply-To: <1485540693-31723-2-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/2] move vm_start to cpus.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, palves@redhat.com, alex.bennee@linaro.org



On 27/01/2017 19:11, Claudio Imbrenda wrote:
> +    }
> +
> +    /* XXX: is it ok to send this even before actually resuming the CPUs? */
> +    qapi_event_send_resume(&error_abort);
> +    return res;
> +}
> +

Yes, it is. :)

Paolo
