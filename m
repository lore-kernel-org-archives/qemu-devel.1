Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C520AC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B6220748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B6220748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrOK-0008Au-Rd
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtrNM-0007hj-VK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:39:32 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:54792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtrNK-0004fW-NU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:39:32 -0400
Received: from player756.ha.ovh.net (unknown [10.110.103.202])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 41102285BE5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 13:39:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 6387113690817;
 Fri, 10 Jul 2020 11:39:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003d0ed600b-f191-4f14-bfbb-68d1210d96ae,79C9B0F10FB5BF228F7D40D3961FE6ED0EC6D924)
 smtp.auth=groug@kaod.org
Date: Fri, 10 Jul 2020 13:39:13 +0200
From: Greg Kurz <groug@kaod.org>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] 9p: null terminate fs driver options list
Message-ID: <20200710133913.49a2cbea@bahia.lan>
In-Reply-To: <20200709175848.650400-1-ppandit@redhat.com>
References: <20200709175848.650400-1-ppandit@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6009490756148631861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrvddugdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeettdeugfetgfegteehleeivedtveegfeelgfefkefftedvgfdttddujefgkeevhfenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.173.103; envelope-from=groug@kaod.org;
 helo=5.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 07:39:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  9 Jul 2020 23:28:48 +0530
P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> NULL terminate fs driver options' list, validate_opt() looks for
> a null entry to terminate the loop.
> 

Good catch ! And this never bit us before because opt ends up
pointing to some valid memory containing zeroes... by luck :)

I've added a Fixes tag and applied this to the 9p-fix branch.

https://github.com/gkurz/qemu/commits/9p-fix

Cheers,

--
Greg

> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  fsdev/qemu-fsdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index a9e069c0c7..3da64e9f72 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -78,6 +78,7 @@ static FsDriverTable FsDrivers[] = {
>              "throttling.iops-read-max-length",
>              "throttling.iops-write-max-length",
>              "throttling.iops-size",
> +            NULL
>          },
>      },
>      {
> @@ -85,6 +86,7 @@ static FsDriverTable FsDrivers[] = {
>          .ops = &synth_ops,
>          .opts = (const char * []) {
>              COMMON_FS_DRIVER_OPTIONS,
> +            NULL
>          },
>      },
>      {
> @@ -95,6 +97,7 @@ static FsDriverTable FsDrivers[] = {
>              "socket",
>              "sock_fd",
>              "writeout",
> +            NULL
>          },
>      },
>  };


