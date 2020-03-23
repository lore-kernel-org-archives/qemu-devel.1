Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7592EC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8E3206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5Yb79yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8E3206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJzu-00031I-Aa
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGJz5-0002Kz-NF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGJz1-0000k7-E1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:07:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGJz1-0000k0-Ab
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584958019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgoomDDiQZ4SDHMaJdUuXOJ8EwLaBp6kYuyvQpi60+o=;
 b=G5Yb79yKpaF6E40b9gHE4HauwP1otdwLldDeanXtrBEfcY13C48/jscEKAnGsuPFPNQIaM
 qYiMAZjQPyzOUYeHKKQhmgCeoz9kpY0smS4pjDUyOhovHLXTdD41qooTP3dvVf+HHVAwcO
 cY6pVn8AbH+sbsIe+bTzw2wtMSf8Ifk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-zrLQSUiJPdKFsDlR-nwCYQ-1; Mon, 23 Mar 2020 06:06:57 -0400
X-MC-Unique: zrLQSUiJPdKFsDlR-nwCYQ-1
Received: by mail-ed1-f71.google.com with SMTP id m24so11123609edq.8
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h739mvRWSGriVmWymJzcpRG3Lmmsw34o1u+UuFq5DcY=;
 b=hKOyMgg8OMxQHYcgugHh+5xid2JIVqfbOfhhY6JeqQaeKzMOjh9u29pVuiDZsjDLMU
 Iig8viPk3yqW1QFvT9F8PYWn0kXJD5qcFbo+9gxoIeASXNkxUtyMdrZAEnjxGgVJkNI7
 7o/72rTXIpBgtybnLNh70sHMpNPqzkFV1m2/or00208cBtpRNvyJykJNYAywv6vpp8LX
 t7jK4O8IU8EwfEIlvoXQJ2sOq493vYuaLvPm+EpchsqMJjRpWfDWMRKqXlDszGxvAPRl
 HfIMXAcHNY364tq1oz3FgP7F6qANiBgT+SUNSLG9C1mHdbxhA/5xA2KZF+7dncgQPtjy
 mECw==
X-Gm-Message-State: ANhLgQ2PLfOTFwnmlnPdTJTFodz6ewM7PvQ5aA/xAc9l3aPEs61anNIb
 CI5SppVosFAT+cs1SvaDLtIBM79VVxwQrdsLI6RDLMih2LP9txyU7eF6dK+eEz/Q42/RYu5OOXb
 e9YemrKPKDnC1UOc=
X-Received: by 2002:aa7:dd51:: with SMTP id o17mr20944317edw.271.1584958015923; 
 Mon, 23 Mar 2020 03:06:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuFVPoMteRmC3UpcUEUmtnjBQmjce6DObRVlRrKhSsHkQqBfV/K9tLUC8RR7lzlykmunCXmzQ==
X-Received: by 2002:aa7:dd51:: with SMTP id o17mr20944294edw.271.1584958015661; 
 Mon, 23 Mar 2020 03:06:55 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id bo17sm404653edb.22.2020.03.23.03.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 03:06:55 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 0/4] tests/docker: Fixes for 5.0
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200322120104.21267-1-philmd@redhat.com>
 <87mu87bdfk.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7770131-7cc2-0fa7-a039-17258703e8e8@redhat.com>
Date: Mon, 23 Mar 2020 11:06:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87mu87bdfk.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 10:58 AM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Easy fixes for our Docker images.
>=20
> Queued to testing/next, thanks.

Thanks, but I think Aleksandar wanted to review patch 2/4 "tests/docker:=20
Install gcrypt devel package in Debian image" and now I notice I forgot=20
to Cc him, oops...

>=20
>>
>> Since v1:
>> - Reword gcrypt patch description (requested by Aleksandar)
>>
>> Philippe Mathieu-Daud=C3=A9 (4):
>>    tests/docker: Keep package list sorted
>>    tests/docker: Install gcrypt devel package in Debian image
>>    tests/docker: Use Python3 PyYAML in the Fedora image
>>    tests/docker: Add libepoxy and libudev packages to the Fedora image
>>
>>   tests/docker/dockerfiles/centos7.docker      |  6 ++++--
>>   tests/docker/dockerfiles/debian-amd64.docker |  1 +
>>   tests/docker/dockerfiles/fedora.docker       | 10 +++++++---
>>   3 files changed, 12 insertions(+), 5 deletions(-)
>=20
>=20


