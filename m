Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D923C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BD62468A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gexzkmSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BD62468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KaI-0002rA-HL
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7KZS-0001tj-Pd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7KZR-00081J-Is
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:55:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7KZR-000817-FA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582815325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9eNi2peYHZPJfYXRhA8i4Fb9dBX8NpiN40uahLQT4k=;
 b=gexzkmSr5JAmMCg7rc2hzHgFZe4/n1lGzSeE+owaEWFl+UuwsVIGuKYvfMXyUso7A1mY4m
 N2uRByvyeLf9U+f2zP+c2Ooj4NQETNCpb9ObVVB3xxuaN0nm5AZOr6JfmUD2UDpWkZ1hxn
 QVAk33Zkqy6NhdJ4OoBQ/M5YXicBeBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-dRiw_tMuPQe1VYBSEtaYtw-1; Thu, 27 Feb 2020 09:55:19 -0500
X-MC-Unique: dRiw_tMuPQe1VYBSEtaYtw-1
Received: by mail-wm1-f71.google.com with SMTP id z7so1110004wmi.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:55:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2/ZRfOQ7WqLtuvUDJFisKVaNyUNpTJkzJ5nXj8kwHQ=;
 b=C68xNlygiYJsWPE2ezYRZueV4HMSb+sIsBiOFF2uHnm9F1M19Yjttmwb/eQWg94kKN
 cDWeFe1+itUomPaSLnu/9slngs2+QOCiE+qybNlcYRT5EWz6/Xa44EqQglhfgVck91gj
 nQVniVrB3X3ZLQb2EBb5BFgy4gUeVnLNfzq34Q9vpyjArYQNEaqILMjzKf866u5RxKqe
 iYR9hyzK9FYPw1KJadpiut3xWNiqbSS4ZSQBWpsjF4vezmsaVsYeFDX2Cz/oH+tcMDnS
 EMNDUVWwrS4oALlzyfPXH5+4rx9KRv1GorbJ7KZGz+NfvOUUDrcaaxykM05esFgVekcH
 npjg==
X-Gm-Message-State: APjAAAWkhxlz1DwGBB+c1dxn5N4IJDVrQfVFsdF4bNxh6LuG3kSRfo4B
 Stz5gi/fZKaBxYWDBD9KKBLPz5BLQW7Gpo12YBJcIqi5kVH7AuAujfMIPDmGZOgRArdSMYKfbYm
 HwLwkTROUPIpwWmg=
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr5553689wma.84.1582815318004; 
 Thu, 27 Feb 2020 06:55:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVQbNBqhdbLlpp7R9DdI7G2+O2CD7REx25LFxfnRchFeJBCFIhYUFEZ2zZXGxUaOt7crUAeg==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr5553671wma.84.1582815317777; 
 Thu, 27 Feb 2020 06:55:17 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s8sm8565729wrt.57.2020.02.27.06.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:55:17 -0800 (PST)
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
To: Markus Armbruster <armbru@redhat.com>
References: <20200227134019.6218-1-philmd@redhat.com>
 <87tv3cozfw.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
Date: Thu, 27 Feb 2020 15:55:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87tv3cozfw.fsf@dusky.pond.sub.org>
Content-Language: en-US
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 3:52 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> This fixes when adding a 'Since' tag:
>>
>>    In file included from qapi/qapi-schema.json:105:
>>    qapi/machine.json:25:1: '@arch:' can't follow 'Notes' section
>=20
> I'm confused.  This error is detected in scripts/qapi/parser.py, and it
> is fatal.  Is the build broken for you?  It isn't for me.  Moreover,
> where is @arch?  I can't see it anywhere close to the two spots the
> patch patches.

I get the error after trying to fix what Eric commented here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg682344.html

>=20
>>
>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v2: Fix another occurrence in CpuInstanceProperties (Liam Merwick)
>> ---
>>   qapi/machine.json | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6c11e3cf3a..3d8b5324f3 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -16,11 +16,11 @@
>>   # individual target constants are not documented here, for the time
>>   # being.
>>   #
>> +# Since: 3.0
>> +#
>>   # Notes: The resulting QMP strings can be appended to the "qemu-system=
-"
>>   #        prefix to produce the corresponding QEMU executable name. Thi=
s
>>   #        is true even for "qemu-system-x86_64".
>> -#
>> -# Since: 3.0
>>   ##
>>   { 'enum' : 'SysEmuTarget',
>>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32'=
,
>> @@ -820,13 +820,13 @@
>>   # @die-id: die number within node/board the CPU belongs to (Since 4.1)
>>   # @core-id: core number within die the CPU belongs to# @thread-id: thr=
ead number within core the CPU belongs to
>>   #
>> +# Since: 2.7
>> +#
>>   # Note: currently there are 5 properties that could be present
>>   #       but management should be prepared to pass through other
>>   #       properties with device_add command to allow for future
>>   #       interface extension. This also requires the filed names to be =
kept in
>>   #       sync with the properties passed to -device/device_add.
>> -#
>> -# Since: 2.7
>>   ##
>>   { 'struct': 'CpuInstanceProperties',
>>     'data': { '*node-id': 'int',
>=20


