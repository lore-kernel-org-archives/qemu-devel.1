Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078FCC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD379206F5
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 07:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD379206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLigX-00083z-VL
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 03:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jLifg-0007MO-Go
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jLife-0001E2-Hp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:29:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:32209)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jLife-00015I-8i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 03:29:18 -0400
IronPort-SDR: uKbjD2jv3M55ufV7RB1RFHYwvy5ya3IiuJm9lACVupyR4enLnDbBQCkIDDzikB+TWHaJHOWmTu
 rZolfJphyhZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 00:29:08 -0700
IronPort-SDR: W8FfYhXnqa/n2PuMdGAn3tZJHQprFAQ+h8su7EvhzYMP+xaLcStqy1+xLoqfUdVM5Wb/nk59CH
 skYKZLdB0ceQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; d="scan'208";a="452346554"
Received: from unknown (HELO [10.238.4.245]) ([10.238.4.245])
 by fmsmga006.fm.intel.com with ESMTP; 07 Apr 2020 00:29:06 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <2c45ec7c-f3ea-2962-47a6-9330f0a2f146@intel.com>
Date: Tue, 7 Apr 2020 15:29:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401031314.11592-1-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

Any comments are appreciated.

Hi Paolo, Richard,

Any comments about this ?


Thanks,

Jingqi

On 4/1/2020 11:13 AM, Liu, Jingqi wrote:
> If the backend file is devdax pmem character device, the alignment
> specified by the option 'align=NUM' in the '-object memory-backend-file'
> needs to match the alignment requirement of the devdax pmem character device.
>
> This patch fetches the devdax pmem file 'align', so that we can compare
> it with the NUM of 'align=NUM'.
> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
>
> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>   exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/exec.c b/exec.c
> index de9d949902..8221abffec 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>       return size;
>   }
>   
> +static int64_t get_file_align(int fd)
> +{
> +    int64_t align = -1;
> +#if defined(__linux__)
> +    struct stat st;
> +
> +    if (fstat(fd, &st) < 0) {
> +        return -errno;
> +    }
> +
> +    /* Special handling for devdax character devices */
> +    if (S_ISCHR(st.st_mode)) {
> +        g_autofree char *subsystem_path = NULL;
> +        g_autofree char *subsystem = NULL;
> +
> +        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
> +                                         major(st.st_rdev), minor(st.st_rdev));
> +        subsystem = g_file_read_link(subsystem_path, NULL);
> +
> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
> +            g_autofree char *align_path = NULL;
> +            g_autofree char *align_str = NULL;
> +
> +            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
> +                                    major(st.st_rdev), minor(st.st_rdev));
> +
> +            if (g_file_get_contents(align_path, &align_str, NULL, NULL)) {
> +                return g_ascii_strtoll(align_str, NULL, 0);
> +            }
> +        }
> +    }
> +#endif /* defined(__linux__) */
> +
> +    return align;
> +}
> +
>   static int file_ram_open(const char *path,
>                            const char *region_name,
>                            bool *created,
> @@ -2275,7 +2311,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>   {
>       RAMBlock *new_block;
>       Error *local_err = NULL;
> -    int64_t file_size;
> +    int64_t file_size, file_align;
>   
>       /* Just support these ram flags by now. */
>       assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
> @@ -2311,6 +2347,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>           return NULL;
>       }
>   
> +    file_align = get_file_align(fd);
> +    if (file_align > 0 && mr && file_align > mr->align) {
> +        error_setg(errp, "backing store align 0x%" PRIx64
> +                   " is larger than 'align' option 0x" RAM_ADDR_FMT,
> +                   file_align, mr->align);
> +        return NULL;
> +    }
> +
>       new_block = g_malloc0(sizeof(*new_block));
>       new_block->mr = mr;
>       new_block->used_length = size;

