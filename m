Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801DAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98C620678
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrylSihS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98C620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8Hd-0006ij-0R
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc8Bi-0001Vl-Kn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc8Bf-00013e-2F
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604932225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FcDPhpL+azic2TdXKbnbXkdQL1Mz8mU0TF0Y/0TLBs=;
 b=FrylSihSgnJxpmNkyM/H6ktYov8Pmo+WRa5GQwojmrEaFMZvRrOTHHxgjP+2h/zjNZeS4r
 T+HgvZx0+0SD1Lp40t9OABdhj1Wsggj8BGs4uGG7/bPVJJNMoKcUQvjpAyAsHy+yDOyZbM
 OfQLc4Jyp6WST/E7hjqOTFg3KQTo3nQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-I2msv-SFM_2O4AqehHqDpg-1; Mon, 09 Nov 2020 09:30:23 -0500
X-MC-Unique: I2msv-SFM_2O4AqehHqDpg-1
Received: by mail-wm1-f69.google.com with SMTP id o19so2039987wme.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3FcDPhpL+azic2TdXKbnbXkdQL1Mz8mU0TF0Y/0TLBs=;
 b=NyNJiDyI2WDS7qIuc9xHDLIwW3TeiA2U4a0/omA1q1WO0is/jlFNlvIRoCRxV7a/pk
 vIxbZllSUno/N3dN0FwIUP85QrBTJnMoj1wCpJXUJn0hUa2qcsfm4jt6GLbC7qzTr0ML
 +Ko/1Gh3BrUu2CopocuG+BZcoPcHIyiBa+x3IcBpJGwpmMpgFGsHsDiI6d1DTCw0cVuI
 uZn+K/XtAun+HdO4NgW0LQK0zUczB+m8Bz5lquOv+jpHuEUAER7TPABR7bcSDewoBSai
 vLhyjddO4QJDUbfkEp/nA0NmtKJETZANP+9MUiNKvnrJdvDgQQdYKZ20tXOZiHyXeehJ
 Ptaw==
X-Gm-Message-State: AOAM530YwsaA17OGmI7He9I1EnflC+hREmUcjX7g+zcmYta0bObMGSLv
 kOhJw7dweUWZMl7YmDbBhgdcGxa0n8niER9I8o83NyX1EN6KDmhQnKzplsPGSrCIkmwYYJA/D8c
 i8GXjy8/LcKyQsq4=
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr19178632wrv.95.1604932221968; 
 Mon, 09 Nov 2020 06:30:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcR9Au5gaRsihnGtxshRgzjuPz/GXtFWRsrgDvtDkOoCngQvdZPOyr1RRDAYQBQkHuG+e+fw==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr19178617wrv.95.1604932221847; 
 Mon, 09 Nov 2020 06:30:21 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d16sm13706477wrw.17.2020.11.09.06.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:30:21 -0800 (PST)
Subject: Re: [PATCH-for-5.2 4/4] migration/ram: Fix hexadecimal format string
 specifier
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
References: <20201103112558.2554390-1-philmd@redhat.com>
 <20201103112558.2554390-5-philmd@redhat.com> <20201103124634.GG3566@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb7fecea-3b3d-b87b-7854-7d36e8133e1d@redhat.com>
Date: Mon, 9 Nov 2020 15:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103124634.GG3566@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David, Juan.

On 11/3/20 1:46 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-DaudÃ© (philmd@redhat.com) wrote:
>> The '%u' conversion specifier is for decimal notation.
>> When prefixing a format with '0x', we want the hexadecimal
>> specifier ('%x').
>>
>> Inspired-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

As there is no qemu-trivial@ pull request during freeze/rc,
can you queue this patch via your migration tree?

Thanks,

Phil.

> 
>> ---
>>  migration/ram.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 2da2b622ab2..23dcfb3ac38 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3729,7 +3729,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
>>      }
>>  
>>      if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
>> -        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIu64,
>> +        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIx64,
>>                       __func__, block->idstr, end_mark);
>>          ret = -EINVAL;
>>          goto out;
>> -- 
>> 2.26.2
>>


