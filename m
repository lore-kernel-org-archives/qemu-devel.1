Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26716C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E155120767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPwVJRPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E155120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIJ1-0006BT-3c
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRIGj-0004Hl-Pu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRIGj-0006XV-7x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:30:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRIGi-0006VZ-QY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587573035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJX0OkQxPpf1nPddMxnAgP1HJXlkGOLvLB9LKM893YI=;
 b=DPwVJRPl4rJnwbgN0bWgIMczDcu/ZOSWkrQLWpMMWl99O+P/dH/P+Ecri/3ZlP4IFwLGI+
 JUOo76DAEP71gtN6FwWrs/5LNMU5xDv2CZ+ricIHjrZFHQH75OMhudh8f1Zva6zUdNJpfW
 kJGhehs8Vcd8FzKbDkyIykPOtuV5ccE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-QNVPv1gDM9mEfzDicNEAGg-1; Wed, 22 Apr 2020 12:30:34 -0400
X-MC-Unique: QNVPv1gDM9mEfzDicNEAGg-1
Received: by mail-wm1-f69.google.com with SMTP id n17so1070586wmi.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y6Z+D/LbPc/KBXkkSexTbNEFknRfsBYZ95rh7tawKvg=;
 b=UwUeQt3m/3itMCbpRxVFXsk7wiRBEUGdtgXxOPJxu4s5nisc5roDIQjO4c0b7RXKjK
 0yhB9KTn5SCWlKb6fdOT8Zn4nNba4ty4AKoC1jj3MrLe8Uk4Fht31ZIG7dYFExMv9cnw
 XKkGB9oalXw/CHgj2zsFdUOePkGBAgjs8Gf7Sy/Ovo2NYQXn0wiD0s2U4MjtYkhru5PK
 AoccvqwoVdvHyDS0K2+JSyovJxnLOwePH2t7PnOhJ1JaSnjaS6RMT+ApWyqxAFGXR7xF
 qXmIWrkiL1DtA6aB41SC/lh3yw45QTvkerNtYfOfGBX3JKRF+6038F2c+Ek+7MjtJ4eT
 O4KA==
X-Gm-Message-State: AGi0Pub58IyGcnYs6MwEPUHK1aCd2zswEyD1gTPgt9gVbDD8NTKkq+yO
 VrNlaeyJINWeS6NOHRLBpJB4y2Fys/Pf8wTv2twteF8upvNduISl74KtDq5Hnbn40ZQP/Q4pkQ4
 pG1RAaPoiwDNGbH8=
X-Received: by 2002:adf:97de:: with SMTP id t30mr27798654wrb.135.1587573032605; 
 Wed, 22 Apr 2020 09:30:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJhyMx4u5q9MHtl+f998pjiON86YiPWNFHC7sZvMaCaEw7XWGgolfdMdT5e7bsKDIyy+5WvOg==
X-Received: by 2002:adf:97de:: with SMTP id t30mr27798593wrb.135.1587573031659; 
 Wed, 22 Apr 2020 09:30:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h1sm8849906wme.42.2020.04.22.09.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:30:31 -0700 (PDT)
Subject: Re: [PATCH v2 12/14] tests/test-logging: Fix test for -dfilter
 0..0xffffffffffffffff
To: Markus Armbruster <armbru@redhat.com>
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-13-armbru@redhat.com>
 <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com>
 <87v9lrv98n.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <98d906a1-a918-e858-a7fa-a94a8cdad81a@redhat.com>
Date: Wed, 22 Apr 2020 18:30:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9lrv98n.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 4/22/20 5:19 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Hi Markus,
>>
>> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>>> Fixes: 58e19e6e7914354242a67442d0006f9e31684d1a
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    tests/test-logging.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/test-logging.c b/tests/test-logging.c
>>> index 6387e4933f..8580b82420 100644
>>> --- a/tests/test-logging.c
>>> +++ b/tests/test-logging.c
>>> @@ -73,10 +73,10 @@ static void test_parse_range(void)
>>>        g_assert(qemu_log_in_addr_range(UINT64_MAX));
>>>        g_assert_false(qemu_log_in_addr_range(UINT64_MAX - 1));
>>>    -    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &err);
>>> +    qemu_set_dfilter_ranges("0..0xffffffffffffffff", &error_abort);
>>
>> Why sometime use this form, ...
>>
>>>        g_assert(qemu_log_in_addr_range(0));
>>>        g_assert(qemu_log_in_addr_range(UINT64_MAX));
>>> -
>>> +
>>>        qemu_set_dfilter_ranges("2..1", &err);
>>>        error_free_or_abort(&err);
>>
>> ... and then this other form?
>=20
> The first form crashes when the function sets an error.
>=20
> The second from crashes when the function doesn't set an error, or else
> frees the error.
>=20
> All clear?

Yes =3D) It is even documented!

  * Assert that an expected error occurred, but clean it up without
  * reporting it (primarily useful in testsuites):
  *     error_free_or_abort(&err);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


