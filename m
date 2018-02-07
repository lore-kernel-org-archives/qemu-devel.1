Received: from eggs.gnu.org ([2001:4830:134:3::10]:35359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejPHo-0000n2-Vi
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:57:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejPHl-0002Vi-42
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:57:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejPHk-0002VM-TZ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:57:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A52274A2F
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 12:57:12 +0000 (UTC)
Date: Wed, 7 Feb 2018 10:57:10 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180207125710.GJ3291@localhost.localdomain>
References: <1518000027-274608-1-git-send-email-imammedo@redhat.com>
	<1518000027-274608-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518000027-274608-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] cpu: add CPU_RESOLVING_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Feb 07, 2018 at 11:40:25AM +0100, Igor Mammedov wrote:
> it will be used for providing to cpu name resolving class for
> parsing cpu model for system and user emulation code.
> 
> Along with change add target to null-machine tests, so
> that when switch to CPU_RESOLVING_TYPE happens,
> it would ensure that null-machine usecase still works.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu> (m68k)
> Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc)
> Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de> (tricore)
> ---
> v2:
>   - use cortex-a57 for aarch64 test (Andrew Jones <drjones@redhat.com>)
>   - fix conflict due to cortex-a57 change in aarch64 entry
>     in previous patch
> v4:
>   - drop removal of default cpu_model in linux-user/main.c the was left
>     there after dropping *-user parts from v3 (Eduardo Habkost <ehabkost@redhat.com>)

So, this macro is only used to find the providers of
CPUClass::class_by_name.  All the classes that set class_by_name
(except TYPE_CPU) are present in the patch.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

About TYPE_CPU: shouldn't we get rid of cpu_common_class_by_name
and just add assert(cc->parse_features) to parse_cpu_model()?

-- 
Eduardo
