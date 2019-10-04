Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986F1C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE1B2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 07:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE1B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGI10-0003sr-Ca
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 03:28:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iGI03-0003MY-Tj
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iGI02-0001yX-Na
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:27:39 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:45626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iGI02-0001xs-H8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 03:27:38 -0400
Received: from player688.ha.ovh.net (unknown [10.109.146.20])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 237F56B821
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 09:27:35 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id E1884A7BE801;
 Fri,  4 Oct 2019 07:27:31 +0000 (UTC)
Subject: Re: [PATCH 2/7] spapr, xive: Turn "nr-ends" property into
 "nr-servers" property
To: Greg Kurz <groug@kaod.org>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010406203.246126.13381271918474281392.stgit@bahia.lan>
 <20191004040725.GB27597@umbus.fritz.box>
 <6313a1ea-f891-d7a0-c5f1-ecf656b58bc3@kaod.org>
 <20191004085257.53bcfcce@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f180e55b-c537-7a4e-b546-a1e1cc25bc7d@kaod.org>
Date: Fri, 4 Oct 2019 09:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191004085257.53bcfcce@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17611044870116969280
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrhedtgdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.233
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

On 04/10/2019 08:52, Greg Kurz wrote:
> On Fri, 4 Oct 2019 07:53:13 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>>>> @@ -283,11 +292,13 @@ static void spapr_xive_realize(DeviceState *de=
v, Error **errp)
>>>>          return;
>>>>      }
>>>> =20
>>>> -    if (!xive->nr_ends) {
>>>> -        error_setg(errp, "Number of interrupt needs to be greater 0=
");
>>>> +    if (!xive->nr_servers) {
>>>> +        error_setg(errp, "Number of interrupt servers must be great=
er than 0");
>>>>          return;
>>>>      }
>>>> =20
>>>> +    xive->nr_ends =3D spapr_xive_vcpu_id_to_end_idx(xive->nr_server=
s);
>>>
>>> I'd prefer not to store both nr_servers and nr_servers * 8 in the
>>> structure.  I think you just want xive->nr_servers, then derive it an=
y
>>> any places that current look at xive->nr_ends.
>>
>> Yes I agree. This is a small change.
>>
>=20
> I'm afraid it isn't that simple (see my other mail).

yes. I had forgotten about the vmstate ...



