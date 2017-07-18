Received: from eggs.gnu.org ([2001:4830:134:3::10]:59793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXLrd-00013a-Ft
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXLra-0008M2-Dd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXLra-0008KU-7G
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:20:06 -0400
References: <20170717144527.24534-1-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a20b1ea8-97b9-b206-e1fd-b3f358250a1f@redhat.com>
Date: Tue, 18 Jul 2017 08:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170717144527.24534-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Daniel P . Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 17.07.2017 16:45, Laurent Vivier wrote:
> Only emit "XXX accelerator not found", if there are not
> further accelerators listed. eg
> 
>    accel=kvm:tcg
> 
> doesn't print a "KVM accelerator not found" warning
> when it falls back to tcg, but a
> 
>    accel=kvm
> 
> prints a warning, since no fallback is given.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: replace "fprintf(stderr, ...)" by error_report()

I gave it a try, and it seems to work fine, thanks!

Tested-by: Thomas Huth <thuth@redhat.com>
