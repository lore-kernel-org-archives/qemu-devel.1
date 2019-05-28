Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A768CC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 07:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3992075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 07:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3992075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVWBt-00082O-Nx
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 03:06:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVWB5-0007dr-2b
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVWB4-0003Gq-6R
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:05:43 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hVWB3-0003GU-UY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:05:42 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M26j1-1hTaHa2usb-002ZLY; Tue, 28 May 2019 09:00:03 +0200
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
References: <20190505105112.22691-1-yuval.shaia@oracle.com>
	<871s0pjisd.fsf@dusky.pond.sub.org>
	<89805e43-4bbe-1a4b-1fd4-2c042aa979bf@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4508df6d-cb54-26e9-1603-09ef9ff87a0b@vivier.eu>
Date: Tue, 28 May 2019 09:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <89805e43-4bbe-1a4b-1fd4-2c042aa979bf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vuuUMc/2cWgLfw03eeHBxTXVx/Y41ECip2Z5iVVZYXnQrN94UHt
	1X3n+lstJovlyJf2jbHd9XGf/RcXgck0kw87c+ASarzHc8MAFomXXsQoUiFspE0VvfXUQYO
	W69igIzKiCkhdVtGFqkkFVfmETR8UxNSkGW9XMha+R/+nAFM6tlhHx85AJn35Oqj13qZ/J3
	CCC1X69/AqYQIKTjo0xAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fmqABoXC+Qs=:SWc46e3cUSoVBgFxVmM5yK
	ze5YNsQna7gRk+jCLOLydlpUI00wIUSgb/FWSyrkvQ1iNqS2/Tb1Y9BLuhabNwg5E93j/qKws
	ziQymUhLYshb9GwAGMDWM7E8oS9OFG8IU3OGyGI+nq4ZQ3q+AI6tyUs4BG1zwQbmSS94QNdHS
	l+a0nAk/O5JEawhzfP+OLLQmXBqEdoGBQOUFRVO2g8eou41UJe8p5LhI7YDItzxdtbnHgtcsH
	f/tBS2GCVS3iL+r+Vqkl+KpiQjfor4E0QSFCnK6xJz6/uvdWVLUTDKngjBB5Cb+KqUhfyhaq2
	DvWilfvHCzeFub2KZcQIYzXYkfWWshiWxDHGhrZZzMq6m9qsmyZqYNS0d7rh3YKyrTA9j8y/s
	XyZ8FZkjLdw9gmSbEHy56SuOkvFV/4g7eBHyXHcFpXbTAtt2eCmqkNkk8lsJFb5UbXOJS8QOW
	XU0HTgCGLt6bUSlX786DJJt3Fcc+nsocNXx9m8fNosHx+1RzcLyb6VpbzTlkopZcmrQwIRo/+
	wus7aFcPjRTo41Kf9zMQTLxdmUoEh4hQbbIiY4eiDMvbQIbUQuMcD/JqyZJ6+VoJHHeNPjkpU
	//BQIQ25cs3AgbsUkcWf5h7+XngMAtx5C7sHSvmAdIk3/gjUtdUhh2PK2z8zmTijjTOOE0d3g
	mmh1nAj/lGuqtkyIruo/X9eIE2O82beCqCMiU6VibFN7Co8AIXW51KtlyBLtQLZNCX31t9HNB
	7pPCcIeJxVqCZelsJRx7UWA3HvgaLJq4RnbQU90a38ISm5M7zlplk8+qIU8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/rdma: Delete unused
 headers inclusion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/2019 07:29, Marcel Apfelbaum wrote:
> Hi Markus,
> 
> On 5/23/19 6:24 PM, Markus Armbruster wrote:
>> Looks stuck.  Let's try qemu-trivial.
> 
> Thanks, that is a great idea.
> 
> I didn't want to send a single-patch pull request,
> especially while another is waiting for reviews.
> Anyway, trivial queue can be used indeed.

Applied to my trivial-patches branch.

Thanks,
Laurent

> Thanks,
> Marcel
> 
>>
>> Yuval Shaia <yuval.shaia@oracle.com> writes:
>>
>>> This is a trivial cleanup patch.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> ---
>>>   hw/rdma/rdma_backend.c | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>
>>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>>> index d1660b6474..05f6b03221 100644
>>> --- a/hw/rdma/rdma_backend.c
>>> +++ b/hw/rdma/rdma_backend.c
>>> @@ -14,16 +14,9 @@
>>>    */
>>>   #include "qemu/osdep.h"
>>> -#include "sysemu/sysemu.h"
>>> -#include "qapi/error.h"
>>> -#include "qapi/qmp/qlist.h"
>>> -#include "qapi/qmp/qnum.h"
>>>   #include "qapi/qapi-events-rdma.h"
>>>   #include <infiniband/verbs.h>
>>> -#include <infiniband/umad_types.h>
>>> -#include <infiniband/umad.h>
>>> -#include <rdma/rdma_user_cm.h>
>>>   #include "contrib/rdmacm-mux/rdmacm-mux.h"
>>>   #include "trace.h"
> 
> 


