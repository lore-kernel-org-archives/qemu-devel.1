Received: from eggs.gnu.org ([209.51.188.92]:45229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hMcYx-0000Yv-22
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hMcYu-0003R5-HQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:05:34 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hMcYu-0003PI-Cn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:05:32 -0400
Received: by mail-ot1-f47.google.com with SMTP id g8so6078510otl.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:05:30 -0700 (PDT)
References: <CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
	<20190429134048.GH7587@stefanha-x1.localdomain>
	<1A278B43-AA26-43B4-B6C2-17231E780BBE@oracle.com>
	<20190501163650.GF21155@stefanha-x1.localdomain>
	<1823F9C3-8092-4B75-87AA-A05325032F48@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <428e3ee5-28b0-7895-8a17-9178354c9406@redhat.com>
Date: Fri, 3 May 2019 12:05:25 -0600
MIME-Version: 1.0
In-Reply-To: <1823F9C3-8092-4B75-87AA-A05325032F48@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Li <wei.d.li@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org

On 03/05/19 10:21, Wei Li wrote:
> Got it, thanks Stefan for your clarification!

Hi Wei,

Stefan and I should be posting a patch to add Linux SCSI driver
batching, and an implementation for virtio-scsi.

Paolo

> Wei
> 
> ﻿On 5/1/19, 9:36 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
> 
>     On Mon, Apr 29, 2019 at 10:56:31AM -0700, Wei Li wrote:
>     >Does this mean the performance could be improved via adding Batch I/O submission support in Guest driver side which will be able to reduce the number of virtqueue kicks?
>     
>     Yes, I think so.  It's not obvious to me how a Linux SCSI driver is
>     supposed to implement batching though.  The .queuecommand API doesn't
>     seem to include information relevant to batching.
>     
>     Stefan
>     
>     
> 
> 
