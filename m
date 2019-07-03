Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D7AC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 04:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B7620673
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 04:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B7620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiWWn-0001sm-Jw
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 00:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hiWV9-0001A6-Bq
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 00:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hiWV5-0007A8-6G
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 00:04:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hiWV0-0006vA-LL
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 00:04:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4F75859FC;
 Wed,  3 Jul 2019 04:03:42 +0000 (UTC)
Received: from [10.72.12.173] (ovpn-12-173.pek2.redhat.com [10.72.12.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACDA71001281;
 Wed,  3 Jul 2019 04:03:39 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA_L2_BJPvpVvNpi-mHkXg-VE-eeyiguWOaqs6AwT_nOYA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c2b9616-925d-0feb-a070-47c37d0b33ef@redhat.com>
Date: Wed, 3 Jul 2019 12:03:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_L2_BJPvpVvNpi-mHkXg-VE-eeyiguWOaqs6AwT_nOYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 04:03:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/17] Net patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/3 =E4=B8=8A=E5=8D=8812:40, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 03:31, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f7224=
6b7c6:
>>
>>    Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-=
pull-request' into staging (2019-07-01 17:40:32 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 0e8818f023616677416840d6ddc880db8de3c96=
7:
>>
>>    migration/colo.c: Add missed filter notify for Xen COLO. (2019-07-0=
2 10:21:07 +0800)
>>
>> ----------------------------------------------------------------
>>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
> for any user-visible changes.
>
> -- PMM


Done.

Thanks


>

