Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B81F2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B81F2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVW7P-0008O4-0r
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVW5t-0007NT-8Z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:37:09 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVW5q-0001uQ-Dz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:37:08 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.51])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E566667DA428;
 Thu, 22 Oct 2020 10:37:02 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 22 Oct
 2020 10:37:02 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001fd514493-c914-4187-b2ac-32203710fe70,
 519BB44447FDA57395BBEBCDF0C34CC9BD4694BF) smtp.auth=groug@kaod.org
Date: Thu, 22 Oct 2020 10:37:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 2/8] tests/9pfs: add local Tunlinkat directory test
Message-ID: <20201022103700.363f6925@bahia.lan>
In-Reply-To: <3c7c65b476ba44bea6afd0b378b5287e1c671a32.1603285620.git.qemu_oss@crudebyte.com>
References: <cover.1603285620.git.qemu_oss@crudebyte.com>
 <3c7c65b476ba44bea6afd0b378b5287e1c671a32.1603285620.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 46db69c4-8ac8-48c3-8de2-39b36b469cf9
X-Ovh-Tracer-Id: 4948893041949972890
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:37:03
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 14:17:01 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This test case uses a Tunlinkat 9p request with flag AT_REMOVEDIR
> (see 'man 2 unlink') to remove a directory from host's test directory.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 21807037df..abd7e44648 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -258,6 +258,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RLOPEN ? "RLOPEN" :
>          id == P9_RWRITE ? "RWRITE" :
>          id == P9_RMKDIR ? "RMKDIR" :
> +        id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :
>          id == P9_RREADDIR ? "READDIR" :
>          "<unknown>";
> @@ -693,6 +694,33 @@ static void v9fs_rmkdir(P9Req *req, v9fs_qid *qid)
>      v9fs_req_free(req);
>  }
>  
> +/* size[4] Tunlinkat tag[2] dirfd[4] name[s] flags[4] */
> +static P9Req *v9fs_tunlinkat(QVirtio9P *v9p, uint32_t dirfd, const char *name,
> +                             uint32_t flags, uint16_t tag)
> +{
> +    P9Req *req;
> +
> +    uint32_t body_size = 4 + 4;
> +    uint16_t string_size = v9fs_string_size(name);
> +
> +    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
> +    body_size += string_size;
> +
> +    req = v9fs_req_init(v9p, body_size, P9_TUNLINKAT, tag);
> +    v9fs_uint32_write(req, dirfd);
> +    v9fs_string_write(req, name);
> +    v9fs_uint32_write(req, flags);
> +    v9fs_req_send(req);
> +    return req;
> +}
> +
> +/* size[4] Runlinkat tag[2] */
> +static void v9fs_runlinkat(P9Req *req)
> +{
> +    v9fs_req_recv(req, P9_RUNLINKAT);
> +    v9fs_req_free(req);
> +}
> +
>  /* basic readdir test where reply fits into a single response message */
>  static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
> @@ -1004,6 +1032,22 @@ static void do_mkdir(QVirtio9P *v9p, const char *path, const char *cname)
>      g_free(name);
>  }
>  
> +static void do_unlinkat(QVirtio9P *v9p, const char *atpath, const char *rpath,
> +                        uint32_t flags)
> +{
> +    char *const name = g_strdup(rpath);
> +    uint32_t fid;
> +    P9Req *req;
> +
> +    fid = do_walk(v9p, atpath);
> +
> +    req = v9fs_tunlinkat(v9p, fid, name, flags, 0);
> +    v9fs_req_wait_for_reply(req, NULL);
> +    v9fs_runlinkat(req);
> +
> +    g_free(name);
> +}
> +
>  static void fs_readdir_split_128(void *obj, void *data,
>                                   QGuestAllocator *t_alloc)
>  {
> @@ -1050,6 +1094,32 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(root_path);
>  }
>  
> +static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    alloc = t_alloc;
> +    struct stat st;
> +    char *root_path = virtio_9p_test_path("");
> +    char *new_dir = virtio_9p_test_path("02");
> +
> +    g_assert(root_path != NULL);
> +
> +    do_attach(v9p);
> +    do_mkdir(v9p, "/", "02");
> +
> +    /* check if created directory really exists now ... */
> +    g_assert(stat(new_dir, &st) == 0);
> +    /* ... and is actually a directory */
> +    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
> +
> +    do_unlinkat(v9p, "/", "02", AT_REMOVEDIR);
> +    /* directory should be gone now */
> +    g_assert(stat(new_dir, &st) != 0);
> +
> +    g_free(new_dir);
> +    g_free(root_path);
> +}
> +
>  static void *assign_9p_local_driver(GString *cmd_line, void *arg)
>  {
>      virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
> @@ -1090,6 +1160,7 @@ static void register_virtio_9p_test(void)
>      opts.before = assign_9p_local_driver;
>      qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
>      qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
> +    qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
>  }
>  
>  libqos_init(register_virtio_9p_test);


