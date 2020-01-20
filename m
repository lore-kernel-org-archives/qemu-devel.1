Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F5C33CB1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F402C207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH/NXLTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F402C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSMy-0000NU-4t
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSMI-0008N6-O1
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSMF-00058Q-8S
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:24:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28875
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSMF-00058D-4s
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579508666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjrRDm3LzuNb1viskA/0oSV80C+f8cbq1AGpxua++WM=;
 b=aH/NXLTpqrGg/9cF+tre9sczNv9uo9amlIjy1oSY0xziXa1VNv+RDrFdL1cxnSorS92Z64
 /ey4u7Bi7huWVfcY672XVaNBaosYgR4q3DbxJ/QzIan27EeBVS7Fyl/ytxd7PJZlZh2ed8
 r+ZtjNvuqbGJpj/xVY5a6KVd0e1cvIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-5BuRuqRwP_ONT9VOGzdurA-1; Mon, 20 Jan 2020 03:24:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so13746645wrq.6
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W/vTNvxxEIhuMCIB5BBAVQ8KXq/cnhTMvzhleqGPqCw=;
 b=oOG22DIzC+M3M5FYoohZ8MGJvOvqBuABPVOjh6lXDzxByyTFdvQvFAM/webR7tBx1a
 YXCA/cGGLcKs3LNx47XOS/Mj8KH+lMc7gKpMjbphDh6AMxPc5B3zi7NMIZamfAWYp/cu
 y/o0UJAhq8yLrb5M3lyIfjwfDzwLpteAcAG/VNBFhbFBlqO1y9UOTsDPcg4nrATB3IVf
 maHA0f1a7B3pbiAzsyH34DfG8FLMDP+K1Gins3WX2y+lUsUcwm27OkQUB0EhaaqOeF/6
 jPTKFsgofNOuqzdskCgZ+5gaYMBTHkw9XgC1aRhgJfJZUCJNCxJNL5XJajXXjsTJapIU
 V5/g==
X-Gm-Message-State: APjAAAWe4adoQMuDlcAQP4/YEjXqVrnpBZx8rS1V+4PJgRvAWFChs5Rk
 FV3D0mUFSw4tKJ6C1kJ2WlGERxSzlzTICBzwe+iDog1TFuSI87nNVZQFJHXVf9IAJ951A0gLuZN
 ik/9RIEsgqFXr7o8=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr17658664wmk.59.1579508662050; 
 Mon, 20 Jan 2020 00:24:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIA27iL1M9hpF3QijVRYNwGEkVdpNy6uf+WwowQBDfOrbg/qvmgQgY5boQwGlOq5GJB0PhwQ==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr17658643wmk.59.1579508661759; 
 Mon, 20 Jan 2020 00:24:21 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id l7sm46648032wrq.61.2020.01.20.00.24.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:24:21 -0800 (PST)
Subject: Re: [PATCH 040/104] virtiofsd: Pass write iov's all the way through
To: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-41-dgilbert@redhat.com>
 <5E240E69.2030803@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <df029231-7b99-818f-f89d-07f23675b22a@redhat.com>
Date: Mon, 20 Jan 2020 09:24:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E240E69.2030803@cn.fujitsu.com>
Content-Language: en-US
X-MC-Unique: 5BuRuqRwP_ONT9VOGzdurA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 9:08 AM, Xiao Yang wrote:
> On 2019/12/13 0:38, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>>
>> Pass the write iov pointing to guest RAM all the way through rather
>> than copying the data.
>>
>> Signed-off-by: Dr. David Alan Gilbert<dgilbert@redhat.com>
>> ---
>> =A0 tools/virtiofsd/fuse_virtio.c | 79 ++++++++++++++++++++++++++++++++-=
--
>> =A0 1 file changed, 73 insertions(+), 6 deletions(-)
>>
[...]
> Hi,
>=20
> Tested the patch and got the correct data written by guest, so it looks=
=20
> fine to me.
> Reviewed-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

So also:
Tested-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

>=20
> Best Regards,
> Xiao Yang


