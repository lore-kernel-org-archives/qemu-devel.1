Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A57C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9045206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 08:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7jNbXVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9045206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip6mY-0000UZ-10
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 03:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ip6jG-0005de-Sh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ip6jF-0002jZ-7M
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:30:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47342
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ip6jF-0002iQ-3H
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 03:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578472212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=baISXU53UhGTYtnre16v17j1krf5mJgqONhzoZagMmk=;
 b=T7jNbXVO6X4NzPgWdujA9l7uyB0+Kp9A+m9kdoJ/3uyCUdYM0fcTzk3Hqg5eXkmlFcQvyk
 tso/KCFYuMnYSAs7NF7cQ3RTfb1ob37nqUqbWY9yTAlGAhc4pSRMmvFs7abNCOyx8RPqYw
 dKCtDLDEiIu4pX1wZ7IrWn6Fp1n1YuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-ZyTwLNVCMeSK_RBMR0BB6Q-1; Wed, 08 Jan 2020 03:30:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40B6C1005512;
 Wed,  8 Jan 2020 08:30:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-114.ams2.redhat.com [10.36.117.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2F5910013A7;
 Wed,  8 Jan 2020 08:29:58 +0000 (UTC)
Subject: Re: [PATCH v2 02/10] ppc: Remove stub of PPC970 HID4 implementation
To: BALATON Zoltan <balaton@eik.bme.hu>, Greg Kurz <groug@kaod.org>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-3-david@gibson.dropbear.id.au>
 <20200107183215.09ce18c6@bahia.lan> <20200107183638.1c84f172@bahia.lan>
 <alpine.BSF.2.21.99999.352.2001071900510.93471@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d4211f26-0b85-aebb-9ce6-53411a3c0992@redhat.com>
Date: Wed, 8 Jan 2020 09:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.99999.352.2001071900510.93471@zero.eik.bme.hu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZyTwLNVCMeSK_RBMR0BB6Q-1
X-Mimecast-Spam-Score: 0
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 qemu-ppc@nongnu.org, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 19.05, BALATON Zoltan wrote:
> On Tue, 7 Jan 2020, Greg Kurz wrote:
>> On Tue, 7 Jan 2020 18:32:15 +0100
>> Greg Kurz <groug@kaod.org> wrote:
>>
>>> On Tue,=C2=A0 7 Jan 2020 15:48:19 +1100
>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>
>>>> The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor
>>>> capability.
>>>> However, it can be (and often was) strapped into "Apple mode", where
>>>> the
>>>> hypervisor capabilities were disabled (essentially putting it always i=
n
>>>> hypervisor mode).
>>
>> Isn't it supervisor mode instead of hypervisor mode ?
>=20
> By the way, do you know if this strapping is hardware or software based?
> So is it the firmware that disables it on Apple hardware or is it some
> CPU pin connected somewhere on the motherboard or it's within the CPU
> and cannot be changed? I wonder if it's theoretically possible to
> re-enable it on an Apple G5 or we would likely never see a PowerPC 970
> with HV enabled?

I don't know how Apple disabled it, but you can buy a used Terrasoft YDL
PowerStation if you want to see it in action.

 Thomas


