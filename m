Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35985C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3309C206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3309C206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIymq-0007Wv-04
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIylc-0006pe-8i; Thu, 17 Sep 2020 14:36:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kIylV-0001yU-DU; Thu, 17 Sep 2020 14:36:23 -0400
Received: from [192.168.100.1] ([82.252.129.222]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MRBWU-1k6xgV1aia-00N9zE; Thu, 17 Sep 2020 20:36:03 +0200
Subject: Re: [PATCH V3 01/10] qemu/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200917075029.313-1-zhaolichang@huawei.com>
 <20200917075029.313-2-zhaolichang@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9091e6ed-ec30-287a-0d11-4f56bb3debcc@vivier.eu>
Date: Thu, 17 Sep 2020 20:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917075029.313-2-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PLtW+lE4Nqxtm2bnSmAyXTtMJe6XKsoG/dTnz1qhOJuYXZqaIvy
 aCRWE+EckNfeQkb34vXWpe6sUmiWRcxS99X+RTcJAk6l8eDbr6fSHVA8x037/8NZrbLo/Kb
 bCQN0zLodP3Jh5uZKGcplUWgwmvka0USRtduhC52k195FfSP+XO/QWNIPoBNjDXeQ/vK2Ru
 SntjrkqLkGQLmu8bFvR6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pvvTz8p5kIA=:rksi8RULrJHMZD3bhVGlKG
 bcsbiBE4GJnWoFbkiAs3sc5xF8rRf8z2TYt6W7/poXmQXHRLRA8q42JLqv/lxkV6QLZ8k7uNy
 MbGevW1t9ILngX1zhC5YVvh29ep16hIF+pIp8wQO607ZbY8IntjbkvZjCuhI+QFk6svZULfDz
 JRMK8s5sFAeCY8oEZijHMELpUzqNevT46eXFKCrMW/1gnWe99eTzE47r+CLIrK37GsHWqW+Hu
 CGpH0PZ3O+MbgSV5IvkiASNt1uVvX1Zjy9w94EWy+CfJ7h3mfpsV+wisY51GecgKFCkK/jjPe
 v/UfgrRqcmawIjsqwYTOd/xr5qLgWGXQTOSPMdRPCd6Ernz4g4MNHAO8GWwJ0RVLAmLVI36+e
 mq1WrnnBqMVwoymfdBGy8JYRzYBLx2fnJ09MBpggTElmfWYcmvk6PDplN5rtGifLe71IsHyXV
 Jlf4wD8GsMVbnj8NyfLnFA1d2PM4/lb4Qyu9UdvBV+wHniV2mVaxb8VEOQ2d2thDPJquDfpgM
 F39PX5eSQWmfEAfvrwNOpA51P3KL0JhXjiCpHuTrV3js12ix21BbSkyyuvjWhngk8505pB72I
 zHYuSR4MqkKkCb2yfcw/cks9atVD+VIz9y55hXEkGpQhceWBJUw8OfrDZb6YsuvzfrbOCFxcG
 u5ioLX5gS4+GrNJX6XhePynjZLemrUZlddXa6rWL+ILxbszEhCmGb+pfoenun+FAyYMGo8zvp
 VlZLN8WjAGQIhEtSk2a/sQir5fc6w3mVOYMXurLvMaHnikVzeJpD1gOTyOCnSnPOQZU1o+lDJ
 MZg3iUlZwy3pEAfhYSkB+IxJcT5W8i4F7zEzQv9+j/FEUfjdZByrVVC9BBEExOtcitk0iUs
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 14:36:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/09/2020 à 09:50, zhaolichang a écrit :
> I found that there are many spelling errors in the comments of qemu,
> so I used the spellcheck tool to check the spelling errors
> and finally found some spelling errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
> ---
>  Changelog                   | 2 +-
>  accel/tcg/user-exec.c       | 2 +-
>  audio/audio.c               | 2 +-
>  block.c                     | 2 +-
>  configure                   | 2 +-
>  fsdev/virtfs-proxy-helper.c | 2 +-
>  hmp-commands.hx             | 2 +-
>  libdecnumber/decNumber.c    | 2 +-
>  qemu-img.c                  | 2 +-
>  qobject/qdict.c             | 2 +-
>  scsi/pr-manager-helper.c    | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Changelog b/Changelog
> index 4a90bb9e8b..f7e178ccc0 100644
> --- a/Changelog
> +++ b/Changelog
> @@ -241,7 +241,7 @@ version 0.8.0:
>  version 0.7.2:
>  
>    - x86_64 fixes (Win2000 and Linux 2.6 boot in 32 bit)
> -  - merge self modifying code handling in dirty ram page mecanism.
> +  - merge self modifying code handling in dirty ram page mechanism.
>    - MIPS fixes (Ralf Baechle)
>    - better user net performances
>  
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..5c96819ded 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -88,7 +88,7 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
>           * use that value directly.  Within cpu_restore_state_from_tb, we
>           * assume PC comes from GETPC(), as used by the helper functions,
>           * so we adjust the address by -GETPC_ADJ to form an address that
> -         * is within the call insn, so that the address does not accidentially
> +         * is within the call insn, so that the address does not accidentally
>           * match the beginning of the next guest insn.  However, when the
>           * pc comes from the signal frame it points to the actual faulting
>           * host memory insn and not the return from a call insn.
> diff --git a/audio/audio.c b/audio/audio.c
> index ce8c6dec5f..1a68cfaafb 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1674,7 +1674,7 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
>          head = audio_handle_legacy_opts();
>          /*
>           * In case of legacy initialization, all Audiodevs in the list will have
> -         * the same configuration (except the driver), so it does't matter which
> +         * the same configuration (except the driver), so it doesn't matter which
>           * one we chose.  We need an Audiodev to set up AudioState before we can
>           * init a driver.  Also note that dev at this point is still in the
>           * list.
> diff --git a/block.c b/block.c
> index 9538af4884..11ab55f80b 100644
> --- a/block.c
> +++ b/block.c
> @@ -2602,7 +2602,7 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
>  
>  /*
>   * Updates @child to change its reference to point to @new_bs, including
> - * checking and applying the necessary permisson updates both to the old node
> + * checking and applying the necessary permission updates both to the old node
>   * and to @new_bs.
>   *
>   * NULL is passed as @new_bs for removing the reference before freeing @child.
> diff --git a/configure b/configure
> index ce27eafb0a..c74d79bfbc 100755
> --- a/configure
> +++ b/configure
> @@ -3411,7 +3411,7 @@ EOF
>      xfs="yes"
>    else
>      if test "$xfs" = "yes" ; then
> -      feature_not_found "xfs" "Instal xfsprogs/xfslibs devel"
> +      feature_not_found "xfs" "Install xfsprogs/xfslibs devel"
>      fi
>      xfs=no
>    fi
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index de061a8a0e..15c0e79b06 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -518,7 +518,7 @@ static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)
>  
>  /*
>   * Gets stat/statfs information and packs in out_iovec structure
> - * on success returns number of bytes packed in out_iovec struture
> + * on success returns number of bytes packed in out_iovec structure
>   * otherwise returns -errno
>   */
>  static int do_stat(int type, struct iovec *iovec, struct iovec *out_iovec)
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 60f395c276..27c4bbe0f2 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1267,7 +1267,7 @@ ERST
>      },
>  SRST
>  ``drive_backup``
> -  Start a point-in-time copy of a block device to a specificed target.
> +  Start a point-in-time copy of a block device to a specified target.
>  ERST
>  
>      {
> diff --git a/libdecnumber/decNumber.c b/libdecnumber/decNumber.c
> index 8c197023f4..1ffe458ad8 100644
> --- a/libdecnumber/decNumber.c
> +++ b/libdecnumber/decNumber.c
> @@ -5626,7 +5626,7 @@ static const uShort LNnn[90] = {
>  /*    would certainly save at least one if it were made ten times     */
>  /*    bigger, too (for truncated fractions 0.100 through 0.999).      */
>  /*    However, for most practical evaluations, at least four or five  */
> -/*    iterations will be neede -- so this would only speed up by      */
> +/*    iterations will be needed -- so this would only speed up by      */
>  /*    20-25% and that probably does not justify increasing the table  */
>  /*    size.							      */
>  /*								      */
> diff --git a/qemu-img.c b/qemu-img.c
> index 1d8c5cd778..3b7700c780 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1188,7 +1188,7 @@ static int64_t find_nonzero(const uint8_t *buf, int64_t n)
>   * 'pnum' is set to the number of sectors (including and immediately following
>   * the first one) that are known to be in the same allocated/unallocated state.
>   * The function will try to align the end offset to alignment boundaries so
> - * that the request will at least end aligned and consequtive requests will
> + * that the request will at least end aligned and consecutive requests will
>   * also start at an aligned offset.
>   */
>  static int is_allocated_sectors(const uint8_t *buf, int n, int *pnum,
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 526de54ceb..1079bd3f6f 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -33,7 +33,7 @@ QDict *qdict_new(void)
>  }
>  
>  /**
> - * tdb_hash(): based on the hash agorithm from gdbm, via tdb
> + * tdb_hash(): based on the hash algorithm from gdbm, via tdb
>   * (from module-init-tools)
>   */
>  static unsigned int tdb_hash(const char *name)
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index d735b1e7f6..685ce7f92d 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -127,7 +127,7 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
>      qio_channel_set_delay(QIO_CHANNEL(sioc), false);
>      pr_mgr->ioc = QIO_CHANNEL(sioc);
>  
> -    /* A simple feature negotation protocol, even though there is
> +    /* A simple feature negotiation protocol, even though there is
>       * no optional feature right now.
>       */
>      r = pr_manager_helper_read(pr_mgr, &flags, sizeof(flags), errp);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


