Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FEAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9FE214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB3tHJMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9FE214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXP5-0005li-EX
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixXNr-0004z1-7J
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixXNp-0000NJ-Ak
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:34:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixXNp-0000Mg-7c
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580481296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LRTYOfSzUI7IvFQFNd/G3GV2Gn6CYOO37wdU+i1zns=;
 b=CB3tHJMkd+bWwzLYHQBN1oNBISU6sS6Croii05gIloKYCNjRbHuMV3Zow/ss1WnD1DUuAO
 6PAFKA3trZnowp4ayfjFIGTVbCLg8gdQZ7JfLWAXJAgL5NtfI5S2hLsPxeY4e5ODqRww9H
 z7yVqxM7g7TLzZD8Cb9qEuz7bCvzWQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-_Ye6qxGzMgONudY67LPlEw-1; Fri, 31 Jan 2020 09:34:49 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so2897156wmh.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 06:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iKFNlRYHVPVxxpxtJCNxnWPl+IaTzDbpEEN0trYD/Aw=;
 b=DBz4pPdiCAPW5Sq9C4EDMMOBcBnK8VSLP/Jhaueh+JSGznp9VPxb0CfgQXyQPN5pk3
 cL1y2X4RZermlPBkLHlI/QRzDcVBpCHqfRzfX8RNMTezQfyIcvke62lf5IQe5DvzqdZ5
 HafgdAOVjziM07WgpT2lFMFug1KLrlDTU2S0DD163FhU1O11onp9ajZb3k/crD+kygkJ
 9EC/qU75MNGffMyl8U6JQ3FmJMEV8msauFRFOGZC7nnbwCJt9JLa5EWJwl9Hz6/2nrzQ
 rhKv0VF/7tKdNZIw7PWAWcrMFY7QQN5QUxQRh8wkClplBKGxfEi+ByvmPk+23XAFu8LG
 xwMg==
X-Gm-Message-State: APjAAAX6C//W0MbhOzjo/irkzrRPcJntehF7YMkp4/nK3T3NkqhIBNL2
 xJGBFfL/keRLMRMb2uVf990yoCovdHdoGY1LTcy38TaGSS4gRjeASU2YYcG1i9cops7gTOnVY+u
 96GYBhaO0kFtDLt0=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr12973753wmc.9.1580481288698;
 Fri, 31 Jan 2020 06:34:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9UREW3UtSu/WiYqfB2y8+oSbA/EKMH/pbttHhQHVR0tEz3mZzFtlYQVWcd4NZquBa0j3sLw==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr12973732wmc.9.1580481288401;
 Fri, 31 Jan 2020 06:34:48 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a132sm10736255wme.3.2020.01.31.06.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 06:34:47 -0800 (PST)
Subject: Re: [PATCH v5 5/6] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200121095205.26323-1-thuth@redhat.com>
 <20200121095205.26323-6-thuth@redhat.com>
 <ef7deb82-e2da-f572-8e17-aaf59b34dd4c@redhat.com>
 <5490675f-bb3c-dd69-6b16-da2ff10c52bd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c412bf53-52ab-d3cc-525a-a7cc1693a562@redhat.com>
Date: Fri, 31 Jan 2020 15:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5490675f-bb3c-dd69-6b16-da2ff10c52bd@redhat.com>
Content-Language: en-US
X-MC-Unique: _Ye6qxGzMgONudY67LPlEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 8:08 AM, Thomas Huth wrote:
> On 30/01/2020 23.31, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/21/20 10:52 AM, Thomas Huth wrote:
>>> We are going to enable some of the python-based tests in the "auto"
>>> group,
>>> and these tests require virtio-blk to work properly. Running iotests
>>> without virtio-blk likely does not make too much sense anyway, so inste=
ad
>>> of adding a check for the availability of virtio-blk to each and every
>>> test (which does not sound very appealing), let's rather add a check fo=
r
>>> this a central spot in the "check" script instead (so that it is still
>>> possible to run "make check" for qemu-system-tricore for example).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  =C2=A0 tests/qemu-iotests/check | 12 ++++++++++--
>>>  =C2=A0 1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>>> index 2890785a10..1629b6c914 100755
>>> --- a/tests/qemu-iotests/check
>>> +++ b/tests/qemu-iotests/check
>>> @@ -642,7 +642,15 @@ fi
>>>  =C2=A0 python_usable=3Dfalse
>>>  =C2=A0 if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >=3D =
(3,6)
>>> else 1)'
>>>  =C2=A0 then
>>> -=C2=A0=C2=A0=C2=A0 python_usable=3Dtrue
>>> +=C2=A0=C2=A0=C2=A0 # Our python framework also requires virtio-blk
>>> +=C2=A0=C2=A0=C2=A0 if "$QEMU_PROG" -M none -device help | grep -q virt=
io-blk
>>>> /dev/null 2>&1
>>
>> FYI I proposed a patch adding a binary_get_devices() helper:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg07314.html
>>
>> You could use something such
>>
>>  =C2=A0 @SkipUntil('virtio-blk' in binary_get_devices(qemu_bin))
>=20
> Unfortunately, that doesn't scale here. You'd have to add this to almost
> all python-based iotests, since the virtio-blk dependency is hard-wired
> deep in the code there (look at the add_drive function).

I see.

Back to your patch:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


