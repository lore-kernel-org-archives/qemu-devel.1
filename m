Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6411720678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6411720678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipcsS-0001D7-Fb
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 13:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ipcrk-0000m2-Gi
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:49:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ipcrj-0002hC-5b
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:49:08 -0500
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:35151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ipcri-0002Wm-RL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 13:49:07 -0500
Received: from player789.ha.ovh.net (unknown [10.109.143.183])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7F22815508B
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 19:49:04 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 89ADBE152B11;
 Thu,  9 Jan 2020 18:49:02 +0000 (UTC)
Date: Thu, 9 Jan 2020 19:49:01 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 3/9] hw/9pfs/9p-synth: added directory for readdir test
Message-ID: <20200109194901.63f67ec7@bahia.lan>
In-Reply-To: <91905ff817851a76d3becaf27208007dfdbf22e1.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
 <91905ff817851a76d3becaf27208007dfdbf22e1.1576678644.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8475774502416980288
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiuddgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.36.149
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

On Wed, 18 Dec 2019 14:23:48 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This will provide the following virtual files by the 9pfs
> synth driver:
> 
>   - /ReadDirDir/ReadDirFile99
>   - /ReadDirDir/ReadDirFile98
>   ...
>   - /ReadDirDir/ReadDirFile1
>   - /ReadDirDir/ReadDirFile0
> 
> This virtual directory and its virtual 100 files will be
> used by the upcoming 9pfs readdir tests.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p-synth.c | 19 +++++++++++++++++++
>  hw/9pfs/9p-synth.h |  5 +++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 54239c9bbf..7eb210ffa8 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -578,6 +578,25 @@ static int synth_init(FsContext *ctx, Error **errp)
>                                         NULL, v9fs_synth_qtest_flush_write,
>                                         ctx);
>          assert(!ret);
> +
> +        /* Directory for READDIR test */
> +        {
> +            V9fsSynthNode *dir = NULL;
> +            ret = qemu_v9fs_synth_mkdir(
> +                NULL, 0700, QTEST_V9FS_SYNTH_READDIR_DIR, &dir
> +            );
> +            assert(!ret);
> +            for (i = 0; i < QTEST_V9FS_SYNTH_READDIR_NFILES; ++i) {
> +                char *name = g_strdup_printf(
> +                    QTEST_V9FS_SYNTH_READDIR_FILE, i
> +                );
> +                ret = qemu_v9fs_synth_add_file(
> +                    dir, 0, name, NULL, NULL, ctx
> +                );
> +                assert(!ret);
> +                g_free(name);
> +            }
> +        }
>      }
>  
>      return 0;
> diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
> index af7a993a1e..036d7e4a5b 100644
> --- a/hw/9pfs/9p-synth.h
> +++ b/hw/9pfs/9p-synth.h
> @@ -55,6 +55,11 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
>  #define QTEST_V9FS_SYNTH_LOPEN_FILE "LOPEN"
>  #define QTEST_V9FS_SYNTH_WRITE_FILE "WRITE"
>  
> +/* for READDIR test */
> +#define QTEST_V9FS_SYNTH_READDIR_DIR "ReadDirDir"
> +#define QTEST_V9FS_SYNTH_READDIR_FILE "ReadDirFile%d"
> +#define QTEST_V9FS_SYNTH_READDIR_NFILES 100
> +
>  /* Any write to the "FLUSH" file is handled one byte at a time by the
>   * backend. If the byte is zero, the backend returns success (ie, 1),
>   * otherwise it forces the server to try again forever. Thus allowing


