Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3D6C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C6B206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C6B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs57R-0001C1-1g
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 08:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hs56t-0000aW-LL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hs56s-0008Kf-Kt
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hs56s-0008Jw-Ei
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:50:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 522893084025;
 Mon, 29 Jul 2019 12:50:37 +0000 (UTC)
Received: from [10.72.12.68] (ovpn-12-68.pek2.redhat.com [10.72.12.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B90460C44;
 Mon, 29 Jul 2019 12:50:36 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1564389226-4489-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA--t_Hjq5G+C_0ShxDcAWQYWfW8w6zDb2DCRR5LfkXX3A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3571f03f-ff11-2622-84b1-2fab7001f182@redhat.com>
Date: Mon, 29 Jul 2019 20:50:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--t_Hjq5G+C_0ShxDcAWQYWfW8w6zDb2DCRR5LfkXX3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 29 Jul 2019 12:50:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/5] Net patches
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


On 2019/7/29 =E4=B8=8B=E5=8D=887:47, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 09:33, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit fff3159900d2b95613a9cb75fc3703e67a6=
74729:
>>
>>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm=
-20190726' into staging (2019-07-26 16:23:07 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to f77bed14f01557596727c4eea042e9818c24204=
9:
>>
>>    net/colo-compare.c: Fix memory leak and code style issue. (2019-07-=
29 16:29:30 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
>> Jason Wang (1):
>>        e1000: don't raise interrupt in pre_save()
>>
>> Prasad J Pandit (3):
>>        qemu-bridge-helper: restrict interface name to IFNAMSIZ
>>        qemu-bridge-helper: move repeating code in parse_acl_file
>>        net: tap: replace snprintf with g_strdup_printf calls
>>
>> Zhang Chen (1):
>>        net/colo-compare.c: Fix memory leak and code style issue.
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
> for any user-visible changes.
>
> -- PMM


Thanks for the reminding.

There's no user-visible changes.


