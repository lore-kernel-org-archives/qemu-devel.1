Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A76C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C46D20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fidHzXdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9msT-0004hd-Lt
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j9mrC-0003aN-Qw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j9mrB-0007hj-MU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:31:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j9mrB-0007gN-In
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583400711;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gxvxE9PQ5nyT5u8+0fKoSxsNysTKTKdDfIzXeUDl8f8=;
 b=fidHzXdJLhmyHGzGTEdsrrd3qM0fnul/w2GGdNxEXMg9pE/5VYsJ/vtsSOhXUKfQpQ3h0r
 d5rwn1PKDGj7CGQQwzorS3xccIcqwsSB2ZPiUUxCPGIYPJR086psUyvAfuLHEGW5pQj+oW
 Z4kKBZrOBMzp3wKSca7X1/w5usXTCrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-bw2oTdkNMted_7XPQepq7A-1; Thu, 05 Mar 2020 04:31:47 -0500
X-MC-Unique: bw2oTdkNMted_7XPQepq7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF418010EC;
 Thu,  5 Mar 2020 09:31:46 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51C0390795;
 Thu,  5 Mar 2020 09:31:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] configure: change a typo in zstd config
In-Reply-To: <26715e80-32fa-5ebf-9f3b-c110f6c9b7fa@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Mar 2020 20:05:33
 +0100")
References: <20200303124925.28079-1-dplotnikov@virtuozzo.com>
 <878skhvbq0.fsf@secure.laptop>
 <26715e80-32fa-5ebf-9f3b-c110f6c9b7fa@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 05 Mar 2020 10:31:43 +0100
Message-ID: <871rq7gnb4.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: peter.maydell@linaro.org, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> On 3/3/20 1:56 PM, Juan Quintela wrote:
>> Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
>>> Package manager --exist flag is used instead of --exists.
>>> Fix it.
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> queued.
>
> It doesn't seem that trivial:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg684754.html

I think you need to do a make clean.

And I found why I didn't catch that problem.  Fedora pkg-config is soooo
intelligent:

$ pkg-config --exist libzstd; echo $?
0
$ pkg-config --exists libzstd; echo $?
0
$ pkg-config --exists libzstd33; echo $?
1
$ pkg-config --exist libzstd33; echo $?
1
$=20

I tried with libzstd-devel installed and uninstalled, with --enable-zstd
and --disable-zstd, and it always did the right thing for me.

Later, Juan.

>
>>
>> thanks.
>>
>>> ---
>>>   configure | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 7b373bc0bb..caa65f5883 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2464,7 +2464,7 @@ fi
>>>   # zstd check
>>>     if test "$zstd" !=3D "no" ; then
>>> -    if $pkg_config --exist libzstd ; then
>>> +    if $pkg_config --exists libzstd ; then
>>>           zstd_cflags=3D"$($pkg_config --cflags libzstd)"
>>>           zstd_libs=3D"$($pkg_config --libs libzstd)"
>>>           LIBS=3D"$zstd_libs $LIBS"
>>
>>


