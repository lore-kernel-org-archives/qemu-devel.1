Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F7BC2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EF72078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EF72078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrUk-0000fw-Be
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jMrTk-0008HV-6B
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jMrTj-0001gz-0S
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:05:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:47788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jMrTi-0001g7-Qb
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 07:05:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jMrTh-0004d4-1A
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 11:05:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 05FFD2E8104
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 11:05:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2020 10:55:52 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1871798@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: configure pie windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee cat-7 chewi philmd
X-Launchpad-Bug-Reporter: James Le Cuirot (chewi)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158642182265.5805.199845175533907355.malonedeb@chaenomeles.canonical.com>
 <20200409211529.5269-8-alex.bennee@linaro.org>
Message-Id: <427d4303-f69b-bbf8-7b2d-12805c61f816@redhat.com>
Subject: [Bug 1871798] Re: [PATCH v1 07/11] configure: disable PIE for Windows
 builds
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5b91f02fd74928a08fe2a9e173ffce91633d79f4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1871798 <1871798@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200410105552.xhTF6Lf_iAwevc_6yjcJs3VVfycwCEC-qDtVTrHw8C0@z>

On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> It seems on some compilers the test can pass but still give you
> broken binaries.
> =

> [AJB untested - please could windows users test]
> =

> Fixes: d2cd29e30736
> Fixes: https://bugs.launchpad.net/qemu/+bug/1871798
> Cc: Bug 1871798 <1871798@bugs.launchpad.net>
> Cc: James Le Cuirot <chewi@aura-online.co.uk>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   configure | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/configure b/configure
> index a207cce82bc..e9c5f630c14 100755
> --- a/configure
> +++ b/configure
> @@ -807,6 +807,7 @@ MINGW32*)
>       audio_drv_list=3D""
>     fi
>     supported_os=3D"yes"
> +  pie=3D"no"
>   ;;
>   GNU/kFreeBSD)
>     bsd=3D"yes"
> =


Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1871798

Title:
  Fails to start on Windows host without explicit --disable-pie

Status in QEMU:
  Incomplete

Bug description:
  Since commit d2cd29e30736afd4a1e8cac3cf4da360bbc65978, which removed
  the x86 conditional around PIE, QEMU completely fails to start on a
  Windows host unless --disable-pie is explicitly given at build time.
  Even just requesting the help text doesn't work. To make testing
  easier, this can be replicated with Wine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1871798/+subscriptions

