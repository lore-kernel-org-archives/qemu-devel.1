Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48371C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1ED21019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1ED21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOGjw-00008S-BJ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 03:11:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOGiv-0007h2-Js
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOGiu-0003P0-Qp
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hOGiu-0003Nx-Lo
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:10:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96F473086214;
	Wed,  8 May 2019 07:10:39 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E391627D8;
	Wed,  8 May 2019 07:10:38 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-14-richard.henderson@linaro.org>
	<c9f9ca4f-d6b5-0225-96d5-ebbb78c10c4b@redhat.com>
	<7e900a3b-303d-8271-2f6b-199b09d75551@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ea5e5236-75ec-18ca-96fd-218fb32f118c@redhat.com>
Date: Wed, 8 May 2019 09:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7e900a3b-303d-8271-2f6b-199b09d75551@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 08 May 2019 07:10:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 13/24] linux-user: Call qcrypto_init if
 not using -seed
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/2019 06:11, Richard Henderson wrote:
> On 5/7/19 7:13 AM, Laurent Vivier wrote:
>>> -=C2=A0=C2=A0=C2=A0 if (seed_optarg !=3D NULL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_guest_random_seed_ma=
in(seed_optarg, &error_fatal);
>>> +=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (seed_optarg !=3D NULL=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q=
emu_guest_random_seed_main(seed_optarg, &err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* ??? Assumes qcrypto is only used by qemu_guest_getrandom.=C2=A0 */
>>
>> perhaps you can add a qemu_guest_random_init() function close to this
>> assumption to call qcrypto_init()? So we will not forget to change thi=
s if we
>> use something else in the future.
>=20
> I'm not sure what you're suggesting.
>=20
> Why would putting qcrypto_init within qemu_guest_random_init make it mo=
re
> likely that, if something else within linux-user required qcrypto routi=
nes, we
> would remember to remove qemu_guest_random_init and call qcrypto_init e=
xactly once?

Why would we need qcrypto routines rather than qemu_guest_getrandom()?
The idea was if  qemu_guest_getrandom() stops to use qcrypto we don't=20
forget to remove this call.

But it's only cosmetic, so:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


