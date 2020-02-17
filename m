Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328EEC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECEA8222D9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XE3J+u8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECEA8222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3jIe-0003Al-1d
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3jHl-0002LW-Io
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3jHk-00006r-E0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:30:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3jHk-00006f-AF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581957015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx2lZJTq31YQ2NsNIDOGQq40TlxdbFXoY++DlLyc+rw=;
 b=XE3J+u8X/baLf2Xb937I48hPdAwzk6Zri6W0G2MCKzR9H/AJCyvn+gmMQUCzbbBYW2Y4p4
 AFhzVTO3Sc7TkPd+bk+gmK7JgPPMmrf0zalQdPHgGypUaETvfLysAwEO45vTpei0YVEe2/
 0bsqY0RYMC+2n/HJV+CyzH5iIkkrOMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-PaLYJ6FXOWKrPBqEPLKvoA-1; Mon, 17 Feb 2020 11:30:13 -0500
Received: by mail-wr1-f71.google.com with SMTP id l1so9241361wrt.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SAbd4B28IoOLxgssqOBcuNLGJzZfOGD2sA3plZCF98Q=;
 b=KS/kWbhMFllo5gv/kbczglka9RohDlm8wQCE9+rM19jxIN8uLdkpEceM50DXw+CuH0
 r3EMYorQOcUhlDRb4m/G2PUC7qAn5Hrn6/kWwpzgxpERJW16NB/FZUWRw+njOI1m7CPi
 BbjCPjJfAz7bABaKfiQ1+UYzcPkgppz3g6AHAd/nL+QrSACStp95PSum+Zfl0j2QGly4
 CdxM6Zl6TWc6l+VXjnqPqua+Jf7uJzVUf5DmLlqR2w4ynkI/2dnipeUZaF4jFEmQJsJB
 lmg7XrjWWZ4JavZdA4UeYv1J62sslQv6orsldVOl3qkcvE6a3PYULt8VXNI9DbImZhxK
 M6dA==
X-Gm-Message-State: APjAAAWEQx6C/bMLFRNQ2R7g0bnevlKsDi1K5Jf4w6wRKcHI9dUUIeYD
 Y51EUJwAz7RTtBKxslWpRuQSKuAcwH5xUdC+nR9jiWzNiFONR3jBaAyb5SKABej0w4UXt2ETkLr
 UVe7WN1k62shBAiU=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr23973416wmo.12.1581957012095; 
 Mon, 17 Feb 2020 08:30:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxEVn3Q266PGtnHpTiRDlw4nGxMhC4b/0bcJG4jFTNYIYGhO1YlaGukEwkH+EwTaHUeSDXDPQ==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr23973401wmo.12.1581957011884; 
 Mon, 17 Feb 2020 08:30:11 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id i4sm1219588wmd.23.2020.02.17.08.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 08:30:11 -0800 (PST)
Subject: Re: [PATCH] q800: fix coverity warning CID 1412799
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200210132252.381343-1-laurent@vivier.eu>
 <2b2dd523-7420-97a1-2223-15bba139ce7a@redhat.com>
Message-ID: <a473881b-b682-33dd-694d-a30da60655fd@redhat.com>
Date: Mon, 17 Feb 2020 17:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2b2dd523-7420-97a1-2223-15bba139ce7a@redhat.com>
Content-Language: en-US
X-MC-Unique: PaLYJ6FXOWKrPBqEPLKvoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

Cc'ing qemu-block@

On 2/10/20 3:56 PM, Philippe Mathieu-Daud=E9 wrote:
> On 2/10/20 2:22 PM, Laurent Vivier wrote:
>> Check the return value of blk_write() and log an error if any
>>
>=20
> Fixes: Coverity CID 1412799 (Error handling issues)
>=20
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>> =A0 hw/misc/mac_via.c | 7 +++++--
>> =A0 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>> index b7d0012794..81343301b1 100644
>> --- a/hw/misc/mac_via.c
>> +++ b/hw/misc/mac_via.c
>> @@ -30,6 +30,7 @@
>> =A0 #include "hw/qdev-properties.h"
>> =A0 #include "sysemu/block-backend.h"
>> =A0 #include "trace.h"
>> +#include "qemu/log.h"
>> =A0 /*
>> =A0=A0 * VIAs: There are two in every machine,
>> @@ -381,8 +382,10 @@ static void via2_irq_request(void *opaque, int=20
>> irq, int level)
>> =A0 static void pram_update(MacVIAState *m)
>> =A0 {
>> =A0=A0=A0=A0=A0 if (m->blk) {
>> -=A0=A0=A0=A0=A0=A0=A0 blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(m->mos652=
2_via1.PRAM), 0);
>> +=A0=A0=A0=A0=A0=A0=A0 if (blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size=
of(m->mos6522_via1.PRAM), 0) < 0) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_log("pram_update: cannot write t=
o file\n");

I am not comfortable reviewing this patch, because it use a undocumented=20
function. If I understand co-routine code enough, this eventually calls=20
blk_co_pwritev_part(), which on success returns bdrv_co_pwritev_part(),=20
which on success returns bdrv_aligned_pwritev(), which itself returns 0=20
or errno (as negative value).

I don't understand how to treat the error, but apparently other devices=20
do the same (only report some error and discarding the block not written).

So this can happens if your filesystem got full, the VM is running, the=20
device can not sync the VIA PRAM but keeps running. You let the user the=20
possibility to make some space on the filesystem so the next sync will=20
succeed.

This does not seem critical, so I dare to add:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

But I'd rather have one of the block folks reviewing this pattern.

Regards,

Phil.

>> +=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 }
>> =A0 }
>>


