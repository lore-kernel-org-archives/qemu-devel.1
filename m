Received: from eggs.gnu.org ([209.51.188.92]:40375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkX8K-0008VJ-C3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkX8G-00027I-Fx
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkX8D-0001wV-RH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:36:34 -0500
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112947-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6313ad1-d178-5843-c826-c6c85f5b2fbe@redhat.com>
Date: Fri, 18 Jan 2019 17:36:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190118112947-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 00/43] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com

On 18/01/19 17:30, Michael S. Tsirkin wrote:
> I wonder whether we can support menuconfig as well?
> Right now entries have no description for menuconfig -
> can that be added?
> 

The problem with menuconfig is that QEMU has many configurations (one
per target), not just one.  Also, Kconfig has some Linux quirks that are
different from QEMU quirks (for example QEMU needs to know about symbols
found by probing the host in ./configure), so it's difficult to use it
as is; we tried it in Google Summer of Code 2013 and it was not successful.

Paolo
