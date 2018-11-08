Received: from eggs.gnu.org ([2001:4830:134:3::10]:35599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gKlhL-0000rI-Do
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gKlhD-00035J-N2
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:54:15 -0500
Date: Thu, 8 Nov 2018 15:53:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181108155348.03d368db@redhat.com>
In-Reply-To: <20181108151623.4de26ecb@redhat.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-6-sameo@linux.intel.com>
	<20181108151623.4de26ecb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/24] hw: acpi: Implement XSDT support
 for RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Thu, 8 Nov 2018 15:16:23 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

[...]
>   patch 4: convert arm's impl. to build_append_int_noprefix() API (commit 5d7a334f7)

>            ... move out to aml-build.c
my mistake, generally when we move something out,
we should do it in separate path preferably without any changes to the moved code
so it would be easier to review. So it should be a separate patch.

[...]
