Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD5C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6099420652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6099420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZnI-0000LE-Iz
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:56:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZeq-0002gm-Ac
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZeo-0008Td-CV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:20 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:48417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLZei-0008JL-R8; Tue, 30 Apr 2019 16:47:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N5G5b-1geqVL0qnt-0117v4; Tue, 30 Apr 2019 22:46:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
	<aaebd05c-b1a6-a93e-222d-ede76633c07d@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <555e5b87-0918-35d9-f7d1-6cb0dd11cc85@vivier.eu>
Date: Tue, 30 Apr 2019 22:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aaebd05c-b1a6-a93e-222d-ede76633c07d@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cddlvfEb2S54XHV7ciE0PqYA5dQVg/vz/YAYecNWjdlMBRmPGpr
	wSHJooyIE1iKGumZ8pYJAXLO/um85wEI0Mp8OZCv5K5MD1UPacUp9VO4q8byNT2fRHvlw4r
	28I2ZHI/pbdXc223GCRkzcXnylem9Qj9g3AAB8TlQetMqTbZUGh8//9foEo9rUv1hHM2CkQ
	XJs5D9Up5gZ05cAH+a6JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+o6H4G6ChlA=:7q4GSfZ5gjmCcDf7VOlmr3
	59hjm7HxL2EJvgRs1DRSxLnFA+0nfPhnk9KOcJzowYwNLifsUvjinkrWAHQk8AoLYVvFAJ9RS
	UmwK3TFVpYLmmMFk+H2DbEB+DuLVokXb36SgNmbp2Hb2yQEG9Ze3NW/gfiM3ttyaZUMfdHCJS
	p48rgGVLl9jWZrO5wn+6U9FifDvs+22lQ+1Rf6xXZxW5m/fbHs3zlYivTUW6XXOulD2vs7IjT
	WKw0++aLrA/FQvRHFe/NsbkywsXrd/Px06KWjBeG1r44CCewhM1VAjbLoyRHEIhbR+Emq18nP
	MwWCUvgtyQU0Wg9b21daxTWSj6PTgsgCnwAmZDEGD18/TVf7j5d1B0SkURODT7xoC6meNXM97
	d743rIi5Rlq6kk4+7YraJXI8LPjOQHzs57WVCoRNJpPEigCVvbSwGCS3zwbMZ8v1VEpbBeJhm
	cbqWJnFKU22EAIX0Nft/uZGcyiym8HWAosPMw0RrsZIESprTo1SBwxEqp1XO9iMxNlnKgTgKj
	MDXqJu7X215rE6EU6GZOQF7B6RPXiRBNPddKB3wMHY6McZ+2LAXhsREy2EpcjLOA+07AUpqBh
	PiCzgaxB9iRwZVKRDPcRpNS0tpaEx9EkY/QNhr5nUWRC/hmG4slRA69bxJszt8iHltcjiRElM
	onc+rvnHPW9Hdsc5WZJ078PreVIJ9/JffsFltcR9MN8Tqj3C9sQpCuY0uYTAyFuNaafddAOQe
	E2pV/4nQYXNOLExbK/fuISRCP8LdW6NUAz5COG9PTSRvPS7g9UjVGPX2ebg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430204656.mAmuL5nOKtdoVAofr9Y7rjAKrkIUsnNO9Y2xdU90Fd8@z>

Le 30/04/2019 à 22:30, Laurent Vivier a écrit :
> Le 30/04/2019 à 22:09, Alistair Francis a écrit :
>> Fix this warning when building with GCC9 on Fedora 30:
>> In function ‘strncpy’,
>>     inlined from ‘sys_uname’ at /home/alistair/qemu/linux-user/uname.c:94:3:
>> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Werror=stringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  linux-user/uname.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/linux-user/uname.c b/linux-user/uname.c
>> index 313b79dbad..293b2238f2 100644
>> --- a/linux-user/uname.c
>> +++ b/linux-user/uname.c
>> @@ -90,6 +90,11 @@ int sys_uname(struct new_utsname *buf)
>>     * struct linux kernel uses).
>>     */
>>  
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wstringop-truncation"
>> +#endif
>> +
>>    memset(buf, 0, sizeof(*buf));
>>    COPY_UTSNAME_FIELD(buf->sysname, uts_buf.sysname);
>>    COPY_UTSNAME_FIELD(buf->nodename, uts_buf.nodename);
>> @@ -101,6 +106,9 @@ int sys_uname(struct new_utsname *buf)
>>  #endif
>>    return (0);
>>  
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
>> +#pragma GCC diagnostic pop
>> +#endif
>>  #undef COPY_UTSNAME_FIELD
>>  }
>>  
>>
> 
> You should use PRAGMA_DISABLE_PACKED_WARNING and
> PRAGMA_REENABLE_PACKED_WARNING from linux-user/qemu.h.

Ok, I should read correctly, the pragma here is not related to them

Thanks,
Laurent


