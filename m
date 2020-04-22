Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9ABC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182102076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqHJmzRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182102076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGiF-0001Ta-8x
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRGhI-0000lv-Sr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRGhH-0005Vo-SP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:49:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRGhH-0005Qq-Dw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587566993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpAQ5/VOwdiaxtUzsmN+iqDTXIS8Izs1wdHhMylr3mA=;
 b=OqHJmzRBz5MHLYNdElUtKv/4jcHCfVEii6DZV95BiSS+n6MG/R4gRnvfOvU8CFDHpKLgKX
 WGx/MlV12gRYaIm0h5Ly4nD5dOzs2Zgjh0j7o/NUaWTmKkLon72Lo3vDkHI4UESvt3FuxZ
 PrJKcQSNUFaPBmug/qj9lAaz0sMjWT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-d4dcimGmPQWsnxyyY_V-iw-1; Wed, 22 Apr 2020 10:49:44 -0400
X-MC-Unique: d4dcimGmPQWsnxyyY_V-iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 323211009600
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 14:49:43 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE16D5D9E2;
 Wed, 22 Apr 2020 14:49:42 +0000 (UTC)
Subject: Re: [PATCH v2 12/14] tests/test-logging: Fix test for -dfilter
 0..0xffffffffffffffff
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-13-armbru@redhat.com>
 <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3b33f4de-dfeb-416f-1e48-ddb73153205d@redhat.com>
Date: Wed, 22 Apr 2020 09:49:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8b72369a-482c-a32f-648d-050c22dadf2e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 8:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Markus,
>=20
> On 4/22/20 3:07 PM, Markus Armbruster wrote:
>> Fixes: 58e19e6e7914354242a67442d0006f9e31684d1a
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> =C2=A0 tests/test-logging.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/test-logging.c b/tests/test-logging.c
>> index 6387e4933f..8580b82420 100644
>> --- a/tests/test-logging.c
>> +++ b/tests/test-logging.c
>> @@ -73,10 +73,10 @@ static void test_parse_range(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(qemu_log_in_addr_range(UINT64_MA=
X));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_false(qemu_log_in_addr_range(UIN=
T64_MAX - 1));
>> -=C2=A0=C2=A0=C2=A0 qemu_set_dfilter_ranges("0..0xffffffffffffffff", &er=
r);
>> +=C2=A0=C2=A0=C2=A0 qemu_set_dfilter_ranges("0..0xffffffffffffffff", &er=
ror_abort);
>=20
> Why sometime use this form, ...

This call must not produce an error (if it does, the test aborts,=20
proving we had a bug).

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(qemu_log_in_addr_range(0));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(qemu_log_in_addr_range(UINT64_MA=
X));
>> -
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_set_dfilter_ranges("2..1", &err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free_or_abort(&err);
>=20
> ... and then this other form?

This call must produce an error (if we do not diagnose the caller's=20
error, our code is buggy, and the test must fail)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


