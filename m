Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB82FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B60920679
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwGJdW41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B60920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6m1-0007gp-Bm
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT6ho-0003m3-Qd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT6hj-0001sy-IW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:01:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT6hj-0001sX-F3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573228903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUlgg9jYPeHHhzAT9ex6+phlaDNDoBjIcEqIvMR7eLo=;
 b=MwGJdW41egX8doGJqMiTxfsHvJu0onscYMkpqr5pHH1G9Wg15bFsOJjc0t3nv1NYvBs2om
 qQaLrgbvj882XuR7VoE30rXVOBBB/3mh01Z94Whu9jE2I03IWAMN3Hdxu1E21z1DIoj67S
 WgOrBBg1ZxG1YmRDGKTrfc+h+wM1htM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-1iEvLjoYPm28XLUufqAENw-1; Fri, 08 Nov 2019 11:01:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DA3F477;
 Fri,  8 Nov 2019 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FCBA60BE1;
 Fri,  8 Nov 2019 16:01:34 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] configure: Detect compiler support for
 __attribute__((alias))
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-4-richard.henderson@linaro.org>
 <87tv7wly54.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd04e1f1-c3ca-e826-06d8-96df2d770045@redhat.com>
Date: Fri, 8 Nov 2019 17:01:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87tv7wly54.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1iEvLjoYPm28XLUufqAENw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/10/2019 16.04, Alex Benn=C3=A9e wrote:
>=20
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
>> Such support is present almost everywhere, except for Xcode 9.
>> It is added in Xcode 10, but travis uses xcode9 by default,
>> so we should support it for a while yet.
>=20
> We really should get someone who has an AppleID to check what the
> support period is because if Apple don't care about Xcode9 anymore I
> doubt we should.

The page at https://docs.travis-ci.com/user/reference/osx/ has a nice=20
list which Xcode versions are used with which macOS versions.
Xcode10 was also available for macOS 10.13 (which is likely the oldest=20
macOS version that we care about), so I think we can assume that macOS=20
users that are still using 10.13 can upgrade to xcode10.1 if they want=20
to compile QEMU.

  Thomas


