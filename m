Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4BC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1542148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1542148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJEXE-0007aV-74
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 05:49:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJEVV-0006e3-Ap
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJEUk-0000Gy-DE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:47:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>)
	id 1hJEUh-0008Kt-Ih; Wed, 24 Apr 2019 05:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BA1EC0B1B48;
	Wed, 24 Apr 2019 09:47:04 +0000 (UTC)
Received: from [10.72.12.170] (ovpn-12-170.pek2.redhat.com [10.72.12.170])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF55860C70;
	Wed, 24 Apr 2019 09:46:57 +0000 (UTC)
To: Dan Streetman <dan.streetman@canonical.com>
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
	<9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
	<CAOZ2QJO5-V4xydkVxKTC-1qnhqhUEMck04D=6+PFkhP9Z9+vmA@mail.gmail.com>
	<ec53494d-99fc-d7b2-987d-ccd79ee47652@redhat.com>
	<CAOZ2QJMKO8_8ygcycNf7xVWYWE8GX1PAk7hePB9D8Q5XCq1=yA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ade59025-3c49-b9f9-673b-8d9c397037d2@redhat.com>
Date: Wed, 24 Apr 2019 17:46:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOZ2QJMKO8_8ygcycNf7xVWYWE8GX1PAk7hePB9D8Q5XCq1=yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 24 Apr 2019 09:47:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?marcandre=2elureau=40redhat=2ecom_=3e=3e_Marc-Andr=c3=a9_Lurea?=
	=?UTF-8?Q?u?= <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424094655.dfDHue30Ufb5WlxAIAFhkhUKrvb5hh90pQwfPjAsqjY@z>


On 2019/4/23 =E4=B8=8B=E5=8D=884:49, Dan Streetman wrote:
>> I think so if net_vhost_user_event() was called in main thread (it cal=
ls
>> qemu_get_current_aio_context()).
> ok, I'll check that, thanks!
>
> I think my other patch, to remove the vhost_user_stop() call
> completely from the net_vhost_user_event() handler for
> CHR_EVENT_CLOSED, is still relevant; do you have thoughts on that?
>

I think that patch makes sense.

Thanks


