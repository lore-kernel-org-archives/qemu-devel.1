Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E07C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE15124125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE15124125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ABx-0007oa-3j
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4ABG-0007MN-0R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4ABE-0004m2-Lo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:13:21 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4ABE-0004cO-BX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:13:20 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mth79-1jJMjw0nT5-00vAAq; Tue, 18 Feb 2020 22:13:03 +0100
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579880839-31466-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579880839-31466-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2 3/4] linux-user: Add support for FIFREEZE and FITHAW
 ioctls
Message-ID: <ad843492-12f7-82a2-b17e-4e81db488ce5@vivier.eu>
Date: Tue, 18 Feb 2020 22:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579880839-31466-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0NU2iCiecqjLaQ9oPGiB2suEIZBTkXkj5nL0IqnH/Z+wvINojfh
 5llqSX8SNfpxUuzpKCTGIimK8RUwv7qsvqIgJlBb76CzOuCd/g5cGILdAeKvdw9bVRIIiAz
 BquuDSB7+oRtLB91OFdlRCkp2B0nRo518dPhBVI2fUFQYo0RRJbtAe3LpDzqWWYlnZV2YZx
 4A7dx9I6DfF8KHqOi03mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nzN0Vrlb3pg=:AnpdAZSDlNTLMbo7fBVPwa
 Cyt8eSbOerYevshMFx013vL5wx4S2/siazO69iim+jzNSjNYcNZXQ7Y2jBoV5R7MCTw0lBc2n
 r8zydL2SSXHZBtrirsdZ8ADDryGR865nAzhmD5ZZ4cV1TGQnhsdPM1RyKWdtz7/Xj3gM23Djk
 ViWq3JJ3+1r7I2NAJCVklsjVoNmdOISl54micyhbtApfsuzJw8dhN6O6F7o0Kwy95b01Qmyhu
 tKWtpaE+pu8MDjDaAqWwconDnOuJ6lDgZU0UqdllO7F5MRXUWO0TZJSgPNu5jJ8F+vftEuegA
 R+09OFdi+02YkULr0/GXw5NIzUUNk9SgIFPeLOPlXcuonPDOK6AEgWuXpcHayQwPKHEfEg7gn
 I4fPeSbRABQKu2oTMv0HjYNA8VZKCCyqXKfAIv1xJwa31Mns7LAGdAPMaPVsSkwAjwp3BK2lm
 V84AlxvuRN2TWJNZ2UYnh98Rr2dGQ80YFLwmZ28d1OOoQB8Hpil8g+tzeBVzCQdM+fiZ8T2lW
 pRySyyrsKLK3ZWQjSrxE3DaqVl9w4KfpEbkvwBObH1DhVnz3Mt1FdOVZibB1pRh5oBEE+w6Mb
 h7sNDyY6URnruooU9nQ7it6p48p6b3WeKDANG2hB0Y2cne59lkq+av9CwnD7Y89dm2RZR8RPr
 gW9NkO3iUZ2O/MpdGSd0pxHv5aet+vVsQEb7spJOVuvzi829XlA/JUnQyn+QTq9SVfaJZPzD9
 hR1L0nvDSBjdH/gl731XjvLt6aHknZUNHvuJnqJiYJr/w/iaUnTeO+SI7DBMpIKw4NQ6VDebt
 /dauzpPCSaZLomRcp7YnafMXBeRLP0HacploBpJk8FtfARp1k9u3fGxtxleNCYyzQjKesdQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/01/2020 à 16:47, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Both FIFREEZE and FITHAW ioctls accept an integer as their third
> argument.
> 
> All ioctls in this group (FI* ioctl) are guarded with "#ifdef", so the
> guards are used in this implementation too for consistency (however,
> many of ioctls in FI* group became old enough that their #ifdef guards
> could be removed, bit this is out of the scope of this patch).

They have been added in v2.6.29

Could you add this information coming from the kernel commit adding them:

   o Freeze the filesystem
      int ioctl(int fd, int FIFREEZE, arg)
        fd: The file descriptor of the mountpoint
        FIFREEZE: request code for the freeze
        arg: Ignored
        Return value: 0 if the operation succeeds. Otherwise, -1

    o Unfreeze the filesystem
      int ioctl(int fd, int FITHAW, arg)
        fd: The file descriptor of the mountpoint
        FITHAW: request code for unfreeze
        arg: Ignored
        Return value: 0 if the operation succeeds. Otherwise, -1
        Error number: If the filesystem has already been unfrozen,
                      errno is set to EINVAL.

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 6 ++++++
>  linux-user/syscall_defs.h | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 944fbeb..adc07ad 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -152,6 +152,12 @@
>  #ifdef FIBMAP
>       IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
>  #endif
> +#ifdef FIFREEZE
> +     IOCTL(FIFREEZE, IOC_W | IOC_R, TYPE_INT)
> +#endif
> +#ifdef FITHAW
> +     IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
> +#endif
>  #ifdef FITRIM
>       IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))
>  #endif
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 8761841..ae4c048 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -950,7 +950,11 @@ struct target_rtc_pll_info {
>  #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
>  #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
>  
> +#define TARGET_FIFREEZE   TARGET_IOWR('X', 119, int)    /* Freeze */
> +#define TARGET_FITHAW     TARGET_IOWR('X', 120, int)    /* Thaw */
> +#ifdef FITRIM
>  #define TARGET_FITRIM     TARGET_IOWR('X', 121, struct fstrim_range)
> +#endif

move "#ifdef FITRIM" to previous patch.

>  #define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
>  #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
>  
> 


