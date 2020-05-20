Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E418C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC292207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 10:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC292207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbM5u-0001Xr-1I
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 06:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbM4Y-0008CH-WD
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:35:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:59804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbM4Y-00024V-11
 for qemu-devel@nongnu.org; Wed, 20 May 2020 06:35:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbM4W-0006H3-HR
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:35:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7EDA92E8024
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:35:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2020 10:25:24 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1879672@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158996968484.21371.12685815665992748631.malonedeb@wampee.canonical.com>
Message-ID: <2e5c6b54-2ffc-6cac-cc53-71b24f2660f4@redhat.com>
Subject: [Bug 1879672] Re: [PATCH 0/2] testing: Build WHPX enabled binaries
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6907253ec8e1e469b845fb57ddfa00215e5aa291
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 06:20:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1879672 <1879672@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200520102524.1p8bi60UtYzmT0kToIErWzMpNOuxpNv5XdlsurLZr3U@z>

+launchpad ticket

On 9/19/19 1:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/19/19 1:18 PM, Stefan Weil wrote:
>> Am 19.09.2019 um 12:59 schrieb Philippe Mathieu-Daud=C3=A9:
>>> Add a job to cross-build QEMU with WHPX enabled.
>>>
>>> Use the Win10SDK headers from the Android Project, as commented
>>> in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.html
>>>
>>> Based-on: <20190918121101.30690-1-philmd@redhat.com>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html
>>>
>>> Philippe Mathieu-Daud=C3=A9 (2):
>>>    tests/docker: Add fedora-win10sdk-cross image
>>>    .shippable.yml: Build WHPX enabled binaries
>>>
>>>   .shippable.yml                                |  2 ++
>>>   tests/docker/Makefile.include                 |  1 +
>>>   .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
>>>   3 files changed, 24 insertions(+)
>>>   create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.doc=
ker
>>>
>>
>> Please note that the required header files are part of the Win10SDK
>> which is not published under a free license, so I am afraid that they
>> cannot be used with QEMU code to produce free binaries.
> =

> Yes :S
> =

>> I have addressed that some time ago, and Justin Terry is still looking
>> for a solution on the Microsoft side.
> =

> Oh this is a good news, thanks for caring about this issue,
> and thanks Justin for looking for a solution!
> =

> Trying to understand how WHPX is used, I noticed there are much many
> Windows QEMU users than I thought, and it would be nice if we can have
> some upstream CI testing to not break the various projects using it.
> =

> Regards,
> =

> Phil.
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879672

Title:
  QEMU installer with WHPX support

Status in QEMU:
  New

Bug description:
  People often ask the community to add WHPX support to the QEMU installer =
for Windows,
  but it is impossible due to the license limitations of the WHPX SDK.

  The WinHvEmulation.h and WinHvPlatform.h header files needed are "All
  rights reserved".

  However these headers only contain struct definitions and integer constan=
ts,
  no functional code in macros or inline functions. See:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg645815.html
  It is questionable whether the headers alone can be considered copyrighta=
ble material.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879672/+subscriptions

