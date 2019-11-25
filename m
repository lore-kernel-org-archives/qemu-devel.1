Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206C520679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhO51wDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206C520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGid-00086F-A0
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZGbo-0000Jh-PI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZGbn-0001lI-M2
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:49:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29159
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZGbn-0001l7-IH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOSks2dXMf57jQvMMsKxQLAqAQcPAWDwQE+afiL78Hw=;
 b=UhO51wDzGqF8z0kQRX1uSTsbH5d07HFAFV1c+CG9dsVoHOLHIs56xmoiz5coYwL9jK0JqL
 DW1q0SbHoJxUTbTBmVNGDYopeShmNOMsn1wuEuxC/B6PnVDdDzWviqDKH82NB05UYyoz7v
 gWkaN0/emSp95xBYIX85oXxeFN1Mh54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-cgnxt3udPui4qAakA_Qi9w-1; Mon, 25 Nov 2019 10:48:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44C1B1801B8A;
 Mon, 25 Nov 2019 15:48:58 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 597AE67E41;
 Mon, 25 Nov 2019 15:48:31 +0000 (UTC)
Subject: Re: [libvirt] [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
 <20191125154021.GI4157473@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cddf6ffc-9753-7a69-e02d-4c192dd78343@redhat.com>
Date: Mon, 25 Nov 2019 09:48:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125154021.GI4157473@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cgnxt3udPui4qAakA_Qi9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 9:40 AM, Daniel P. Berrang=C3=A9 wrote:

>> Please don't start any deprecation process. This requires certain
>> consultation within my company. Rest assured that everyone's opinion wil=
l
>> be taken into account while doing consiltation.
>=20
> The idea of having a deprecation process is precisely to
> allow time for people like to provide feedback before any
> deletion takes place. So this is not a reason to delay
> starting of deprecation.
>=20
> The process lasts for 2 releases before we delete anything:
>=20
>    https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>=20
> When we start the clock now, it is deprecated when 5.0 releases
> in April 2020, and still deprecated with 5.1 in August 2020.
>=20
> The code won't be deleted until Sep 2020 when 5.2 dev cycle opens,
> and there's still time to undelete it right up until the 5.2 feature
> freeze in late Oct 2020. That's 11 months away, which is plenty of
> time for feedback IMHO.

And that's the soonest it could be removed. If your consultation reports=20
back that it is still needed, we can reverse the decision to deprecate=20
or extend the deprecation to last longer, as needed, rather than blindly=20
removing at the first possible moment.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


