Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082F02084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 06:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTXTAE0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082F02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnyzA-0006xH-64
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 02:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnyyP-0005no-AN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 02:33:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnyyM-0001Yk-G0
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 02:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592980405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0stp2+Wg73gHSAIzPgPBp8vuLxEwZR5ngEzgfFqsjDo=;
 b=UTXTAE0TicTscdHrEyF7z4RygMQPgnOGBgzgfCsCxQg/wi8d3rgXviJRFPI7Nt/Rpifb5j
 mRJSwQZV0W6hT7TguT3nJQcp7zLCZ25mZtZcL8AooMZKOq6BrZb5hyC+FiSpDDbGczqXxp
 YaTSqRjA3538mB//q4idnaBfPqevSvg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-1HaBo-xkOl6m3HqZ0sYWPQ-1; Wed, 24 Jun 2020 02:33:21 -0400
X-MC-Unique: 1HaBo-xkOl6m3HqZ0sYWPQ-1
Received: by mail-wr1-f70.google.com with SMTP id w4so168227wrm.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 23:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0stp2+Wg73gHSAIzPgPBp8vuLxEwZR5ngEzgfFqsjDo=;
 b=aCqWLBy97iTuB1euMpUf1NBriaBxTijAkMi4PH7KklLp45CyWqDix2kIXmWTTSyCbV
 g8aonfh3Qy2g4MNCSO/pnsMFgUBe8pFZSzK/hjGuvYLSyIggaHccq4GF8VIXla/SU14u
 9O8NUWlEAA1AXe9oWwJkdO/op+vlP9CCHXvgQ6QY7CQvw2FtOISbKCKe7gu+BFQdDvLS
 zyyrvDDeL8PJVVkMc0RwkwTRNv5mmhEQIUa6caJNqzE+5xkS5onNBB9PmTDNm4KrOoDA
 Zmmo5seLEH3zs4eQXbpWqrFxWoS3b4ZY7srwITJOsveHue+SMHGLfr8Uxgg2KNXXMPbN
 3u5w==
X-Gm-Message-State: AOAM533RkHFnm+zSFCEjWqlEEJNKFLyHsn3S3D4i5haihp1O2+++x/tX
 loPwoC3yMXePLzZF+cadGsLoR4mXwIn0SvdyTTx30zFe2gvSp58Z8c2RdBb2NKCjEQnCMhIEynV
 5HBmsGzmdu3/b2q4=
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr12284747wmf.0.1592980400364; 
 Tue, 23 Jun 2020 23:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo3UruM7RHim9mqtAsSNSArakmfmyWUIBl4Ic/D72o/NakO4cVAwJrnqNEJbOzl+BvjiQ/xw==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr12284739wmf.0.1592980400165; 
 Tue, 23 Jun 2020 23:33:20 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id h12sm6359135wmm.42.2020.06.23.23.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 23:33:19 -0700 (PDT)
Subject: Re: [PATCH] ibex_uart: fix XOR-as-pow
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20200623195441.14646-1-pbonzini@redhat.com>
 <e47cdd98-ee3f-a222-5bc9-6f8f7085584f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8635411c-d3c0-6d26-c068-4fa02de98df9@redhat.com>
Date: Wed, 24 Jun 2020 08:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e47cdd98-ee3f-a222-5bc9-6f8f7085584f@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 22:07, Eric Blake wrote:
>>
>>              uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
>>               baud *= 1000;
>> -            baud /= 2 ^ 20;
>> +            baud >>= 20;
> 
> Dividing by 1M instead of 22 seems much more logical, indeed :)

Based on the spec, the "* 1000" is the clock, in other words this is a
fixed point value relative to the clock:

f_baud = NCO * f_clock / 2^20

The example in the spec (https://docs.opentitan.org/hw/ip/uart/doc/) has
f_clock = 50 MHz, while here it's only 1 kHz.  And the register is only
16 bit, so the above would only allow a baud rate up to 62 (65535 * 1000
/ 2^20).

Should the clock be a property of the device instead?

Thanks,

Paolo

> It's odd that we are scaling up by 1000, down by 1024*1024, then
> 
>>                 s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10; 


