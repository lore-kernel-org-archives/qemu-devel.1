Received: from eggs.gnu.org ([2001:4830:134:3::10]:45097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVtxx-0005rV-JS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVtxu-0004Cv-7z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVtxu-0004Aq-1M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:20:38 -0400
Date: Fri, 14 Jul 2017 02:20:33 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1689390822.16456651.1500013233018.JavaMail.zimbra@redhat.com>
In-Reply-To: <415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
References: <1499964378-24344-1-git-send-email-mst@redhat.com>
	<c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
	<415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>


> NACK.
> 
> It's not that simple. If you do it like this, you then suddenly get
> these ugly '"kvm" accelerator not found' messages during "make check"
> which we really should avoid.

You're right, I thought these were shut up before with Laurent's patch.
I think we should print a single message at the end, like

   qemu: -machine accel=kvm:xen: No accelerator found

Paolo

> Laurent suggested some better ideas a couple of months ago, but I think
> the common sense was rather "unit tests should always use TCG" at that
> point in time:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00400.html
> 
> Well, now that we've got the "--disable-tcg" configure option, we should
> maybe start to reconsider that ;-)
> 
> So I'm fine with the patch if you also include Laurent's patch to shut
> up the error message:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00395.html
> 
>  Thomas
> 
