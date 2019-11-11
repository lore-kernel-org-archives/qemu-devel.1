Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FC2C17445
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F98721655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSI94oPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F98721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAsJ-0000oE-Jy
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUArK-0000BP-4z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUArJ-0007O9-4t
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:40:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUArJ-0007O0-1H
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573483200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YsHntkrrrmM2NHDD36K1LYYsBqC2Hl8XAXwVlvs9i2E=;
 b=MSI94oPSjM5IR8AaEMJpFHTQ24Hgm0/KUQxuLyZlxHTvElGU/IDs2L1UeYPCGgZsoGc+Lg
 DuxKaFiWHRGxtXQ2+V6G1zmRhD9GHpBDGeX6Bd3Q/iJDtwyl9jCtZUwQM9a/rTwNOze5IE
 sLaFj0DIsDge2Z40z4Az0xKZVIo81h0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-OVaYc1PTOQyZel_Ukl4cRw-1; Mon, 11 Nov 2019 09:39:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55F551034B4B;
 Mon, 11 Nov 2019 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 984CF171C0;
 Mon, 11 Nov 2019 14:39:53 +0000 (UTC)
Subject: Re: [PATCH] tests/migration: use the common library function
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191111125530.26579-1-alex.bennee@linaro.org>
 <cd4917d6-75b7-2c47-0c6b-07dda077c52e@redhat.com> <878soma4ev.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <97fd0943-586c-035f-b33b-eb6b2eb3dde6@redhat.com>
Date: Mon, 11 Nov 2019 15:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <878soma4ev.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OVaYc1PTOQyZel_Ukl4cRw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/2019 15.11, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 11/11/2019 13.55, Alex Benn=C3=A9e wrote:
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> Could you please add at least a short patch description? (Why is this
>> change necessary / a good idea?)
>=20
> It's just a minor clean-up Dave happened to comment on last week. Using
> the helper function is preferable given it abstracts away any system
> differences for the same information.

But this also changes the behavior on non-Linux systems (i.e. the *BSDs
and macOS), since they will now use getpid() instead of gettid ... is
that the intended change here?

 Thomas

>>> ---
>>>  tests/migration/stress.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
>>> index 0c239646934..915389b53ae 100644
>>> --- a/tests/migration/stress.c
>>> +++ b/tests/migration/stress.c
>>> @@ -31,7 +31,7 @@ const char *argv0;
>>>
>>>  static int gettid(void)
>>>  {
>>> -    return syscall(SYS_gettid);
>>> +    return qemu_get_thread_id();
>>>  }
>>>
>>>  static __attribute__((noreturn)) void exit_failure(void)
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20


