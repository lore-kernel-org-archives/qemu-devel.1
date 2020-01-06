Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CD1C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC232072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 11:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC232072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioQ8t-0007Px-3B
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 06:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioQ7v-0006XU-CP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioQ7u-0001xx-CX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:00:51 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:33538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioQ7u-0001vs-6W
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 06:00:50 -0500
Received: from player750.ha.ovh.net (unknown [10.108.57.49])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id B9006153AED
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 12:00:47 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id E9430DD8D130;
 Mon,  6 Jan 2020 11:00:45 +0000 (UTC)
Date: Mon, 6 Jan 2020 12:00:44 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 1/9] tests/virtio-9p: add terminating null in
 v9fs_string_read()
Message-ID: <20200106120044.7ef0c26c@bahia.lan>
In-Reply-To: <11a52f72d4a301518ad3fa3ec08080cf1d02e3d1.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <11a52f72d4a301518ad3fa3ec08080cf1d02e3d1.1576678644.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1395834410555119936
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejhedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.63.230
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

On Wed, 18 Dec 2019 14:06:30 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> The 9p protocol sends strings in general without null termination
> over the wire. However for future use of this functions it is
> beneficial for the delivered string to be null terminated though
> for being able to use the string with standard C functions which
> often rely on strings being null terminated.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  tests/virtio-9p-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index e7b58e3a0c..06263edb53 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -130,8 +130,9 @@ static void v9fs_string_read(P9Req *req, uint16_t *len, char **string)
>          *len = local_len;
>      }
>      if (string) {
> -        *string = g_malloc(local_len);
> +        *string = g_malloc(local_len + 1);
>          v9fs_memread(req, *string, local_len);
> +        (*string)[local_len] = 0;
>      } else {
>          v9fs_memskip(req, local_len);
>      }


