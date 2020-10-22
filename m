Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE619C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431F222249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431F222249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWUt-0003fd-8e
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVWTS-0002a5-Pk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:01:30 -0400
Received: from 4.mo51.mail-out.ovh.net ([188.165.42.229]:53808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVWTN-0002Hf-2M
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:01:30 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.52])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id D4FFA22E828;
 Thu, 22 Oct 2020 11:01:21 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 22 Oct
 2020 11:01:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001e0398319-34a5-4305-a30a-8f5ff5f17d37,
 519BB44447FDA57395BBEBCDF0C34CC9BD4694BF) smtp.auth=groug@kaod.org
Date: Thu, 22 Oct 2020 11:01:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 6/8] tests/9pfs: add local Tunlinkat symlink test
Message-ID: <20201022110120.6ea5bcba@bahia.lan>
In-Reply-To: <a23cd4d2ab6d8d3048addab8cbf0416fe5ead43e.1603285620.git.qemu_oss@crudebyte.com>
References: <cover.1603285620.git.qemu_oss@crudebyte.com>
 <a23cd4d2ab6d8d3048addab8cbf0416fe5ead43e.1603285620.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 2815ae9f-980c-4b0f-a386-39064e6d1f1c
X-Ovh-Tracer-Id: 5359565032456296858
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.42.229; envelope-from=groug@kaod.org;
 helo=4.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 05:01:22
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

On Wed, 21 Oct 2020 14:36:23 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This test case uses a Tunlinkat request to remove a symlink using
> the 9pfs 'local' fs driver.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/virtio-9p-test.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index 0c11417236..33cba24b18 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -1295,6 +1295,32 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(real_file);
>  }
>  
> +static void fs_unlinkat_symlink(void *obj, void *data,
> +                                QGuestAllocator *t_alloc)
> +{
> +    QVirtio9P *v9p = obj;
> +    alloc = t_alloc;
> +    struct stat st;
> +    char *real_file = virtio_9p_test_path("06/real_file");
> +    char *symlink_file = virtio_9p_test_path("06/symlink_file");
> +
> +    do_attach(v9p);
> +    do_mkdir(v9p, "/", "06");
> +    do_lcreate(v9p, "06", "real_file");
> +    g_assert(stat(real_file, &st) == 0);
> +    g_assert((st.st_mode & S_IFMT) == S_IFREG);
> +
> +    do_symlink(v9p, "06", "symlink_file", "real_file");
> +    g_assert(stat(symlink_file, &st) == 0);
> +
> +    do_unlinkat(v9p, "06", "symlink_file", 0);
> +    /* symlink should be gone now */
> +    g_assert(stat(symlink_file, &st) != 0);
> +
> +    g_free(symlink_file);
> +    g_free(real_file);
> +}
> +
>  static void *assign_9p_local_driver(GString *cmd_line, void *arg)
>  {
>      virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
> @@ -1339,6 +1365,8 @@ static void register_virtio_9p_test(void)
>      qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
>      qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
>      qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
> +    qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
> +                 &opts);
>  }
>  
>  libqos_init(register_virtio_9p_test);


