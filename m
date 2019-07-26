Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A1C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FFA21873
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FFA21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqtRW-0007uo-2r
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 02:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqtRJ-0007MW-VT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqtRI-0004sa-1S
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:10:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqtRD-0004oY-NH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:10:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so46600861wme.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 23:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+CKSmJY/FGQYHMgYVWAkMOHJmJzWL/EmlEhTzHXyM3Q=;
 b=KIlNF4LYk02VboJsB2sUFW/gW0vSOCkoHjutg1iMHZgLlCU30koayna6u4v62GPMbq
 vq3FK3KZHq0aEWUMBcrBPMNwPIqvpcRzBPxZxbEcnMj8IbCcBZ6LGZYdViioTJjndJd7
 +3qL52PvH5zSc4/nrf6LITKFZ2Q7wlgtLr0GTyJDaiKl0fBTcR0M1mO4Wn21DIeB2EUk
 hlUrpGFYr7y7vJlRIzwGswZ9XmilU+mmJUnw+6H0ujcx9m+7Q5gkPslohM2BzUw2gAh5
 /mbYyxSVkvJDWinSuJIJExnMpv2kSS12Ld8zfez9UkWViPhv3QawBR/YjkbVhnRE38hA
 AklA==
X-Gm-Message-State: APjAAAXQKesxd3z3Twt+xkjN0JYpoWvGjBISs0dVypV68Ml6xhh10g5R
 7qVsOv8Ck6oW8/HboWEpJRYPMg==
X-Google-Smtp-Source: APXvYqxJMwICgwUyS/ulsPRRZbVOKZPXuCCTLNHKyWkVZhE5Re2jX1aTbLSktZegaAnZHgaOVRLe9Q==
X-Received: by 2002:a7b:c84c:: with SMTP id c12mr80806507wml.70.1564121442118; 
 Thu, 25 Jul 2019 23:10:42 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id z25sm55374341wmf.38.2019.07.25.23.10.40
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 23:10:41 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048354001.54262@bt.com>
 <ee5949da-4457-0560-4525-40e4d4aaef4a@redhat.com>
 <1564120985317.14967@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dbc40cd4-f252-6b05-4edf-ae43143248b2@redhat.com>
Date: Fri, 26 Jul 2019 08:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564120985317.14967@bt.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v4 02/15] memory: Access MemoryRegion with
 MemOp
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 shorne@gmail.com, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/19 8:03 AM, tony.nguyen@bt.com wrote:
> On 7/25/19 9:45 PM, Philippe Mathieu-Daudé wrote: 
>>On 7/25/19 11:52 AM, tony.nguyen@bt.com wrote:
>>> Replacing size with size+sign+endianness (MemOp) will enable us to
>>> collapse the two byte swaps, adjust_endianness and handle_bswap, along
>>> the I/O path.
>>> 
>>> While interfaces are converted, callers will have existing unsigned
>>> size coerced into a MemOp, and the callee will use this MemOp as an
>>> unsigned size.
>>> 
>>> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
>>> ---
>>>  include/exec/memop.h  | 4 ++++
>>>  include/exec/memory.h | 9 +++++----
>>>  memory.c              | 7 +++++--
>>>  3 files changed, 14 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/include/exec/memop.h b/include/exec/memop.h
>>> index ac58066..09c8d20 100644
>>> --- a/include/exec/memop.h
>>> +++ b/include/exec/memop.h
>>> @@ -106,4 +106,8 @@ typedef enum MemOp {
>>>      MO_SSIZE = MO_SIZE | MO_SIGN,
>>>  } MemOp;
>>> 
>>> +/* No-op while memory_region_dispatch_[read|write] is converted to
> MemOp */
>>> +#define MEMOP_SIZE(op)  (op)    /* MemOp to size.  */
>>> +#define SIZE_MEMOP(ul)  (ul)    /* Size to MemOp.  */
>>
>>SIZE_MEMOP() is never used until patch #10 "memory: Access MemoryRegion
>>with MemOp semantics", it would be clearer to only introduce the
>>MEMOP_SIZE() no-op here, and directly introduce the correct SIZE_MEMOP()
>>macro in patch #10.
> 
> SIZE_MEMOP() is used, and is the main change, in patches #3 to #10.
> Perhaps you
> meant MEMOP_SIZE()?

Eh, I inverted the macro names... :( Thanks for correcting me.

> Either way, you have raised an issue :)
> 
> There is a lack of clarity in how the two macros are used to update the
> interfaces.​
> 
> 

