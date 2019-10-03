Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3264C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 08:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79472133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 08:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79472133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFwfS-0000kO-Sp
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 04:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFweg-00007w-Lt
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFwef-0004Qs-3G
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:40:10 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:37861)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFwed-0004Q9-Bf
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 04:40:09 -0400
Received: from player770.ha.ovh.net (unknown [10.109.159.73])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1F75510C8AB
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:40:03 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 52F64A86F177;
 Thu,  3 Oct 2019 08:39:58 +0000 (UTC)
Subject: Re: [PATCH v4 22/25] ppc/xive: Introduce a xive_os_cam_decode() helper
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-23-clg@kaod.org>
 <20191003023451.GP11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cb7efb25-dbd8-6f39-e15d-da521a0e98c2@kaod.org>
Date: Thu, 3 Oct 2019 10:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003023451.GP11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 12961922678061632409
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.107.143
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

On 03/10/2019 04:34, David Gibson wrote:
> On Wed, Sep 18, 2019 at 06:06:42PM +0200, C=E9dric Le Goater wrote:
>> The OS CAM line has a special encoding exploited by the HW. Provide a
>> helper routine to hide the details to the TIMA command handlers. This
>> also clarifies the endian ness of different variables : 'qw1w2' is
>> big-endian and 'cam' is native.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c | 35 ++++++++++++++++++++++++++---------
>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index dfae584a319f..cdc4ea8b0e51 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -342,14 +342,29 @@ static void xive_tm_set_os_pending(XivePresenter=
 *xptr, XiveTCTX *tctx,
>>      xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xf=
f));
>>  }
>> =20
>> +static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
>> +                               uint32_t *nvt_idx, bool *vo)
>> +{
>> +    *nvt_blk =3D xive_nvt_blk(cam);
>> +    *nvt_idx =3D xive_nvt_idx(cam);
>> +    *vo =3D !!(cam & TM_QW1W2_VO);
>> +}
>> +
>>  static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tc=
tx,
>>                                      hwaddr offset, unsigned size)
>>  {
>> -    uint32_t qw1w2_prev =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>> -    uint32_t qw1w2;
>> +    uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>> +    uint32_t qw1w2_new;
>> +    uint32_t cam =3D be32_to_cpu(qw1w2);
>> +    uint8_t nvt_blk;
>> +    uint32_t nvt_idx;
>> +    bool vo;
>> =20
>> -    qw1w2 =3D xive_set_field32(TM_QW1W2_VO, qw1w2_prev, 0);
>> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
>=20
> I'd kind of prefer to fold both the memcpy and the endian swizzle into
> a read/write_register_word helper of some sort.

ok. I will see if I can improve that. The goal being to get and set
the relevant fields of the CAM line and hide away the ugly details.


C.

>=20
>> +    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
>> +
>> +    /* Invalidate CAM line */
>> +    qw1w2_new =3D xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
>> +    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
>>      return qw1w2;
>>  }
>> =20
>> @@ -387,13 +402,15 @@ static void xive_tctx_need_resend(XiveRouter *xr=
tr, XiveTCTX *tctx,
>>  static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>>                                  hwaddr offset, uint64_t value, unsign=
ed size)
>>  {
>> -    uint32_t qw1w2 =3D value;
>> -    uint8_t nvt_blk =3D xive_nvt_blk(qw1w2);
>> -    uint32_t nvt_idx =3D xive_nvt_idx(qw1w2);
>> -    bool vo =3D !!(qw1w2 & TM_QW1W2_VO);
>> +    uint32_t cam =3D value;
>> +    uint32_t qw1w2 =3D cpu_to_be32(cam);
>> +    uint8_t nvt_blk;
>> +    uint32_t nvt_idx;
>> +    bool vo;
>> +
>> +    xive_os_cam_decode(cam, &nvt_blk, &nvt_idx, &vo);
>> =20
>>      /* First update the registers */
>> -    qw1w2 =3D cpu_to_be32(qw1w2);
>>      memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
>> =20
>>      /* Check the interrupt pending bits */
>=20


