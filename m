Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8108BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509BF20578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509BF20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDr2j-0007EP-Dk
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDr27-0006gz-GO
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:20:17 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:60147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kDr24-0007Xw-IL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:20:15 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.252])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 89BB55724584;
 Thu,  3 Sep 2020 17:19:33 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 3 Sep 2020
 17:19:33 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0044bba4b4b-9b4e-491f-a895-5c117f28b309,
 FF22E3E2F99647A0705B7EB067E934078DCBDF97) smtp.auth=groug@kaod.org
Date: Thu, 3 Sep 2020 17:19:31 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 0/1] 9pfs: log warning if msize <= 8192
Message-ID: <20200903171931.3bfe611a@bahia.lan>
In-Reply-To: <cover.1599144062.git.qemu_oss@crudebyte.com>
References: <cover.1599144062.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f8443b98-e691-4da4-bab8-e18eabd6f2e0
X-Ovh-Tracer-Id: 685954519315093981
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheeggedvvdethfdttddvhfeiudetvdfgjedtudetgfevheeijeeileevffegkeehnecuffhomhgrihhnpehqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepsggvrhhrrghnghgvsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 11:20:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 3 Sep 2020 16:41:02 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> I have updated the QEMU 9P setup wiki page about this 'msize' issue. For
> some reason the dedicated anchor 'msize' does not work though:
> 
> https://wiki.qemu.org/Documentation/9psetup#msize
> 

AFAICT the wiki derives the anchor from the section name, ie.

https://wiki.qemu.org/Documentation/9psetup#Performance_Considerations

It's a bit longer than #msize but it works. I don't know if you can
add anchors manually in the wiki.

> Not sure whether that's a wiki installation problem? When I view the wiki
> source, it looks like it is showing some errors there.
> 
> v1->v2:
> 
>   * Updated commit log message to make it more clear why the client cannot
>     auto pick a good value for 'msize'.
> 
>   * Added a web link to the log message, pointing to the appropriate QEMU
>     wiki page which explains the 'msize' issue in detail.
> 
> Message-ID of previous version (v1):
>   E1kDR8W-0001s4-Sr@lizzy.crudebyte.com
> 
> Christian Schoenebeck (1):
>   9pfs: log warning if msize <= 8192
> 
>  hw/9pfs/9p.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 


