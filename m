Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD30C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6192073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf24LCKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6192073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icV4t-0002Zl-EC
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icV4G-00026z-HY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icV4E-0003bj-Au
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:51:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icV4E-0003b3-03
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575467505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=p2FEE7Gn7YLh6/kTzVWkZiiIyM6EK6VOLNjp9yY0tZM=;
 b=Mf24LCKQ+llXsj9uM0Qipm/owRbcnt/JDjdkxsJMier+z7b9wBMKBUhzhPF2Bsc1tQX2jc
 E9rreg1uFmzedWOSiQSfWD7YGYkcKP9nm/StwLHomjURzVPriW3cXmiy2ypcMxeoeKNX62
 jnaFNmSTgNaeY0HoGMWECN0ls///FUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-E1VgE3nnNXmic74qdHr2PA-1; Wed, 04 Dec 2019 08:51:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C69C78BD3B0;
 Wed,  4 Dec 2019 13:51:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63140691B7;
 Wed,  4 Dec 2019 13:51:37 +0000 (UTC)
Subject: Re: [PATCH v3] travis.yml: Run tcg tests with tci
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <87lfrtbtj6.fsf@linaro.org>
 <20191204083133.6198-1-thuth@redhat.com> <87muc88amd.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ce570051-eb8f-4184-8f1e-bb9ba3652f62@redhat.com>
Date: Wed, 4 Dec 2019 14:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87muc88amd.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: E1VgE3nnNXmic74qdHr2PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/2019 14.48, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> So far we only have compile coverage for tci. But since commit
>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>> for INDEX_op_ld16u_i64") has been included now, we can also run the
>> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
>> Since we don't gain much additional test coverage by compiling all
>> targets, and TCI is broken e.g. with the Sparc targets, we also limit
>> the target list to a reasonable subset now (which should still get us
>> test coverage by tests/boot-serial-test for example).
>=20
> Queued to testing/next, thanks.

Thanks! But could you maybe s/--enable-debug/--enable-debug-tcg/ as
Richard just suggested in his mail? Or want me to send a v4?

 Thomas


