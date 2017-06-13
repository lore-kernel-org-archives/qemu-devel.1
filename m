Received: from eggs.gnu.org ([2001:4830:134:3::10]:57090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.p.peng@linux.intel.com>) id 1dKeyx-000192-Qg
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.p.peng@linux.intel.com>) id 1dKeyu-0002hw-Gs
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:07:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:21343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.p.peng@linux.intel.com>)
	id 1dKeyu-0002hN-8R
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 02:07:12 -0400
Message-ID: <1497334024.13717.8.camel@linux.intel.com>
From: Chao Peng <chao.p.peng@linux.intel.com>
Date: Tue, 13 Jun 2017 14:07:04 +0800
In-Reply-To: <20170524150753.GB23327@stefanha-x1.localdomain>
References: <20170524150753.GB23327@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Status of q35-lite?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 2017-05-24 at 16:07 +0100, Stefan Hajnoczi wrote:
> Hi Chao,
> Last year there was an effort to make "built-in" hardware optional so
> that VMs can be launched with a minimal set of devices.  You made
> SATA,
> PIT, and SMBus optional.
> 
> What is the current status of this work?
> 
> Are there more devices that could benefit from an optional switch?

Hi Stefan, in terms of making device optional, we don't have more
follow-ups basically because other build-in devices do not have
significant performance impact. For other optimizations (like
optimizing/skipping BIOS), we are still working on them.

Chao
> 
> For reference, here is the discussion that kicked of the effort to
> make
> some core devices optional:
> "[RFC 0/9] Introduce light weight PC platform pc-lite"
> https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg04842.html
> 
> Stefan
