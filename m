Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979DDC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 16:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E1E20708
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E1E20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kExB4-0000pm-LY
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 12:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kExAI-0000Iz-EE
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 12:05:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kExAF-0006FR-EN
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 12:05:14 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYvTs-1k1sHL35A8-00UsB5; Sun, 06 Sep 2020 18:05:08 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200823195925.117104-1-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Add support for a group of '_V2' btrfs ioctls
Message-ID: <7aa4265f-47fa-dd0f-b579-cadb5550e192@vivier.eu>
Date: Sun, 6 Sep 2020 18:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200823195925.117104-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7g0t6mHcm1n2t2u0xpskWzno3yJ6YTxDXVdZLWASB+VvgFzSE93
 ugu3B1opQsxzX2vWc5r2fluPwbn0bBCKTxocPiR6svztH3yq4L+f/rj8ZGfnFZnGw6qL2yr
 AIVY6WDpzWlXZUWmkKeKpVEYI0DJQNAXC4jp15NYFX49Q/IHmC7MZ41wr5DUj8jbQqRQcq0
 3KDLxj8b4ckQ/CWM3NFPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xz85KnE1Hbc=:Rh9eiSf0QYFOiNleD+xZls
 tgkePyeXJIId0kSFYHIvGbbJ9KH/biLjYnektdBpzyNM9LZER3ejqEVIOPqQFVWxR0V5VGS0+
 bOKPMm8XxevscuogMd/i2AQ+Sz9ArL1IJJ/FnP3UgHqzlxIzz81cUoT/CxzHYROjzl9gLiOR/
 u/jGKxZiV5A+jr8p9kPO9p9+SFIEYdR93JyNVbAKD3bXpGvIbNNywxnsxFZrvWJ6mRk4xnJWp
 CFyxryBnbScyCJtnnqo8aYSAL9FkQfX87Kh/Wnr8L2gFaHF00T/c7fsK4ZRsKUelD9N/40WzV
 AGRbgy3SSb2Z578QMHevoPv4JfMeJ8WSI/pG4y2OFCf6BiN8lHuxUslVPOI+LdtMuihp4DNZQ
 6TWfU+l1mAbtgZnTy8tqfoFl4F6xqVSe1yVFy6a8iXyrok7LdAzJGo+1fO2U7TTUX6gmZjpB5
 wvKyUgWqWowPDDd82tJe01v2U4Yp4e93nfBBhnHvTeQ1hRkhcdCW3jJF0JNSFkJmOpP9NPxA5
 0P913NQrBpsNlE4j5SbWVc6bJgRmtKE/GyrUKW2I6CbKjGUu9AM7Yd870PIFpu6fr7SjfLyRp
 Ea0YDlEslQtDaR4Hg8izXUZlyWchYbAPB7CVevCGIMdCazhe2wsXtonRL4gZbjDkEdbwVjdhH
 fn55Hqu45MUHTGpflUTlp4EMW1A3TOOWrYP6fAP0B5fsWRHS2JQzgW9JoApN8g+EkqwXhUfpK
 OwV/++vf7noz97Q5xQoY5lbj0U6KbP6cb/c2QqsQ57+IKrwvD62P+/YSvVEFvpOyNKl0WojqD
 cNqk1KkJIzcdV/DbRUfnrW3HVIh1jSilgYWIGZy2RLtfg7j1XJm2cwa0Hr/ma/+lvwlngZ8
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 12:05:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.69,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/08/2020 à 21:59, Filip Bozuta a écrit :
> This patch introduces functionality for following btrfs ioctls:
> 
> BTRFS_IOC_SUBVOL_CREATE_V2 - Adding a new btrfs subvolume
> 
>     Create a new btrfs subvolume (same as with BTRFS_IOC_SUBVOL_CREATE).
>     The third ioctl's argument is a pointer to a following type:
> 
>     struct btrfs_ioctl_vol_args_v2 {
> 	__s64 fd;
> 	__u64 transid;
> 	__u64 flags;
> 	union {
> 		struct {
> 			__u64 size;
> 			struct btrfs_qgroup_inherit __user *qgroup_inherit;
> 		};
> 		__u64 unused[4];
> 	};
> 	union {
> 		char name[BTRFS_SUBVOL_NAME_MAX + 1];
> 		__u64 devid;
> 		__u64 subvolid; /* added in kernel version 5.8 */
> 	};
>     };
> 
>     When calling this ioctl, the 'name' field should be filled with
>     the aproppriate value that contains the name of the subvolume that
>     is to be created. The flags field can take values that are
>     'BTRFS_SUBVOL_RDONLY' or 'BTRFS_SUBVOL_QGROUP_INHERIT'. If the
>     latter is specified, the field 'qgroup_inherit' should be filled
>     with aproppriate values of the quota group in which the newly
>     created subvolume is to be added. The definition of
>     'struct btrfs_qgroup_inherit' can be found at:
>     https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L90
> 
> BTRFS_IOC_SNAP_CREATE_V2 - Adding a btrfs snapshot for a subvolume
> 
>     Create a new btrfs snapshot for a specified subvolume (same as with
>     BTRFS_IOC_SNAP_CREATE). The ioctl's third argument is a pointer to
>     the above mentioned 'struct btrfs_ioctl_vol_args_v2'. Before calling
>     this ioctl, field 'fd' should be filled with the aproppriate file
>     descriptor value for the btrfs subvolume for which the snapshot is
>     to be created. Also, the 'name' field should be filled with the
>     aproppriate value that represents the name of the snapshot that is
>     to be created. The 'flags' field takes the same values as in case
>     of 'BTRFS_IOC_SUBVOL_CREATE_V2' and represents the same functionality.
> 
> BTRFS_IOC_RM_DEV_V2 - Removing a btrfs device
> 
>     Delete a btrfs device (same as with BTRFS_IOC_RM_DEV). The ioctl's third
>     argument is a pointer to the above mentioned 'struct btrfs_ioctl_vol_args_v2'.
>     Before calling this ioctl, either the 'name' or the 'devid' field should
>     be filled with the name or id of the device that is to be removed. Also, the
>     flags field should be filled either with 0 or 'BTRFS_DEVICE_SPEC_BY_ID'
>     depending on if the device is gonna be specified via name or id.
> 
> BTRFS_IOC_SNAP_DESTROY_V2 - Removing a btrfs snapshot
> 
>     Remove a btrfs snapshot (same as with BTRFS_IOC_SNAP_DESTROY). The ioctl's
>     third argument is a pointer to the above mentioned 'struct btrfs_ioctl_vol_args_v2'.
>     Before calling this ioctl, either the 'name' or the 'subvolid' field should
>     be filled with the name or id of the snapshot that is to be removed. Also, the
>     flags field should be filled either with 0 or 'BTRFS_SUBVOL_SPEC_BY_ID'
>     depending on if the snapshot is gonna be specified via name or id.
> 
> Implementation notes:
> 
>     Since the third argument of the implemented ioctl's is a
>     structure that contains unions, a special converting function
>     'target_to_host_btrfs_ioctl_vol_args_v2' was defined in 'syscall.c'.
>     This function is called instead of 'thunk_convert()' to convert
>     the values of the third argument from target to host. All of
>     the ioctls in this patch are of type 'IOW' which is why a converting
>     function from host to target is not required. Also, a separate printing
>     function was defined in file 'strace.c' that is called instead of
>     'thunk_print()' to print the contents of the third argument.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Based-on: <20200811164553.27713-2-Filip.Bozuta@syrmia.com>
> Based-on: <20200723210233.349690-4-Filip.Bozuta@syrmia.com>
> ---
>  linux-user/ioctls.h        | 16 +++++++
>  linux-user/qemu.h          |  5 ++
>  linux-user/strace.c        | 95 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c       | 77 ++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 28 +++++++++++
>  linux-user/syscall_types.h |  5 ++
>  thunk.c                    |  2 +-
>  7 files changed, 227 insertions(+), 1 deletion(-)
> 

> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index a69a0bd347..4add164673 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -708,6 +708,11 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
>  
>  void print_termios(void *arg);
>  
> +#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
> + || defined(BTRFS_IOC_SNAP_DESTROY_V2)  || defined(BTRFS_IOC_RM_DEV_V2)

The #if is not needed on the declaration of the symbol. It can be unused
or not defined, there will be no error.

> +void print_btrfs_ioctl_vol_args_v2(void *arg);
> +#endif
> +
>  /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
>  #ifdef TARGET_ARM
>  static inline int regpairs_aligned(void *cpu_env, int num)
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b9ba39ce6e..04fe38a846 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -9,6 +9,9 @@
>  #include <netinet/tcp.h>
>  #include <linux/if_packet.h>
>  #include <linux/netlink.h>
> +#ifdef CONFIG_BTRFS
> +#include <linux/btrfs.h>
> +#endif
>  #include <sched.h>
>  #include "qemu.h"
>  
...
> @@ -1774,6 +1793,82 @@ print_termios(void *arg)
>      qemu_log("}");
>  }
>  
> +#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
> + || defined(BTRFS_IOC_SNAP_DESTROY_V2)  || defined(BTRFS_IOC_RM_DEV_V2)
> +void
> +print_btrfs_ioctl_vol_args_v2(void *arg)
> +{
> +    struct target_btrfs_ioctl_vol_args_v2 *target_args_v2 = arg;
> +    uint64_t flags = tswap64(target_args_v2->flags);
> +    int device_spec_by_id = 0;
> +    int subvol_spec_by_id = 0;
> +
> +    qemu_log("{fd = %" PRId64 ", flags = ", tswap64(target_args_v2->fd));
> +    print_flags(btrfs_args_vol_v2_flags, flags, 0);
> +    qemu_log(" transid = %" PRIu64 ",", tswap64(target_args_v2->transid));
> +
> +#ifdef BTRFS_SUBVOL_QGROUP_INHERIT
> +    if (flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
> +
> +        struct btrfs_qgroup_inherit *target_inherit;
> +        abi_long inherit_addr = tswapal(target_args_v2->qgroup_inherit);
> +
> +        target_inherit = lock_user(VERIFY_READ, inherit_addr,
> +                                   sizeof(*target_inherit), 1);
> +
> +        if (target_inherit) {
> +            qemu_log(" size = %" PRIu64,
> +                     tswap64(target_args_v2->size));
> +            qemu_log(", qgroup_inherit = {");
> +
> +            qemu_log("flags = %" PRIu64,
> +                     tswap64(target_inherit->flags));
> +            qemu_log(", num_qgroups = %" PRIu64,
> +                     tswap64(target_inherit->num_qgroups));
> +            qemu_log(", num_ref_copies = %" PRIu64,
> +                     tswap64(target_inherit->num_ref_copies));
> +            qemu_log(", num_excl_copies = %" PRIu64,
> +                     tswap64(target_inherit->num_excl_copies));
> +
> +            qemu_log(", lim = {");
> +            qemu_log("lim.flags = %" PRIu64,
> +                     tswap64(target_inherit->lim.flags));
> +            qemu_log(", lim.max_rfer = %" PRIu64,
> +                     tswap64(target_inherit->lim.max_rfer));
> +            qemu_log(", lim.max_excl = %" PRIu64,
> +                     tswap64(target_inherit->lim.max_excl));
> +            qemu_log(", lim.rsv_rfer = %" PRIu64,
> +                     tswap64(target_inherit->lim.rsv_rfer));
> +            qemu_log(", lim.rsv_excl = %" PRIu64 "}",
> +                     tswap64(target_inherit->lim.rsv_excl));
> +
> +            qemu_log(", ...}, ");
> +        }
> +
> +        unlock_user(target_inherit, inherit_addr, 0);
> +    }
> +#endif
> +
> +#ifdef BTRFS_DEVICE_SPEC_BY_ID
> +    if (flags & BTRFS_DEVICE_SPEC_BY_ID) {
> +        qemu_log(" devid = %" PRIu64, tswap64(target_args_v2->devid));
> +        device_spec_by_id = 1;
> +    }
> +#endif
> +#ifdef BTRFS_SUBVOL_SPEC_BY_ID
> +    if (flags & BTRFS_SUBVOL_SPEC_BY_ID) {
> +        qemu_log(" subvolid = %" PRIu64, tswap64(target_args_v2->subvolid));
> +        subvol_spec_by_id = 1;
> +    }
> +#endif
> +    if (!device_spec_by_id && !subvol_spec_by_id) {
> +        qemu_log(" name = \"%s\"", target_args_v2->name);

If the name is not NUL terminated we can have an overflow here.

> +    }
> +
> +    qemu_log("}");
> +}
> +#endif
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b58098b5bb..78d7106b80 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5668,6 +5668,83 @@ static const StructEntry struct_termios_def = {
>      .print = print_termios,
>  };
>  
> +#if defined(BTRFS_IOC_SUBVOL_CREATE_V2) || defined(BTRFS_IOC_SNAP_CREATE_V2) \
> + || defined(BTRFS_SNAP_DESTROY_V2)      || defined(BTRFS_RM_DEV_V2)
> +static void target_to_host_btrfs_ioctl_vol_args_v2(void *dst, const void *src)
> +{
> +    struct btrfs_ioctl_vol_args_v2 *host_args_v2 = dst;
> +    const struct target_btrfs_ioctl_vol_args_v2 *target_args_v2 = src;
> +    int device_spec_by_id = 0;
> +    int subvol_spec_by_id = 0;
> +
> +    __get_user(host_args_v2->fd, &target_args_v2->fd);
> +    __get_user(host_args_v2->flags, &target_args_v2->flags);
> +    __get_user(host_args_v2->transid, &target_args_v2->transid);
> +
> +    if (host_args_v2->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
> +        struct btrfs_qgroup_inherit *target_inherit;
> +        abi_long inherit_addr = tswapal(target_args_v2->qgroup_inherit);
> +
> +        target_inherit = lock_user(VERIFY_READ, inherit_addr,
> +                                   sizeof(*target_inherit), 1);
> +
> +        host_args_v2->qgroup_inherit = g_new(struct btrfs_qgroup_inherit, 1);

Where do you free this memory?
And the size is in fact variable and given by size in
btrfs_ioctl_vol_args_v2.

> +
> +        if (!target_inherit) {
> +            host_args_v2->qgroup_inherit = NULL;

And you overwrite the pointer here

> +        } else {
> +            __get_user(host_args_v2->qgroup_inherit->flags,
> +                       &target_inherit->flags);
> +            __get_user(host_args_v2->qgroup_inherit->num_qgroups,
> +                       &target_inherit->num_qgroups);
> +            __get_user(host_args_v2->qgroup_inherit->num_ref_copies,
> +                       &target_inherit->num_ref_copies);
> +            __get_user(host_args_v2->qgroup_inherit->num_excl_copies,
> +                       &target_inherit->num_excl_copies);
> +            __get_user(host_args_v2->qgroup_inherit->lim.flags,
> +                       &target_inherit->lim.flags);
> +            __get_user(host_args_v2->qgroup_inherit->lim.max_rfer,
> +                       &target_inherit->lim.max_rfer);
> +            __get_user(host_args_v2->qgroup_inherit->lim.max_excl,
> +                       &target_inherit->lim.max_excl);
> +            __get_user(host_args_v2->qgroup_inherit->lim.rsv_rfer,
> +                       &target_inherit->lim.rsv_rfer);
> +            __get_user(host_args_v2->qgroup_inherit->lim.rsv_excl,
> +                       &target_inherit->lim.rsv_excl);

And what about qgroups?

> +        }
> +
> +        unlock_user(target_inherit, inherit_addr, 0);
> +    }
> +
> +#ifdef BTRFS_DEVICE_SPEC_BY_ID
> +    if (host_args_v2->flags & BTRFS_DEVICE_SPEC_BY_ID) {
> +        __get_user(host_args_v2->devid, &target_args_v2->devid);
> +        device_spec_by_id = 1;
> +    }
> +#endif
> +#ifdef BTRFS_SUBVOL_SPEC_BY_ID
> +    if (host_args_v2->flags & BTRFS_SUBVOL_SPEC_BY_ID) {
> +        __get_user(host_args_v2->subvolid, &target_args_v2->subvolid);
> +        subvol_spec_by_id = 1;
> +    }
> +#endif
> +
> +    if (!device_spec_by_id & !subvol_spec_by_id) {
> +        memcpy(host_args_v2->name, target_args_v2->name,
> +               BTRFS_SUBVOL_NAME_MAX + 1);
> +    }
> +}
> +
> +static const StructEntry struct_btrfs_ioctl_vol_args_v2_def = {
> +    .convert = { NULL, target_to_host_btrfs_ioctl_vol_args_v2},
> +    .print = print_btrfs_ioctl_vol_args_v2,
> +    .align = { __alignof__(struct target_btrfs_ioctl_vol_args_v2),
> +               __alignof__(struct btrfs_ioctl_vol_args_v2) },
> +    .size = { sizeof(struct target_btrfs_ioctl_vol_args_v2),
> +              sizeof(struct btrfs_ioctl_vol_args_v2) },
> +};
> +#endif
> +
>  static bitmask_transtbl mmap_flags_tbl[] = {
>      { TARGET_MAP_SHARED, TARGET_MAP_SHARED, MAP_SHARED, MAP_SHARED },
>      { TARGET_MAP_PRIVATE, TARGET_MAP_PRIVATE, MAP_PRIVATE, MAP_PRIVATE },
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 969377d622..d2d4d1e1cb 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -967,6 +967,26 @@ struct target_rtc_pll_info {
>  #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
>  #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
>  
> +#define TARGET_BTRFS_SUBVOL_NAME_MAX    4039

As you use BTRFS_SUBVOL_NAME_MAX in memcpy() of
target_to_host_btrfs_ioctl_vol_args_v2, I think you don't need to define
the TARGET_ variant (the value is the same for all the targets).

> +
> +struct target_btrfs_ioctl_vol_args_v2 {
> +    uint64_t fd;

fd is signed in btrfs_ioctl_vol_args_v2

> +    uint64_t transid;
> +    uint64_t flags;
> +    union {
> +        struct {
> +            uint64_t size;
> +            abi_long qgroup_inherit;
> +        };
> +        uint64_t unused[4];
> +    };
> +    union {
> +        char name[TARGET_BTRFS_SUBVOL_NAME_MAX + 1];
> +        uint64_t devid;
> +        uint64_t subvolid;
> +    };
> +};
> +
>  /* btrfs ioctls */
>  #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
>  #define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)

Thanks,
Laurent

