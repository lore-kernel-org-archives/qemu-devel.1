Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D481C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54AD206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54AD206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIX01-0000KF-DY
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWpz-00059o-Mw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWpy-0007vj-II
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWpy-0007vM-9p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:42:30 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68FDD69084
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:42:29 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id o8so2510279wmc.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dO50rGa5s7OXTG5VGdHfyey22rtFDO/NsLBek7cOw4=;
 b=QVGS+WZKfkfIk/SjEsTgHKkj4Ql8HQKx97z1n2pFEazmnBJ7j0G6QAfFslI/+IxoK2
 dm7Uj6tr9t/de0r0jBXC+5PcM4Gc26nkmk7/U/0PNk9wu2VwTcJlduSqEUcRe4vfOsnv
 +Do/wNa88QfiZ1KFAJii9l2UgkeqXpeJU3nyy1IQnIkwt4qipoEo4PhkuOJEyQKl8vQy
 l4TUFrT6A9hSl7OU1QE/eVvmfjgCXiAeOrJBERX8npXNJ9iQxKOP3wDNUvKSdWA23ede
 LOtL9lGn3pQXQ7mwoCrg6J+merA/N2v5oPlBLzKg+v0aYacP5xRD8amr5dSvtsVynD5k
 zUnA==
X-Gm-Message-State: APjAAAVhge7VgBYPhHpPujp59wIzITy98AGNLw7ehr5ZdQ2EntrMWJMw
 5t+3jiPTg4wROkkIi9CcSDegLfjFed5WDsrmB3I/AX7FIdBpwOjQmxT3DDqwel3KLPzaOdUNQW9
 e7vxalzlaaEhkzQk=
X-Received: by 2002:a7b:ce07:: with SMTP id m7mr7468873wmc.117.1570707748132; 
 Thu, 10 Oct 2019 04:42:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSfNv41CgNc7hLGs1AZBJ8KJLdk5gufq5w8Z1yUh27hgSkLoT5PjPhQZKyzOWI9CAJxPkKDQ==
X-Received: by 2002:a7b:ce07:: with SMTP id m7mr7468855wmc.117.1570707747956; 
 Thu, 10 Oct 2019 04:42:27 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id r10sm6831401wml.46.2019.10.10.04.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:42:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] IDE: deprecate ide-drive
To: Peter Krempa <pkrempa@redhat.com>
References: <20191009224303.10232-1-jsnow@redhat.com>
 <20191009224303.10232-2-jsnow@redhat.com>
 <518ae20b-049d-19ee-1e86-c48466ba0655@redhat.com>
 <20191010112650.GR6129@angien.pipo.sk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <10bb29c8-2375-25cd-af67-edddca1be5d7@redhat.com>
Date: Thu, 10 Oct 2019 13:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191010112650.GR6129@angien.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 1:26 PM, Peter Krempa wrote:
> On Thu, Oct 10, 2019 at 13:22:37 +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 10/10/19 12:43 AM, John Snow wrote:
>>> It's an old compatibility shim that just delegates to ide-cd or ide-h=
d.
>>> I'd like to refactor these some day, and getting rid of the super-obj=
ect
>>> will make that easier.
>>>
>>> Either way, we don't need this.
>>>
>>> Libvirt-checked-by: Peter Krempa <pkrempa@redhat.com>
>>
>> Peter made a comment regarding Laszlo's Regression-tested-by tag:
>>
>>    [...] nobody else is using
>>    this convention (there are exactly 0 instances of
>>    "Regression-tested-by" in the project git log as far as
>>    I can see), and so in practice people reading the commits
>>    won't really know what you meant by it. Everybody else
>>    on the project uses "Tested-by" to mean either of the
>>    two cases you describe above, without distinction...
>>
>> It probably applies to 'Libvirt-checked-by' too.
>=20
> I certainly didn't test it. So feel free to drop that line altogether.

But you reviewed it, can we use your 'Reviewed-by' instead?

