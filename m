Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942AAC10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 18:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F15205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 18:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F15205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56019 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIHWb-0004IB-LP
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 14:49:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIHVe-0003tJ-AX
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIHVa-0001W8-IJ
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:48:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIHVY-0001Sn-T5
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 14:48:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so12231682wmc.3
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 11:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=k8sdNv1dFCGV8U5ZPoUVUsS9dPOQSLF9lD2Ww9PtpNY=;
	b=tGeykroPjQu6+AL+Gb+ae3uCc3Z8KkhQCWu/x2xa089U243oIFVeDZbPpXarDxl4c7
	vknCdbBEF/cX5txY4D47jX/H7d1RaVUj/kw6TvCc8OnKrSsZV560uYdrA18H8wYi3zmZ
	Kvnu1ltnF8FqAtVvcrmSAEBtONrpBBdh1dt4ldq0bfmqN7gxTY6jzp7y2lmlPtkRNFIA
	DktX4HIsUnfCIaIwT9B1D8ttHZU1M345JgssFGexN8u/8qvRIgN21EEETInfSXZVnnde
	i48eTATHHMV5T0sA0AfO3DmyGOVdjjnbNUHOCf3qsrnFo17WLeP/CKEFOeosTFM6yPr7
	K3mA==
X-Gm-Message-State: APjAAAXIt0/Jmsz/CfwcMLKXm8Ha/EJGiZ20Vn72kASdj8k8AMFZ3MQA
	bdeRDAXiTf+Tm3oamUkmntdEOQ==
X-Google-Smtp-Source: APXvYqwJt8yAVl2KyDA6/GgVoHXS/5+BO/9y98Pd/I2R6TZZ7fm/0mCERyvMRVD1j80KqMcNKfY4Bg==
X-Received: by 2002:a05:600c:2294:: with SMTP id
	20mr9230981wmf.56.1555872485993; 
	Sun, 21 Apr 2019 11:48:05 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	r18sm16507291wme.18.2019.04.21.11.48.04
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Apr 2019 11:48:05 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>,
	lvivier@redhat.com, pbonzini@redhat.com, lersek@redhat.com,
	kraxel@redhat.com
References: <20190319023030.947-1-liq3ea@163.com>
	<20190319023030.947-2-liq3ea@163.com>
	<27424fa0-0fed-c292-2321-069d725fd57d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <687c9a5b-b4bf-8364-36ff-f6b61439083e@redhat.com>
Date: Sun, 21 Apr 2019 20:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <27424fa0-0fed-c292-2321-069d725fd57d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: fw_cfg: add a function to get
 the fw_cfg file
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421184803.rh3Ts7AUy3_1fSQqQInilUW-7xXXxS9ROsxo8VJHNvc@z>

Hi Thomas,

On 4/19/19 9:03 AM, Thomas Huth wrote:
> On 19/03/2019 03.30, Li Qiang wrote:
>> This is useful to write qtest about fw_cfg file entry.
>>
>> Signed-off-by: Li Qiang <liq3ea@163.com>
>> ---
>>  tests/libqos/fw_cfg.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/libqos/fw_cfg.h |  2 ++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
>> index d0889d1e22..2df33df859 100644
>> --- a/tests/libqos/fw_cfg.c
>> +++ b/tests/libqos/fw_cfg.c
>> @@ -16,12 +16,57 @@
>>  #include "libqos/fw_cfg.h"
>>  #include "libqtest.h"
>>  #include "qemu/bswap.h"
>> +#include "hw/nvram/fw_cfg.h"
>>  
>>  void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>>  {
>>      fw_cfg->select(fw_cfg, key);
>>  }
>>  
>> +/*
>> + * The caller need check the return value. When the return value is
>> + * nonzero, it means that some bytes have been transferred.
>> + *
>> + * If the fw_cfg file in question is smaller than the allocated & passed-in
>> + * buffer, then the buffer has been populated only in part.
>> + *
>> + * If the fw_cfg file in question is larger than the passed-in
>> + * buffer, then the return value explains how much room would have been
>> + * necessary in total. And, while the caller's buffer has been fully
>> + * populated, it has received only a starting slice of the fw_cfg file.
>> + */
>> +size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
>> +                      void *data, size_t buflen)
>> +{
>> +    uint32_t count;
>> +    uint32_t i;
>> +    unsigned char *filesbuf = NULL;
>> +    size_t dsize;
>> +    FWCfgFile *pdir_entry;
>> +    size_t filesize = 0;
>> +
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
>> +    count = be32_to_cpu(count);
>> +    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
>> +    filesbuf = g_malloc0(dsize);
>> +    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
> 
> If I get the code right,  qfw_cfg_get() fills the whole buffer here...
> in that case, g_malloc() should be sufficient, so you don't need
> g_malloc0() here.

Correct.

Apparently Li did address your suggestion in his next iteration of this
patch (same subject, Message-Id: <20190420100056.116305-3-liq3ea@163.com>).

Thanks,

Phil.

