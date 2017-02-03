Received: from eggs.gnu.org ([2001:4830:134:3::10]:37228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZhiG-0007rN-8B
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZhiB-0004PO-8c
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:31:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZhiB-0004Of-2p
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:31:51 -0500
References: <20170203170925.12554-1-rjones@redhat.com>
	<20170203170925.12554-2-rjones@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f5ef524-02d7-e0e8-c693-db932f8270b9@redhat.com>
Date: Fri, 3 Feb 2017 09:31:43 -0800
MIME-Version: 1.0
In-Reply-To: <20170203170925.12554-2-rjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com, stefanha@gmail.com



On 03/02/2017 09:09, Richard W.M. Jones wrote:
> +                                                   const char *port,
> +                                                   bool fork_process)
> +{
> +    if (device != NULL) {
> +        return "NBD device can't be set when using socket activation";
> +    }
> +
> +    if (sockpath != NULL) {
> +        return "Unix socket can't be set when using socket activation";
> +    }
> +
> +    if (address != NULL) {
> +        return "The interface can't be set when using socket activation";
> +    }
> +
> +    if (port != NULL) {
> +        return "TCP port number can't be set when using socket activation";
> +    }
> +
> +    if (fork_process) {
> +        return "Fork (--fork) can't be used with socket activation";
> +    }

Why not?  You could have a Type=forking foo.service, which makes little
sense but would work.

Apart from this, the patch seems fine.

> +    return NULL;
> +}
