Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E65C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F123218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F123218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxT8-0008Ic-B9
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFxRj-0007NN-7z
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFxRh-0002N0-7Y
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:30:51 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:33252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFxRf-0002LZ-M0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:30:49 -0400
Received: from player732.ha.ovh.net (unknown [10.109.146.173])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id A1E4D6B692
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:30:43 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 89AF2A6A156B;
 Thu,  3 Oct 2019 09:30:38 +0000 (UTC)
Subject: Re: [PATCH v4 13/25] ppc/xive: Introduce a xive_tctx_ipb_update()
 helper
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-14-clg@kaod.org>
 <20191003021137.GK11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5580c25b-dc6e-3303-8e85-9d25ad8b92e7@kaod.org>
Date: Thu, 3 Oct 2019 11:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003021137.GK11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 13817888084286475161
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.43.105
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 04:11, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:33PM +0200, C=E9dric Le Goater wrote:
>> We will use it to resend missed interrupts when a vCPU context is
>> pushed a HW thread.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h |  1 +
>>  hw/intc/xive.c        | 15 +++++++++++----
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index f35ff3b64791..a461753f5da5 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -467,6 +467,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, Xi=
veTCTX *tctx, hwaddr offset,
>> =20
>>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)=
;
>> +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
>> =20
>>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nv=
t_idx)
>>  {
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 68d3361d1c3f..5f7c37b091a7 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -135,6 +135,15 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, ui=
nt8_t ring, uint8_t cppr)
>>      xive_tctx_notify(tctx, ring);
>>  }
>> =20
>> +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
>> +{
>> +    uint8_t *regs =3D &tctx->regs[ring];
>> +
>> +    regs[TM_IPB] |=3D ipb;
>> +    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
>=20
> You're opencoding the existing ipb_update() here, but not eliminating
> it.  That doesn't seem like a good idea.
 It is in patch 15 when the IPB is correctly recorded in the NVT.=20

I can move that part before patch 13 to make things clearer.


C.=20

>> +    xive_tctx_notify(tctx, ring);
>> +}
>> +
>>  static inline uint32_t xive_tctx_word2(uint8_t *ring)
>>  {
>>      return *((uint32_t *) &ring[TM_WORD2]);
>> @@ -336,8 +345,7 @@ static void xive_tm_set_os_cppr(XivePresenter *xpt=
r, XiveTCTX *tctx,
>>  static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tct=
x,
>>                                     hwaddr offset, uint64_t value, uns=
igned size)
>>  {
>> -    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
>> -    xive_tctx_notify(tctx, TM_QW1_OS);
>> +    xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xf=
f));
>>  }
>> =20
>>  static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tc=
tx,
>> @@ -1382,8 +1390,7 @@ static bool xive_presenter_notify(uint8_t format=
,
>> =20
>>      /* handle CPU exception delivery */
>>      if (count) {
>> -        ipb_update(&match.tctx->regs[match.ring], priority);
>> -        xive_tctx_notify(match.tctx, match.ring);
>> +        xive_tctx_ipb_update(match.tctx, match.ring, priority_to_ipb(=
priority));
>>      }
>> =20
>>      return count;
>=20


