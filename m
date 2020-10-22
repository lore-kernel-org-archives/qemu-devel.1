Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF64C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D36B223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D36B223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWO7-00082k-7P
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVWMz-0007WN-JA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:54:49 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVWMv-0008Gc-Pe
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 04:54:49 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.47])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 3A14767DBA74;
 Thu, 22 Oct 2020 10:54:42 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 22 Oct
 2020 10:54:41 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005acc17777-f0fc-4704-9071-c713a00737c9,
 519BB44447FDA57395BBEBCDF0C34CC9BD4694BF) smtp.auth=groug@kaod.org
Date: Thu, 22 Oct 2020 10:54:40 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 4/8] tests/9pfs: add local Tunlinkat file test
Message-ID: <20201022105440.2cf1c4d1@bahia.lan>
In-Reply-To: <4eabeed7f662721dd5664cb77fe36ea0aa08b1ec.1603285620.git.qemu_oss@crudebyte.com>
References: <cover.1603285620.git.qemu_oss@crudebyte.com>
 <4eabeed7f662721dd5664cb77fe36ea0aa08b1ec.1603285620.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: cc038246-c8bb-4f1f-98c7-845fce2f2be3
X-Ovh-Tracer-Id: 5247256517251864986
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
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

On Wed, 21 Oct 2020 14:28:37 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This test case uses a Tunlinkat request to remove a regular file using
> the 9pfs 'local' fs driver.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index c030bc2a6c..6b74a1fd7e 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -1196,6 +1196,29 @@ static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(new_file);
>  }
>  
> +static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    alloc = t_alloc;
> +    struct stat st;
> +    char *new_file = virtio_9p_test_path("04/doa_file");
> +
> +    do_attach(v9p);
> +    do_mkdir(v9p, "/", "04");
> +    do_lcreate(v9p, "04", "doa_file");
> +
> +    /* check if created file exists now ... */
> +    g_assert(stat(new_file, &st) == 0);
> +    /* ... and is a regular file */
> +    g_assert((st.st_mode & S_IFMT) == S_IFREG);
> +
> +    do_unlinkat(v9p, "04", "doa_file", 0);
> +    /* file should be gone now */
> +    g_assert(stat(new_file, &st) != 0);
> +
> +    g_free(new_file);
> +}
> +
>  static void *assign_9p_local_driver(GString *cmd_line, void *arg)
>  {
>      virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
> @@ -1238,6 +1261,7 @@ static void register_virtio_9p_test(void)
>      qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
>      qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
>      qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
> +    qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
>  }
>  
>  libqos_init(register_virtio_9p_test);


