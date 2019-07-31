Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1341C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 04:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A812067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 04:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A812067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsgha-00048E-S4
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 00:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hsghB-0003iF-0N
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 00:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hsgh6-0006rP-S8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 00:58:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hsgh3-0006ly-N1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 00:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0050B3084288;
 Wed, 31 Jul 2019 04:58:26 +0000 (UTC)
Received: from [10.72.12.51] (ovpn-12-51.pek2.redhat.com [10.72.12.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A61D19C5B;
 Wed, 31 Jul 2019 04:58:23 +0000 (UTC)
To: Stefan Hajnoczi <stefanha@gmail.com>, P J P <ppandit@redhat.com>
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-4-ppandit@redhat.com>
 <20190723130326.GC5445@stefanha-x1.localdomain>
 <CAKXe6S+pXN0d6K9Vw=kxsy51bVz1PxXBHYEmTesUnYo8u8vcYg@mail.gmail.com>
 <nycvar.YSQ.7.76.1907241116470.10049@xnncv>
 <20190729150400.GG6771@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fb5835f4-2894-72c5-db35-91ccf966cb9f@redhat.com>
Date: Wed, 31 Jul 2019 12:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729150400.GG6771@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 31 Jul 2019 04:58:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/29 =E4=B8=8B=E5=8D=8811:04, Stefan Hajnoczi wrote:
> On Wed, Jul 24, 2019 at 11:18:09AM +0530, P J P wrote:
>> +-- On Tue, 23 Jul 2019, Li Qiang wrote --+
>> | Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=88=
23=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:03=E5=86=99=E9=81=93=EF=
=BC=9A
>> | > On Tue, Jul 23, 2019 at 04:17:54PM +0530, P J P wrote:
>> | > > -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s =
%s",
>> | > > -                     helper, "--use-vnet", fd_buf, br_buf);
>> | > > +            helper_cmd =3D g_strdup_printf("%s %s %s %s", helpe=
r,
>> | > > +                            "--use-vnet", fd_buf, br_buf ? br_b=
uf : "");
>> | >
>> | > The change to the br_buf argument isn't covered in the commit
>> | > description.  Why did you change this, was it a bug, etc?
>> |
>> | IIUC, if we pass the NULL argument in g_strdup_printf, the 'helper_c=
md' will
>> | contain the '(null)' char.
>>
>> Yep, right.
> This change isn't related to the topic of the patch.  It's a separate
> bug fix.
>
> Please either document it in the commit description so it's clear the
> change is intentional, or send it as a separate patch.
>
> Stefan


Prasad, please send a patch for this.

Thanks


