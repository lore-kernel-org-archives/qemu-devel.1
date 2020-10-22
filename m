Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D7FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D4B2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D4B2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVv4-0004qe-18
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVVtp-0003ek-Ar
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:24:45 -0400
Received: from 5.mo52.mail-out.ovh.net ([188.165.45.220]:35398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVVtl-0005sE-S7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:24:41 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.244])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id B26C81FFF9E;
 Thu, 22 Oct 2020 10:24:32 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 22 Oct
 2020 10:24:31 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006d18d9999-817b-4a5c-a397-007ed2bc184a,
 519BB44447FDA57395BBEBCDF0C34CC9BD4694BF) smtp.auth=groug@kaod.org
Date: Thu, 22 Oct 2020 10:24:30 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 1/8] tests/9pfs: simplify do_mkdir()
Message-ID: <20201022102430.3631ca23@bahia.lan>
In-Reply-To: <4d7275b2363f122438a443ce079cbb355285e9d6.1603285620.git.qemu_oss@crudebyte.com>
References: <cover.1603285620.git.qemu_oss@crudebyte.com>
 <4d7275b2363f122438a443ce079cbb355285e9d6.1603285620.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: c6bde1d0-9e01-4d3c-9c55-f12062881f18
X-Ovh-Tracer-Id: 4737786811507251610
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.45.220; envelope-from=groug@kaod.org;
 helo=5.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:24:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 14:06:53 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Split out walking a directory path to a separate new utility function
> do_walk() and use that function in do_mkdir().
> 
> The code difference saved this way is not much, but we'll use that new
> do_walk() function in the upcoming patches, so it will avoid quite
> some code duplication after all.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 2ea555fa04..21807037df 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -583,6 +583,23 @@ static void do_version(QVirtio9P *v9p)
>      g_free(server_version);
>  }
>  
> +/* utility function: walk to requested dir and return fid for that dir */
> +static uint32_t do_walk(QVirtio9P *v9p, const char *path)
> +{
> +    char **wnames;
> +    P9Req *req;
> +    const uint32_t fid = genfid();
> +
> +    int nwnames = split(path, "/", &wnames);
> +
> +    req = v9fs_twalk(v9p, 0, fid, nwnames, wnames, 0);
> +    v9fs_req_wait_for_reply(req, NULL);
> +    v9fs_rwalk(req, NULL, NULL);
> +
> +    split_free(&wnames);
> +    return fid;
> +}
> +
>  static void fs_version(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
>      alloc = t_alloc;
> @@ -974,23 +991,17 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
>  
>  static void do_mkdir(QVirtio9P *v9p, const char *path, const char *cname)
>  {
> -    char **wnames;
>      char *const name = g_strdup(cname);
> +    uint32_t fid;
>      P9Req *req;
> -    const uint32_t fid = genfid();
>  
> -    int nwnames = split(path, "/", &wnames);
> -
> -    req = v9fs_twalk(v9p, 0, fid, nwnames, wnames, 0);
> -    v9fs_req_wait_for_reply(req, NULL);
> -    v9fs_rwalk(req, NULL, NULL);
> +    fid = do_walk(v9p, path);
>  
>      req = v9fs_tmkdir(v9p, fid, name, 0750, 0, 0);
>      v9fs_req_wait_for_reply(req, NULL);
>      v9fs_rmkdir(req, NULL);
>  
>      g_free(name);
> -    split_free(&wnames);
>  }
>  
>  static void fs_readdir_split_128(void *obj, void *data,


