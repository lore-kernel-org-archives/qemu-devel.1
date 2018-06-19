Received: from eggs.gnu.org ([2001:4830:134:3::10]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVIOF-0007xY-BD
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVIOC-0001L7-Rh
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:17:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVIOC-0001Kt-Ku
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:17:48 -0400
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
Date: Tue, 19 Jun 2018 17:17:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180615222855.44421-2-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] kvm: support -dedicated
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On 16/06/2018 00:29, Michael S. Tsirkin wrote:
>  
> +static QemuOptsList qemu_dedicated_opts = {
> +    .name = "dedicated",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_dedicated_opts.head),
> +    .desc = {
> +        {
> +            .name = "mem-lock",
> +            .type = QEMU_OPT_BOOL,
> +        },
> +        {
> +            .name = "cpu-pm",
> +            .type = QEMU_OPT_BOOL,
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +

Let the bikeshedding begin!

1) Should we deprecate -realtime?

2) Maybe -hostresource?

Paolo
