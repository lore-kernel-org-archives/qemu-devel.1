Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D2C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C4206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3nGz1Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC6BT-0004cg-6f
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 14:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC6Ag-0004ED-Gv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC6Ae-00074R-A0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:33:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC6Ae-00071O-4y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583951611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QXY0gqY94BzlUASCgeSSlkZSj9ucE2XC/TIrN2f+8qU=;
 b=Z3nGz1BlDwk0Wj2TIHhwQJirrS0Dz6Lv1SFmykyRg7eLAI+78sn5Aht1HA3wKBMS41TjGH
 dZjuOfOlVuXf/mS99gdifQhmUmP1oB8JFg1EFfkbQ4h/L0BJV1qrTXqgtkmMhY4plKqdeB
 N7ZR5ljCefgawi10l795xniFzQOdiB4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-dm0EUG7COBu5LZmRTBVeKA-1; Wed, 11 Mar 2020 14:33:24 -0400
X-MC-Unique: dm0EUG7COBu5LZmRTBVeKA-1
Received: by mail-wr1-f72.google.com with SMTP id p5so1320099wrj.17
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 11:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bVy5vtT5Pyxy46Nb0LmBYUR7AdvAIgC4u5tNZr/GHaA=;
 b=rGlDsW47DXPfJJxpL5ttMGpR+7NaT3ezd2xeUEcY5ewkgnL2UAt8ef5S5g6+q3YRr8
 w/OHWd8VugprDiotQ/opFoe7UMeHl4FimLblU8wHnv5waMedZ56o2za6y05TOqMG8kYF
 H5gXqs+mti/PHUA4zU0cgTH1C1PuX8UoHELeOhHgkCqGlMA3gqH/+QU/WKs4twxlHlKx
 9UUSTperCHXpeIPvHoxkrB88FXUgIZxP+EUmXcQ2IElM49u0uOjd9oHHNCOe7g87T+c5
 ld3XLexCHYcBhWQHan1VSxSLiUooBTvgxKiY7Vgn4DfoSafKfyEsVOqlr3c25yRpWjq5
 ZT3A==
X-Gm-Message-State: ANhLgQ0SuPDPAo0nGNCLQta4SaKGTq5Co6Mm4i6IDIEEoFjlOORCqIVX
 C2714XVuu1mywOt+ptXVwVuPMqir/dieTOvmFaHEN1mmMF/o3412zf8xadznVvdfuNRptd+aqFu
 Aot+ZfFsQLUQI4NQ=
X-Received: by 2002:a5d:6082:: with SMTP id w2mr5806332wrt.300.1583951603536; 
 Wed, 11 Mar 2020 11:33:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsJIgg5VZVB6ZRUOyb7onbArnj/B1Ntt59/Jp6FWSbBbal1JvCIhfltpb4JHnFJjB2m0zOvgw==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr5806315wrt.300.1583951603269; 
 Wed, 11 Mar 2020 11:33:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id f187sm6006705wme.31.2020.03.11.11.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 11:33:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] modules: load modules from versioned /var/run dir
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20200310145806.18335-1-christian.ehrhardt@canonical.com>
 <20200310145806.18335-2-christian.ehrhardt@canonical.com>
 <20200310154749.GK3234052@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff2363cc-9136-3fee-0c55-f7f386d2cf84@redhat.com>
Date: Wed, 11 Mar 2020 19:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310154749.GK3234052@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pkg-qemu-devel@lists.alioth.debian.org,
 Miroslav Rezanina <mrezanin@redhat.com>, qemu-devel@nongnu.org,
 Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 16:47, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 10, 2020 at 03:58:06PM +0100, Christian Ehrhardt wrote:
>> On upgrades the old .so files usually are replaced. But on the other
>> hand since a qemu process represents a guest instance it is usually kept
>> around.
>>
>> That makes late addition of dynamic features e.g. 'hot-attach of a ceph
>> disk' fail by trying to load a new version of e.f. block-rbd.so into an
>> old still running qemu binary.
>>
>> This adds a fallback to also load modules from a versioned directory in =
the
>> temporary /var/run path. That way qemu is providing a way for packaging
>> to store modules of an upgraded qemu package as needed until the next re=
boot.
>>
>> An example how that can then be used in packaging can be seen in:
>> https://git.launchpad.net/~paelzer/ubuntu/+source/qemu/log/?h=3Dbug-1847=
361-miss-old-so-on-upgrade-UBUNTU
>>
>> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1847361
>> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
>> ---
>>  configure     | 15 +++++++++++++++
>>  util/module.c | 14 ++++++++++++++
>>  2 files changed, 29 insertions(+)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel
>=20

Queued, thanks.

Paolo


