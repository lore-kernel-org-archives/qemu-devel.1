Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE56E20866
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 08:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRV0EFUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE56E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA8h5-0006d4-W8
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 03:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1jA8gJ-0005qb-In
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1jA8gI-00020i-7g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:50:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1jA8gI-0001w7-3T
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 03:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583484605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JAlr59J7wONsILeUjB8F1sjGwaXVlSm4K8ZCjsOmptY=;
 b=dRV0EFUJ0L/GIdQaxHIbtbn8EEUXcqLpPp0H6RYIfNQl323bn1TO4PC376uefz8nhAjiC2
 DiKqmOFBI/wBr033N7ZvVBdWRwKc7yrDUfh6poHilO/yXwdppLOoZGJax+FzEvVyajK+ZS
 aap63D7VvqaXdQh1P9UgV91RdkLJ0wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-sB2tFOZ4PKuG2ivL4qYzpw-1; Fri, 06 Mar 2020 03:50:03 -0500
X-MC-Unique: sB2tFOZ4PKuG2ivL4qYzpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE0D107ACCA;
 Fri,  6 Mar 2020 08:50:02 +0000 (UTC)
Received: from [10.40.205.44] (ovpn-205-44.brq.redhat.com [10.40.205.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80EC31001902;
 Fri,  6 Mar 2020 08:50:01 +0000 (UTC)
Subject: Re: [PATCH] configure: Improve zstd test
To: quintela@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200305103427.157658-1-quintela@redhat.com>
 <87imji6eio.fsf@linaro.org> <87h7z2g6te.fsf@secure.laptop>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <5b2ff215-ef9c-2981-5467-b79ad7af7a34@redhat.com>
Date: Fri, 6 Mar 2020 09:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87h7z2g6te.fsf@secure.laptop>
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5. 3. 2020 16:27, Juan Quintela wrote:
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> There were one error on the test (missing an s for --exists).
>>> But we really need a recent zstd (0.8.1).
>>> That version was released in 2016, so it is newer that some of our trav=
is
>>> images.  Just check for the version that we need.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  configure | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 7b373bc0bb..1bf48df1ef 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2464,7 +2464,8 @@ fi
>>>  # zstd check
>>> =20
>>>  if test "$zstd" !=3D "no" ; then
>>> -    if $pkg_config --exist libzstd ; then
>>> +    libzstd_minver=3D"0.8.1"
>>> +    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
>>>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>>>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>>>          LIBS=3D"$zstd_libs $LIBS"
>>
>> Hmm still breaks with:
>>
>>    make docker-test-build@ubuntu J=3D9 V=3D1
>=20
> Thanks.
>=20
>> With:
>>
>>   FY_SOURCE=3D2 -g   -c -o monitor/qmp.o /tmp/qemu-test/src/monitor/qmp.=
c
>>   /tmp/qemu-test/src/migration/multifd-zstd.c: In function 'zstd_send_pr=
epare':
>>   /tmp/qemu-test/src/migration/multifd-zstd.c:125:9: error: unknown type=
 name 'ZSTD_EndDirective'; did you mean 'ZSTD_DDict'?
>>            ZSTD_EndDirective flush =3D ZSTD_e_continue;
>>            ^~~~~~~~~~~~~~~~~
>=20
> Greate, more things were introduced later.
> As it would be too easy, the zstd repository is not lineal, you need to
> checkout the tag you want to see when something has been introduced.
>=20
> Will try to get this fixed.
>=20
> Sorry for the inconveniences.
>=20
>=20
>>   Version: 1.3.8+dfsg-3
>>   Depends: libzstd1 (=3D 1.3.8+dfsg-3)
>>   Description: fast lossless compression algorithm -- development files
>=20
> I don't undertsand now.
>=20
> ZSTD_EndDirective was included in 1.3.0.
>=20
> I can just change that for 1.3.9, but I don't know why is that there.
> Could you do a grep ZSTD_EndDirective /usr/lib/zstd.h?

Thing is, they have so called experimental APIs. You get them only if
you define ZSTD_STATIC_LINKING_ONLY before including zstd.h. So the
plain grep of a symbol tells us nothing. We need to check if it's not in
#ifdef. Looks like 1.3.9 is the minimal version which has everything we
want.

Michal


