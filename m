Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1317CC4CECC
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 16:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25D3214D8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 16:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KQCV/Hjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25D3214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9X6i-0005FK-R9
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 12:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1i9X3p-0004g0-Ii
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 12:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1i9X3o-0004JQ-IF
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 12:07:37 -0400
Received: from mout.web.de ([212.227.15.4]:37277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1i9X3o-0004H1-6A
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 12:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1568563624;
 bh=lO2+lEtynshWUePIvXeVTjzPeQe/38MegxHYjMcL8RQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KQCV/HjzW6/H4vL0ELJhl4fqvkfePoAZ+EbEs7L7/jqhldzfandKi/UxcVwzFpE/V
 1Wy0U+DVmo9OkP31L1v7KcWoauEaXJB7w0WpxxFf8MrjzC1K46H6uhj+LroGJyBYww
 DTg3ZnHAAwzJJdyNh+gm2+dcXug7vuCpkGg7QzsY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.53]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3k9J-1iRTPV0NUX-00rFao; Sun, 15
 Sep 2019 18:07:04 +0200
Date: Sun, 15 Sep 2019 18:07:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <20190915180701.7b6edfc8@luklap>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D7806264100@shsmsx102.ccr.corp.intel.com>
References: <cover.1568110100.git.lukasstraub2@web.de>
 <77d2eb7d0ce8a1887a575119e21ce0a06d4af533.1568110100.git.lukasstraub2@web.de>
 <9CFF81C0F6B98A43A459C9EDAD400D7806264100@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:31mE3bqvTv9RuGs4LcWS0hVLmRuDwcnbvdn5XYuLcvZ155zWTsr
 xzgJfPj+qA48yR75vJtIUgQjLA6FvEu+QMs2jJv6/+MbYTpVmEYLis42Y/SFRpmUzB+eI9V
 Gl9uIyKwfbdD1foNbyIE2h0k+JkPQgAy554vWAi6n7MbLpmqsn7i38TEJ7GPL6cgiXqLNYO
 kif5+WideG27Rq7KQzEZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t8nNbdzVRLA=:Lx2At0ZaJ9z+PdpjBBw1Sx
 O/ELLuLkV8gyNt0J+wWgVVXWZxIEmaq6VM8leuGkYluT9pjXdr6JrRdASOkO2Te1MQmaI2SdS
 dzM1hNM6lAybgm/fJlQG5x/9PIL/B16n9n5BwsX0Vk5YGK9jPD9OINr5BE9+jGBvQXIg7EPb/
 K/FwAUSbvTCjtaV9pPHI9Gqnz5AE+f3cTX84aJbzh05aNp7R1AWEPKu7YIWrLQGQRBxciwof2
 HIkr9w/tGoDF5Pdb+MTW8FLkOcu924XWroq4Qhj5puKwzfFyawEOc0lhoLDcn6fkf+GplTYOP
 t//XGHto1rWQ7BQS7hhrZqkdZ84YEtDFOm4Dkf6b3NN8MuE6PEYoqNEantmGGOs2uWtqqs/Hk
 wV2nWzAbVsCweU64ic4zrVvmvj/nuNlolrE6QPz22oZHtM5xjFWkoG/pUv79ikChFH1Z79c9O
 +qKmEJGGp6I0Z8qj3DUon5bjGuoVDzrXWjHEU1/3u2NSDkdvyQEyOyH4yagbKDBfgBymup74F
 wGLKrFMVBvw2v4X+QRr7NLmq8igL/xVM9VTRaM75JS/WenUroHnLQpHGNUi+0vZfT62+zuEpp
 fYZd8UKXuX/4xA1797dYJJh1vV6oFWXgTckf2hLB1ueemF/jqQnIqGD57jojvLPt3v4nTDREe
 K1wFNk7/syqAFmQ5dgbUjhbIuVMEIbdYuRmSRtFYzTELNmU+RP1eDbqZiIlDq5918vUSzKUnh
 Pr07LghvQBHSf7IOWc3oTlJam9pcqKQddEO8quB9aMWX0maPK7Kdq0x7tH4vE4qanRQiQ4h7T
 nOOdVJ2pcTzMMCP9B5MqyKGZqXzSEcb3OFssHC1++pEys8r3pOq3DtAffwE3Hr56BNETHrIBg
 8CTkqQ3JX2eiRYB9CLu91vCtANCsXSjXnYzq+RRFdBjddODjsCnFdT2QYLpQgg5jkUM5NG0OU
 X8yJ4kJfQvp01+LvcS2zmHXAJT2gcBwzyWfc55oZ7Xh6kCtSDSkYNS7gqL76VA4m4/5pkBzbR
 B25xh9tABCL7jHfBp7PXAsovAXNpe2gLEUyocHWkdCk9PsetgmktV4DMHi2maaZhPJz630ahI
 gVZNPsaIjixToqQmnHB0M7TnMH8Ip0gZNCpwP3LDKfRE00hmEy9BRbxBMJ9gT+aNsNjdDV8my
 HrNTQH4VDaxoaaPbBXsT7FV4mFP2HsaiEjPXw5SSR53TG5tQMvsfFxEvsDuvDVe0wTXihnWHB
 5RvYH3iLNrhvt5OfuxvKlRdijIbQR5nGr8R9+rTvkYGtJhUoNFlvaAwKwcDw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
Subject: Re: [Qemu-devel] [PATCH v4 3/4] net/filter.c: Add Options to insert
 filters anywhere in the filter list
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019 20:12:45 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Tuesday, September 10, 2019 6:15 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> > <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> > Xie Changlong <xiechanglong.d@gmail.com>; kwolf@redhat.com;
> > mreitz@redhat.com
> > Subject: [PATCH v4 3/4] net/filter.c: Add Options to insert filters an=
ywhere in
> > the filter list
> >
> > To switch the Secondary to Primary, we need to insert new filters befo=
re the
> > filter-rewriter.
> >
> > Add the options insert=3D and position=3D to be able to insert filters=
 anywhere in
> > the filter list.
> >
> > position should be either "head", "tail" or the id of another filter.
>
> In current patch, we cannot distinguish the real "head/tail" or the ID =
=3D "head/tail".
> And in real environment we can't order users reserve the "head/tail" as =
keywords.
> So, I think we can use position=3DID-xxxx/head/tail to solve this issue,=
 or do you have any other idea?
>

Hi,
Yes, I will change that.

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>
> > insert should be either "before" or "behind" to specify where to inser=
t the
> > new filter relative to the one specified with position.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---


