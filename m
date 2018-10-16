Received: from eggs.gnu.org ([2001:4830:134:3::10]:51479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCNwp-0006A4-TS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCNwp-0007fc-0m
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:55:39 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCNwo-0007ZY-IZ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:55:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id l197-v6so17754765oib.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 04:55:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180829175009.GD17213@habkost.net>
References: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z.zhang@linux.intel.com>
	<20180829175009.GD17213@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 12:55:08 +0100
Message-ID: <CAFEAcA8t0YrF04NZwdPUsW4+WWV7n=wNKS+eenJsKF+YdiKwiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] hostmem-file: fixed the memory leak
 while get pmem path.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, yu.c.zhang@linux.intel.com, Igor Mammedov <imammedo@redhat.com>, Junyan He <junyan.he@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On 29 August 2018 at 18:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Wed, Aug 29, 2018 at 12:14:22AM +0800, Zhang Yi wrote:
>> object_get_canonical_path_component() returns a string which
>> must be freed using g_free().
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> Queueing on machine-next, thanks.

Ping? This patch doesn't seem to have made it to master...

thanks
-- PMM
