Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF4C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4732067D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4732067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huco9-0005xb-Cv
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mprivozn@redhat.com>) id 1hucnf-0005Xr-Pa
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1hucne-0005sZ-N3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hucne-0005rw-Hr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:13:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C47F5C064293;
 Mon,  5 Aug 2019 13:13:17 +0000 (UTC)
Received: from [10.40.204.137] (ovpn-204-137.brq.redhat.com [10.40.204.137])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FFD05D6C8;
 Mon,  5 Aug 2019 13:13:14 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190803082517.15035-1-philmd@redhat.com>
 <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <a4158e8a-d67f-52b5-c082-681d21ac2599@redhat.com>
Date: Mon, 5 Aug 2019 15:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cPDdwXkSra_8vxE8c9M2y91s5FvpB7sZh12xF-LPUWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sk-SK
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 13:13:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/1] EDK2 firmware patches
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

On 8/3/19 12:22 PM, Peter Maydell wrote:
> On Sat, 3 Aug 2019 at 09:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>
>> The following changes since commit 9bcf2dfa163f67b0fec6ee0fe88ad5dc5d6=
9dc59:
>>
>>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-CVE-2019-14=
378-pull-request' into staging (2019-08-02 13:06:03 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/philmd/qemu.git tags/edk2-next-20190803
>>
>> for you to fetch changes up to 177cd674d6203d3c1a98e170ea56c5a904ac4ce=
8:
>>
>>   Makefile: remove DESTDIR from firmware file content (2019-08-03 09:5=
2:32 +0200)
>>
>> ----------------------------------------------------------------
>> A harmless build-sys patch that fixes a regression affecting Linux
>> distributions packaging QEMU.
>>
>> ----------------------------------------------------------------
>>
>> Olaf Hering (1):
>>   Makefile: remove DESTDIR from firmware file content
>=20
> Is this pullreq intended for 4.1 ?

Please do pull it into 4.1 as the commit it fixes is aiming at 4.1 (just
like the whole feature). If not included then distros will need to
backport it anyway. Just my $0.02. Let's wait for Philippe's confirmation=
.

Michal

