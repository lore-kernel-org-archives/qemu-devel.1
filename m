Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF73C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22530205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 20:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYT929HV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22530205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iePTa-00009o-7B
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 15:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iePSe-00080I-0H
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iePSc-0007hm-5P
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:16:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iePSc-0007gd-0s
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 15:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575922607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onU/5UZ0qFOwNzPN8XA+Zenesx1O9w3z0Z++6+WvPCY=;
 b=gYT929HVdPzo9yFbjwQygGuu3IfL6VHTEl2fT96O1mdfS8zBL8wJA5VBkMvm/py125iaZn
 seAJ06pOTl1qdGNs5cl/wIJW9egtqPnHBxLIeaEt/T3lpY+bA/DbzpThXH4MXG7OddqgrL
 SB7IVtkuMK9Nw6fOHR8SNMoCq591uaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-ALCOnTN0Mrq8Ivc_9ggS7A-1; Mon, 09 Dec 2019 15:16:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A08ADC20
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 20:16:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 122A55C1B2;
 Mon,  9 Dec 2019 20:16:36 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v3 3/9] tests: q35: MCH: add default SMBASE SMRAM
 lock test
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575896942-331151-4-git-send-email-imammedo@redhat.com>
 <1575899217-333105-1-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0116dead-489d-e995-8cb5-a90dfdc38ce6@redhat.com>
Date: Mon, 9 Dec 2019 21:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575899217-333105-1-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ALCOnTN0Mrq8Ivc_9ggS7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: dinechin@redhat.com, pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/19 14:46, Igor Mammedov wrote:
> test lockable SMRAM at default SMBASE feature, introduced by
> patch "q35: implement 128K SMRAM at default SMBASE address"
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>  - a bunch of spelling fixes
>    (Christophe de Dinechin <dinechin@redhat.com>)

Since I've run git-range-diff for this series anyway, I guess I can help
other reviewers with the changes (relative to the previous, fully
separate posting):

>  2:  f1a896f4dbc6 !  3:  092ec4a30289 tests: q35: MCH: add default SMBASE SMRAM lock test
>     @@ -6,7 +6,7 @@
>          patch "q35: implement 128K SMRAM at default SMBASE address"
>
>          Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>     -    Message-Id: <1575479147-6641-3-git-send-email-imammedo@redhat.com>
>     +    Message-Id: <1575899217-333105-1-git-send-email-imammedo@redhat.com>
>
>      diff --git a/tests/q35-test.c b/tests/q35-test.c
>      --- a/tests/q35-test.c
>     @@ -40,7 +40,7 @@
>      +    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
>      +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
>      +
>     -+    /* check that writinng junk to 0x9c before before negotiating is ignorred */
>     ++    /* check that writing junk to 0x9c before before negotiating is ignored */
>      +    for (i = 0; i < 0xff; i++) {
>      +        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
>      +        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
>     @@ -60,7 +60,7 @@
>      +        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
>      +        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x02);
>      +
>     -+        /* RAM access should go inot black hole */
>     ++        /* RAM access should go into black hole */
>      +        qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
>      +        g_assert_cmpint(qtest_readb(qts, SMBASE), ==, 0xff);
>      +    }
>     @@ -98,7 +98,7 @@
>      +    pcidev = qpci_device_find(pcibus, 0);
>      +    g_assert(pcidev != NULL);
>      +
>     -+    /* check that RAM accessible */
>     ++    /* check that RAM is accessible */
>      +    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
>      +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
>      +

Thanks,
Laszlo

On 12/09/19 14:46, Igor Mammedov wrote:
> ---
>  tests/q35-test.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/tests/q35-test.c b/tests/q35-test.c
> index a68183d..c922d81 100644
> --- a/tests/q35-test.c
> +++ b/tests/q35-test.c
> @@ -186,6 +186,109 @@ static void test_tseg_size(const void *data)
>      qtest_quit(qts);
>  }
>
> +#define SMBASE 0x30000
> +#define SMRAM_TEST_PATTERN 0x32
> +#define SMRAM_TEST_RESET_PATTERN 0x23
> +
> +static void test_smram_smbase_lock(void)
> +{
> +    QPCIBus *pcibus;
> +    QPCIDevice *pcidev;
> +    QDict *response;
> +    QTestState *qts;
> +    int i;
> +
> +    qts = qtest_init("-M q35");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +    g_assert(pcibus != NULL);
> +
> +    pcidev = qpci_device_find(pcibus, 0);
> +    g_assert(pcidev != NULL);
> +
> +    /* check that SMRAM is not enabled by default */
> +    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
> +    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
> +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
> +
> +    /* check that writing junk to 0x9c before before negotiating is ignored */
> +    for (i = 0; i < 0xff; i++) {
> +        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
> +        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
> +    }
> +
> +    /* enable SMRAM at SMBASE */
> +    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0xff);
> +    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x01);
> +    /* lock SMRAM at SMBASE */
> +    qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, 0x02);
> +    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x02);
> +
> +    /* check that SMRAM at SMBASE is locked and can't be unlocked */
> +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, 0xff);
> +    for (i = 0; i <= 0xff; i++) {
> +        /* make sure register is immutable */
> +        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
> +        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0x02);
> +
> +        /* RAM access should go into black hole */
> +        qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
> +        g_assert_cmpint(qtest_readb(qts, SMBASE), ==, 0xff);
> +    }
> +
> +    /* reset */
> +    response = qtest_qmp(qts, "{'execute': 'system_reset', 'arguments': {} }");
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    qobject_unref(response);
> +
> +    /* check RAM at SMBASE is available after reset */
> +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
> +    g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == 0);
> +    qtest_writeb(qts, SMBASE, SMRAM_TEST_RESET_PATTERN);
> +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_RESET_PATTERN);
> +
> +    g_free(pcidev);
> +    qpci_free_pc(pcibus);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_without_smram_base(void)
> +{
> +    QPCIBus *pcibus;
> +    QPCIDevice *pcidev;
> +    QTestState *qts;
> +    int i;
> +
> +    qts = qtest_init("-M pc-q35-4.1");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +    g_assert(pcibus != NULL);
> +
> +    pcidev = qpci_device_find(pcibus, 0);
> +    g_assert(pcidev != NULL);
> +
> +    /* check that RAM is accessible */
> +    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
> +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
> +
> +    /* check that writing to 0x9c succeeds */
> +    for (i = 0; i <= 0xff; i++) {
> +        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
> +        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == i);
> +    }
> +
> +    /* check that RAM is still accessible */
> +    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN + 1);
> +    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, (SMRAM_TEST_PATTERN + 1));
> +
> +    g_free(pcidev);
> +    qpci_free_pc(pcibus);
> +
> +    qtest_quit(qts);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -197,5 +300,7 @@ int main(int argc, char **argv)
>      qtest_add_data_func("/q35/tseg-size/8mb", &tseg_8mb, test_tseg_size);
>      qtest_add_data_func("/q35/tseg-size/ext/16mb", &tseg_ext_16mb,
>                          test_tseg_size);
> +    qtest_add_func("/q35/smram/smbase_lock", test_smram_smbase_lock);
> +    qtest_add_func("/q35/smram/legacy_smbase", test_without_smram_base);
>      return g_test_run();
>  }
>


