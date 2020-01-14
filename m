Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2482C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FED2467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FED2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNKU-0005nO-18
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNJl-0005CF-FI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNJh-0001vQ-5P
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:37:17 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:58939)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNJf-0001uw-L3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:37:12 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mwwhv-1jbdFN0oP5-00ySOT; Tue, 14 Jan 2020 15:36:54 +0100
Subject: Re: [PATCH v5 15/20] linux-user: Add support for
 FD<SETEMSGTRESH|SETMAXERRS|GETMAXERRS> ioctls
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-16-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67c734ed-ada4-44f1-0f61-fddc359ab684@vivier.eu>
Date: Tue, 14 Jan 2020 15:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-16-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hfomYalZ/5W7OKxdJnNJ3vOySIr9rXBMMpyTvK4Ch4P9oLizgnH
 XueVv9WPrwbr1z1UdbRzm5JoONsBw+vZwLk72H6645JXeOpHCx9exqnrCNYm2XV51ynWqLs
 E2budXcf7KrHBFmtr6rP9wikW1Jb5gF7K0wRR2qxdhEYQ7T46x5JWoCcDdinB2FPqbEUQhh
 J7x59oaA3vSZKltn0jBQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1mJ99U7s8I=:DXb2QhdEpXXr75klWoUNC0
 x+V6OFFhZg+gwhQFr+cyanjnoTSraR2ffSXjYikqxbplUtsg3xjnvNTTw7X3rtM75AGQsr6sn
 3T4+ANTENYkmAxAKkhxvDpnl4irWjmjjPDbK1WcAyytsT23occSd5W3HrFsu5xw6z3lYJCIoS
 NK4rv2cIctP7Fm0rtGj7yJrI/vwsCuRgKjLt1IAYB9tgDXYle4ewFhiNGst546N3ayRqXX4OF
 HszUy1hCnhokTsAQEwzZW1IYQbLmdBreHVGuLUR8azxIXGvyaA3Lf7LnaQHED83IREF24rOrW
 miFc/TR7uyyQvZrmv8W5za6f3fl6t+plsiEA8B3XoPbDl1cj7n1cNwvuXpopg1tdahe0iFrbM
 qJCvprrjs4AnwTPQ1BvGLdEAZAgCKiZ2YjeLkB0bBoGnkcWpNzJR+gvZBG7+BfDE+CHou/Hvn
 PUTJrCSmsklBO9L35bJlfZelGj80J1Y4bf9RSxesb7tUlS7i5ZRZ7UpvW6yVeuJ9COEDzIZHY
 ZzbGapBHpQY4v+mNs5PzcyMmSYh0bWC6lNxGfuXzZck964o3w68x5IB184md++FSSDYC3qy0y
 N0pT3+lg5rrcmMVe+ivAqV1L0MwGLJ6dBbTD3Q7d3/6bI/HGLmJkjW4sNc2oirHhITqC8A+m3
 3QGAo3NFLvsBV8ePs7EnqE9hIjg2ry1YQnC+TeWa02l2faaZdb4aUSdbQJl8eI5qohpOED/NO
 UhLB0vWIFMX7kK9Z6m8gxvz6Nu0lctwA0FtWBsWT1/ieAS2J0q8myOluWRuw/FXMB0Nbjkf8t
 qxo/jzXH38ZhZukh6VbpRbb+7RVy8UT0kFdtXOQHPeHF8Bdu/D9CaA2i1mXXUiMg3GGynJBiJ
 +vT6fjOcZkf3RL7ehbPQQvS+MP21l0JK8L5ucQk/Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
> for controlling error reporting of a floppy drive.
> 
> FDSETEMSGTRESH's third agrument is a pointer to the structure:
> 
> struct floppy_max_errors {
>     unsigned int
>       abort,      /* number of errors to be reached before aborting */
>       read_track, /* maximal number of errors permitted to read an
>                    * entire track at once */
>       reset,      /* maximal number of errors before a reset is tried */
>       recal,      /* maximal number of errors before a recalibrate is
>                    * tried */
>       /*
>        * Threshold for reporting FDC errors to the console.
>        * Setting this to zero may flood your screen when using
>        * ultra cheap floppies ;-)
>        */
>       reporting;
> };
> 
> defined in Linux kernel header <linux/fd.h>.
> 
> Since all fields of the structure are of type 'unsigned int', there is
> no need to define "target_floppy_max_errors".
> 
> FDSETMAXERRS and FDGETMAXERRS ioctls do not use the third argument.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h        | 3 +++
>  linux-user/syscall_defs.h  | 3 +++
>  linux-user/syscall_types.h | 7 +++++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 66f8c4e..9e3ca90 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -114,7 +114,10 @@
>  
>       IOCTL(FDMSGON, 0, TYPE_NULL)
>       IOCTL(FDMSGOFF, 0, TYPE_NULL)
> +     IOCTL(FDSETEMSGTRESH, 0, TYPE_NULL)
>       IOCTL(FDFLUSH, 0, TYPE_NULL)
> +     IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
> +     IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>       IOCTL(FDRESET, 0, TYPE_NULL)
>       IOCTL(FDRAWCMD, 0, TYPE_NULL)
>       IOCTL(FDTWADDLE, 0, TYPE_NULL)
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 6b88030..efe3860 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -899,7 +899,10 @@ struct target_pollfd {
>  
>  #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
>  #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
> +#define TARGET_FDSETEMSGTRESH TARGET_IO(2, 0x4a)
>  #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
> +#define TARGET_FDSETMAXERRS  TARGET_IOW(2, 0x4c, struct floppy_max_errors)
> +#define TARGET_FDGETMAXERRS  TARGET_IOR(2, 0x0e, struct floppy_max_errors)
>  #define TARGET_FDRESET        TARGET_IO(2, 0x54)
>  #define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
>  #define TARGET_FDTWADDLE      TARGET_IO(2, 0x59)
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 4e36983..e4e0429 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -261,6 +261,13 @@ STRUCT(blkpg_ioctl_arg,
>         TYPE_INT, /* datalen */
>         TYPE_PTRVOID) /* data */
>  
> +STRUCT(floppy_max_errors,
> +       TYPE_INT, /* abort */
> +       TYPE_INT, /* read_track */
> +       TYPE_INT, /* reset */
> +       TYPE_INT, /* recal */
> +       TYPE_INT) /* reporting */
> +
>  #if defined(CONFIG_USBFS)
>  /* usb device ioctls */
>  STRUCT(usbdevfs_ctrltransfer,
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

