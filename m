Received: from eggs.gnu.org ([2001:4830:134:3::10]:40892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNh8G-0006Pp-1E
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNh8F-0001ky-CH
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:38:12 -0500
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181116172919.43f3e27d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4f6f0ef-1333-a917-e3eb-d9bad47c9648@redhat.com>
Date: Fri, 16 Nov 2018 17:37:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181116172919.43f3e27d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/24] ACPI reorganization for
 hardware-reduced API addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On 16/11/18 17:29, Igor Mammedov wrote:
> General suggestions for this series:
>   1. Preferably don't do multiple changes within a patch
>      neither post huge patches (unless it's pure code movement).
>      (it's easy to squash patches later it necessary)
>   2. Start small, pick a table generalize it and send as
>      one small patchset. Tables are often independent
>      and it's much easier on both author/reviewer to agree upon
>      changes and rewrite it if necessary.

How would that be done?  This series is on the bigger side, agreed, but
most of it is really just code movement.  It's a starting point, having
a generic ACPI library is way beyond what this is trying to do.

Paolo

>   3. when you think about refactoring acpi into a generic API
>      think about it as routines that go into a separate library
>      (pure acpi spec code) and qemu/acpi glue routines and
>       divide them correspondingly.
