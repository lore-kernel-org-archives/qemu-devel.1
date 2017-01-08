Received: from eggs.gnu.org ([2001:4830:134:3::10]:58495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJZV-0005v5-8F
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQJZS-0004qp-1s
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQJZR-0004qU-Pm
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 14:56:01 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99C99C057FA5
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 19:56:01 +0000 (UTC)
Date: Sun, 8 Jan 2017 17:55:57 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170108195557.GY3315@thinpad.lan.raisama.net>
References: <20170108194041.10908-1-ehabkost@redhat.com>
	<148390484023.199.4100601245593596436@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148390484023.199.4100601245593596436@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH 0/5] Use non-blacklisted
 family/model/stepping for Haswell CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, fweimer@redhat.com, libvir-list@redhat.com, dgilbert@redhat.com, carlos@redhat.com, pbonzini@redhat.com, jdenemar@redhat.com, triegel@redhat.com

Oops, there are 3 actual mistakes I missed among the false
positives, below:

On Sun, Jan 08, 2017 at 11:47:21AM -0800, no-reply@patchew.org wrote:
[...]
> === OUTPUT BEGIN ===
> Checking PATCH 1/5: i386: Add explicit array size to x86_cpu_vendor_words2str()...
> ERROR: line over 90 characters
> #27: FILE: target/i386/cpu.c:172:
> +static void x86_cpu_vendor_words2str(char dst[static (CPUID_VENDOR_SZ + 1)], uint32_t vendor1,

False positive.

> 
> ERROR: space prohibited between function name and open parenthesis '('
> #27: FILE: target/i386/cpu.c:172:
> +static void x86_cpu_vendor_words2str(char dst[static (CPUID_VENDOR_SZ + 1)], uint32_t vendor1,

False positive.

> 
> total: 2 errors, 0 warnings, 8 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 2/5: i386: host_vendor_fms() helper function...
> ERROR: line over 90 characters
> #20: FILE: target/i386/cpu.c:685:
> +void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping)

Oops, will fix it.

> 
> ERROR: space prohibited between function name and open parenthesis '('
> #20: FILE: target/i386/cpu.c:685:
> +void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping)

False positive.

> 
> ERROR: storage class should be at the beginning of the declaration
> #20: FILE: target/i386/cpu.c:685:
> +void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping)
> 

False positive.

> ERROR: line over 90 characters
> #57: FILE: target/i386/cpu.c:1599:
> +    host_vendor_fms(host_cpudef.vendor, &host_cpudef.family, &host_cpudef.model, &host_cpudef.stepping);

Will fix it.

> 
> ERROR: line over 90 characters
> #69: FILE: target/i386/cpu.h:1426:
> +void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping);

Will fix it.

> 
> ERROR: space prohibited between function name and open parenthesis '('
> #69: FILE: target/i386/cpu.h:1426:
> +void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping);

False positive.

> 
> ERROR: storage class should be at the beginning of the declaration
> #69: FILE: target/i386/cpu.h:1426:
> +void host_vendor_fms(char vendor[static (CPUID_VENDOR_SZ + 1)], int *family, int *model, int *stepping);

False positive.

> 
> total: 7 errors, 0 warnings, 50 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/5: i386/kvm: Blacklist TSX on known broken hosts...
> Checking PATCH 4/5: pc: Add 2.9 machine-types...
> Checking PATCH 5/5: i386: Change stepping of Haswell to non-blacklisted value...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

-- 
Eduardo
