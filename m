Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC91AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FB12070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLU5NUW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FB12070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZVT-0004lx-LW
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itZUX-00041b-WA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itZUR-0008QL-Qf
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:01:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21927
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itZUR-0008PW-Fr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579536081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=X9rETscvFTLTa8L6yAsP2C6y+lufGJg4QaWW3FA/hak=;
 b=gLU5NUW89PB/dXhrQF0KzLbOgj8dA1Pghc7qkAyFo3BIBxGHHTnCDmB9s3PdS/vtOfD6fj
 093qIE7j6NyPQXf7TWMdKonMpsY2snZ6eEdjDs4b4NHaki1Rum+DlfY5VzlpjUNF5KNVsl
 sA5OO68NoUXVsbRdVJPJxpfjNptOzR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-EeYzpL-XODq62zEroGzhnQ-1; Mon, 20 Jan 2020 11:01:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28F31107ACCD;
 Mon, 20 Jan 2020 16:01:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A171D60BF4;
 Mon, 20 Jan 2020 16:01:14 +0000 (UTC)
Subject: Re: [PATCH v4 3/6] iotests: Test 183 does not work on macOS and
 OpenBSD
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
 <20191202101039.8981-4-thuth@redhat.com>
 <99340090-0575-9b4e-4156-dac823e34be3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f6ada5b9-3164-78da-5ab4-4d87af7cb071@redhat.com>
Date: Mon, 20 Jan 2020 17:01:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <99340090-0575-9b4e-4156-dac823e34be3@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EeYzpL-XODq62zEroGzhnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/2020 15.36, Max Reitz wrote:
> On 02.12.19 11:10, Thomas Huth wrote:
>> In the long term, we might want to add test 183 to the "auto" group
>> (but it still fails occasionally, so we cannot do that yet). However,
>> when running 183 in Cirrus-CI on macOS, or with our vm-build-openbsd
>> target, it currently always fails with an "Timeout waiting for return
>> on handle 0" error.
>>
>> Let's mark it as supported only on systems where the test is working
>> fine (i.e. Linux, FreeBSD and NetBSD).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/183 | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
>> index bced83fae0..0bbae13647 100755
>> --- a/tests/qemu-iotests/183
>> +++ b/tests/qemu-iotests/183
>> @@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  . ./common.filter
>>  . ./common.qemu
>> =20
>> +_supported_os Linux FreeBSD NetBSD
>=20
> I don=E2=80=99t suppose you have data on OpenBSD?

I've checked it with our "make vm-build-openbsd" target (see patch
description) and it was failing there in the same way as on macOS.

> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!

 Thomas


