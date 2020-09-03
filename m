Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473CDC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F2D20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F2D20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrkB-00071l-7q
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDrhQ-0003KW-41
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:02:56 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:52197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDrhN-0006ea-U4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:02:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.8])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4A092572881A;
 Thu,  3 Sep 2020 18:02:50 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 3 Sep 2020
 18:02:49 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0058ebef85b-6f19-405a-a748-ee95702c255e,
 FF22E3E2F99647A0705B7EB067E934078DCBDF97) smtp.auth=groug@kaod.org
Date: Thu, 3 Sep 2020 18:02:48 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 1/1] 9pfs: log warning if msize <= 8192
Message-ID: <20200903180248.6199bb7b@bahia.lan>
In-Reply-To: <e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f.1599144062.git.qemu_oss@crudebyte.com>
References: <cover.1599144062.git.qemu_oss@crudebyte.com>
 <e6fc84845c95816ad5baecb0abd6bfefdcf7ec9f.1599144062.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ae6eb1ef-4199-4211-a3e5-6b69bd03cd76
X-Ovh-Tracer-Id: 1416945036509092317
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeggedvvdethfdttddvhfeiudetvdfgjedtudetgfevheeijeeileevffegkeehnecuffhomhgrihhnpehqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 11:20:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 16:20:21 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> It is essential to choose a reasonable high value for 'msize' to avoid
> severely degraded file I/O performance. This parameter can only be
> chosen on client/guest side, and a Linux client defaults to an 'msize'
> of only 8192 if the user did not explicitly specify a value for 'msize',
> which results in very poor file I/O performance.
> 
> Unfortunately many users are not aware that they should specify an
> appropriate value for 'msize' to avoid severe performance issues, so
> log a performance warning (with a QEMU wiki link explaining this issue
> in detail) on host side in that case to make it more clear.
> 
> Currently a client cannot automatically pick a reasonable value for
> 'msize', because a good value for 'msize' depends on the file I/O
> potential of the underlying storage on host side, i.e. a feature
> invisible to the client, and even then a user would still need to trade
> off between performance profit and additional RAM costs, i.e. with
> growing 'msize' (RAM occupation), performance still increases, but
> performance delta will shrink continuously.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 7bb994bbf2..99b6f24fd6 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1353,6 +1353,15 @@ static void coroutine_fn v9fs_version(void *opaque)
>          goto out;
>      }
>  
> +    /* 8192 is the default msize of Linux clients */
> +    if (s->msize <= 8192) {

I agree that an msize of 8192 suck from a performance standpoint but
I guess many users are msize agnostic, and they use the default value
without even knowing it. They might not even care for performance at
all, otherwise they'd likely ask google and they will eventually land
on:

https://wiki.qemu.org/Documentation/9psetup#Performance_Considerations

But with this patch, they will now get a warning each time they start
QEMU, maybe freak out and file reports in launchpad. So I suggest you
turn <= into < to avoid bothering these placid users with a warning.

Anyway, it's your choice :) so if you manage to get the #msize anchor to
work as expected:

Reviewed-by: Greg Kurz <groug@kaod.org>

> +        warn_report_once(
> +            "9p: degraded performance: a reasonable high msize should be "
> +            "chosen on client/guest side (chosen msize is <= 8192). See "
> +            "https://wiki.qemu.org/Documentation/9psetup#msize for details."
> +        );
> +    }
> +
>  marshal:
>      err = pdu_marshal(pdu, offset, "ds", s->msize, &version);
>      if (err < 0) {


