Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ACCC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E09206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E09206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrj0-000788-L5
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kHq7Y-0003Vi-FO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:20 -0400
Received: from relay68.bu.edu ([128.197.228.73]:55056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kHq7W-0000fy-4x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:10:19 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 08EF9Yv0019743
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2020 11:09:39 -0400
Date: Mon, 14 Sep 2020 11:09:34 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Bug 1895219 <1895219@bugs.launchpad.net>
Subject: Re: [Bug 1895219] Re: qemu git -vnc fails due to missing en-us keymap
Message-ID: <20200914150934.ratvtegtv2aghr74@mozz.bu.edu>
References: <159978635021.22139.4037516560250644869.malonedeb@wampee.canonical.com>
 <160009007915.15025.5721686079641285935.launchpad@gac.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160009007915.15025.5721686079641285935.launchpad@gac.canonical.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 11:10:16
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.892, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200914150934.psYbUaQPQX8Gu8OASGY55Xi8JfMYCqu_WVa56517LZ0@z>

I can also reproduce this issue. +CC Gerd Hoffmann


On 200914 1327, Darren Blaber wrote:
> ** Branch unlinked: lp:envbot/0.0.1
> 
> -- 
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1895219
> 
> Title:
>   qemu git -vnc fails due to missing en-us keymap
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   If trying to run qemu with -vnc :0, it will fail with:
>   ./qemu-system-x86_64 -vnc :2
>   qemu-system-x86_64: -vnc :2: could not read keymap file: 'en-us'
> 
>   share/keymaps is missing en-us keymap and only has sl and sv,
>   confirmed previous stable versions had en-us.
> 
>   Tried with multiple targets, on arm64 and amd64
> 
>   Git commit hash: 9435a8b3dd35f1f926f1b9127e8a906217a5518a (head)
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1895219/+subscriptions
> 

