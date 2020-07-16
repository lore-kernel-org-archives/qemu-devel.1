Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689412065F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="NOtn6005"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689412065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw2uw-0006ci-Kf
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw2u9-0006BT-1Z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:22:25 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw2u6-0007oN-69
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=aTijdTSeZocyPBRyptjmCWOMUSVEBA88x0BqHVnXZTU=; b=NOtn6005aytz+1vIkfBKV/iZpG
 aRLwiQCY3EU2CCePYZChP+xjTqfUK9jtEQFFnrCwnX195pn0TqSAekcAjblmCYyd75JieCapg7LwN
 VHks5Ctzn2x+3WrhL7kG+0WDnmSlBPdM42Tp7uDvi35khatx1ag4RXLbg1JsZBYAIr8bf3FuHGZqZ
 u8ngdvS6+71GGhfgjd3zi5dQImxu2xxbJbQ7odqnh/K01X9WBLxsLJ0UROeiT3rRFhs2FKM2N6uw8
 /KpVhvcF84l3JNQXpr8hlbUoZoRvu6n8JIqr/cuRiCFOs4fHqlT0zUeqbpTz+m0CD6uFvifxQKy+7
 qx8UDs1w==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 P J P <ppandit@redhat.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Date: Thu, 16 Jul 2020 14:22:14 +0200
Message-ID: <5717837.yeCYy4G0CH@silver>
In-Reply-To: <20200716100157.GK227735@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <3491260.5YPxQhmjAg@silver> <20200716100157.GK227735@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 08:22:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. Juli 2020 12:01:57 CEST Daniel P. Berrang=E9 wrote:
> > My concern here is that just distinguishing between either 'low' or 'hi=
gh'
> > is a far too rough classification.
> >=20
> > In our preceding communication regarding 9pfs, I made clear that a) we =
do
> > care about security relevant 9pfs issues, and only b) the avarage use
> > cases (as far we know) for 9pfs are above a certain trust level.
> >=20
> > However b) does not imply 9pfs being 'unsafe', nor that we want users to
> > refrain using it in a security relevant environment. So 9pfs would
> > actually be somewhere in between.
>=20
> We shouldn't overthink this and invent many classification levels.
>=20
> This is essentially about distinguishing code that is written with the
> intent of protecting from a malicous guest, from code that assumes a
> non-malicious guest. That is a pretty clear demarcation on when it is
> reasonable to use any given feature in QEMU.
>=20
> Within the set of code that is assuming a malicious guest, there are
> still going to be varying levels of quality, and that is ok. We don't
> need to express that programatically, the docs are still there to
> describe the fine nuances of any given feature. We're just saying that
> in general, this set of code is acceptable to use in combination with
> a malicious guest, and if you find bugs we'll triage them as security
> flaws.

Yes, that would be a base consideration for any security classification. An=
d=20
it applies to 9pfs hence it would suggest 'high' for 9pfs, but ...

> 9p is generally written from the POV of protecting against a malicious
> guest, so it would be considered part of the high security set, and
> flaws will be treated as CVEs. We don't need to be break it down into
> any more detail than that.

=2E.. this is where it already differs from reality, as 9pfs security issue=
s=20
were both handled as CVEs as well as normal reports for years, which nobody=
=20
objected.

So I wonder how helpful it would be trying to either put 9pfs into either=20
'high' or 'low', because another observed problematic with 9pfs is that the=
=20
degree of participation is so low, that if you try to impose certain formal=
=20
minimum requirements to contributors, you usually never hear from them agai=
n.

And BTW Prasad actually suggested the opposite classification:=20

> @@ -1761,6 +1927,7 @@ virtio-9p
>=20
>  M: Greg Kurz <groug@kaod.org>
>  M: Christian Schoenebeck <qemu_oss@crudebyte.com>
>  S: Odd Fixes
>=20
> +C: Low
>=20
>  F: hw/9pfs/
>  X: hw/9pfs/xen-9p*
>  F: fsdev/

Even though we discussed this issue with him in detail before, which probab=
ly=20
shows that a simple binary security classification is too coarse and too=20
ambiguous.

Best regards,
Christian Schoenebeck



