Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E600C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 05:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 227842073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 05:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1/GR12O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 227842073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWCky-0002w5-8z
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 01:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWCkP-0002WA-Ij
 for qemu-devel@nongnu.org; Wed, 06 May 2020 01:37:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWCkN-0007BE-Ts
 for qemu-devel@nongnu.org; Wed, 06 May 2020 01:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588743450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXCN4P9IZmmuI8MXYbSLdzdyPX1pUZemuh42Racv59I=;
 b=E1/GR12OFo+5mwaB4jpAKXzYWevY/PH+A6JE+KSTZRTyl2SytdfCTIx778WdBaJ2rwJF82
 Hhb3NR+mLFdBwSNVWYvrlO1JRKU6Abhevm3PXqrA1OTPZdFfJve4tBimlfDUip3wNXIi/g
 QCOgw77SHBdkqMvENceIztAzK/JZ8GM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-DotkeWrsN6itHpcSBgPhLA-1; Wed, 06 May 2020 01:37:28 -0400
X-MC-Unique: DotkeWrsN6itHpcSBgPhLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F791835B40;
 Wed,  6 May 2020 05:37:27 +0000 (UTC)
Received: from [10.72.13.165] (ovpn-13-165.pek2.redhat.com [10.72.13.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8E9B5C1BD;
 Wed,  6 May 2020 05:37:22 +0000 (UTC)
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
 <20200331102004-mutt-send-email-mst@kernel.org>
 <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <90f00200-da2d-a8d6-a734-fc08e2e5313a@redhat.com>
Date: Wed, 6 May 2020 13:37:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOEp5OeOcTZM_b254LxX5=jRiiAkGSoLsbMeiMjPs2OoF1MxNA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Yan Vugenfirer <yan@daynix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/1 =E4=B8=8B=E5=8D=8812:01, Yuri Benditovich wrote:
> Michael/Jason,
>
> As Linux headers was updated in qemu and now include RSC/RSS/Hash=20
> definitions, please let me know what you prefer:
> 1. You apply this series as is, then I submit clean-up series that=20
> will remove all the redundant defines from virtio-net.c
> 2. I post v8 of this series with cleanup of all the redundant defines=20
> and also RSC ones
> 3. Something other


Hi Yuri:

Though I've queued this series but consider we have new headers, I think=20
it's better to post v8.

Thanks


