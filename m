Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF17C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAE2208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAE2208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGXU-0005k4-UO
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dave.Martin@arm.com>)
 id 1kSGWK-0005DJ-BK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:23:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42862)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Dave.Martin@arm.com>) id 1kSGWB-00031V-VG
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:22:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EF431B;
 Tue, 13 Oct 2020 02:22:47 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 486B93F66B;
 Tue, 13 Oct 2020 02:22:46 -0700 (PDT)
Date: Tue, 13 Oct 2020 10:22:43 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
Message-ID: <20201013092240.GI32292@arm.com>
References: <20201012220620.124408-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012220620.124408-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Received-SPF: pass client-ip=217.140.110.172; envelope-from=Dave.Martin@arm.com;
 helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 05:22:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-api@vger.kernel.org, qemu-devel@nongnu.org,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 12:06:20AM +0200, Linus Walleij wrote:
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
> 
> This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> to set the underlying filesystem into 32bit mode even if the
> file handle was opened using 64bit mode without the compat
> syscalls.
> 
> Programs that need the 32 bit file system behavior need to
> issue a fcntl() system call such as in this example:
> 
>   #define FD_32BIT_MODE 2
> 
>   int main(int argc, char** argv) {
>     DIR* dir;
>     int err;
>     int fd;
> 
>     dir = opendir("/boot");
>     fd = dirfd(dir);
>     err = fcntl(fd, F_SETFD, FD_32BIT_MODE);
>     if (err) {
>       printf("fcntl() failed! err=%d\n", err);
>       return 1;
>     }
>     printf("dir=%p\n", dir);
>     printf("readdir(dir)=%p\n", readdir(dir));
>     printf("errno=%d: %s\n", errno, strerror(errno));
>     return 0;
>   }
> 
> This can be pretty hard to test since C libraries and linux
> userspace security extensions aggressively filter the parameters
> that are passed down and allowed to commit into actual system
> calls.
> 
> Cc: Florian Weimer <fw@deneb.enyo.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://bugs.launchpad.net/qemu/+bug/1805913
> Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v3 RESEND 1:
> - Resending during the v5.10 merge window to get attention.
> ChangeLog v2->v3:
> - Realized that I also have to clear the flag correspondingly
>   if someone ask for !FD_32BIT_MODE after setting it the
>   first time.
> ChangeLog v1->v2:
> - Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
>   instead of a new fcntl operation, there is already a fcntl
>   operation to set random flags.
> - Sorry for taking forever to respin this patch :(
> ---
>  fs/fcntl.c                       | 7 +++++++
>  include/uapi/asm-generic/fcntl.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 19ac5baad50f..6c32edc4099a 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		break;
>  	case F_GETFD:
>  		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> +		/* Report 32bit file system mode */
> +		if (filp->f_mode & FMODE_32BITHASH)
> +			err |= FD_32BIT_MODE;
>  		break;
>  	case F_SETFD:
>  		err = 0;
>  		set_close_on_exec(fd, arg & FD_CLOEXEC);
> +		if (arg & FD_32BIT_MODE)
> +			filp->f_mode |= FMODE_32BITHASH;
> +		else
> +			filp->f_mode &= ~FMODE_32BITHASH;

This seems inconsistent?  F_SETFD is for setting flags on a file
descriptor.  Won't setting a flag on filp here instead cause the
behaviour to change for all file descriptors across the system that are
open on this struct file?  Compare set_close_on_exec().

I don't see any discussion on whether this should be an F_SETFL or an
F_SETFD, though I see F_SETFD was Ted's suggestion originally.

[...]

Cheers
---Dave

