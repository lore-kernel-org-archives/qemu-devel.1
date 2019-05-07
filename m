Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E868C04AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642D22087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642D22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1lc-0004ZQ-Kg
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:12:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO1iT-0002Jh-T8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO1iT-0007Eo-2y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hO1iQ-0007Ag-Tj; Tue, 07 May 2019 11:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59A1B300414B;
	Tue,  7 May 2019 15:09:09 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 256B8611C3;
	Tue,  7 May 2019 15:09:07 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-20-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <9b3d7d8f-c5f6-c320-3100-2f55a2d486d5@redhat.com>
Date: Tue, 7 May 2019 17:09:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 15:09:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 19/24] hw/misc/bcm2835_rng: Use
 qemu_guest_getrandom_nofail
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
Cc: qemu-arm@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 19:33, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.  Use the *_nofail routine
> instead of rolling our own error handling locally.
>=20
> Cc: qemu-arm@nongnu.org
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/misc/bcm2835_rng.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>



