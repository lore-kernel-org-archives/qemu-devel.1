Received: from eggs.gnu.org ([209.51.188.92]:43114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hCM7r-0005rW-53
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hCM7q-0004XL-B1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:31:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hCM7p-0004W1-UR
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:31:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so7381271wrp.0
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 03:31:09 -0700 (PDT)
Date: Fri, 5 Apr 2019 12:31:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190405103105.c2ohp53bitfgamax@steredhat>
References: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
Subject: Re: [Qemu-devel] [PATCH] e1000: Never increment the RX undersize
 count register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, bhavesh.davda@oracle.com, Chris Kenna <chris.kenna@oracle.com>

On Thu, Apr 04, 2019 at 10:21:26AM -0500, Mark Kanda wrote:
> From: Chris Kenna <chris.kenna@oracle.com>
> 
> In situations where e1000 receives an undersized Ethernet frame,
> QEMU increments the emulated "Receive Undersize Count (RUC)"
> register when padding the frame.
> 
> This is incorrect because this an expected scenario (e.g. with
> VLAN tag stripping) and not an error. As such, QEMU should not
> increment the emulated RUC.
> 
> Fixes: 3b2743017749 ("e1000: Implementing various counters")
> 
> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
> Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
> ---
>  hw/net/e1000.c | 1 -
>  1 file changed, 1 deletion(-)

CCing Jason.

LGTM, if we don't discard it, we shouldn't increase the RUC counter.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
