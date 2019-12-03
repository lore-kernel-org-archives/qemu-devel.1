Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E462620675
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 09:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E462620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic4r5-0005QG-8A
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 04:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ic4oM-0004S0-J3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ic4oK-0001K9-Au
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:49:38 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:50321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ic4oC-0000t5-8P
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 04:49:30 -0500
Received: from player761.ha.ovh.net (unknown [10.108.42.215])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id BC1E7124CC0
 for <qemu-devel@nongnu.org>; Tue,  3 Dec 2019 10:49:18 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id EF90DCD72A2B;
 Tue,  3 Dec 2019 09:49:16 +0000 (UTC)
Date: Tue, 3 Dec 2019 10:49:14 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] 9pfs: well form error hint helpers
Message-ID: <20191203104914.5671fb87@bahia.w3ibm.bluemix.net>
In-Reply-To: <9410855e-8bb1-7623-6940-8848832db662@virtuozzo.com>
References: <20191127191549.21216-1-vsementsov@virtuozzo.com>
 <20191127233742.198e00f7@bahia.w3ibm.bluemix.net>
 <9410855e-8bb1-7623-6940-8848832db662@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3431179966926592339
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehorhdrtgiipdhgihhthhhusgdrtghomhdpghhnuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.44
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 09:36:21 +0000
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 28.11.2019 1:37, Greg Kurz wrote:
> > On Wed, 27 Nov 2019 22:15:49 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> > 
> >> Make error_append_security_model_hint and
> >> error_append_socket_sockfd_hint hint append helpers well formed:
> >> rename errp to errp_in, as it is IN-parameter here (which is unusual
> >> for errp).
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> Acked-by: Greg Kurz <groug@kaod.org>
> >> ---
> >>
> >> v6: add Greg's a-b
> >>
> > 
> > I've already pushed that to my 9p-next branch:
> > 
> > https://github.com/gkurz/qemu/commits/9p-next
> 
> 
> Markus proposed to use Error *const *errp for such cases (among other
> things)
> 
> So, seems there would be v7, the current version is here:
> git://repo.or.cz/qemu/armbru.git branch error-prep
> 
> Discussion is here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04633.html
> and here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg04636.html
> 

Ok, this makes sense. It's cleaner and it addresses your concern
with coccinelle, so I've dropped the patch from my 9p-next branch.

> > 
> > 
> >>   hw/9pfs/9p-local.c | 4 ++--
> >>   hw/9pfs/9p-proxy.c | 5 +++--
> >>   2 files changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> >> index 4708c0bd89..76fa1858b7 100644
> >> --- a/hw/9pfs/9p-local.c
> >> +++ b/hw/9pfs/9p-local.c
> >> @@ -1473,9 +1473,9 @@ static void local_cleanup(FsContext *ctx)
> >>       g_free(data);
> >>   }
> >>   
> >> -static void error_append_security_model_hint(Error **errp)
> >> +static void error_append_security_model_hint(Error **errp_in)
> >>   {
> >> -    error_append_hint(errp, "Valid options are: security_model="
> >> +    error_append_hint(errp_in, "Valid options are: security_model="
> >>                         "[passthrough|mapped-xattr|mapped-file|none]\n");
> >>   }
> >>   
> >> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> >> index 97ab9c58a5..9e29abc3ef 100644
> >> --- a/hw/9pfs/9p-proxy.c
> >> +++ b/hw/9pfs/9p-proxy.c
> >> @@ -1114,9 +1114,10 @@ static int connect_namedsocket(const char *path, Error **errp)
> >>       return sockfd;
> >>   }
> >>   
> >> -static void error_append_socket_sockfd_hint(Error **errp)
> >> +static void error_append_socket_sockfd_hint(Error **errp_in)
> >>   {
> >> -    error_append_hint(errp, "Either specify socket=/some/path where /some/path"
> >> +    error_append_hint(errp_in,
> >> +                      "Either specify socket=/some/path where /some/path"
> >>                         " points to a listening AF_UNIX socket or sock_fd=fd"
> >>                         " where fd is a file descriptor to a connected AF_UNIX"
> >>                         " socket\n");
> > 
> 
> 


