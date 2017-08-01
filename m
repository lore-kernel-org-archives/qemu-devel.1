Received: from eggs.gnu.org ([2001:4830:134:3::10]:46993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcaNW-0006uj-Ji
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcaNS-00084p-G9
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcaNS-000813-71
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B89AFC0E8D12
	for <qemu-devel@nongnu.org>; Tue,  1 Aug 2017 16:50:31 +0000 (UTC)
References: <150160611982.36.12492156362530631521@93e45bedd699>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09b423f3-c9fe-77de-c6df-4ed79f0fa9bf@redhat.com>
Date: Tue, 1 Aug 2017 18:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <150160611982.36.12492156362530631521@93e45bedd699>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

On 01/08/2017 18:48, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/17: vl.c/exit: pause cpus before closing block devices...
> Checking PATCH 2/17: cpu_physical_memory_sync_dirty_bitmap: Fix alignment check...
> Checking PATCH 3/17: accel: cleanup error output...
> Checking PATCH 4/17: char-fd: remove useless chr pointer...
> Checking PATCH 5/17: char: don't exit on hmp 'chardev-add help'...
> Checking PATCH 6/17: docs: document deprecation policy & deprecated features in appendix...
> Checking PATCH 7/17: target-i386: kvm_get/put_vcpu_events don't handle sipi_vector...
> Checking PATCH 8/17: exec: Add lock parameter to qemu_ram_ptr_length...
> Checking PATCH 9/17: bt: stop the sdp memory allocation craziness...
> ERROR: space prohibited before that '++' (ctx:WxB)
> #78: FILE: hw/bt/sdp.c:741:
> +        data[len ++] = attribute_id >> 8;
>                   ^
> 
> ERROR: space prohibited before that '++' (ctx:WxB)
> #79: FILE: hw/bt/sdp.c:742:
> +        data[len ++] = attribute_id & 0xff;

This is the preexisting Bluetooth code... I didn't change the space,
should I have done that?

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 10/17: qemu-options: document existance of versioned machine types...
> Checking PATCH 11/17: migration: optimize the downtime...
> Checking PATCH 12/17: hw/scsi/vmw_pvscsi: Remove the dead error handling...
> Checking PATCH 13/17: hw/scsi/vmw_pvscsi: Convert to realize...
> Checking PATCH 14/17: rtc-test: cleanup register_b_set_flag test...
> ERROR: space required before the open parenthesis '('
> #73: FILE: tests/rtc-test.c:344:
> +    } while(0)

This seems to be more common than "while (0)" inside macros, should we
allow it in checkpatch.pl?

Paolo

> total: 1 errors, 0 warnings, 115 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 15/17: rtc-test: introduce more update tests...
> Checking PATCH 16/17: mc146818rtc: simplify check_update_timer...
> Checking PATCH 17/17: mc146818rtc: implement UIP latching as intended...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 
