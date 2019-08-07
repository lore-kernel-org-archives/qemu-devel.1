Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F18C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C39321E6A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C39321E6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJL8-00055H-6o
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45600)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvJKU-000458-GR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvJKT-0001bj-AH
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:38:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvJKT-0001b8-3C
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:38:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id k2so4975520wrq.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xGIMuvKiRWGAighMeIoXICvoM84+mSRh6SCMOKg4t50=;
 b=k+MCfbYSDGzlvT9ITtWoHTKEtnIcJxoPU79dKU3TAfjlrVojs1IQWJmAUCox4ff9/O
 7esc22aFNqo3E5l6HHIpMphCo7Qfnc5AlOqdttssmZKryTU0NoBrKWKxlt+YggRWF9mE
 FYJcDrP93pbgnxJGYRsl0ltrrEVh39ep6IO9X9XQWd2VTWHmaPYI9ZarPq3DCyzmYrW2
 aBG+XBA7OxAF0yNrn2R/iuC6nsfcYc5yFDZ/6DbAUF0ODujEvBf76W4+caqljjVE6G8X
 9ryWQNy3t2vF4QcNpbulcJo3OuHn2zBPi60bx7y22D9nyDN3jIvKGC00OYSsTEvADBtL
 ONrg==
X-Gm-Message-State: APjAAAWEWmWUGRoD4HN2EK5xWVuZu0DgRsJRFbtzS6w8Xth3+t98XdLu
 Hy6z/iZ26ptTpzlp8yhajTbkwQ==
X-Google-Smtp-Source: APXvYqy4PVePIQDOvyWhEAtzNmLdItuCVcldRUW9KfALbPXIzDY7t2Ssr5gwLrhAtbji1xjO4Hfrdw==
X-Received: by 2002:adf:f481:: with SMTP id l1mr3615709wro.123.1565174280079; 
 Wed, 07 Aug 2019 03:38:00 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id c187sm4719394wmd.39.2019.08.07.03.37.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:37:59 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2397186a-a28e-85dd-131c-900e777a60ad@redhat.com>
Date: Wed, 7 Aug 2019 12:37:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <45ec4924e0b34a3d9124e2db06af75b4@tpw09926dag18e.domain1.systemhost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v6 00/26] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, sagark@eecs.berkeley.edu, mst@redhat.com,
 green@moxielogic.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 keith.busch@intel.com, jcmvbkbc@gmail.com, frederic.konrad@adacore.com,
 pbonzini@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 mreitz@redhat.com, pburton@wavecomp.com, marex@denx.de, robh@kernel.org,
 hare@suse.com, gxt@mprc.pku.edu.cn, berto@igalia.com, proljc@gmail.com,
 qemu-block@nongnu.org, arikalo@wavecomp.com, jslaby@suse.cz, deller@gmx.de,
 david@redhat.com, magnus.damm@gmail.com, yuval.shaia@oracle.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, hpoussin@reactos.org,
 joel@jms.id.au, anthony.perard@citrix.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, jasowang@redhat.com, atar4qemu@gmail.com,
 antonynpavlov@gmail.com, jiri@resnulli.us, ehabkost@redhat.com,
 minyard@acm.org, jcd@tribudubois.net, sw@weilnetz.de, alistair@alistair23.me,
 chouteau@adacore.com, b.galvani@gmail.com, eric.auger@redhat.com,
 alex.williamson@redhat.com, sstabellini@kernel.org, jan.kiszka@web.de,
 clg@kaod.org, stefanha@redhat.com, imammedo@redhat.com,
 xen-devel@lists.xenproject.org, shorne@gmail.com, andrew.smirnov@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, xiaoguangrong.eric@gmail.com, qemu-riscv@nongnu.org,
 andrew@aj.id.au, lersek@redhat.com, crwulff@gmail.com, laurent@vivier.eu,
 Andrew.Baumann@microsoft.com, sundeep.lkml@gmail.com, i.mitsyanko@gmail.com,
 michael@walle.cc, paul.durrant@citrix.com, qemu-ppc@nongnu.org,
 huth@tuxfamily.org, amarkovic@wavecomp.com, kbastian@mail.uni-paderborn.de,
 cohuck@redhat.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 10:23 AM, tony.nguyen@bt.com wrote:
[...]
> v3:
> - Like v1, the entire TCGMemOp enum is now MemOp.
> - MemOp target dependant attributes are conditional upon NEED_CPU_H
> 
> v4:
> - Added Paolo Bonzini as include/exec/memop.h maintainer
> 
> v5:
> - Improved commit messages to clarify how interface to access
>   MemoryRegion will be converted from "unsigned size" to "MemOp op".
> - Moved cpu_transaction_failed() MemOp conversion from patch #11 to #9
>   to make review easier.
> 
> v6:
> - Improved commit messages.
> - Include as patch #1 an earlier posted TARGET_ALIGNED_ONLY configure patch.
> - Typeless macro SIZE_MEMOP is now inline.
> - size_memop now includes CONFIG_DEBUG_TCG code.
> - size_memop now also encodes endianness via MO_TE.
> - Reverted size_memop operand "unsigned long" back to "unsigned".
> - Second pass of size_memop to replace no-op place holder with MO_{8|16|32|64}.
> - Delay memory_region_dispatch_{read,write} operand conversion until no-op
>   size_memop is implemented so we have proper typing at all points in between.
> - Fixed bug where not all memory_region_dispatch_{read,write} callers where
>   encoding endianness into the MemOp operand, see patch #20.
> - Fixed bug where not all memory_region_dispatch_{read,write} callers were
>   collapsing their byte swap into adjust_endianness, see patch #20 and #22.
> - Split byte swap collapsing patch (v5 #11) into #21 and #22.
> - Corrected non-common *-common-obj to *-obj.
> - Replaced enum device_endian with MemOp to simplify endianness checks. A
>   straight forward sed but touched *alot* of files. See patch #16 and #17.
> - Deleted enum device_endian.
> - Deleted DEVICE_HOST_ENDIAN definition.
> - Generalized the description of introduced MemTxAttrs attribute byte_swap.

I'm confused I think I already reviewed various patches of your previous
series but don't see my Reviewed-by tags.

