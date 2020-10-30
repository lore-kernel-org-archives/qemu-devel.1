Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC78C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014332075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014332075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSf7-00086h-O9
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYSdr-0006e9-F2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:32:23 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYSdn-00081c-S9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:32:23 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.118])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4DA476977504;
 Fri, 30 Oct 2020 12:32:16 +0100 (CET)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 30 Oct
 2020 12:32:15 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001ea49b428-9dc1-486d-a0cf-2aafed0c2d0a,
 28B94817A5BF005C53DACA451BCD6EA07813AA4A) smtp.auth=groug@kaod.org
Date: Fri, 30 Oct 2020 12:32:14 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/2] tests/9pfs: fix test dir for parallel tests
Message-ID: <20201030123214.50806454@bahia.lan>
In-Reply-To: <73a2acc5ca29f95d6d2e5ce60ec69c62bd55f637.1604046404.git.qemu_oss@crudebyte.com>
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
 <73a2acc5ca29f95d6d2e5ce60ec69c62bd55f637.1604046404.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a68d0be3-3902-400e-969a-6f39834274ba
X-Ovh-Tracer-Id: 17996384112431831520
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleehgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheptefgffffgffgkeegffetkefhhfeuleffvdehvdfgtdfhiedutedvudelgfevveetnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:32:16
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 09:19:46 +0100
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
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM

I've been running 'make check-qtest -j' with 4 archs for 2 hours without
hitting the issue.

Tested-by: Greg Kurz <groug@kaod.org>

>  tests/qtest/libqos/virtio-9p.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index d43647b3b7..6b22fa0e9a 100644
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

Just per curiosity, is there a preferred way to output error messages ?

Cc'ing Thomas and Laurent.

[...]

