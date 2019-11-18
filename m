Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C4C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A1C20692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A1C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdkn-0003rw-R7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWdgj-0001Kn-V9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWdgi-0000xU-N6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:51:17 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:58542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWdgi-0000wn-Dy
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:51:16 -0500
Received: from player792.ha.ovh.net (unknown [10.108.35.131])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id F41031435FB
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:51:13 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id AFEFFC32D137;
 Mon, 18 Nov 2019 09:51:07 +0000 (UTC)
Subject: Re: [PATCH v2 for-5.0 0/8] ppc: Consolidate QOM links and pointers to
 the same object
To: Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>
References: <157383332103.165747.15204186097237659466.stgit@bahia.lan>
 <87zhgtwn63.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a88d4d7d-f088-1115-6f0c-1b80c9a37743@kaod.org>
Date: Mon, 18 Nov 2019 10:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87zhgtwn63.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7606861247232117521
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeghedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefheenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.36.149
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/2019 10:26, Markus Armbruster wrote:
> Greg Kurz <groug@kaod.org> writes:
> 
>> There's a recurring pattern in the code where a const link is added to a
>> newly instanciated object and the link is then used in the object's realize
>> function to keep a pointer to the QOM entity which the link points to.
>>
>> void create_obj_b(Object *obj_a)
>> {
>>     Object *obj_b;
>>
>>     obj_b = object_new(TYPE_B);
>>     object_property_add_const_link(obj_b, "link-to-a", obj_a, &error_abort);
>>     object_property_set_bool(obj_b, true, "realized", &error_abort);
>> }
>>
>> void object_b_realize(DeviceState *dev, Error **errp)
>> {
>>     Object *obj_a;
>>
>>     obj_a = object_property_get_link(OBJECT(dev), "link-to-a", errp);
>>     if (!obj_a) {
>>         return;
>>     }
>>
>>     obj_b->obj_a = A(obj_a); // If obj_b->obj_a is changed, the link property
>>                              // still points to the original obj_a that was
>>                              // passed to object_property_add_const_link()
>> }
>>
>> Confusing bugs could arise if the pointer and the link go out of sync for
>> some reason. This can be avoided if the property is defined to directly use
>> the pointer with the DEFINE_PROP_LINK() macro.
>>
>> This series just does that for all occurences of the fragile pattern in
>> the XIVE and PNV code.
> 
> Have you looked for the pattern elsewhere?

I can take care of the Aspeed machine. I followed the same pattern there.

C.


