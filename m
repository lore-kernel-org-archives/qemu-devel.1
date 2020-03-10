Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB15C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59CB120727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dptWWUK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CB120727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgX7-0007HM-Fz
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBgIy-0001cY-Hu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBgIx-0006GC-Hi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:56:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37465
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBgIx-0006Ej-DJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583852182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6Y9O3L6ux6zcyjxR98H17Ex0dxMm2pHA4GBIrRUtcw=;
 b=dptWWUK8xm+rNN/bFaX0eFQRYYXv+Fdc0PVCpHKn+PpKwkezxBCNjHbaHgv0LSOI7ka7/j
 yJUZVCQhQvKB87YmNWqz/rbeEmlsQ9WEIEdhb9GaYfJSDI7ivlXNxAKfKMFCFzVJEk1L50
 zF1dZyTEx1SkCZpiFydLu72UemmWBec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-sfzD9SM5NJ6iyJlr4oKb0Q-1; Tue, 10 Mar 2020 10:56:19 -0400
X-MC-Unique: sfzD9SM5NJ6iyJlr4oKb0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47CA919067E1;
 Tue, 10 Mar 2020 14:56:17 +0000 (UTC)
Received: from [10.36.117.85] (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6F5E5C28D;
 Tue, 10 Mar 2020 14:56:14 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v4 00/13] arm/arm64: Add ITS tests
To: Zenghui Yu <yuzenghui@huawei.com>, Andrew Jones <drjones@redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
 <20200309115741.6stx5tpkb6s6ejzh@kamzik.brq.redhat.com>
 <20200309120012.xkgmlbvd5trm6ewk@kamzik.brq.redhat.com>
 <5cfe64d3-e609-cd1e-4f92-e24cf5f62c77@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4a80c1d0-e33f-b1d9-c8d5-3a2fb01104db@redhat.com>
Date: Tue, 10 Mar 2020 15:56:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5cfe64d3-e609-cd1e-4f92-e24cf5f62c77@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 3/10/20 11:18 AM, Zenghui Yu wrote:
> On 2020/3/9 20:00, Andrew Jones wrote:
>> On Mon, Mar 09, 2020 at 12:57:51PM +0100, Andrew Jones wrote:
>>> This looks pretty good to me. It just needs some resquashing cleanups=
.
>>> Does Andre plan to review? I've only been reviewing with respect to
>>> the framework, not ITS. If no other reviews are expected, then I'll
>>> queue the next version.
>>
>> Oops, sorry Zenghui, I forgot to ask if you'll be reviewing again as
>> well.
>=20
> I'd like to have a look again this week if time permits :-).=C2=A0 Than=
ks
> for reminding me.
I have just sent:

[kvm-unit-tests PATCH v5 00/13] arm/arm64: Add ITS tests

where I took last Drew's comments

Thanks

Eric
>=20
>=20
> Zenghui
>=20


