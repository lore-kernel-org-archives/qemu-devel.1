Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B550C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D964020848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsrFGS69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D964020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8P9-0001g5-Uv
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jA8OH-00010b-B3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jA8OF-00087H-Na
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:31:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jA8OF-00085J-H3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583483485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RpojfijsU9y+rQwYrmpsn2m4GobdOgZ7+s75i/wQq8U=;
 b=DsrFGS694n0o9hy8MIxgJi/aZRY2r+e7r8CLc/j0SvGK0bPFFUIwXIv+ZGyKOjSmc0Vj0z
 U4JGJUsNv+MACChet4gAniD137IE6tey3rHdnJ7PxXyMYVoetVVhosrrpvkmVeFKiukYB/
 EXnsblTjQt5ZSwvdc03r3FNn0853BkU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-yw6_CTU2PQKyqx5fMK0B2Q-1; Fri, 06 Mar 2020 03:31:24 -0500
X-MC-Unique: yw6_CTU2PQKyqx5fMK0B2Q-1
Received: by mail-wr1-f70.google.com with SMTP id p5so679284wrj.17
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 00:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GAQHxOk0kjaxmZZhKBC5JUVKRSshRqkoQmhU91qi7wY=;
 b=mt2DQMKIUqUL4rJ871+/SeYat3JDgcvcXAqfGHbvgsJZnzSn+kYZ5FDS2wVAVnUtgm
 RIclgwkJbx3lqVTGDDnT/5cIpVwBuMADw2JomycgHMDrK3WvPBbN8QZkBjk/Q5ocdi/1
 NWbavPwLRm+egcZDBw5WgO7K8TCU8NxMU/Lv5Oof24oL21ZOlB0iVgURkDxd6ILFVQG7
 oma7lxeBGiN3EYOQc5DslNZufvlcLBpXiu2pEyvIUu4hRuw80jHhYTjeYSUe0wOo1MLm
 HZCpOhOHvIhYss8B5yKRWuTfaSvT8kZkvX5+pmyC2E04JqjczaTcEP8a27nzT6H5BbP9
 fcjA==
X-Gm-Message-State: ANhLgQ0w8avnauhU2mnsA4yO8NpibmJZjCwZemkj6k1tKIL/eq9Aty1t
 1s8EAC2BO12cUS6bDka+qExXiRUxiwTOLlePzmp3Tb3Ar6m06ihGg4t4yEsh6HTjJ5DlpG6xjnT
 jSEfUg63zvzJwt8U=
X-Received: by 2002:a1c:f312:: with SMTP id q18mr2726360wmq.88.1583483482962; 
 Fri, 06 Mar 2020 00:31:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtP/lQ7zGtvpTOEfod6I8/Z1YK3H9l288ost+HM9L2gwi03n8L6hn1zofh4bemCi229Zh8Kyg==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr2726334wmq.88.1583483482642; 
 Fri, 06 Mar 2020 00:31:22 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c26sm12378454wmb.8.2020.03.06.00.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 00:31:22 -0800 (PST)
Subject: Re: [PATCH v3 0/7] hw/scsi/spapr_vscsi: Fix time bomb buffer overflow
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200305121253.19078-1-philmd@redhat.com>
 <20200305230356.GB617846@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <42009fcc-4957-a272-8839-87e6a3b0d5c0@redhat.com>
Date: Fri, 6 Mar 2020 09:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305230356.GB617846@umbus.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/20 12:03 AM, David Gibson wrote:
> On Thu, Mar 05, 2020 at 01:12:46PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> This series fixes a possible buffer overflow.
>>
>> Simples patches first (dissociate the buffer holding DMA
>> requests with pointer to SRP Information Unit packets) to
>> clean the issue in the penultimate patch.
>>
>=20
> Applied to ppc-for-5.0, thanks.

Thanks Paolo and David!

>=20
>> v3:
>> - Fixed typo reported by Greg Kurz
>> - Addressed Paolo Bonzini review comments as an extra patch
>> - Added another patch converting a fprintf() call while here
>>
>> v2:
>> - Addressed David Gibson review comments
>>
>> Supersedes: <20200305083135.8270-1-philmd@redhat.com>
>>
>> Philippe Mathieu-Daud=E9 (7):
>>    hw/scsi/viosrp: Add missing 'hw/scsi/srp.h' include
>>    hw/scsi/spapr_vscsi: Use SRP_MAX_IU_LEN instead of sizeof flexible
>>      array
>>    hw/scsi/spapr_vscsi: Simplify a bit
>>    hw/scsi/spapr_vscsi: Introduce req_iu() helper
>>    hw/scsi/spapr_vscsi: Do not mix SRP IU size with DMA buffer size
>>    hw/scsi/spapr_vscsi: Prevent buffer overflow
>>    hw/scsi/spapr_vscsi: Convert debug fprintf() to trace event
>>
>>   hw/scsi/viosrp.h      |  3 +-
>>   hw/scsi/spapr_vscsi.c | 72 +++++++++++++++++++++++++------------------
>>   hw/scsi/trace-events  |  1 +
>>   3 files changed, 45 insertions(+), 31 deletions(-)
>>
>=20


