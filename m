Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639A422302
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7bJOCcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639A422302
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7QY-0005of-F8
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX7Oe-0004I5-8Y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX7Od-0003VK-7O
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:34:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45451
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX7Od-0003V1-3l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574184874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2Pir5K/w8ZUPavb0dlj/mAqFdzq8b7/QL6WoRwXbhY=;
 b=E7bJOCcgBgTD8NCLdBzQZCsI96za1CQCK0MJ8c3qbBOnhF/v/v2jbnYzew8hfvUNV4NC5F
 u4FBy7JKSNQ5XvpV/EY7mqvq+Y1DBUFenXaZ14H0cXyw7ujOJZt2YtY60aBDsAj7f0lffy
 8eh8hQRh3K0qHhvx65H8bafc1O19+yU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-LZy46tYIPU6oX1hk6WSGEQ-1; Tue, 19 Nov 2019 12:34:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42928802A60;
 Tue, 19 Nov 2019 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1351E6919B;
 Tue, 19 Nov 2019 17:34:23 +0000 (UTC)
Subject: Re: [PATCH 2/6] iotests: Skip test 079 if it is not possible to
 create large files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-3-thuth@redhat.com>
 <7242d268-6563-246f-4acc-2e714ebfd513@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <06a31aff-e01b-74ae-3d9a-ff0f8ea2696b@redhat.com>
Date: Tue, 19 Nov 2019 18:34:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <7242d268-6563-246f-4acc-2e714ebfd513@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: LZy46tYIPU6oX1hk6WSGEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 18.29, Philippe Mathieu-Daud=E9 wrote:
> On 11/19/19 6:08 PM, Thomas Huth wrote:
>> Test 079 fails in the arm64, s390x and ppc64le LXD containers, which
>> apparently do not allow large files to be created. Test 079 tries to
>> create a 4G sparse file, so check first whether we can really create
>> such files before executing the test.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =A0 tests/qemu-iotests/079 | 6 ++++++
>> =A0 1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
>> index 81f0c21f53..e9b81419b7 100755
>> --- a/tests/qemu-iotests/079
>> +++ b/tests/qemu-iotests/079
>> @@ -39,6 +39,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =A0 _supported_fmt qcow2
>> =A0 _supported_proto file nfs
>> =A0 +# Some containers (e.g. non-x86 on Travis) do not allow large files
>> +if ! truncate --size=3D4G "$TEST_IMG"; then
>=20
> Shouldn't we restrict that to Travis-CI by checking some environment var?

I'd rather like to keep it independent from Travis environment
variables, since somebody might want to run "make check" in other
non-Travis containers or on weird filesystems, and then the test should
ideally not fail, but simply skip, too.

 Thomas


