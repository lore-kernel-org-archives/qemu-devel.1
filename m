Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC3CF20838
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3CF20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Qbu-0007bI-Ox
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1Qb9-0007AD-Ki
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:41:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:60296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k1Qb7-0006Tj-Je
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:41:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k1Qb5-0003bX-HC
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 33C252E80EE
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2020 08:33:22 -0000
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
 <2acf854f-c49a-0811-31af-80e1e958f058@redhat.com>
Message-ID: <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
Subject: [Bug 1879672] Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a7617c13ad4a6e2a4944317eb2c6c046c463d513
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:41:21
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
Message-ID: <20200731083322.ENhRhT75ndr6ZlmpCzUolBeHSkZ1fi7_HbqaUewWaO8@z>

Hi Justin, Sunil,

On 5/20/20 12:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> +launchpad ticket
> =

> On 9/20/19 6:53 PM, Justin Terry (VM) wrote:
>> Hey Phil,
>>
>> I have contacted our legal department for guidance on this specific
>> use case and will update you when I hear back. Thank you for your
>> patience.

I recently understood legal changes can be very complex, thus it is
implicit it can take years before getting updates.

Since the project is still actively developed, maybe you could provide
a Azure CI job to build a WHPX binary. We don't need to have access to
the binary, just to the exit status (success/fail) and build logs.

Do you think it is doable?

Thanks,

Phil.

>>
>> Justin Terry
>>
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Sent: Friday, September 20, 2019 8:18 AM
>>> To: qemu-devel@nongnu.org; Justin Terry (VM) <juterry@microsoft.com>
>>> Cc: Daniel P . Berrang=C3=A9 <berrange@redhat.com>; Fam Zheng
>>> <fam@euphon.net>; Thomas Huth <thuth@redhat.com>; Paolo Bonzini
>>> <pbonzini@redhat.com>; Alex Benn=C3=A9e <alex.bennee@linaro.org>; Richa=
rd
>>> Henderson <rth@twiddle.net>; Eduardo Habkost <ehabkost@redhat.com>;
>>> Stefan Weil <sw@weilnetz.de>
>>> Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
>>>
>>> On 9/20/19 1:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Add a job to cross-build QEMU with WHPX enabled.
>>>>
>>>> Since the WHPX is currently broken, include the patch required to have
>>>> successful Shippable build.
>>>>
>>>> I previously included the WHPX headers shared by the Android project,
>>>> and Daniel asked me to check the EULA. While trying to manually
>>>> install the Windows SDK, I noticed the installer fetches archives
>>>> directly, kindly asking where they are stored via the /fwlink API.
>>>> Do the same, fetch the required archives and extract them. No need to
>>>> accept EULA...
>>>>
>>>> Docker build the image first, then build QEMU in a instance of this
>>>> image. The image is internal to Shippable, the instances are not
>>>> reachable and are thrown once the build is finished. What we collect
>>>> from Shippable is the console output of QEMU build process, and if the
>>>> build process succeed or failed. So far we do not redistribute the
>>>> image or built binaries.
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 (3):
>>>> =C2=A0=C2=A0 target/i386: Fix broken build with WHPX enabled
>>>> =C2=A0=C2=A0 tests/docker: Add fedora-win10sdk-cross image
>>>> =C2=A0=C2=A0 .shippable.yml: Build WHPX enabled binaries
>>>
>>> FWIW here is the result of this series:
>>> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fapp.
>>> shippable.com%2Fgithub%2Fphilmd%2Fqemu%2Fruns%2F516%2F11%2Fcon
>>> sole&amp;data=3D02%7C01%7Cjuterry%40microsoft.com%7C733a566f3233427
>>> 8ae6f08d73dddb39f%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
>>> 37045894733463150&amp;sdata=3D55URgDII5r74QMUpLOD%2FWT5%2B5jbzyv
>>> nfCSdv%2FNaWDAw%3D&amp;reserved=3D0
>>> Duration 17 minutes (1076 seconds)
>>>
>>> 4m49s building the qemu:fedora-win10sdk-cross docker image, 11m10s
>>> building WHPX QEMU.
>

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

