Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B95C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936B921842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936B921842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hppNT-00080J-SJ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 03:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hppNK-0007a3-5Y
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hppNI-0002WV-8F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hppNF-0002TH-Og; Tue, 23 Jul 2019 03:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C22C308FBB4;
 Tue, 23 Jul 2019 07:38:11 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-52.ams2.redhat.com
 [10.36.117.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A92D119C58;
 Tue, 23 Jul 2019 07:38:04 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
 <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
 <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
 <053eeafe-4e93-aa96-f544-ea0606e244b6@redhat.com>
 <689b75f8-ae47-621f-44a5-f3ad07fe2661@redhat.com>
 <63ff0471-aa50-f60d-417b-c42d315e02e3@redhat.com>
 <CAFEAcA-4xUJRJ1BKc5-NBLy+jfY1dShE8GaoVVq_+USzdfxYQg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <21191e6c-e0b1-a4bf-5b78-22f95db6e080@redhat.com>
Date: Tue, 23 Jul 2019 09:38:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4xUJRJ1BKc5-NBLy+jfY1dShE8GaoVVq_+USzdfxYQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 23 Jul 2019 07:38:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v7 1/1] hw/block/pflash_cfi01: Add
 missing DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/22/19 19:12, Peter Maydell wrote:
> On Mon, 22 Jul 2019 at 17:51, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 07/19/19 18:19, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Laszlo,
>>>
>>> On 7/18/19 9:35 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 7/18/19 8:38 PM, Laszlo Ersek wrote:
>>>>> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>>>
>>> Patchwork doesn't recognize your R-t-b tag:
>>>
>>> https://patchwork.ozlabs.org/patch/1133671/
>>>
>>> Should I change it for a Tested-by, or add as it?
>>
>> Please pick it up manually, as it is, if that's possible.
>>
>> I prefer to dedicate "Tested-by" to cases where my before-after
>> comparison highlights a difference (i.e., bug disappears, or feature
>> appears). I dedicate "R-t-b" to cases where nothing observable changes
>> (in accordance with my expectation).
>=20
> The counter-argument to this is that nobody else is using
> this convention (there are exactly 0 instances of
> "Regression-tested-by" in the project git log as far as
> I can see), and so in practice people reading the commits
> won't really know what you meant by it. Everybody else
> on the project uses "Tested-by" to mean either of the
> two cases you describe above, without distinction...

OK. If "Tested-by" carries both meanings in the QEMU git log, then I'm
fine with either tag (T-b or R-t-b) from me on this patch. (Or I'll try
to remember this in the future anyway, seeing that Phil has submitted a
pull request already.)

Thanks
Laszlo

> (At one point we talked about using checkpatch to enforce
> that we used a particular set of tags, mostly to avoid
> people managing to typo the tagname, but also partly to
> retain some consistency of usage.)
>=20
> thanks
> -- PMM
>=20


