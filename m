Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C909C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7BC2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 23:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3y47eu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7BC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK9Ws-0007mz-2H
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 19:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK9Vy-000736-Ho
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK9Vx-0001K7-F2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:12:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK9Vt-0001Hk-Kw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 19:12:32 -0400
Received: by mail-pg1-x541.google.com with SMTP id i76so10930187pgc.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ByA4UOMoD8kVhgFaSenOHHGcB2tKC+mxr8FC3XKWVpY=;
 b=M3y47eu5zFPN0d1KytcLq6Pw4EIz8xWE2huK8trzTKw+ADzvbDfuTkKK0qj1lk1Pdh
 LCjI5avp3tvTyCf+xaceJKN8tGKs8tohzLfAczn3y3faBbePTq4lDwqbiKRxn3aFlM4L
 VjVoz5FoDmtkzH0eIlW03hc3GC7wtj5DqOoTSKDwo45M4EEOZCky0sowd7NuuLAFs8Ye
 uR8AWkcRBPh6xvqxi45KCTuUKGBxTmIoqcy5fHg8qqISCwFtKIEmstXz8qEReiEV7y0O
 rOA9azVc/cqwMG17y86PptTUJ2CxY9+HeOsnE2/JNNxM6M66x68ImceI73AB0QKRoYT6
 UT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ByA4UOMoD8kVhgFaSenOHHGcB2tKC+mxr8FC3XKWVpY=;
 b=YKQclu/7gkNCplzPDj8jnuZNhrwto63uvI2iJ+a3dCHJV/ARmoEqij9pDQ93vJronv
 ijai1PD3MF9NXi1FTnofOe1Y7+mCHaINO8zPMsjbDwxUSAQJtZv5utcO6rGBHrNVBBCH
 q7gSlSX7OJ09sXCixkqC3hWes/GKy3vMkHPi4WvThJYPiEs29DeV9oS5gRVW8DAJzAv4
 sAGhDG0ELV2DK7O8uGtDMq934A6JGqt2KsDkRzzza1phxdyhiU+5SV/QRQe8Z2pipwkz
 vBXfYJ+J1FX9jPky3hLYm0mvY7nOaR7YGmgOApEWTAPs6pqHR0mIbKz1DagnNwtukn0H
 owEA==
X-Gm-Message-State: APjAAAV1tFzE+vfqejeXvBuiGQ0fU1903uswwiH8pXbLz5zhmg9jY11r
 M9SuYgZ+cCsvZIyEtGAQwfdJ9A==
X-Google-Smtp-Source: APXvYqwrsThb6PmLiueoCw9oHTSgCHRp00PvLyKKSARtOxz3Vt746CXVN5hAqzGRo5pL+XWXdV2ohw==
X-Received: by 2002:a63:5064:: with SMTP id q36mr29718841pgl.393.1571094748044; 
 Mon, 14 Oct 2019 16:12:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w10sm16486067pjq.3.2019.10.14.16.12.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 16:12:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] core: replace getpagesize() with
 qemu_real_host_page_size
To: Wei Yang <richardw.yang@linux.intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-3-richardw.yang@linux.intel.com>
 <20191014091502.GA3250@work-vm> <20191014213617.GA15059@richard>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9395cf95-9e4f-3df1-9a68-9e8e5a592395@linaro.org>
Date: Mon, 14 Oct 2019 16:12:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014213617.GA15059@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: fam@euphon.net, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, den@openvz.org,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, sw@weilnetz.de, yuval.shaia@oracle.com,
 alex.williamson@redhat.com, stefanha@redhat.com, imammedo@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 2:36 PM, Wei Yang wrote:
> On Mon, Oct 14, 2019 at 10:15:02AM +0100, Dr. David Alan Gilbert wrote:
>> We also use sysconf(_SC_PAGESIZE) in a few places.
> 
> You mean need to replace them too?

I would say so, as a separate patch.


r~

