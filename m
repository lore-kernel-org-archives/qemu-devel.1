Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6996022CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996022CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Mvu-0000nE-Gj
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Mqf-0004LM-RE
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Mqd-0006fx-A8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Mqd-0006f3-0V
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:00:31 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32DE88667D
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:00:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id x13so1909913wmj.9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MxqtFGEIkvxFPA2bTMn4lpuM+RWUjv3q+0Y26Y4S0CI=;
 b=e47cqcP1OTiNRXL526YXkg0fOhjuiaXbYMkIVIbXs95d7K3QYYsxIrx2iKNsKICh8X
 e2ktfqp7cT6tMSvVnCvKLJvxrco3Yl2Rbu3ihpbyx3NJIqRTC3ZMQnHV/eRx0IONLHts
 JxQRJuh7rm68KvVjcC3BjX5d16/mtLkRImgx4GFpu+69PDysGXFbWiPwOzMHNz7d0bKI
 Sha5Drn9wZumYJ+X1dvLBpVVDNWeoXipdP3w47UpBg3eWq2CtxtXmYx4vxTBUhFJgnR0
 X525BS1hlvUCwZi72jJDkGjNh4MHMEyOvRUVxernJeoVT73Aq07BN2+ldH2kYRvvZO3K
 zhvg==
X-Gm-Message-State: APjAAAWum8Fmhi5O9LBvPw8I+Tlyuxx0e56n/3OMNQAWSgzYsKV/fOiK
 sfZcibhd9NhsNNu2InQ1RaxkPln5aCpGRcqzg6H8uJ9py1ZyHFUu5DpzkmlldbsDlf/SA/h2RAw
 oUeQ6xB3N5/iYoA0=
X-Received: by 2002:adf:a415:: with SMTP id d21mr9445033wra.94.1567094428965; 
 Thu, 29 Aug 2019 09:00:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwf+6ebe7A95fuZHc1KDd1dRYOWlo7KzN9ttYeQkmowXZMR7MktGDoB5AFtxVS9Gp12YdXl+Q==
X-Received: by 2002:adf:a415:: with SMTP id d21mr9445002wra.94.1567094428761; 
 Thu, 29 Aug 2019 09:00:28 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id n12sm4191286wmc.24.2019.08.29.09.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:00:28 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>, slirp@lists.freedesktop.org,
 Petr Matousek <pmatouse@redhat.com>, Vishnu Dev TJ <vishnudevtj@gmail.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
 <20190822183313.pptfwjsnrpdi6tfp@function>
 <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
 <20190825225403.vwg2fhfff6i7gnwd@function>
 <a032c557-7f1e-c710-f25a-e42200f0cf91@redhat.com>
 <f7ce663c-0235-3585-f324-9bc74bc3b383@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fa96984f-df2b-6b9a-8fd9-cd7cb9eb2e86@redhat.com>
Date: Thu, 29 Aug 2019 18:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f7ce663c-0235-3585-f324-9bc74bc3b383@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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

On 8/29/19 5:53 PM, Philippe Mathieu-Daud=E9 wrote:
> On 8/29/19 5:43 PM, Philippe Mathieu-Daud=E9 wrote:
>> On 8/26/19 12:54 AM, Samuel Thibault wrote:
>>> Philippe Mathieu-Daud=E9, le ven. 23 ao=FBt 2019 17:15:32 +0200, a ec=
rit:
>>>>> Did you make your test with commit 126c04acbabd ("Fix heap overflow=
 in
>>>>> ip_reass on big packet input") applied?
>>>>
>>>> Yes, unfortunately it doesn't fix the issue.
>>>
>>> Ok.
>>>
>>> Could you try the attached patch?  There was a use-after-free.  Witho=
ut
>>> it, I can indeed crash qemu with the given exploit.  With it I don't
>>> seem to be able to crash it (trying in a loop for several minutes).
> [...]
>>
>> Note 2: We miss some Makefile rules in QEMU with the libslirp split.
>>
>> Checkouting branches in the slirp/ directory doesn't trigger recompili=
ng
>> the slirp object, and even if I force the creation of the libslirp.a
>> archive, the QEMU binaries are not linked again with the refreshed arc=
hive.
>=20
> And I hit the same issue after applying your patch =3D)
>=20
> So, using a clean workspace, I can not reproduce the null deref anymore=
.
>=20
> If you send a proper patch, feel free to add:
>=20
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

I was going to suggest to also add:

  Reported-by: Quan Wenli <wquan@redhat.com>

But you answered in another thread that this patch was already commited
3 days ago as:

https://gitlab.freedesktop.org/slirp/libslirp/commit/d203c81b

