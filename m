Received: from eggs.gnu.org ([2001:4830:134:3::10]:58215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOr0-0004WF-Mg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOqz-0005Jh-Sq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:13:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOqz-0005JM-KV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E3DF7D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:13:17 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-14-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd85ece3-d2ac-d203-1ba3-fa9dff89591e@redhat.com>
Date: Tue, 17 Jul 2018 14:13:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-14-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/25] check: Only test isa-testdev when it
 is compiled in
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

On 17.07.2018 13:33, Juan Quintela wrote:
[...]
> @@ -319,15 +319,15 @@ check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
>  
> -check-qtest-mips-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
> -check-qtest-mips64-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
> -check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
> +check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>  
> -check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
> +check-qtest-moxie-$(CONFIG_ISA_TESTDEV) = tests/boot-serial-test$(EXESUF)

boot-serial-test is not related to ISA_TESTDEV, so that change looks
wrong to me.

 Thomas
