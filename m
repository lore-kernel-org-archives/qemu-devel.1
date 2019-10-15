Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 06:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BD220872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 06:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoA+ubGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BD220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKGXY-0007eK-H6
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 02:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKGW4-00071H-SO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKGW2-0007gM-Cr
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:41:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKGW2-0007Sf-4q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:41:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so22334223wrv.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=upizE4WP+MxmkadUBcl9hxchPxBsZW6E72h+k4bSyMU=;
 b=eoA+ubGIP6z7QteI2SCMzYZFBUxvmOM+7yhVOtHEZKG0PbFfFLaV7yaFu5viDDmr3M
 L5JA64mHyKorh7eQ8NlhvwsQvNxYedr03xKn6lDcTEKfBi9ZCllUeZRa7P4kVBu7wqEo
 mOD/lnM/LE7PyfXXwwnoYTW/SMdkV5ROtUJ0174mrEijJWrHBhlwTwZjsKIENOAlOjHO
 3AmRkdmqdezfdq94pllQv0yDi++ng+uEnrlAERI0HzM+4bYoidZofZQgV1PDk1DsRF6J
 LP/hyuOWbW5QFfJhNerc2Z/SU7Oe/PBOBZq8nprD9/l5De0Qpy+Iw0SL0FPNwr74e0aA
 zvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=upizE4WP+MxmkadUBcl9hxchPxBsZW6E72h+k4bSyMU=;
 b=Eh4hAhcG7iIlpzcQDfltbTQzbH1nlgRDkRkdgUoXPXmQ2GbzWV3dS9phbFwYLVqJPa
 Th2//G6GJiuVXnDtB2gxpBMCRM+P1v/GIzbOWnQorgXjTB6vSMnGeBncNMaL8mMNcd4R
 Q5PRd2/jfT1xuimDAnwc9/egT65+D3KE41EVZ9ZtgAuMsPhI51jQwOASZWXBlxsOh2/J
 PHvtokVX8LhckX0WJzBbDE1IZBS8FUXBfLt9hmsOioyN4Lwyjurouzb4ZSHsmrnaxcA3
 B0PuDaT+owOBr/QqjqysF6m/ihU5PPqXOXxZygk1yfd2onNH4iXG5bqkJ9OktIbBEw0z
 pXXw==
X-Gm-Message-State: APjAAAUzBpy5YlH0KP8N2ItKQdSio7M/CIhd5mjlKGhtBfUojDfP7tV0
 C8ArqkU99FN7ZJwAvBYi8BkN1A==
X-Google-Smtp-Source: APXvYqyF/KMdIw4NSZ1A9DILOoRLgP46c42cv+blq7Kh5k0BfSXD+ni8M7nPm5MpOAHxdDhUwE7pGA==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr30618618wrq.227.1571121661450; 
 Mon, 14 Oct 2019 23:41:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm29401075wrg.80.2019.10.14.23.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 23:41:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 15BC01FF87;
 Tue, 15 Oct 2019 07:41:00 +0100 (BST)
References: <20191014135905.24364-1-alex.bennee@linaro.org>
 <20191014135905.24364-6-alex.bennee@linaro.org>
 <719f9549-0b15-a9ef-7f23-11215a02237a@cmss.chinamobile.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 5/5] contrib/gitdm: add China Mobile to the domain map
In-reply-to: <719f9549-0b15-a9ef-7f23-11215a02237a@cmss.chinamobile.com>
Date: Tue, 15 Oct 2019 07:41:00 +0100
Message-ID: <8736fumryb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>, dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


maozy <maozhongyi@cmss.chinamobile.com> writes:

> Hi, Alex
>
> On 10/14/19 9:59 PM, Alex Benn=C3=A9e wrote:
>> We've had a number of contributions from this domain. I think they are
>> from the company rather than customers using the email address but
>> it's hard for me to tell. Please confirm.
>
> Yes, this domain comes from a china company, not an individual, and I'm
> very grateful for this patch.
>
> Currently we can only view the community's patch via the GNU mailing
> list, Does this patch mean that we can now easily subscribe to the
> mailing list form the mail client?

The domain-map is only used to group contributions under the same
company when generating stats with gitdm. It should have no affect on
the ability to subscribe to the mailing list.

Does this mean your not subscribed to the list and you have to read via
the archives (https://lists.gnu.org/archive/html/qemu-devel/)? That
sounds like something going wrong with the mailer setup as anybody
should be able to subscribe to the list.

>
> Many thanks,
> Mao
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> Cc: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> ---
>>   contrib/gitdm/domain-map | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
>> index 304e91010a..7fc7fda68f 100644
>> --- a/contrib/gitdm/domain-map
>> +++ b/contrib/gitdm/domain-map
>> @@ -5,6 +5,7 @@
>>   #
>>     amd.com         AMD
>> +cmss.chinamobile.com China Mobile
>>   citrix.com      Citrix
>>   greensocs.com   GreenSocs
>>   fujitsu.com     Fujitsu
>>


--
Alex Benn=C3=A9e

