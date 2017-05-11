Received: from eggs.gnu.org ([2001:4830:134:3::10]:51364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8odV-0007uK-S5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d8odS-0002jq-Rd
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:00:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d8odS-0002iL-Lh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:00:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91E5D3D95E
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 14:00:04 +0000 (UTC)
Date: Thu, 11 May 2017 16:00:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170511160000.277d67f7@nial.brq.redhat.com>
In-Reply-To: <20170508183205.10884-1-ehabkost@redhat.com>
References: <20170508183205.10884-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: Add [+-]feature and
 feature=on|off test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon,  8 May 2017 15:32:05 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Add test code to ensure features are enabled/disabled correctly in the
> command-line. The test case use the "feature-words" and
> "filtered-features" properties to check if the features were
> enabled/disabled correctly.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Remove explicit "accel=" option to avoid triggering warnings
>   on "make check"
> * Use qdict_get_*() helpers to make code shorter
> * Rename input_eax, input_ecx to in_eax, in_ecx to make
>   lines fit in the coding style width limit
> * v1 was submitted as part of the series:
>   Subject: [PATCH 0/4] x86: Support "-cpu feature=force"
> * Coding style: split lines
> * Style changes on code comments
> ---
>  tests/test-x86-cpuid-compat.c | 111 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
[...]
> +    add_feature_test("x86/cpuid/features/max-plus-invtsc",
> +                     "-cpu max,+invtsc",
> +                     0x80000007, 0, "EDX", 8, true);
> +    add_feature_test("x86/cpuid/features/max-invtsc-on",
> +                     "-cpu max,invtsc=on",
> +                     0x80000007, 0, "EDX", 8, true);
> +    add_feature_test("x86/cpuid/features/max-minus-mmx",
> +                     "-cpu max,-mmx",
> +                     1, 0, "EDX", 23, false);
> +    add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
> +                     "-cpu max,mmx=off",
> +                     1, 0, "EDX", 23, false);
Why do you add 'max' variants in addition to 486/pentium?

>      return g_test_run();
>  }
