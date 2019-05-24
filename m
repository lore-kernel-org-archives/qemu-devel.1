Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F2F2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMloG0pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F2F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU2mm-0006D4-FE
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 01:30:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hU2ln-0005bS-Ik
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hU2ll-0003Bv-Mu
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:29:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hU2lj-00036O-8I; Fri, 24 May 2019 01:29:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so8548000wrs.5;
	Thu, 23 May 2019 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=8xL9hLKjHeqBCqWPzXp7cxDLN+8Q/AhnQdJHy3G+juY=;
	b=YMloG0pbd3V1Sunn1y+OmoDVL2S57KxNmAlXCqCzN/XIjjCgiOc9lVG4dDQ0VTtqpE
	mJ/dfA3lRNYy8D3HIBFLIig7fI5y40e/XOSipJk1jswfR+I5+BW8fKS/Qa1sZ/4gIzGh
	gwRic6PcpMo2TMMr+4Rc0C7Z6ibWBBdut8RKdk1LVXTthdXrCSMZNl/x+ItLAP4QoHIc
	Hv2UCm5ExopEfdeHyOnOm3F0f4V3Ul3DlSL63bF9mDQEH73RORRdSW5gUAMtUUr+WRFX
	cuwtaxI0sNRmbmaH0L8tFmGLXxFL2m4fgEhPpqv9GBdzIsWMktE5hQ1uuvPcC4c+mzPk
	OwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=8xL9hLKjHeqBCqWPzXp7cxDLN+8Q/AhnQdJHy3G+juY=;
	b=qDa9P1nM2GU4S0dEJPr+q5zkXCkYqFeAQS5dpsNQ7kLwiJba1Nl6kXu3Gc0MPVpaYt
	+EaGUB+gvMM2kgn1yBdBoIAONfIzHtxPrfFFZRWHB/X64n9v9sB0Ofci+Zsh/tHIBDCW
	usHM/jR3TeR0rGklojNZfQtuGy4Vdyv3dXPx+jA1U6zRjrhgv4g6MsQf8S53RobJFT+2
	Tu9MbbqP3HlOURIf7xkKlBD5Ds5utHDR9vhEih6j2K16/nOwPPoRERcNvCf75mlXQfVw
	XbydLk+aQj42zkcOl4v7ORu0kOcs5THyrsiXZacb6sxHccdOCK74YDQp/GKWuoaaWyFH
	ncCg==
X-Gm-Message-State: APjAAAUk8IByeyAX7IZgtScCOLSjT/bRUOMFe8iazSwK87xFwoMj55pW
	pLo+l4lizjgE7QIyeZRXQ7rDW9CJ
X-Google-Smtp-Source: APXvYqwz4cNvoSg4tbyg2pELU9iv/pbc1QS3fpwQmEbWrx0NyvDrAldlrxcgs3vDaomjtZZf38Tt2g==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr3687297wrw.65.1558675765524; 
	Thu, 23 May 2019 22:29:25 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id o8sm2739063wra.4.2019.05.23.22.29.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 22:29:24 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
References: <20190505105112.22691-1-yuval.shaia@oracle.com>
	<871s0pjisd.fsf@dusky.pond.sub.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <89805e43-4bbe-1a4b-1fd4-2c042aa979bf@gmail.com>
Date: Fri, 24 May 2019 08:29:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <871s0pjisd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Delete unused headers inclusion
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

Hi Markus,

On 5/23/19 6:24 PM, Markus Armbruster wrote:
> Looks stuck.  Let's try qemu-trivial.

Thanks, that is a great idea.

I didn't want to send a single-patch pull request,
especially while another is waiting for reviews.
Anyway, trivial queue can be used indeed.

Thanks,
Marcel

>
> Yuval Shaia <yuval.shaia@oracle.com> writes:
>
>> This is a trivial cleanup patch.
>>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> ---
>>   hw/rdma/rdma_backend.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index d1660b6474..05f6b03221 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -14,16 +14,9 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> -#include "sysemu/sysemu.h"
>> -#include "qapi/error.h"
>> -#include "qapi/qmp/qlist.h"
>> -#include "qapi/qmp/qnum.h"
>>   #include "qapi/qapi-events-rdma.h"
>>   
>>   #include <infiniband/verbs.h>
>> -#include <infiniband/umad_types.h>
>> -#include <infiniband/umad.h>
>> -#include <rdma/rdma_user_cm.h>
>>   
>>   #include "contrib/rdmacm-mux/rdmacm-mux.h"
>>   #include "trace.h"


