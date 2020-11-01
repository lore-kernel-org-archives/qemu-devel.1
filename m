Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DBAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3F2208A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3F2208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZHR3-0003Ir-6T
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 12:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kZHPR-0002MR-OW
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 12:44:55 -0500
Received: from 8.mo52.mail-out.ovh.net ([46.105.37.156]:51247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kZHPN-0006B8-QN
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 12:44:53 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.141])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id DC9F72009DD;
 Sun,  1 Nov 2020 18:44:45 +0100 (CET)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 1 Nov 2020
 18:44:45 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00398df24c8-22a0-4c25-a3b0-90a313ce5233,
 510A72FFAFC78B4C24D608C8B6637C1151DF677A) smtp.auth=groug@kaod.org
Date: Sun, 1 Nov 2020 18:44:44 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 2/2] tests/9pfs: fix test dir for parallel tests
Message-ID: <20201101184444.0da77d03@bahia.lan>
In-Reply-To: <7746f42d8f557593898d3d9d8e57c46e872dfb4f.1604243521.git.qemu_oss@crudebyte.com>
References: <cover.1604243521.git.qemu_oss@crudebyte.com>
 <7746f42d8f557593898d3d9d8e57c46e872dfb4f.1604243521.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e9742a29-8b9a-418b-b6de-cb9d8b36277b
X-Ovh-Tracer-Id: 17585712119964735898
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleelgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.37.156; envelope-from=groug@kaod.org;
 helo=8.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 12:44:46
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

On Sun, 1 Nov 2020 15:37:12 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Use mkdtemp() to generate a unique directory for the 9p 'local' tests.
> 
> This fixes occasional 9p test failures when running 'make check -jN' if
> QEMU was compiled for multiple target architectures, because the individual
> architecture's test suites would run in parallel and interfere with each
> other's data as the test directory was previously hard coded and hence the
> same directory was used by all of them simultaniously.
> 
> This also requires a change how the test directory is created and deleted:
> As the test path is now randomized and virtio_9p_register_nodes() being
> called in a somewhat undeterministic way, that's no longer an appropriate
> place to create and remove the test directory. Use a constructor and
> destructor function for creating and removing the test directory instead.
> Unfortunately libqos currently does not support setup/teardown callbacks
> to handle this more cleanly.
> 
> The constructor functions needs to be in virtio-9p-test.c, not in
> virtio-9p.c, because in the latter location it would cause all apps that
> link to libqos (i.e. entirely unrelated test suites) to create a 9pfs
> test directory as well, which would even break other test suites.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

I could run 'make check -j' with 4 archs (ppc64, x86_64, aarch64, s390x)
on a POWER9 system with 128 cpus, for ~1 hour without seeing any failure.

Tested-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/libqos/virtio-9p.c | 14 ++++++++------
>  tests/qtest/virtio-9p-test.c   | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index 2736e9ae2a..586e700b24 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -35,7 +35,12 @@ static char *concat_path(const char* a, const char* b)
>  static void init_local_test_path(void)
>  {
>      char *pwd = g_get_current_dir();
> -    local_test_path = concat_path(pwd, "qtest-9p-local");
> +    char *template = concat_path(pwd, "qtest-9p-local-XXXXXX");
> +    local_test_path = mkdtemp(template);
> +    if (!local_test_path) {
> +        g_test_message("mkdtemp('%s') failed: %s", template, strerror(errno));
> +    }
> +    g_assert(local_test_path);
>      g_free(pwd);
>  }
>  
> @@ -43,6 +48,8 @@ void virtio_9p_create_local_test_dir(void)
>  {
>      struct stat st;
>  
> +    init_local_test_path();
> +
>      g_assert(local_test_path != NULL);
>      mkdir(local_test_path, 0777);
>  
> @@ -244,11 +251,6 @@ static void virtio_9p_register_nodes(void)
>      const char *str_simple = "fsdev=fsdev0,mount_tag=" MOUNT_TAG;
>      const char *str_addr = "fsdev=fsdev0,addr=04.0,mount_tag=" MOUNT_TAG;
>  
> -    /* make sure test dir for the 'local' tests exists and is clean */
> -    init_local_test_path();
> -    virtio_9p_remove_local_test_dir();
> -    virtio_9p_create_local_test_dir();
> -
>      QPCIAddress addr = {
>          .devfn = QPCI_DEVFN(4, 0),
>      };
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index c15908f27b..6401d4f564 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -1076,3 +1076,15 @@ static void register_virtio_9p_test(void)
>  }
>  
>  libqos_init(register_virtio_9p_test);
> +
> +static void __attribute__((constructor)) construct_9p_test(void)
> +{
> +    /* make sure test dir for the 'local' tests exists */
> +    virtio_9p_create_local_test_dir();
> +}
> +
> +static void __attribute__((destructor)) destruct_9p_test(void)
> +{
> +    /* remove previously created test dir when test suite completed */
> +    virtio_9p_remove_local_test_dir();
> +}


