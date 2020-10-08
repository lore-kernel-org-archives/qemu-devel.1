Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CCC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD30F2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="BSFGL+fC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD30F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQV2C-000176-Cn
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQV0G-0000EB-D1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:26:36 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQV0E-0005Q7-8I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=LcjZF5esGMdSvlR6q2ebFSoCcA1CmVagInjD/W7UOZc=; b=BSFGL+fCmrKD+L7mGSoNJMQDXV
 KK3mCiBiL8iSWkSHDt4KsEzM8agqmQX5eU/RFv2uBextoik5xyBEulLbqqbCyDOD/nCRYRUkAYI1d
 dbBp7h4osrptGlnGvho7ZjqShkd/h3GssBR7VvNF6bE6CoK3mQgvjlpmogXTbhTBJ6B8JGWR4SS+8
 AxFGyGsL0GnAQWLILtFo4le02yUYPgUpS0rMfRS7mpW8QhRJKktFqe0ZK/ScVu4nFNDQ4US+/sUs+
 LFv77hFdZutt3KP40vI4NnJmwt+kFp0QYBIBKcPCzg6lo4bcZPLZ6zlbWklmP6bFmq7BoD5qN2OvP
 IuAR8S0A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, berrange@redhat.com
Subject: Re: [PATCH v3 09/11] tests/9pfs: wipe local 9pfs test directory
Date: Thu, 08 Oct 2020 14:26:28 +0200
Message-ID: <10015241.kaXt91Qapa@silver>
In-Reply-To: <0c54a2ca2049e9824df9805324cac8dac029c113.1601655308.git.qemu_oss@crudebyte.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <0c54a2ca2049e9824df9805324cac8dac029c113.1601655308.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 08:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 2. Oktober 2020 18:15:05 CEST Christian Schoenebeck wrote:
> Before running the first 9pfs test case, make sure the test directory
> for running the 9pfs 'local' tests on is entirely empty. For that
> reason simply delete the test directory (if any) before (re)creating
> it on test suite startup.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/libqos/virtio-9p.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index 1bada47af1..41a7c2baaa 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -53,6 +53,18 @@ static void create_local_test_dir(void)
>      g_assert((st.st_mode & S_IFMT) == S_IFDIR);
>  }
> 
> +/* Deletes directory previously created by create_local_test_dir(). */
> +static void remove_local_test_dir(void)
> +{
> +    g_assert(local_test_path != NULL);
> +    char *cmd = g_strdup_printf("rm -r '%s'\n", local_test_path);
> +    int res = system(cmd);
> +    if (res < 0) {
> +        /* ignore error, dummy check to prevent compiler error */
> +    }
> +    g_free(cmd);
> +}
> +
>  static void virtio_9p_cleanup(QVirtio9P *interface)
>  {
>      qvirtqueue_cleanup(interface->vdev->bus, interface->vq, alloc);
> @@ -220,6 +232,7 @@ static void virtio_9p_register_nodes(void)
> 
>      /* make sure test dir for the 'local' tests exists and is clean */
>      init_local_test_path();
> +    remove_local_test_dir();
>      create_local_test_dir();
> 
>      QPCIAddress addr = {
>          .devfn = QPCI_DEVFN(4, 0),
>      };
>     
>      QOSGraphEdgeOptions opts = {
>          .before_cmd_line = "-fsdev synth,id=fsdev0",
>      };
>     
>      /* virtio-9p-device */
>      opts.extra_device_opts = str_simple,
>      qos_node_create_driver("virtio-9p-device", virtio_9p_device_create);
>      qos_node_consumes("virtio-9p-device", "virtio-bus", &opts);
>      qos_node_produces("virtio-9p-device", "virtio");
>      qos_node_produces("virtio-9p-device", "virtio-9p");
>     
>      /* virtio-9p-pci */
>      opts.extra_device_opts = str_addr;
>      add_qpci_address(&opts, &addr);
>      qos_node_create_driver("virtio-9p-pci", virtio_9p_pci_create);
>      qos_node_consumes("virtio-9p-pci", "pci-bus", &opts);
>      qos_node_produces("virtio-9p-pci", "pci-device");
>      qos_node_produces("virtio-9p-pci", "virtio");
>      qos_node_produces("virtio-9p-pci", "virtio-9p");
> }
> 
> libqos_init(virtio_9p_register_nodes);

I wonder why libqos is calling virtio_9p_register_nodes() again after all 
qtests ended.

That's somewhat suboptimal here, as it causes remove_local_test_dir() to be 
called again after all qtests completed. My intention was actually only to 
wipe the "qtest-9p-local" test directory at the *start* of the test suite run. 
Not at the end of the test suite. Because it would allow developers to look at 
the actual dirs/files created after the tests completed.

I could of course misuse and add a dedicated "wipedir" test as workaround, but 
that OTOH would break the option of running individual tests with the -p CL 
switch.

Best regards,
Christian Schoenebeck



