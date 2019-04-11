Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC7C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785772073F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 19:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785772073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfoj-0003nV-Qd
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 15:57:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfnc-0002ym-LJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfnb-0006aw-Pf
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:55:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEfnZ-0006ZS-CY; Thu, 11 Apr 2019 15:55:49 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MDN3O-1h4GDG0Z2U-00ARrr; Thu, 11 Apr 2019 21:55:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190327095634.53038-1-sgarzare@redhat.com>
	<20190327095634.53038-2-sgarzare@redhat.com>
	<9e0618f0-e889-5e37-fc4c-b44ada5fe509@vivier.eu>
Message-ID: <3e50baae-995f-c857-f733-2bdddffc9609@vivier.eu>
Date: Thu, 11 Apr 2019 21:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9e0618f0-e889-5e37-fc4c-b44ada5fe509@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9Cn57zqhuD6+RfFtq87kZYsLCDrj6Em6t3RhFxZz61aGSzGQDlq
	cP3H5NHEUACvjIMhRtCuFzDUcUUWVtB6NjIa4hvLnkYWVSxBs9ghXYLpnzDihZVdORyE9ds
	PSYUHQqUk0VnOJ14fJUgMMEvPyuzrBEI91oJSBEMy8+0PW2dQSBYP160B8x46+Sc283Ldt7
	J10FUZh3yWvu8+7eWiueg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LT9PiCbqfbQ=:Q4vjNPCPAZGL61XPGVRDmV
	URyFeTrK8GaZHHNWlYfRPiGWSWbDpUWxVkuSmnC4z77oPm0U/o0l/hMHPXwFqflQZjc18r0gh
	fNDl/K5Bcib+HMSLWOsN7WRDRavUM4X1H5XZTyyYu3FTPmFckJWWBOtHGB6Ly6+HV9hELF5RA
	Fck1IESantc6kvEGTNhJ9K5WOHEgZM9v3u4sHG7AHSQBpyMzaLolhfww8i8vj2EmtoY0GQSZg
	u2UoQNOjNJyfLLN48IlJ4Vhaonqeylj3qPSkAUhmoblKDdPNezxs5V7iL+UnQudVj5qNxA3e+
	EouCN2oBW3H8KDbGB8hobngE9fpxOej/WRMekFSayb1xlxr6G9sDnqTKCCQGNK7mxSbRlzEnJ
	KVzpdvf0fc8t54KNuJQittDsACdUWX0l/nWSBgIJKtgzSU9MC8edP8EY5IL0Fzgqpu/3CzP/G
	nVP6ONDwMevHK6Cl05rdnGT6fprsT3DgYmTehBOxfZ+MvkQNjt1N+ubL7yYaIyyyTx1E6/QqR
	GYrO7XPhYGxQ0bu/wxCN9qC9WY8sPNleAP48FEV+Dtdy9MLM67pFC2XS9QxGmLL/YMMBTBmgy
	7ytoe53GFvkYea7YZuecx5rbbo34QNlfpzGwpa6EI2KQk6refrKXkbbxKUKueqDmmdo4VfBlz
	D7GIkEjrxpAMP4giaSJuCOy+pLVsORhn/K6b5FrJCgUDS4L+mmBthGc6rR9A8njaobb1oHTAP
	iUoh0Q8aJCgVV9DV/dKDSV43s619tMJ7q09HU05j7Z25Aw4g8slokH1Jbtk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 1/2] block/vhdx: Remove
 redundant IEC binary prefixes definition
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	qemu-trivial@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Max Reitz <mreitz@redhat.com>, Jeff Cody <codyprime@gmail.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411195542.sbjcV86LxMsYMAuOG4ZwI19uGM6M3z-wLEDTLpqavwk@z>

On 11/04/2019 21:54, Laurent Vivier wrote:
> On 27/03/2019 10:56, Stefano Garzarella wrote:
>> IEC binary prefixes are already defined in "qemu/units.h",
>> so we can remove redundant definitions in "block/vhdx.h".
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  block/vhdx.c | 3 ++-
>>  block/vhdx.h | 6 +-----
>>  2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/vhdx.c b/block/vhdx.c
>> index b785aef4b7..7cd1fc3731 100644
>> --- a/block/vhdx.c
>> +++ b/block/vhdx.c
>> @@ -1889,7 +1889,8 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>>          return -EINVAL;
>>      }
>>      if (block_size > VHDX_BLOCK_SIZE_MAX) {
>> -        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZE_MAX);
>> +        error_setg(errp, "Block size must not exceed %" PRId64,
>> +                   VHDX_BLOCK_SIZE_MAX);
>>          return -EINVAL;
>>      }
>>  
>> diff --git a/block/vhdx.h b/block/vhdx.h
>> index 1bfb4e4f73..bf72090c8f 100644
>> --- a/block/vhdx.h
>> +++ b/block/vhdx.h
>> @@ -17,11 +17,7 @@
>>  
>>  #ifndef BLOCK_VHDX_H
>>  #define BLOCK_VHDX_H
>> -
>> -#define KiB              (1 * 1024)
>> -#define MiB            (KiB * 1024)
>> -#define GiB            (MiB * 1024)
>> -#define TiB ((uint64_t) GiB * 1024)
>> +#include "qemu/units.h"
>>  
>>  #define DEFAULT_LOG_SIZE 1048576 /* 1MiB */
>>  /* Structures and fields present in the VHDX file */
>>
> 
> Applied to my trivial-patches branch.

Removed as Kevin already applied it to block-next.

Thanks,
Laurent


