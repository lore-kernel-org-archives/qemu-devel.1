Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B65C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191EC20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHuLKnHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191EC20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvS5-0007kz-8e
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRvQ4-00065L-HO
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRvQ4-0004NI-2y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:18:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRvQ3-0004I7-M4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587723530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrPPbcsnVYNDZ2S5Uf/C6t9fkMO9PR7OSaNEqZZexYc=;
 b=CHuLKnHFvlvUa+V9X6KZDhQe90r/WB20q1MJDzRySwAA/omSyXmN7Ok3AYcs5EaaEIWY4r
 ippZ+PnfEETYxOCQDTnl5EYNcyM7iMBDBoluqndR7lm0Ge6dvgnwjOoA5amoYnEfSAUiOe
 +clOmwN2HWJFCa/rV2gPGoiDTkyngq8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-CSc23oxNNJSZqZa2qSSmSg-1; Fri, 24 Apr 2020 06:18:48 -0400
X-MC-Unique: CSc23oxNNJSZqZa2qSSmSg-1
Received: by mail-wr1-f72.google.com with SMTP id r11so4525201wrx.21
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 03:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JrPPbcsnVYNDZ2S5Uf/C6t9fkMO9PR7OSaNEqZZexYc=;
 b=ckKfp//Cn5RJmyagXb9i0FzQQR07DatPnX7qSTzggl3GtDaJgdq1ZBXxxoTk7yolJX
 lN6ITw3UHjI0gxSVqoW7GJiIVGY+U+Co87yAPxU61txup8mXEr92Ss5jS8oCF4cdXgB0
 Wpaacxc4SNOR8rsgRDj/5D2dhRguYN//PWv03L+JTOBI+agNo2tZ11+IcDbn9jqIHEbG
 SoTCceHdfT6p8qdPrbxeEhxM8m65MZdAUPch1KL0vwdS0CcI4g+tLXrGw51X4i+RbhW1
 Pkoq2MpedLp6+SSdjRu0QAJV2NJ0+SNzToPhESkQAXKNQcz103Y8lzAPJNq1zq09NTrL
 T3ig==
X-Gm-Message-State: AGi0Pua2g/qHSPdtPXJ77g6dQcwfCwwFOBkOfgxPSLMy49p0aYKSvOaQ
 v22tvnM408xBG9Jo405KdHf0VWL1ngbbjQ3aPz/KB88R4OV5tf62cfTdtqsnG2pK2lIkZuQDxWD
 XUB2Sj8m5FBbFqzk=
X-Received: by 2002:adf:916f:: with SMTP id j102mr9869500wrj.335.1587723527398; 
 Fri, 24 Apr 2020 03:18:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLZbgEh5e3/+/H+L3ODoxfatGhmzn3f3Z+4Scy1c6JsiNz42Ph8kUlAszYQPvP7wnziXrsaBA==
X-Received: by 2002:adf:916f:: with SMTP id j102mr9869481wrj.335.1587723527206; 
 Fri, 24 Apr 2020 03:18:47 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j10sm2404011wmi.18.2020.04.24.03.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 03:18:46 -0700 (PDT)
Subject: Re: [PATCH 2/4] smbus: Fix spd_data_generate() error API violation
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20200420132826.8879-1-armbru@redhat.com>
 <20200420132826.8879-3-armbru@redhat.com>
 <alpine.BSF.2.22.395.2004201613040.29873@zero.eik.bme.hu>
 <87h7xd5rvs.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2004221502090.19234@zero.eik.bme.hu>
 <87r1wdnro1.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ea6a25ab-17e9-1560-d1c3-9479bcecef54@redhat.com>
Date: Fri, 24 Apr 2020 12:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87r1wdnro1.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 11:45 AM, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Tue, 21 Apr 2020, Markus Armbruster wrote:
[...]
>>>
>>> Here's what I actually disagree with:
>>>
>>> 1. QEMU warning the user about its choice of memory type, but only
>>> sometimes.  Why warn?  There is nothing wrong, and there is nothing the
>>> user can do to avoid the condition that triggers the warning.
>>
>> The memory size that triggers the warning is specified by the user so
>> the user can do someting about it.
> 
> There is no way to trigger the warning.  If we dropped PATCH 1 instead
> of fixing it as I did in v2, then the only way to trigger the warning is
> -M sam460ex -m 64 or -m 32, and the only way to avoid it is to don't do
> that.
> 
> Why would a user care whether he gets DDR or DDR2 memory?

To use a different firmware code path!


