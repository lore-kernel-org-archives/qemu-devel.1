Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F1C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BF2222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWdC7TZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BF2222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7E7K-0003Qw-8Z
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7E6H-0002rC-FH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7E6F-0003DJ-Sw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:00:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7E6E-00037n-0m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582790447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yE5Hx1AAL7CADO7/zyb61bboxGgXJ6xNaPC5Q4+u9Pk=;
 b=TWdC7TZDE3JjiOW50BbOPVMMGqiQ+BK16lgtYWA0nDae79BsxMmOWPTkzGHO5JvONYndr7
 /COEjCK2WCYxWAK22OeDZnS3KeajwrUIP4TGTNEnD6bjbCqkFiLOgh73aUTOzayaFKTaCZ
 qb7ulQHG7e27wAL6Duj7+nZXHhE6oPI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-e4JphP0FPbOwVkRaEVHrPA-1; Thu, 27 Feb 2020 03:00:44 -0500
X-MC-Unique: e4JphP0FPbOwVkRaEVHrPA-1
Received: by mail-wr1-f72.google.com with SMTP id f10so965006wrv.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 00:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f6hzv6RfxrfDmTJ9rzSurTVrY4zLOxvjt9xoWfKo82I=;
 b=qMot5B6HtIf4FZ9bTH/Wg8YPeK6JIBojQoy9I92ihvADrIaIFQfnhc5c+LSd7vuc0H
 HJfItVyF0H8UAGMuiwTAAOwTr+WEhuZvHZYZyIuCwvbdo7UL0jhPtC+gJYB9D4bSUpUb
 AIIYp4CBVnu3rM7q2RdwP5bcdQ0cMKYBBhIB1kpU6o/EWI4bXRRXJcLTLhQSUN4ZjrVu
 igbyFhARokz+Vj3BgSJUEsAGAySqq9Jy9u58GOVycdMdQ89Tz1m1rXiJKF0Npw3d/cdx
 Jwj2HBTtNtZTZ+6i2SVF1GGSAWcY3nkxbY6w3igfrrPFixtNtiz7xjtR+B72yvAPK0cG
 Dhzg==
X-Gm-Message-State: APjAAAWIDNfw/HFlATF7shJLA4pN79knp2c/eXjZ2mZl2RZ/46C6ygZg
 zK9EBKZtTghb4+BP9s6h7IAPY3qBx5AIE/DpHwsv3RQQ/KyK4LDdId2XdNi6t+jqnF4osz61iOY
 4u7OTEpemUAgFjyI=
X-Received: by 2002:a5d:5706:: with SMTP id a6mr3271736wrv.318.1582790443619; 
 Thu, 27 Feb 2020 00:00:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1QHnZsXTSRIqlYZKBJd1Bmmg/R1v5HUfMGJwmOB5fBHe8wSNODnppQ76DDB/Dxz7q+HlzFg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr3271698wrv.318.1582790443304; 
 Thu, 27 Feb 2020 00:00:43 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p15sm6393677wma.40.2020.02.27.00.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 00:00:42 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Colin Xu <colin.xu@intel.com>, qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20200226043204.67961-1-colin.xu@intel.com>
 <556a79eb-de83-0471-353f-b92423a77faa@redhat.com>
Message-ID: <7509aa5c-aa6f-14e0-e641-6e70731e59d9@redhat.com>
Date: Thu, 27 Feb 2020 09:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <556a79eb-de83-0471-353f-b92423a77faa@redhat.com>
Content-Language: en-US
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, wenchao.wang@intel.com,
 hang.yuan@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 8:56 AM, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing qemu-trivial@
>=20
> On 2/26/20 5:32 AM, Colin Xu wrote:
>> HAXM covers below files:
>> include/sysemu/hax.h
>> target/i386/hax-*
>>
>> Cc: Wenchao Wang <wenchao.wang@intel.com>
>> Cc: Hang Yuan <hang.yuan@intel.com>
>> Signed-off-by: Colin Xu <colin.xu@intel.com>
>=20
> Please keep the Acked-by/Reviewed-by tags:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg623832.html
>=20
> This patch already has:
> Reviewed-by: Hang Yuan <hang.yuan@intel.com>
>=20
>> ---
>> =A0 MAINTAINERS | 10 ++++++++++
>> =A0 1 file changed, 10 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 36d94c17a654..27727e2fac13 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -435,6 +435,16 @@ F: include/hw/block/dataplane/xen*
>> =A0 F: include/hw/xen/
>> =A0 F: include/sysemu/xen-mapcache.h
>> +Guest CPU Cores (HAXM)
>> +---------------------
>> +X86 HAXM CPUs
>> +M: Wenchao Wang <wenchao.wang@intel.com>
>> +M: Colin Xu <colin.xu@intel.com>

Maybe you can also link where to report HAXM issues:

W: https://github.com/intel/haxm/issues

>> +L: haxm-team@intel.com
>> +S: Maintained
>> +F: include/sysemu/hax.h
>> +F: target/i386/hax-*
>> +
>> =A0 Hosts
>> =A0 -----
>> =A0 LINUX
>>


