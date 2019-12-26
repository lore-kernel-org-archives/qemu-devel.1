Return-Path: <SRS0=LSdK=2Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ECDC2D0DA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 14:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2DD20828
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2019 14:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yo76YOXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2DD20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikTlq-0005IU-LZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Dec 2019 09:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ikTkx-0004qg-Am
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 09:04:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ikTku-0002XI-OR
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 09:04:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56931
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ikTku-0002Vl-BR
 for qemu-devel@nongnu.org; Thu, 26 Dec 2019 09:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577369082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8IUPTeGV0tsZkJU3wzdZIMQVHMfn+XgOh4seywZKH1c=;
 b=Yo76YOXiHSnkrgoYDQj6e+niiNVMDsNR1tL4aZRaKei9JDALN/ZPczLSc4WaoF6HUr8o9E
 qRM2iC7BnjQjltq+HTAwraUg0ABGriV8ySKGzZ90sW00hMWsiFJUadUb5DSMftMYkDYku0
 KPh+cYuqDftDgFuYHqBdu3XbuAeQHzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-Y68DMVhQOnmXiaTN0q04xQ-1; Thu, 26 Dec 2019 09:04:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A3DADB20;
 Thu, 26 Dec 2019 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-71.gru2.redhat.com
 [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDDB31C4;
 Thu, 26 Dec 2019 14:04:34 +0000 (UTC)
Subject: Re: [PATCH v8 1/4] Acceptance tests: introduce BLD_DIR, SRC_DIR and
 LNK_DIR
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-2-crosa@redhat.com>
 <3362e435-73be-f5c3-a672-6208f2bacd95@redhat.com>
 <20191219002539.GA29918@localhost.localdomain>
 <1d90bf81-7acb-f80c-959f-95ab8fee899b@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f060662b-f364-e618-c33f-c2d8cbc334e1@redhat.com>
Date: Thu, 26 Dec 2019 12:04:33 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1d90bf81-7acb-f80c-959f-95ab8fee899b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Y68DMVhQOnmXiaTN0q04xQ-1
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/19/19 9:12 AM, Philippe Mathieu-Daud=E9 wrote:
> On 12/19/19 1:25 AM, Cleber Rosa wrote:
>> On Thu, Dec 19, 2019 at 01:02:39AM +0100, Philippe Mathieu-Daud=E9 wrote=
:
>>> On 12/19/19 12:24 AM, Cleber Rosa wrote:
>>>> Some tests may benefit from using resources from a build directory.
>>>> This introduces three variables that can help tests find resources in
>>>> those directories.
>>>>
>>>> First, a BLD_DIR is assumed to exist, given that the primary form of
>>>> running the acceptance tests is from a build directory (which may or
>>>> may not be the same as the source tree, that is, the SRC_DIR).
>>>
>>> Can we name this BUILD_DIR?
>>>
>>
>> Yes, of course.
>>
>>> This would be more in line with the other buildsys files=20
>>> (configure/make).
>>>
>>
>> That's a good point.
>>
>>>> If the directory containing the acceptance tests happens to be a link
>>>> to a directory (kept as LNK_DIR), it's assumed to it points to the
>>>> source tree (SRC_DIR), which is the behavior defined on the QEMU
>>>> Makefiles.=A0 If the directory containing the acceptance tests is not =
a
>>>> link, then a in-tree build is assumed, and the BLD_DIR and SRC_DIR are
>>>> the same and LNK_DIR is set None.
>>>
>>> Similarly, can we name this CURRENT_DIR instead of LNK_DIR?
>>>
>>
>> Yes, or maybe even drop it?=A0 TBH, I can only see use cases for build
>
> I haven't checked why you needed to add it, so if we don't need it,=20
> let's drop it :)


1+ for dropping LNK_DIR variable.

Thanks,

Wainer


>
>
>> and source dirs.=A0 So, I assume you'd propose SRC_DIR would be
>> SOURCE_DIR?
>
> This one is understandable as it, but SOURCE_DIR is cleaner indeed.
>
> Thanks,
>
> Phil.
>
>


