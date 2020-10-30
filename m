Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB2C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED3A207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED3A207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSqd-00067U-7S
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYSpX-0005dq-PJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:44:27 -0400
Received: from 3.mo51.mail-out.ovh.net ([188.165.32.156]:34007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kYSpV-0003vb-Ro
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:44:27 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.11])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 1F8FB233BBC;
 Fri, 30 Oct 2020 12:44:21 +0100 (CET)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 30 Oct
 2020 12:44:21 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0023df1b4e5-cc23-4a80-8e34-61fac3afec9d,
 28B94817A5BF005C53DACA451BCD6EA07813AA4A) smtp.auth=groug@kaod.org
Date: Fri, 30 Oct 2020 12:44:18 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 2/2] tests/9pfs: fix coverity error in
 create_local_test_dir()
Message-ID: <20201030124418.1a20fb9f@bahia.lan>
In-Reply-To: <b111895492f8fb79bcca1c3e9586c0615f46cc97.1604046404.git.qemu_oss@crudebyte.com>
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
 <b111895492f8fb79bcca1c3e9586c0615f46cc97.1604046404.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 6c5bdb23-dff3-4be9-9751-652fd8500368
X-Ovh-Tracer-Id: 18200453470395406746
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleehgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.32.156; envelope-from=groug@kaod.org;
 helo=3.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:44:22
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

On Fri, 30 Oct 2020 09:19:46 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Coverity wants the return value of mkdir() to be checked, so let's
> pretend to do that. We're actually just making a dummy check and
> ignore the result, because we actually only care if the required
> directory exists and we have an existence check for that in place
> already.
> 

I see that sometimes changelog shows a copy of the original
coverity report (e.g. commit df1a312fea58).

> Reported-by: Greg Kurz <groug@kaod.org>

Please give credits to coverity, not me :-)

And most importantly, we want to mention the CID in the changelog.

e.g.

Reported-by: Coverity (CID 1435963)

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/libqos/virtio-9p.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> index 6b22fa0e9a..0a7c0ee5d8 100644
> --- a/tests/qtest/libqos/virtio-9p.c
> +++ b/tests/qtest/libqos/virtio-9p.c
> @@ -48,9 +48,13 @@ static void init_local_test_path(void)
>  static void create_local_test_dir(void)
>  {
>      struct stat st;
> +    int res;
>  
>      g_assert(local_test_path != NULL);
> -    mkdir(local_test_path, 0777);
> +    res = mkdir(local_test_path, 0777);
> +    if (res < 0) {
> +        /* ignore error, dummy check to prevent error by coverity */

Why not printing an error message with errno there like you did in
the previous patch ?

> +    }
>  
>      /* ensure test directory exists now ... */
>      g_assert(stat(local_test_path, &st) == 0);


