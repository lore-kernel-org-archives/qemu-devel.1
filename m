Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B59C76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE0020818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE0020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnfPU-0003uJ-Rk
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hnfPJ-0003Q1-Ha
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hnfPI-0007os-8i
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:35:25 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:43301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hnfPI-0007fC-2r
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:35:24 -0400
Received: from player693.ha.ovh.net (unknown [10.109.146.137])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 1CD1371D70
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 10:35:11 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id E29937FDF2D8;
 Wed, 17 Jul 2019 08:35:06 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-9-clg@kaod.org> <20190703020748.GD9442@umbus.fritz.box>
 <08faf669-72a7-8f30-d33c-2e285405005c@kaod.org>
 <20190712011527.GB2561@umbus.fritz.box>
 <4f2f24e7-28da-8f32-e1f7-721dc6533e7c@kaod.org>
 <20190717020809.GE9123@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <671315c7-c47a-f86d-3cce-0478a264645e@kaod.org>
Date: Wed, 17 Jul 2019 10:35:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717020809.GE9123@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 15978490005418380115
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddriedvgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.45
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xive: Extend XiveTCTX with an
 router object pointer
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2019 04:08, David Gibson wrote:
> On Mon, Jul 15, 2019 at 05:45:38PM +0200, C=E9dric Le Goater wrote:
>> On 12/07/2019 03:15, David Gibson wrote:
>>> On Wed, Jul 03, 2019 at 07:54:57AM +0200, C=E9dric Le Goater wrote:
>>>> On 03/07/2019 04:07, David Gibson wrote:
>>>>> On Sun, Jun 30, 2019 at 10:45:59PM +0200, C=E9dric Le Goater wrote:
>>>>>> This is to perform lookups in the NVT table when a vCPU is dispatc=
hed
>>>>>> and possibly resend interrupts.
>>>>>
>>>>> I'm slightly confused by this one.  Aren't there multiple router
>>>>> objects, each of which can deliver to any thread?  In which case wh=
at
>>>>> router object is associated with a specific TCTX?
>>>>
>>>> when a vCPU is dispatched on a HW thread, the hypervisor does a stor=
e=20
>>>> on the CAM line to store the VP id. At that time, it checks the IPB =
in=20
>>>> the associated NVT structure and notifies the thread if an interrupt=
 is=20
>>>> pending.=20
>>>>
>>>> We need to do a NVT lookup, just like the presenter in HW, hence the=
=20
>>>> router pointer. You should look at the following patch which clarifi=
es=20
>>>> the resend sequence.
>>>
>>> Hm, ok.
>>>
>>>>>> Future XIVE chip will use a different class for the model of the
>>>>>> interrupt controller. So use an 'Object *' instead of a 'XiveRoute=
r *'.
>>>>>
>>>>> This seems odd to me, shouldn't it be an interface pointer or
>>>>> something in that case?
>>>>
>>>> I have duplicated most of the XIVE models for P10 because the intern=
al=20
>>>> structures have changed. I managed to keep the XiveSource and XiveTC=
TX=20
>>>> but we now have a Xive10Router, this is the reason why.
>>>
>>> Right, but XiveRouter and Xive10Router must have something in common
>>> if they can both be used here.  Usually that's expressed as a shared
>>> QOM interface - in which case you can use a pointer to the interface,
>>> rathe than using Object * which kind of implies *anything* can go
>>> here.
>>
>> Yeah. I also think it would be better to have a common base object but
>> the class don't have much in common. Here is what I have for now :
>=20
> Uh.. QOM interfaces don't require there to be a common base object,
> only common methods.

It's not a QOM interface today because it already uses an interface.=20

>>
>> P9:
>>
>> typedef struct XiveRouterClass {
>>     SysBusDeviceClass parent;
>>
>>     /* XIVE table accessors */
>>     int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx=
,
>>                    XiveEAS *eas);
>>     int (*get_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx=
,
>>                    XiveEND *end);
>>     int (*write_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_i=
dx,
>>                      XiveEND *end, uint8_t word_number);
>>     int (*get_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx=
,
>>                    XiveNVT *nvt);
>>     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_i=
dx,
>>                      XiveNVT *nvt, uint8_t word_number);
>>     XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
>>     uint8_t (*get_block_id)(XiveRouter *xrtr);
>> } XiveRouterClass;
>>
>> and P10:
>>
>> typedef struct Xive10RouterClass {
>>     SysBusDeviceClass parent;
>>
>>     /* XIVE table accessors */
>>     int (*get_eas)(Xive10Router *xrtr, uint8_t eas_blk, uint32_t eas_i=
dx,
>>                    Xive10EAS *eas);
>>     int (*get_end)(Xive10Router *xrtr, uint8_t end_blk, uint32_t end_i=
dx,
>>                    Xive10END *end);
>>     int (*write_end)(Xive10Router *xrtr, uint8_t end_blk, uint32_t end=
_idx,
>>                      Xive10END *end, uint8_t word_number);
>>     int (*get_nvp)(Xive10Router *xrtr, uint8_t nvt_blk, uint32_t nvt_i=
dx,
>>                    Xive10NVP *nvt);
>>     int (*write_nvp)(Xive10Router *xrtr, uint8_t nvt_blk, uint32_t nvt=
_idx,
>>                      Xive10NVP *nvt, uint8_t word_number);
>>     XiveTCTX *(*get_tctx)(Xive10Router *xrtr, CPUState *cs);
>>     uint8_t (*get_block_id)(XiveRouter *xrtr);
>>     uint32_t (*get_config)(Xive10Router *xrtr);
>> } Xive10RouterClass;
>>
>> Only get_tctx() is common.=20
>>
>> The XIVE structures (END, NV*) used by the routing algo have changed a=
 lot.
>> Even the presenter has changed, because all the CAM lines have a sligh=
tly=20
>> different format.  =20
>>
>> C.
>>
>>
>=20


