Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0DCC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A611223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A611223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWZC-0006OO-59
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVWUm-0003oR-KZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:02:52 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:49645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVWUh-0002er-Qd
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:02:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.48])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 6910D67DC544;
 Thu, 22 Oct 2020 11:02:45 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 22 Oct
 2020 11:02:44 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00382599e24-f80c-48ef-8d2c-87822315e2a8,
 519BB44447FDA57395BBEBCDF0C34CC9BD4694BF) smtp.auth=groug@kaod.org
Date: Thu, 22 Oct 2020 11:02:44 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 7/8] tests/9pfs: add local Tlink test
Message-ID: <20201022110244.3abc6c85@bahia.lan>
In-Reply-To: <f0d869770ad23ee5ce10f7da90fdb742cadcad72.1603285620.git.qemu_oss@crudebyte.com>
References: <cover.1603285620.git.qemu_oss@crudebyte.com>
 <f0d869770ad23ee5ce10f7da90fdb742cadcad72.1603285620.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: b9d901fd-3cc4-47cc-aefd-8011b4e086bf
X-Ovh-Tracer-Id: 5383208932490647962
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
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

On Wed, 21 Oct 2020 14:51:09 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This test case uses a Tlink request to create a hard link to a regular
> file using the 9pfs 'local' fs driver.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 33cba24b18..460fa49fe3 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -260,6 +260,7 @@ static const char *rmessage_name(uint8_t id)
>          id == P9_RMKDIR ? "RMKDIR" :
>          id == P9_RLCREATE ? "RLCREATE" :
>          id == P9_RSYMLINK ? "RSYMLINK" :
> +        id == P9_RLINK ? "RLINK" :
>          id == P9_RUNLINKAT ? "RUNLINKAT" :
>          id == P9_RFLUSH ? "RFLUSH" :
>          id == P9_RREADDIR ? "READDIR" :
> @@ -767,6 +768,33 @@ static void v9fs_rsymlink(P9Req *req, v9fs_qid *qid)
>      v9fs_req_free(req);
>  }
>  
> +/* size[4] Tlink tag[2] dfid[4] fid[4] name[s] */
> +static P9Req *v9fs_tlink(QVirtio9P *v9p, uint32_t dfid, uint32_t fid,
> +                         const char *name, uint16_t tag)
> +{
> +    P9Req *req;
> +
> +    uint32_t body_size = 4 + 4;
> +    uint16_t string_size = v9fs_string_size(name);
> +
> +    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
> +    body_size += string_size;
> +
> +    req = v9fs_req_init(v9p, body_size, P9_TLINK, tag);
> +    v9fs_uint32_write(req, dfid);
> +    v9fs_uint32_write(req, fid);
> +    v9fs_string_write(req, name);
> +    v9fs_req_send(req);
> +    return req;
> +}
> +
> +/* size[4] Rlink tag[2] */
> +static void v9fs_rlink(P9Req *req)
> +{
> +    v9fs_req_recv(req, P9_RLINK);
> +    v9fs_req_free(req);
> +}
> +
>  /* size[4] Tunlinkat tag[2] dirfd[4] name[s] flags[4] */
>  static P9Req *v9fs_tunlinkat(QVirtio9P *v9p, uint32_t dirfd, const char *name,
>                               uint32_t flags, uint16_t tag)
> @@ -1142,6 +1170,21 @@ static void do_symlink(QVirtio9P *v9p, const char *path, const char *clink,
>      g_free(name);
>  }
>  
> +/* create a hard link named @a clink in directory @a path pointing to @a to */
> +static void do_hardlink(QVirtio9P *v9p, const char *path, const char *clink,
> +                        const char *to)
> +{
> +    uint32_t dfid, fid;
> +    P9Req *req;
> +
> +    dfid = do_walk(v9p, path);
> +    fid = do_walk(v9p, to);
> +
> +    req = v9fs_tlink(v9p, dfid, fid, clink, 0);
> +    v9fs_req_wait_for_reply(req, NULL);
> +    v9fs_rlink(req);
> +}
> +
>  static void do_unlinkat(QVirtio9P *v9p, const char *atpath, const char *rpath,
>                          uint32_t flags)
>  {
> @@ -1321,6 +1364,33 @@ static void fs_unlinkat_symlink(void *obj, void *data,
>      g_free(real_file);
>  }
>  
> +static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    alloc = t_alloc;
> +    struct stat st_real, st_link;
> +    char *real_file = virtio_9p_test_path("07/real_file");
> +    char *hardlink_file = virtio_9p_test_path("07/hardlink_file");
> +
> +    do_attach(v9p);
> +    do_mkdir(v9p, "/", "07");
> +    do_lcreate(v9p, "07", "real_file");
> +    g_assert(stat(real_file, &st_real) == 0);
> +    g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
> +
> +    do_hardlink(v9p, "07", "hardlink_file", "07/real_file");
> +
> +    /* check if link exists now ... */
> +    g_assert(stat(hardlink_file, &st_link) == 0);
> +    /* ... and it's a hard link, right? */
> +    g_assert((st_link.st_mode & S_IFMT) == S_IFREG);
> +    g_assert(st_link.st_dev == st_real.st_dev);
> +    g_assert(st_link.st_ino == st_real.st_ino);
> +
> +    g_free(hardlink_file);
> +    g_free(real_file);
> +}
> +
>  static void *assign_9p_local_driver(GString *cmd_line, void *arg)
>  {
>      virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
> @@ -1367,6 +1437,7 @@ static void register_virtio_9p_test(void)
>      qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
>      qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
>                   &opts);
> +    qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
>  }
>  
>  libqos_init(register_virtio_9p_test);


