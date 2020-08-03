Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:02:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DA220672
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DA220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YEL-0008ST-U5
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2YDI-00081e-5w
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:01:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:33388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2YDF-0002fu-0V
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:01:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2YDC-00066Z-E0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 11:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6190B2E80D2
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 11:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 10:51:35 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1879672@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Opinion; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange philmd ubuntu-weilnetz
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158996968484.21371.12685815665992748631.malonedeb@wampee.canonical.com>
Message-ID: <b8afd626-b6ae-d6fa-c8b7-5e5778574c07@redhat.com>
Subject: [Bug 1879672] Re: [EXTERNAL] Re: [PATCH v2 0/3] testing: Build WHPX
 enabled binaries
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 38cef08c27491d80b05f23b00c94cf74a81c0337
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 07:00:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20200803105135.Fg4kStcm-ppSGt5KWd2ELJiXIiZNqRrN3smuDC9Y4WI@z>

Hi Sunil,

On 8/1/20 1:31 AM, Sunil Muthuswamy wrote:
>> Hi Justin, Sunil,
> =

> Justin has moved to a different team is no longer working with WHPX. Movi=
ng him
> to bcc.

OK. Does that mean you are the new responsible of updating the ticket
regarding the WHPX headers and their license?

> =

>>
>> On 5/20/20 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> +launchpad ticket
>>>
>>> On 9/20/19 6:53 PM, Justin Terry (VM) wrote:
>>>> Hey Phil,
>>>>
>>>> I have contacted our legal department for guidance on this specific
>>>> use case and will update you when I hear back. Thank you for your
>>>> patience.
>>
>> I recently understood legal changes can be very complex, thus it is
>> implicit it can take years before getting updates.
>>
>> Since the project is still actively developed, maybe you could provide
>> a Azure CI job to build a WHPX binary. We don't need to have access to
>> the binary, just to the exit status (success/fail) and build logs.
>>
>> Do you think it is doable?
>>
>> Thanks,
>>
>> Phil.
>>
> The ask generally sounds reasonable. But, can you help me understand the =
full
> scope of the ask. Few questions:
> 1. Stefan has a CI pipeline to build WHPX.

Great! I didn't know Stefan already did it :)
Can you share the URL please, so we can integrate it with mainstream CI?

> What's the benefit of having another CI
> job, that doesn't export the binary, but, just the status?

As usual, we do not want to circumvent the license. IANAL but IIUC we
can not force a CI job to accept the EULA when installing it, even to
test it. So the best we can do is check if the build succeeded (exit
status).

> 2. Which branch is the CI pipeline expected to build?

'master', to be sure no regressions are introduced.

> 3. Is the expectation also that it will build WHPX patches that are submi=
tted to the
> WHPX branch?

You describe a "downstream CI" testing, which is out of scope of the
community public CI.

Regards,

Phil.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879672

Title:
  QEMU installer with WHPX support

Status in QEMU:
  Opinion

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

