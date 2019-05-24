Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F072C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA182175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA182175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54795 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAPO-0006gU-6P
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:38:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUAOH-00062u-30
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUAOF-0004XW-Rd
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:37:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hUAOF-0004Wy-Lv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:37:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so9446174wme.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cZOF5/nRtQUljlIvZZ1uTeg4deO4yTOhy9UP60Uqb5w=;
	b=GJ0rI/6MqPYx0gMRHDpISUMkM0y4aBaXhgX6BfQ8m1jPrEo6fcgoDVTCLjjNtcXj6x
	ez1hAc6dxIQ//HSgwUiRpuwNOBmASFoBOOZopN/CrKJ9AxIzKzaskzYfTwQr6ZK9r6T1
	fmjIb+BDervAp84tZjJz05kuXhqk8/BxRJJhiZoMEhH06yS+Ku30kylXl4EDam3jU17O
	f1IgBB51qVgGio9JSLvws2uvk+ewnniZ4SOKOBn8YNRDP1crdEtIFQFwJ66Wz+xRPWVy
	W9tqtwiOIR43cUdlHCMOhccM+O1zGYTkJdEnlNt+RDxVd/qrevjE9xvHWbgu1szbYUby
	XFgw==
X-Gm-Message-State: APjAAAX/ZX0p7tfZs6SebqhXF1cazzEQITLUnLxUoE28pzb4JSzwmfqv
	SgbsxPqrFUrFO+aeExYH4Y3eKA==
X-Google-Smtp-Source: APXvYqxz10tD2JetETJD3Ry0VFFBsP/1d6WKslo4MYjMu6wZOMX8W36BfBgiqNdg0LB3817+QjH/XA==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr15405391wmh.126.1558705062522; 
	Fri, 24 May 2019 06:37:42 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q68sm3043507wme.11.2019.05.24.06.37.41
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 06:37:42 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <155870450828.24.7185600599110160688@549697c9ad12>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6d97fa23-6ff0-998e-b698-388f2313d535@redhat.com>
Date: Fri, 24 May 2019 15:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155870450828.24.7185600599110160688@549697c9ad12>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Update the Fedora image to
 Fedora 30
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
Cc: fam@euphon.net, pbonzini@redhat.com, thuth@redhat.com,
	alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Patchew,

On 5/24/19 3:28 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190504060336.21060-1-philmd@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.

"20 days later", not yet a movie title.

>     inlined from ‘fill_psinfo’ at /var/tmp/patchew-tester-tmp-3g8u4fv2/src/linux-user/elfload.c:3208:12,
>     inlined from ‘fill_note_info’ at /var/tmp/patchew-tester-tmp-3g8u4fv2/src/linux-user/elfload.c:3390:5,
>     inlined from ‘elf_core_dump’ at /var/tmp/patchew-tester-tmp-3g8u4fv2/src/linux-user/elfload.c:3539:9:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

This has been fixed by the following commit, merged earlier today:

commit d7eb2b928a855a2e8038e8e75f7edf1a12226bd3
Author: Alistair Francis <Alistair.Francis@wdc.com>
Date:   Tue Apr 30 23:29:01 2019 +0000

    linux-user/elfload: Fix GCC 9 build warnings

    Fix this warning when building with GCC9 on Fedora 30:
    In function ‘strncpy’,
        inlined from ‘fill_psinfo’ at
/home/alistair/qemu/linux-user/elfload.c:3208:12,
        inlined from ‘fill_note_info’ at
/home/alistair/qemu/linux-user/elfload.c:3390:5,
        inlined from ‘elf_core_dump’ at
/home/alistair/qemu/linux-user/elfload.c:3539:9:
    /usr/include/bits/string_fortified.h:106:10: error:
‘__builtin_strncpy’ specified bound 16 equals destination size
[-Werror=stringop-truncation]
      106 |   return __builtin___strncpy_chk (__dest, __src, __len,
__bos (__dest));
          |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

Done!

