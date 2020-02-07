Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5FC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138E320726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVK9zzlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138E320726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00OJ-00085t-95
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j00NH-0006b6-4H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j00NF-0000rZ-Vn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:56:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j00NF-0000rP-SV
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581069393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Z4vSjjsokUivvYk+WWl6qmV1m+wsuP1VTe2XrcBlYjI=;
 b=MVK9zzltt/mIU2Ocuf6DV+9saFilQNr8Lju6y/3euM4YIzkQHMcdxFwgajubzqPlc9L8l9
 dygI0ypPu9ljncOC9PrQDiuDtiprZujyByb2wISnX0ajDrbsSexu5i0ih95DSJzgla+rqh
 IGhRWfvO4xufqHFC65P+iFp23CuXPB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-5LagyxBCPwqTRScpY134_g-1; Fri, 07 Feb 2020 04:56:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9965102CE14;
 Fri,  7 Feb 2020 09:56:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-143.ams2.redhat.com [10.36.116.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06A5C89F08;
 Fri,  7 Feb 2020 09:56:20 +0000 (UTC)
Subject: Re: [PATCH] travis.yml: Test the s390-ccw build, too
To: Cornelia Huck <cohuck@redhat.com>
References: <20200206202543.7085-1-thuth@redhat.com>
 <20200207104751.36609b11.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1a263ca4-68fd-2afc-ddf9-ed7231467b94@redhat.com>
Date: Fri, 7 Feb 2020 10:56:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207104751.36609b11.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5LagyxBCPwqTRScpY134_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/2020 10.47, Cornelia Huck wrote:
> On Thu,  6 Feb 2020 21:25:43 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> Since we can now use a s390x host on Travis, we can also build and
>> test the s390-ccw bios images there. For this we have to make sure
>> that roms/SLOF is checked out, too, and then move the generated *.img
>> files to the right location before running the tests.
>=20
> Oh, nice.
>=20
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .travis.yml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 6c0ec6cf69..c0eeff9caa 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -508,6 +508,16 @@ matrix:
>>        env:
>>          - TEST_CMD=3D"make check check-tcg V=3D1"
>>          - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU=
_TARGETS},s390x-linux-user"
>> +      script:
>> +        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
>> +        - BUILD_RC=3D0 && make -j${JOBS} || BUILD_RC=3D$?
>> +        - |
>> +          if [ "$BUILD_RC" -eq 0 ] ; then
>> +              mv pc-bios/s390-ccw/*.img pc-bios/ ;
>> +              ${TEST_CMD} ;
>=20
> Out of curiousity: Which kind of tests are run for the net image?

The tests/qtest/pxe-test.c test exercises the netboot.
(and tests/qtest/cdrom-test.c execises booting from disk)

We could maybe add also add more complex test in "check-acceptance"
later, but that's something for another day...

 Thomas


