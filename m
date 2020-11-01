Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F77C5517A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8E22224E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8E22224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZGnV-0000v7-FC
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 12:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kZGlC-0007sa-Kz
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 12:03:18 -0500
Received: from 2.mo52.mail-out.ovh.net ([178.33.105.233]:58189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kZGl8-0001Uy-Io
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 12:03:18 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.132])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id BBBF32007F2;
 Sun,  1 Nov 2020 18:03:01 +0100 (CET)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 1 Nov 2020
 18:03:01 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005b5d3c0d1-c26b-46b2-b5c4-4feefcc3fa22,
 510A72FFAFC78B4C24D608C8B6637C1151DF677A) smtp.auth=groug@kaod.org
Date: Sun, 1 Nov 2020 18:03:00 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 1/2] tests/9pfs: make create/remove test dir public
Message-ID: <20201101180300.00e6f228@bahia.lan>
In-Reply-To: <ec90703cbc23d6b612b3672f946d7741f4a16080.1604243521.git.qemu_oss@crudebyte.com>
References: <cover.1604243521.git.qemu_oss@crudebyte.com>
 <ec90703cbc23d6b612b3672f946d7741f4a16080.1604243521.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 2aa2b6b5-939b-4568-83e4-d46df0db2c05
X-Ovh-Tracer-Id: 16880898779478858138
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleelgdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.105.233; envelope-from=groug@kaod.org;
 helo=2.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 12:03:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Sun, 1 Nov 2020 15:25:14 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Make functions create_local_test_dir() and remove_local_test_dir()
> public. They're going to be used in the next patch.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/libqos/virtio-9p.c | 10 ++++------
>  tests/qtest/libqos/virtio-9p.h | 10 ++++++++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index d43647b3b7..2736e9ae2a 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -39,8 +39,7 @@ static void init_local_test_path(void)
>      g_free(pwd);
>  }
>  
> -/* Creates the directory for the 9pfs 'local' filesystem driver to access. */
> -static void create_local_test_dir(void)
> +void virtio_9p_create_local_test_dir(void)
>  {
>      struct stat st;
>  
> @@ -53,8 +52,7 @@ static void create_local_test_dir(void)
>      g_assert((st.st_mode & S_IFMT) == S_IFDIR);
>  }
>  
> -/* Deletes directory previously created by create_local_test_dir(). */
> -static void remove_local_test_dir(void)
> +void virtio_9p_remove_local_test_dir(void)
>  {
>      g_assert(local_test_path != NULL);
>      char *cmd = g_strdup_printf("rm -r '%s'\n", local_test_path);
> @@ -248,8 +246,8 @@ static void virtio_9p_register_nodes(void)
>  
>      /* make sure test dir for the 'local' tests exists and is clean */
>      init_local_test_path();
> -    remove_local_test_dir();
> -    create_local_test_dir();
> +    virtio_9p_remove_local_test_dir();
> +    virtio_9p_create_local_test_dir();
>  
>      QPCIAddress addr = {
>          .devfn = QPCI_DEVFN(4, 0),
> diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
> index 19a4d97454..480727120e 100644
> --- a/tests/qtest/libqos/virtio-9p.h
> +++ b/tests/qtest/libqos/virtio-9p.h
> @@ -44,6 +44,16 @@ struct QVirtio9PDevice {
>      QVirtio9P v9p;
>  };
>  
> +/**
> + * Creates the directory for the 9pfs 'local' filesystem driver to access.
> + */
> +void virtio_9p_create_local_test_dir(void);
> +
> +/**
> + * Deletes directory previously created by virtio_9p_create_local_test_dir().
> + */
> +void virtio_9p_remove_local_test_dir(void);
> +
>  /**
>   * Prepares QEMU command line for 9pfs tests using the 'local' fs driver.
>   */


