Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D0C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91703206DB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91703206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVrw-0001lA-PQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioVqg-0000Sa-IE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioVqf-0001Ws-9R
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:07:26 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:34610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioVqf-0001Ld-2z
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:07:25 -0500
Received: from player726.ha.ovh.net (unknown [10.108.54.119])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id DF9E67AF89
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 18:07:15 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 2FD0FDD33489;
 Mon,  6 Jan 2020 17:07:13 +0000 (UTC)
Date: Mon, 6 Jan 2020 18:07:11 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 5/9] tests/virtio-9p: check file names of R_readdir
 response
Message-ID: <20200106180711.3a665d11@bahia.lan>
In-Reply-To: <2a40095340d9536575af8fd214a7ac647b4603c9.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <2a40095340d9536575af8fd214a7ac647b4603c9.1576678644.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7584906201415719232
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.233
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

On Wed, 18 Dec 2019 14:35:56 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Additionally to the already existing check for expected amount
> of directory entries returned by R_readdir response, also check
> whether all directory entries have the expected file names (as
> created on 9pfs synth driver side), ignoring their precise order
> in result list though.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM and trivial enough that it can be folded in the previous
patch.

>  tests/virtio-9p-test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index 48c0eca292..cb5c9fb420 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -565,6 +565,16 @@ static void fs_walk(void *obj, void *data, QGuestAllocator *t_alloc)
>      g_free(wqid);
>  }
>  
> +static bool fs_dirents_contain_name(struct v9fs_dirent *e, const char* name)
> +{
> +    for (; e; e = e->next) {
> +        if (!strcmp(e->name, name)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
>  {
>      QVirtio9P *v9p = obj;
> @@ -599,6 +609,18 @@ static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
>          QTEST_V9FS_SYNTH_READDIR_NFILES + 2 /* "." and ".." */
>      );
>  
> +    /*
> +     * Check all file names exist in returned entries, ignore their order
> +     * though.
> +     */
> +    g_assert_cmpint(fs_dirents_contain_name(entries, "."), ==, true);
> +    g_assert_cmpint(fs_dirents_contain_name(entries, ".."), ==, true);
> +    for (int i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
> +        char *name = g_strdup_printf(QTEST_V9FS_SYNTH_READDIR_FILE, i);
> +        g_assert_cmpint(fs_dirents_contain_name(entries, name), ==, true);
> +        g_free(name);
> +    }
> +
>      v9fs_free_dirents(entries);
>      g_free(wnames[0]);
>  }


