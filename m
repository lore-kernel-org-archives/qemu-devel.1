Received: from eggs.gnu.org ([2001:4830:134:3::10]:40527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQDN-0003ZE-Co
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fsQDJ-00031l-4W
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:18:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fsQDI-000312-H9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:18:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C749540216E8
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:18:07 +0000 (UTC)
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-4-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d025405-6302-6fa0-d7fe-f4d2a0db5ea7@redhat.com>
Date: Wed, 22 Aug 2018 12:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180822095421.11765-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/10] check: Only test isa-testdev when
 it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 2018-08-22 11:54, Juan Quintela wrote:
> Once there, untangle endianness-test and boot-serial-test.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> boot-serial-test don't depend on isa-testdev.  Thanks Thomas.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Please remove the duplicated Sob.

> @@ -321,15 +321,15 @@ check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-mips-y = tests/endianness-test$(EXESUF)
> -
> -check-qtest-mips64-y = tests/endianness-test$(EXESUF)
> -
> -check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
> -
>  check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-ppc-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> +
> +check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> +
> +check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
> +
> +check-qtest-ppc-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)

Maybe keep moxie after mips? So that they stay in alphabetical order?

When you fixed the nits:

Reviewed-by: Thomas Huth <thuth@redhat.com>
