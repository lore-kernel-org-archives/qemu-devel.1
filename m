Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4380EC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073C720731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2JzkFfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073C720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioQEd-0004TJ-7E
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 06:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioQE1-0003y6-Oq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioQE0-0005gc-LN
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:07:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioQE0-0005gC-HS
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578308827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3jO3YQ6cwnTXgO7+PO8vQ9d98mIBEizEEcEsCDGWzs=;
 b=H2JzkFfBG7SssNtxUW9VO66rI7MYEIe4UyHVfUeJ64Iffda4jpU3iXYN4lgh0GKzOaXZVV
 3qfPkhpojepzXZb6r2rlvM51RvH/sVcANjp79yFC9qRjMhg8nbEKm4POmX9nUG1PHPTEj9
 5RlchBreraGayCl6d9Irc44tJdhq1M0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-zzMiZ_0fM2WFO-a8YxNf_Q-1; Mon, 06 Jan 2020 06:07:04 -0500
Received: by mail-wr1-f72.google.com with SMTP id u12so26966225wrt.15
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 03:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hgjdRRBv1GysZIrRioCKI+5hIiqcsuQJITUH1vwbSVc=;
 b=XTL3Q+VVXe8Pg9a2ZiIABtoHW9sVrFkVLLTTKsq5vCJ2beJ3o3Ypm/HELRzwM1friw
 CUKDnStQkJsaNGIE3D/SF5ankEy2G+8kxcNVQheCKfBogCYL246JSTa+c77Fv/cloaMO
 mV5OTh0naWjj0tia3k4pSti27MJKuL4vR9AUNazIxUEkchPD0d7IfwVcwn5wMJQt6krF
 tAqTeiF47lYuFg4bVud4NkRPBHW20hxXe4K4grA6VlgvaCyMLIoknKfTS/0EZdwNSLpP
 Is3h9BFRwcIyFvZaWXj4hpje9juP+FoI5wKfuvsLnCMr+62NW240/LG53TQQbHq7hfPP
 DUxQ==
X-Gm-Message-State: APjAAAUk9eXPHgeXqCXoKjHhp78SxDbBPNr3d2KKePa8WKFDfoqz8VoS
 ZmG+FquvYEg6TdJgq6H7E2zMbdE5OssHhhb2uubJTGmkTAdz19k1tea/OfLARwZb8jh8Cojly0M
 77tn+T4nEMJknSmM=
X-Received: by 2002:adf:fd84:: with SMTP id d4mr102291372wrr.211.1578308823320; 
 Mon, 06 Jan 2020 03:07:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2lfju+34tlvPlOsXfiLOL9MfFt8nIDIdoQ+foiYGO9V6GCIIPhmkw4Fr2xVo3bb+5oMUoEg==
X-Received: by 2002:adf:fd84:: with SMTP id d4mr102291350wrr.211.1578308823071; 
 Mon, 06 Jan 2020 03:07:03 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id y139sm23697219wmd.24.2020.01.06.03.07.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 03:07:02 -0800 (PST)
Subject: Re: [PATCH] 9pfs: local: Fix possible memory leak in local_link()
To: Greg Kurz <groug@kaod.org>, Jiajun Chen <chenjiajun8@huawei.com>
References: <20191220094934.21232-1-chenjiajun8@huawei.com>
 <20191223115909.524ca244@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <307e94fc-e71c-e625-480d-b0224a64ac3b@redhat.com>
Date: Mon, 6 Jan 2020 12:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191223115909.524ca244@bahia.lan>
Content-Language: en-US
X-MC-Unique: zzMiZ_0fM2WFO-a8YxNf_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/23/19 11:59 AM, Greg Kurz wrote:
> On Fri, 20 Dec 2019 17:49:34 +0800
> Jiajun Chen <chenjiajun8@huawei.com> wrote:
>=20
>> There is a possible memory leak while local_link return -1 without free
>> odirpath and oname.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Jaijun Chen <chenjiajun8@huawei.com>
>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> ---
>=20
> Applied to 9p-next.

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Thanks.
>=20
>>   hw/9pfs/9p-local.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>> index 4708c0bd89..491b08aee8 100644
>> --- a/hw/9pfs/9p-local.c
>> +++ b/hw/9pfs/9p-local.c
>> @@ -947,7 +947,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldp=
ath,
>>       if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
>>           local_is_mapped_file_metadata(ctx, name)) {
>>           errno =3D EINVAL;
>> -        return -1;
>> +        goto out;
>>       }
>>  =20
>>       odirfd =3D local_opendir_nofollow(ctx, odirpath);
>=20
>=20


