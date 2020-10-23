Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52273C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9730321D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9730321D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVziG-0000li-HM
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVz35-0001R5-Lb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:32:11 -0400
Received: from 5.mo51.mail-out.ovh.net ([188.165.49.213]:40600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVz32-00026K-Du
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:32:11 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.66])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 0284F2327E9;
 Fri, 23 Oct 2020 17:32:03 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 23 Oct
 2020 17:32:03 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e61b585c-4dec-48de-940b-8b3b665ed247,
 C0BA1F4BE5C42AD64430581CA289E8EEBB8A5892) smtp.auth=groug@kaod.org
Date: Fri, 23 Oct 2020 17:32:02 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PULL 01/13] tests/9pfs: Factor out do_version() helper
Message-ID: <20201023172950.4b148e3f@bahia.lan>
In-Reply-To: <ccc858509ddfa3f6244cc4caf92c4149b7269b43.1603452058.git.qemu_oss@crudebyte.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <ccc858509ddfa3f6244cc4caf92c4149b7269b43.1603452058.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 116d6bd5-5420-428f-9677-d69b5087557d
X-Ovh-Tracer-Id: 17830595349952960989
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhg
Received-SPF: pass client-ip=188.165.49.213; envelope-from=groug@kaod.org;
 helo=5.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:32:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It feels weird to receive a mail I didn't send with my address
in the top From: header. I would have expected yours instead and
another From: with my address in the changelog...


On Tue, 20 Oct 2020 18:09:14 +0200
Greg Kurz <groug@kaod.org> wrote:

... here.

> fs_version() is a top level test function. Factor out the reusable
> code to a separate helper instead of hijacking it in other tests.
> 

> Signed-off-by: Greg Kurz <groug@kaod.org>
> Message-Id: <160321015403.266767.4533967728943968456.stgit@bahia.lan>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index c15908f27b..59bcea4c30 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -567,10 +567,8 @@ static void v9fs_rflush(P9Req *req)
>      v9fs_req_free(req);
>  }
>  
> -static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
> +static void do_version(QVirtio9P *v9p)
>  {
> -    QVirtio9P *v9p = obj;
> -    alloc = t_alloc;
>      const char *version = "9P2000.L";
>      uint16_t server_len;
>      char *server_version;
> @@ -585,13 +583,19 @@ static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(server_version);
>  }
>  
> +static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
> +    alloc = t_alloc;
> +    do_version(obj);
> +}
> +
>  static void fs_attach(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
>      alloc = t_alloc;
>      P9Req *req;
>  
> -    fs_version(v9p, NULL, t_alloc);
> +    do_version(v9p);
>      req = v9fs_tattach(v9p, 0, getuid(), 0);
>      v9fs_req_wait_for_reply(req, NULL);
>      v9fs_rattach(req, NULL);
> @@ -831,7 +835,7 @@ static void fs_walk_dotdot(void *obj, void *data, QGuestAllocator *t_alloc)
>      v9fs_qid root_qid, *wqid;
>      P9Req *req;
>  
> -    fs_version(v9p, NULL, t_alloc);
> +    do_version(v9p);
>      req = v9fs_tattach(v9p, 0, getuid(), 0);
>      v9fs_req_wait_for_reply(req, NULL);
>      v9fs_rattach(req, &root_qid);



