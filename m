Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A20C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE6F222EF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqDRkxAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE6F222EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5BM-0007Yi-5g
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX5AS-0006n2-WD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX5AR-0007E7-LS
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:11:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51448
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX5AR-0007Dh-Hj
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574176306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+5hKhxC/cbqF0MFbzsu2iu8v0D6ed2/3ftjvBJIkOQ=;
 b=ZqDRkxARHOc209OWAFR/9NvujKtF8FY8sIt7R+RA4AgoTVET7RdUcZHnc+L5SCpq3tQ2DJ
 YY5UQKRe0T5V44e2WS4UnUUssmPD9iBNi2GIvg/rfgztUdct+mxJ17RMSdWIFqAp8xS8J0
 DFGLi52h1M5y2blCjMwBDJhrORb9REg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-XixLVJ4jOPmJtlwRKiwu5Q-1; Tue, 19 Nov 2019 10:11:45 -0500
Received: by mail-wm1-f71.google.com with SMTP id g13so1543964wme.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 07:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nCybWj82/X4X7FDVCHxqhGeXjeN/tD+T+yH9jRuQQw8=;
 b=jWPC6DFDPXcUDVMKYJUcZvrl5PJkGh0gJGjI08eZVU7wnpTQNNJxDQ6NbcoZJqwqts
 0V2i9giEELguQIgzihRe3I9gLmOKX7n6QhxbRtMb/EeXWhxPtZoCX5nMvdd32yAUGCMZ
 Y5C9isRjAryqifyDmLBFrWaQlE8cO1QjCNZi2kW676bXhoPvDw86SfPzo9sI2Yov7u7J
 E5ezI2GknSkkPE+upsWWvj++JLkAEUkb/VJwOP8NCacf+bKP+h5HctTLatA52W4V1wf6
 AOu1TRMxo7uMMCKCHGREFt7IoJHWX2nifM7JNEklKvO0y1+YZYv9S5PtZ7aV8jxSXb5Y
 yJAA==
X-Gm-Message-State: APjAAAV0/XLc5WaavK8Ex/wm4H1EwhhgX3cYcpfxx7tT1qoIWj8XCR2k
 Yo6a384j9gR7DtLtgKFPlH1VP2bf3yjxAW4+i/rYJ3GXD+ifwhYRECU+0rOV97w3bo1w9dJvreM
 lsIN7OSnEHcy8fwk=
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr6071035wml.174.1574176303349; 
 Tue, 19 Nov 2019 07:11:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpskoEyc1nnDSmr1lncEk+luKALE1k1ME3RAMSUgaBpWN02Gk0FT33jDdXCCYCwHDmJ3czZg==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr6071018wml.174.1574176303163; 
 Tue, 19 Nov 2019 07:11:43 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id b186sm3408082wmb.21.2019.11.19.07.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 07:11:42 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Eric Blake <eblake@redhat.com>, Taylor Simpson <tsimpson@quicinc.com>,
 laurent@vivier.eu, riku.voipio@iki.fi, qemu-devel@nongnu.org
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <811eb939-d793-a03a-4ea9-0579d8babe52@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd379149-e02d-cf9c-d877-d83cf5a6678a@redhat.com>
Date: Tue, 19 Nov 2019 16:11:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <811eb939-d793-a03a-4ea9-0579d8babe52@redhat.com>
Content-Language: en-US
X-MC-Unique: XixLVJ4jOPmJtlwRKiwu5Q-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 3:14 PM, Eric Blake wrote:
> On 11/18/19 5:58 PM, Taylor Simpson wrote:
>=20
> In addition to what others have said, you have an atypical and long=20
> subject line. You'll want to rewrite it to match more typical subject=20
> lines (around 65 characters) then a blank line then the additional=20
> details.=A0 'git shortlog -30' might give you some ideas on how to do it;=
=20
> you'll probably want to use 'hexagon:' as your prefix.
>=20
>> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
>> ---
>=20
>> =A0 31 files changed, 2184 insertions(+)
>=20
> That's a big patch.=A0 How much of it is copied verbatim from elsewhere=
=20
> and how much is new code? Splitting the patch along those lines makes=20
> review of the non-copied portion easier.

This is WAY less than the 132114 additions in 2 patches from the first=20
round (see=20
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg07188.html)

:)))


