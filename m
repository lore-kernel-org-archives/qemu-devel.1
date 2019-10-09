Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3207C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E05720679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3kZ9Mnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E05720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIH9d-00056g-11
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iICsE-00018H-NX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iICsC-0007jP-Lk
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:23:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43902
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iICsC-0007hn-Ie
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 10:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570631007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQSaIxtuVJYPGgnMUcWSBUNAI0npHfA1/QXzmXOjgOM=;
 b=X3kZ9MnzJjxPte4LDz//2R3PrXhuhnTWQGqVDpYXazUxmu6uGPURLCBuQb7vcPdK10cihL
 vFb5fjuQzpkRxpHGTcRjnivy44LpyrJPFoiQdNm44DkwOxIL03LLump81vEGtwl4Q+t2Rn
 oIIOEnd657soa6fQk2TzkpsbTGxcCNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-aHBKpsCONrm2dlS3p6tgxw-1; Wed, 09 Oct 2019 10:23:25 -0400
Received: by mail-wm1-f70.google.com with SMTP id c188so737087wmd.9
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 07:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aXqAr2gwTx4jxMfFo5hG0G5Ws6xHUcvEwTJGobjcgrc=;
 b=jr4baDzhqzXW9cZJveEeJDTKwXMaXdHQoSz9iY7M+wXH2v9+wqZesSZ8Lpqh1LMy1a
 Ovld67zIstPx6unvMS5IvpHl1ClsJ+av2cn5TrD/H8qQXxnXsWBWaw3XR5vozQZ39ZCV
 D/9+4M3+p24fc7LxhLE4E6asS9JhJhJBxUXrJjNW0yJUaqnP+Msf/BFrFrrAOBjaBuD+
 RsRpTWV1/0VKDnK/m7I/zB72kU/6d0hpJ9NVMKRsqoouW8Iq+vfyEMp5ce69eGWpJVlP
 y4W7dTVa4er+z8V+kNslYCS2ZMWAPymRb3/KPwUFNqltc7+Sm4MMI2+VZ94RGhkvxnCj
 vwKw==
X-Gm-Message-State: APjAAAV6VEJRlIyJspqtYU1gixbrCl6fdbBErZMnQgu+/y+DX5H8Lmv3
 EKU6jMFOG5/s4ON9RG6FFbsTWpRGUPC+SrdQLklpFD7C7toaF5OQZr4dCNdb85JKISysTncNx+2
 8ORtfSuorZNcsikM=
X-Received: by 2002:a5d:500e:: with SMTP id e14mr3136958wrt.88.1570631003884; 
 Wed, 09 Oct 2019 07:23:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcvEM/KoOMsFO5kfgtakOA1GCwmq1663WU22l9ZAzkvZMnXI+QKi0RBvDH0K06fiCUpI+jCQ==
X-Received: by 2002:a5d:500e:: with SMTP id e14mr3136943wrt.88.1570631003670; 
 Wed, 09 Oct 2019 07:23:23 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id 143sm3326664wmb.33.2019.10.09.07.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 07:23:23 -0700 (PDT)
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1, freeze on
 2019-10-10
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
 <78c46a05-76eb-ccec-df4d-103bee7c2760@redhat.com>
 <157063064956.3717.12528742598919174752@sif>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8117fa49-f0d8-c4ed-f992-95bc04051442@redhat.com>
Date: Wed, 9 Oct 2019 16:23:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <157063064956.3717.12528742598919174752@sif>
Content-Language: en-US
X-MC-Unique: aHBKpsCONrm2dlS3p6tgxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 4:17 PM, Michael Roth wrote:
> Quoting Philippe Mathieu-Daud=C3=A9 (2019-10-08 08:04:52)
>> Hi Michael,
>>
>> On 10/2/19 1:44 AM, Michael Roth wrote:
>>> Hi everyone,
>>>
>>> The following new patches are queued for QEMU stable v4.0.1:
>>>
>>>     https://github.com/mdroth/qemu/commits/stable-4.0-staging
>>>
>>> The release is planned for 2019-10-17:
>>>
>>>     https://wiki.qemu.org/Planning/4.0
>>>
>>> Please respond here or CC qemu-stable@nongnu.org on any patches you
>>> think should be included in the release.
>>
>> Since it is a "release", these probably fit:
>>
>> commit 45c61c6c23918e3b05ed9ecac5b2328ebae5f774
>> Author: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Date:   Thu Sep 12 18:12:01 2019 -0500
>>
>>       make-release: pull in edk2 submodules so we can build it from tarb=
alls
>>
>> commit f3e330e3c319160ac04954399b5a10afc965098c
>> Author: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Date:   Thu Sep 12 18:12:02 2019 -0500
>>
>>       roms/Makefile.edk2: don't pull in submodules when building from ta=
rball
>>
>> When is the next qemu-stable release scheduled? Do we care about Python2
>> use for this one?
>=20
> 4.1.1, likely early November during 4.2 hard-freeze. I think Python2 is o=
kay
> since presumably downstreams would've crossed that bridge with 4.1.0, ass=
uming
> you're thinking of the changes in your recent edk2 pull.

Yes.

Do you mind adding these dates to https://wiki.qemu.org/Planning/4.1?

Thanks,

Phil.


