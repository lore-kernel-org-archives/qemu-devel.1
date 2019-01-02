Received: from eggs.gnu.org ([208.118.235.92]:33722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gegJC-0005Gp-6Z
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gegJA-0000fg-CD
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:11:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gegJ8-0000em-Fn
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:11:38 -0500
References: <1545920014-114011-1-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <38ce2180-ec32-cd57-7cab-b4d7e265b8c2@redhat.com>
Date: Wed, 2 Jan 2019 14:11:23 +0100
MIME-Version: 1.0
In-Reply-To: <1545920014-114011-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] tests: apci: consolidate and
 cleanup ACPI test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, wainersm@redhat.com

On 2018-12-27 15:13, Igor Mammedov wrote:
> Changes since v1:
>   * rebase on top of current master due to a lots of conflicts with
>     'qtest global' removal being merged first

Sorry for that ... I hope it was not too much trouble!

>   * drop explicit cast to uint8_t* as sdt->aml is uint8_t* now
>   * drop not comment explaining strange offsets as offsets are
>     now follow ACPI spec
> 
> While working on adding tests for virt/arm board (uefi/XSDT/64-bit table pointers),
> I found it's rather difficult to deal with mixed ACPI testing code that we've
> collected so far. So instead of just adding a pile of XSDT hacks on top, here
> goes small refactoring series:
>    * that removes dead code
>    * replaces reading tables with a fetch per table everywhere instead of
>      mix of field by field and whole table
>    * consolidates the way tables are read (reduces code duplication)
>    * test no longer depends on ACPI structures from QEMU (i.e. doesn't affected
>      by mistakes there) 
>    * fixes FACS not being compared against reference tables
> Overall test is reduced on ~160LOC and hopefully it makes easier to follow and
> add more stuff on top.
> 
> PS:
> arm/virt test patches fill follow up a separate series on top of this one
> for not to mix things up
> 
> Git tree for testing:
>   https://github.com/imammedo/qemu acpi_tests_cleanup_v2
> 
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>

Do you want me to take this through the qtests tree, or will you take it
through your ACPI tree?

In the latter case, FWIW:
Acked-by: Thomas Huth <thuth@redhat.com>
