Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749A82082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPzTB81Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749A82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfAN-0005ZQ-Ig
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihf7F-0001Zq-EG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihf7D-0005Nm-0I
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihf7C-0005Ka-KL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576697770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=GiprSwdHZ/Z6TSNz/6DxrHEnQe0kiuxGby8tvQrTjLc=;
 b=EPzTB81Y8skjfkM8vtZC19G/vLoAopcKCqiCdGhCb9O2jLqpkek2qR5EHg6R8Ckl5oztFb
 eNpNo/i58IDeB7izjH8GmxsZiTC7bVin+uzCNHCYsDMt1tOg0YpmgSOcvpt2OuwXkIkvmF
 isv92fl4CRIZ5fIzSfrQ9FM/2kY09K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-WxuNooOsNP2TC_FJfZ2PFQ-1; Wed, 18 Dec 2019 14:35:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E8C4102CE16;
 Wed, 18 Dec 2019 19:35:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56DAE5D9E2;
 Wed, 18 Dec 2019 19:35:50 +0000 (UTC)
Subject: Re: [PATCH 3/6] hw/net/imx_fec: Rewrite fall through comments
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191217173425.5082-1-philmd@redhat.com>
 <20191217173425.5082-4-philmd@redhat.com>
 <2fc74b64-0a0b-c437-e925-4c16d3907da7@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <54e5071f-b5c2-3cc7-514c-ecc2b7e2bed4@redhat.com>
Date: Wed, 18 Dec 2019 20:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2fc74b64-0a0b-c437-e925-4c16d3907da7@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: WxuNooOsNP2TC_FJfZ2PFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/2019 18.55, Thomas Huth wrote:
> On 17/12/2019 18.34, Philippe Mathieu-Daud=C3=A9 wrote:
>> GCC9 is confused by this comment when building with CFLAG
>> -Wimplicit-fallthrough=3D2:
>>
>>   hw/net/imx_fec.c: In function =E2=80=98imx_eth_write=E2=80=99:
>>   hw/net/imx_fec.c:906:12: error: this statement may fall through [-Werr=
or=3Dimplicit-fallthrough=3D]
>>     906 |         if (unlikely(single_tx_ring)) {
>>         |            ^
>>   hw/net/imx_fec.c:912:5: note: here
>>     912 |     case ENET_TDAR:     /* FALLTHROUGH */
>>         |     ^~~~
>>   cc1: all warnings being treated as errors
>>
>> Rewrite the comments in the correct place,  using 'fall through'
>> which is recognized by GCC and static analyzers.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Peter Chubb <peter.chubb@nicta.com.au>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: qemu-arm@nongnu.org
>> ---
>>  hw/net/imx_fec.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
>> index bd99236864..30cc07753d 100644
>> --- a/hw/net/imx_fec.c
>> +++ b/hw/net/imx_fec.c
>> @@ -901,15 +901,17 @@ static void imx_eth_write(void *opaque, hwaddr off=
set, uint64_t value,
>>              s->regs[index] =3D 0;
>>          }
>>          break;
>> -    case ENET_TDAR1:    /* FALLTHROUGH */
>> -    case ENET_TDAR2:    /* FALLTHROUGH */
>> +        /* fall through */
>=20
> Wrong location. And I think you don't need any comment here at all, GCC
> should stay silent without it?
>=20
>> +    case ENET_TDAR1:
>> +    case ENET_TDAR2:
>>          if (unlikely(single_tx_ring)) {
>>              qemu_log_mask(LOG_GUEST_ERROR,
>>                            "[%s]%s: trying to access TDAR2 or TDAR1\n",
>>                            TYPE_IMX_FEC, __func__);
>>              return;
>>          }
>> -    case ENET_TDAR:     /* FALLTHROUGH */
>> +        /* fall through */
>=20
> I'd suggest to simply remove it, too.

/me needsmorecoffee

... of course this hunk was fine. Good that you kept it in v2.

 Thomas


>> +    case ENET_TDAR:
>>          if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
>>              s->regs[index] =3D ENET_TDAR_TDAR;
>>              imx_eth_do_tx(s, index);
>>
>=20
>  Thomas
>=20


