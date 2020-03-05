Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5856C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F579208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkpyreFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F579208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9sQq-0000O7-M0
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j9sPw-0008H2-3D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j9sPu-00013u-HB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:28:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j9sPu-00012i-CX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583422085;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ltEaftIAwBsKDFG9iTR7+L/C2sXjivId4aEz/aWFWo=;
 b=UkpyreFh+Gc9cb0/OfOTUbuE4DY6tgd3pnb+UFih1rIhG4In7YbnR3OPWpkwMwSMZt8OFG
 zeITjNJZeZT0ZAiBvGp6B/gQdLD4oZXhJM+qyN3KXh47lm0tbzOw8kXgmIurnNO6WY7+1F
 gJcLi4KTYuIsh/ibBdzdGjpdTFLH6BU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-rbJF5UUaMNm4p_D3IJ2_wA-1; Thu, 05 Mar 2020 10:28:04 -0500
X-MC-Unique: rbJF5UUaMNm4p_D3IJ2_wA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C01B3800D50;
 Thu,  5 Mar 2020 15:28:02 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 406C860BE0;
 Thu,  5 Mar 2020 15:28:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] configure: Improve zstd test
In-Reply-To: <87imji6eio.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Thu, 05 Mar 2020 14:51:43 +0000")
References: <20200305103427.157658-1-quintela@redhat.com>
 <87imji6eio.fsf@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 05 Mar 2020 16:27:57 +0100
Message-ID: <87h7z2g6te.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Reply-To: quintela@redhat.com
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> There were one error on the test (missing an s for --exists).
>> But we really need a recent zstd (0.8.1).
>> That version was released in 2016, so it is newer that some of our travi=
s
>> images.  Just check for the version that we need.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  configure | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 7b373bc0bb..1bf48df1ef 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2464,7 +2464,8 @@ fi
>>  # zstd check
>> =20
>>  if test "$zstd" !=3D "no" ; then
>> -    if $pkg_config --exist libzstd ; then
>> +    libzstd_minver=3D"0.8.1"
>> +    if $pkg_config --atleast-version=3D$libzstd_minver libzstd ; then
>>          zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>>          zstd_libs=3D"$($pkg_config --libs libzstd)"
>>          LIBS=3D"$zstd_libs $LIBS"
>
> Hmm still breaks with:
>
>    make docker-test-build@ubuntu J=3D9 V=3D1

Thanks.

> With:
>
>   FY_SOURCE=3D2 -g   -c -o monitor/qmp.o /tmp/qemu-test/src/monitor/qmp.c
>   /tmp/qemu-test/src/migration/multifd-zstd.c: In function 'zstd_send_pre=
pare':
>   /tmp/qemu-test/src/migration/multifd-zstd.c:125:9: error: unknown type =
name 'ZSTD_EndDirective'; did you mean 'ZSTD_DDict'?
>            ZSTD_EndDirective flush =3D ZSTD_e_continue;
>            ^~~~~~~~~~~~~~~~~

Greate, more things were introduced later.
As it would be too easy, the zstd repository is not lineal, you need to
checkout the tag you want to see when something has been introduced.

Will try to get this fixed.

Sorry for the inconveniences.


>   Version: 1.3.8+dfsg-3
>   Depends: libzstd1 (=3D 1.3.8+dfsg-3)
>   Description: fast lossless compression algorithm -- development files

I don't undertsand now.

ZSTD_EndDirective was included in 1.3.0.

I can just change that for 1.3.9, but I don't know why is that there.
Could you do a grep ZSTD_EndDirective /usr/lib/zstd.h?

Or if there is some documentation that shows how to use that docker
images.

Later, Juan.


