Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCFC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB02215A5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CH46k52L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB02215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia4p7-0007dR-Ac
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 16:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1ia4k7-00061p-GO
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1ia4k5-0003vr-FP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:20:59 -0500
Received: from mout.web.de ([212.227.15.3]:44435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1ia4k5-0003tp-65
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574889628;
 bh=LKc1iDdS1DWAi20HHG8PgRzARPzSCeDVTLfGvhjFxbs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=CH46k52L/xNjrHDwboYwyDjtmO3KToywfnMHbyfaOpm/F4HTfgDJtFFsT/0q4jX0L
 qmwN70JfJXbQwNCJ687qD64MKvbapu6ORJWWUjMheN1trNnRUhlGFeYaYLedxkTCdR
 qMN5Z93/85IfXlvcAGX2UM4dhCVHzynhgIYZ6U2w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.185]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTvU-1iOxsJ3sds-00SfFl; Wed, 27
 Nov 2019 22:20:28 +0100
Date: Wed, 27 Nov 2019 22:20:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH 1/4] block/quorum.c: stable children names
Message-ID: <20191127222024.4bcb34b8@luklap>
In-Reply-To: <w51imn667m6.fsf@maestria.local.igalia.com>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <ce10f8cf2bb9ae8a1505b59bbc2199f7b4966990.1574356137.git.lukasstraub2@web.de>
 <2ce1be55-010b-d3c3-9df4-e8e02eb522f9@redhat.com>
 <20191121193445.2361b846@luklap>
 <w51imn667m6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zuP7AkDvxcuZSCvAXPYn+t5Qr0FAZlnsmRce2RRQmZ1LDYRt3bK
 6GatUnghNRdCp+cximZMKJ9LfYiqHFYAWo7e8O1MO8oXNfwEFZMLJL7y+EwdgA2WkJ/30w3
 Hjh1ScUoeatRQZJ73AQPeIrtQXJUi94kZrEdy8ldm5cH1ob90qjmXlhwfiOLqbEtJH/RhKW
 9mh7caccOk8+HZUL9Rc/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KJiB3i0PsdY=:fw6qXx5Usf39vuMOQyM5R3
 yZQehWXLGkga3xD2+nT9alcu1waI56o1z0c+rSdifePsTOtHB+33nGqoNcAJjzff9t+nIFJcB
 vnkeS42G537gM7xdII0lqEDsrVYfxOwPeVe3B0HEYb/YKrDfCCG6aYUlJaNWT62izxXrfeQA0
 NUEY3wzMbs/dr2m99HyRrwKD3LKsEayZpzVRa6Cvpp/Xk+F65EHd/M6VuX2qzaKdtycmM3H6F
 9JHwbfV6oOXArihKljSaxRLhQ1UE667mCnH+fzj3eiQMwNca+Er9QUNoZpj+jXR7oPHAH4Y6w
 OyxW7Sx5c3oWAswrk3Lv52Hkw3KFrrbFAmIEkvo4N9y3vghOpq0wBQiHbdrd1fY39gEEWkGao
 ws37C+bjlJREZJ5/rHWmBf1dcPH7ldAXeAk1DP6x1Fetrvy5sEXISR1Rz4kmhq6/3YCdrrllq
 oPumvSaWB+PUqjZAUdH/EHMPAo5vpFWhc/qoGQvfw+sle+uNowdVP+0b0wDciv1EnVriOgnIH
 h9BV1jYZfLSFvZU0iGfnLPlh2X2NQjSnm4xAQLrwy8W71fGRjZ8CsFc8+N7fme+mXzz2NXBsH
 7OfbsTGKScEIPZELTD5wkPDenOfqpg8rboSjjRGOSA/Hd4k6u5SNeQnK8e1fNf08vA8cv/QFi
 zoySV59c2Kywc09Ltp0vvm0IXabVJdv9EwbTqCiqgsmUOkeWv1kAfeKpmOrur6JzJWhKfS+yy
 Wob++f++f6MK/9qTeJOuB5D3bsfZi2VVoMisp6N87ohJ8UsOcYB8zkdOCx3skkvK0hhFVoNIZ
 6FLDwSvALRK6Rn6URoj0FmFtAe2jUwQVWz27dUXwkUYEkShLhMqWj3r03vIuMVNoHrLbDTVhK
 1RNw8OKXlCpSDm7+Z7415uVZh7Sw1TgBFrt9GdWbcyRgcAx6EsQCEurCR50ZFNY9nnzWywtgD
 usDzpyeQsMFTw2tilAdjRE8TakKHIDlVoKvf6EjJA1FFGwDLmxO4upDAkVY9LfConcxEs69HV
 n0HmFbf8beEDZD4bvzmI63m9nGQQ0b8HVKgnvQb9EsRx6W6B73dHJz4hUhG6nA6amhwS1WrQ3
 Bfm6IO9JrMehCGCC0kes0HjCHF7u3UCudTCgj7r1bTU/N67l+NDiV2oIwEBK4CJMNV+wv7MV9
 LPjS1DFP0QZ3Dbzb5PRz5gK/ojoLxV+sTF3vGs8iOPY2H6zTcid/j6KTfWKFZe1/tXDrWICoo
 V/6PbHdscxblgtBN87kw9HBkCE24/XhCb21KDG5iNBIackwGBW/Xl1YoN7GA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.3
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 Nov 2019 15:21:37 +0100
Alberto Garcia <berto@igalia.com> wrote:

> On Thu 21 Nov 2019 07:34:45 PM CET, Lukas Straub wrote:
> >> > diff --git a/block/quorum.c b/block/quorum.c
> >> > index df68adcfaa..6100d4108a 100644
> >> > --- a/block/quorum.c
> >> > +++ b/block/quorum.c
> >> > @@ -1054,6 +1054,12 @@ static void quorum_del_child(BlockDriverStat=
e *bs, BdrvChild *child,
> >> >       /* We know now that num_children > threshold, so blkverify mu=
st be false */
> >> >       assert(!s->is_blkverify);
> >> >
> >> > +    unsigned child_id;
> >> > +    sscanf(child->name, "children.%u", &child_id);
> >>
> >> sscanf() cannot detect overflow. Do we trust our input enough to
> >> ignore this shortfall in the interface, or should we be using saner
> >> interfaces like qemu_strtoul()?  For that matter, why do we have to
> >> reparse something; is it not already available somewhere in numerical
> >> form?
> >
> > Yes, I wondered about that too, but found no other way. But the input
> > is trusted, AFAIK the only way to add child nodes is trough
> > quorum_add_child above and quorum_open and there already are adequate
> > checks there.
>
> I also don't see any other way to get that value, unless we change
> BDRVQuorumState to store that information (e.g. instead of children
> being a list of pointers BdrvChild ** it could be a list of {pointer,
> index}, or something like that).
>
> There's another (more convoluted) alternative if we don't want to parse
> child->name. Since we only want to know if the child number equals
> s->next_child_index - 1, we can do it the other way around:
>
>    snprintf(str, 32, "children.%u", s->next_child_index - 1);
>
> and then compare str and child->name.
>
> Berto

Hi,
I will do it your way, then it's also more consistent with the name
creation in quorum_add and quorum_open.

Regards,
Lukas Straub

