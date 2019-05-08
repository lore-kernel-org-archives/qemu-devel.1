Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C870C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003E121019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 07:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003E121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOGku-0000xA-88
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 03:12:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOGjt-0000L2-Rh
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOGjt-0003oo-2P
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hOGjs-0003oK-TP
	for qemu-devel@nongnu.org; Wed, 08 May 2019 03:11:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37D2A30832D1;
	Wed,  8 May 2019 07:11:40 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71C5B5C226;
	Wed,  8 May 2019 07:11:39 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-10-richard.henderson@linaro.org>
	<b2a1544e-bf3d-5d90-c6e5-df7f49664059@redhat.com>
	<ea815545-4603-fe68-2b2d-ca03f790c7ed@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d4a63fb0-b96a-bbb2-b14d-007490cdde9c@redhat.com>
Date: Wed, 8 May 2019 09:11:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ea815545-4603-fe68-2b2d-ca03f790c7ed@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 08 May 2019 07:11:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 09/24] ui/vnc: Use gcrypto_random_bytes
 for start_auth_vnc
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/05/2019 02:32, Richard Henderson wrote:
> On 5/7/19 3:49 AM, Laurent Vivier wrote:
>>>  =C2=A0 =C2=A0 void start_auth_vnc(VncState *vs)
>>>  =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 make_challenge(vs);
>>> +=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (qcrypto_random_bytes(vs->challenge, sizeof(vs=
->challenge), &err)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_vnc_auth_fail(vs, v=
s->auth, "cannot get random bytes",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 error_get_pretty(err));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 authentication_failed(vs)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>
>> This part is weird for me: if auth fails we send "vnc_write_u32(vs, 1)=
" but if
>> it succeeds we send the challenge. There is no success value to send (=
like
>> "vnc_write_u32(vs, 0)") ?
>=20
> There is, but this code is a mess of callbacks.  In this case it happen=
s toward
> the end of protocol_client_auth_vnc:
>=20
>     2604         trace_vnc_auth_pass(vs, vs->auth);
>     2605         vnc_write_u32(vs, 0); /* Accept auth */
>     2606         vnc_flush(vs);
>=20

ok, thanks.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


