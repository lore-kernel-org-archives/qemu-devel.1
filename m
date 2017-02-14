Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdc7P-0007JW-55
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdc7M-0007TN-2b
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:22:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdc7L-0007SW-Sv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:22:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDD8C3A7698
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 12:21:59 +0000 (UTC)
References: <20170213135235.12274-1-pbonzini@redhat.com>
	<20170213135235.12274-2-pbonzini@redhat.com>
	<20170214074831.GE6428@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81b4bee0-ed2e-96b8-0d77-b0447ce54578@redhat.com>
Date: Tue, 14 Feb 2017 13:21:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170214074831.GE6428@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com



On 14/02/2017 08:48, Fam Zheng wrote:
> On Mon, 02/13 14:52, Paolo Bonzini wrote:
>> --- /dev/null
>> +++ b/util/aiocb.c
>> @@ -0,0 +1,55 @@
>> +/*
>> + * BlockAIOCB allocation
>> + *
>> + * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team
> 
> Hmm, I'm not lawyer, just wondering if the QEMU team is a legal entity that can
> hold copyright? :)

Not sure, but I'll note that copyright notices haven't been particularly
useful since 1989, when the United States finally implemented the Berne
Convention.

Paolo
