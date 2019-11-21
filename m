Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49542088F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 07:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49542088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXh5n-0003lh-0u
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 02:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXh4z-0003Dv-5m
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXh4x-0001Xj-PU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:40:41 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:41225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXh4x-0001XM-IW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 02:40:39 -0500
Received: from player711.ha.ovh.net (unknown [10.109.159.222])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6BA0A14D458
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:40:37 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 81183C3E66AF;
 Thu, 21 Nov 2019 07:40:33 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v5 15/23] ppc/xive: Use the XiveFabric and
 XivePresenter interfaces
To: Greg Kurz <groug@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-16-clg@kaod.org> <20191120193001.5b9229a2@bahia.lan>
 <d03e9084-21e9-90ff-00d2-3c7f11b506c8@kaod.org>
 <20191121083042.190a038a@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e2ff291d-4ec6-5f69-5ea6-5e0cccca1bc2@kaod.org>
Date: Thu, 21 Nov 2019 08:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121083042.190a038a@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4572561000503085907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehuddgudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.78.111
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 08:30, Greg Kurz wrote:
> On Thu, 21 Nov 2019 08:01:44 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 20/11/2019 19:30, Greg Kurz wrote:
>>> On Fri, 15 Nov 2019 17:24:28 +0100
>>> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>>>
>>>> Now that the machines have handlers implementing the XiveFabric and
>>>> XivePresenter interfaces, remove xive_presenter_match() and make use
>>>> of the 'match_nvt' handler of the machine.
>>>>
>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/xive.c | 48 +++++++++++++++++------------------------------=
-
>>>>  1 file changed, 17 insertions(+), 31 deletions(-)
>>>>
>>>
>>> Nice diffstat :)
>>>
>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>> index 1c9e58f8deac..ab62bda85788 100644
>>>> --- a/hw/intc/xive.c
>>>> +++ b/hw/intc/xive.c
>>>> @@ -1423,30 +1423,6 @@ int xive_presenter_tctx_match(XivePresenter *=
xptr, XiveTCTX *tctx,
>>>>      return -1;
>>>>  }
>>>> =20
>>>> -static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
>>>> -                                 uint8_t nvt_blk, uint32_t nvt_idx,
>>>> -                                 bool cam_ignore, uint8_t priority,
>>>> -                                 uint32_t logic_serv, XiveTCTXMatch=
 *match)
>>>> -{
>>>> -    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
>>>> -    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
>>>> -    int count;
>>>> -
>>>> -    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ig=
nore,
>>>> -                           priority, logic_serv, match);
>>>> -    if (count < 0) {
>>>> -        return false;
>>>> -    }
>>>> -
>>>> -    if (!match->tctx) {
>>>> -        qemu_log_mask(LOG_UNIMP, "XIVE: NVT %x/%x is not dispatched=
\n",
>>>> -                      nvt_blk, nvt_idx);
>>>
>>> Maybe keep this trace...
>>
>> It's in spapr_xive_match_nvt() now.
>>
>=20
> Not really... spapr_xive_match_nvt() has a trace for the opposite case =
of duplicate
> matches:

not that one. The one in spapr.c ... Yes I need to change the name.

C.

>=20
>             if (match->tctx) {
>                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a t=
hread "
>                               "context NVT %x/%x\n", nvt_blk, nvt_idx);
>                 return -1;
>             }
>=20
>>>
>>>> -        return false;
>>>> -    }
>>>> -
>>>> -    return true;
>>>> -}
>>>> -
>>>>  /*
>>>>   * This is our simple Xive Presenter Engine model. It is merged in =
the
>>>>   * Router as it does not require an extra object.
>>>> @@ -1462,22 +1438,32 @@ static bool xive_presenter_match(XiveRouter =
*xrtr, uint8_t format,
>>>>   *
>>>>   * The parameters represent what is sent on the PowerBus
>>>>   */
>>>> -static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
>>>> +static bool xive_presenter_notify(uint8_t format,
>>>>                                    uint8_t nvt_blk, uint32_t nvt_idx=
,
>>>>                                    bool cam_ignore, uint8_t priority=
,
>>>>                                    uint32_t logic_serv)
>>>>  {
>>>> +    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
>>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
>>>>      XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
>>>> -    bool found;
>>>> +    int count;
>>>> =20
>>>> -    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, =
cam_ignore,
>>>> -                                 priority, logic_serv, &match);
>>>> -    if (found) {
>>>> +    /*
>>>> +     * Ask the machine to scan the interrupt controllers for a matc=
h
>>>> +     */
>>>> +    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ign=
ore,
>>>> +                           priority, logic_serv, &match);
>>>> +    if (count < 0) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    /* handle CPU exception delivery */
>>>> +    if (count) {
>>>>          ipb_update(&match.tctx->regs[match.ring], priority);
>>>>          xive_tctx_notify(match.tctx, match.ring);
>>>>      }
>>>
>>> ... in an else block here ^^ ?
>>>
>>>> =20
>>>> -    return found;
>>>> +    return count;
>>>
>>> Implicit cast is ok I guess, but !!count would ensure no paranoid
>>> compiler ever complains.
>>
>> yes.=20
>>
>> Thanks,
>>
>> C.
>>
>>
>>>
>>>>  }
>>>> =20
>>>>  /*
>>>> @@ -1590,7 +1576,7 @@ static void xive_router_end_notify(XiveRouter =
*xrtr, uint8_t end_blk,
>>>>          return;
>>>>      }
>>>> =20
>>>> -    found =3D xive_presenter_notify(xrtr, format, nvt_blk, nvt_idx,
>>>> +    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
>>>>                            xive_get_field32(END_W7_F0_IGNORE, end.w7=
),
>>>>                            priority,
>>>>                            xive_get_field32(END_W7_F1_LOG_SERVER_ID,=
 end.w7));
>>>
>>
>=20


