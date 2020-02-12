Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D012C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD685206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh2d6h5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD685206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1nuk-00080Z-0s
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1nu3-0007YT-Ny
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1nty-0005ne-WE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:01:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1nty-0005nP-SP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581498106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=So42hqAGnO9fj3KU4JmVNAi2HbvwMmnZA5+c50zreDo=;
 b=Nh2d6h5lrnjYRutHv6emwNmj8f72DIbi8BEpwQzZleFPX5xJS8/AkhJ9bHcvILAckwVU9t
 jRCqs5sYWjhvHbjDm39iPmKo5skMbCtvNRu5KNQlSuaB6pBsdPLR9VgjDjhKWqj8bECpq4
 rlY19f2dJpIbfFqPYrKrJrZjf1Elcx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-e3o9AIYFNZKcuebDygc6Mg-1; Wed, 12 Feb 2020 04:01:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C875800D4C;
 Wed, 12 Feb 2020 09:01:43 +0000 (UTC)
Received: from [10.72.13.111] (ovpn-13-111.pek2.redhat.com [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 513B360BF4;
 Wed, 12 Feb 2020 09:01:34 +0000 (UTC)
Subject: Re: [PATCH 1/2] NetRxPkt: Introduce support for additional hash types
To: Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20200127115405.13459-1-yuri.benditovich@daynix.com>
 <DDDADB15-A1C8-40E6-A595-6A516F6E5831@gmail.com>
 <CAOEp5Oc8qYN=abgh5QYarvMPnG-BuC_isfHBw6V0FvbKvwe0JQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0a24ebf8-eabb-01b3-4c8e-2fd8b2c983e6@redhat.com>
Date: Wed, 12 Feb 2020 17:01:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oc8qYN=abgh5QYarvMPnG-BuC_isfHBw6V0FvbKvwe0JQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: e3o9AIYFNZKcuebDygc6Mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/12 =E4=B8=8B=E5=8D=884:50, Yuri Benditovich wrote:
> Hi Jason,
>
> Can you please review these 2 patches and apply if there are no objection=
s.
>
> Thanks,
> Yuri Benditovich


Applied.

Thanks




