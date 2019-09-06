Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C9FC43140
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFD9214E0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFD9214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Bed-0006q6-Ey
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6Be1-0006RW-1X
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6Bdz-0005sJ-PX
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:39:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6Bdz-0005rj-FY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:39:07 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MjSwu-1iYLRi2tzO-00l0CD; Fri, 06 Sep 2019 12:38:40 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <59c1cd46-2893-4e8e-5579-51a4fb131cca@vivier.eu>
Date: Fri, 6 Sep 2019 12:38:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567601968-26946-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:O91CdQ0Js2jRzXl6BXdDbVmEtiHOn/5lNrDYfHqr4bU0oWCeZOm
 y1+1GiLciQ7OTma29BEFwDzSRdaZLzxUtCCQEiyJkIoHLy0gqshqEEMYn/CEu8Wg8xogj7T
 gzo/A2qBnj0sJYgyzFDoT1ijbIyFLrSlRkkB0UNkE/5xa7Bjr3qPrd4/yOX6WnxzKBo0gvd
 IuSwwfPnG5xalq9ka0ECQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LSJIumkM2dg=:g/ZOaAhJQctFmXhp/WYf3T
 b9RSrpxrQU+RWhLXda4sNcSxFKV527/JpvX6iYMciPVHOhzhl99XMHysEhzX1X0NhqJzrvQYe
 iI3IIcwtS5sUXXO7TpgDcs4i60V3W5d609j/RF03ikEI1kUIG00mP6GrMd6bkMEdLILI2Vy0k
 TDSdB7anb6/dobudMAaUqXEsGy8DrAF8CWKQhj6nJTM2P+kFJUtTSxtwtXlUNAfYK5hd5TcuC
 60pKm6gGpZjHZfQ6H4U0z7Yglj0LYT9XiGEj3a7VR/LADws9U/csE4wHtd5pqeG3r6c/lZjjk
 1RIDpAJi3WtKKFJKZBQl+GHUUvwBy0z4b4Sah4f2qFDJmORUQcCHrxTaF7Sh2GtOt7HVTmBmS
 RkkEyqCM6Zq/UReKNvN1sCSnPClwFcims2gp5l9rZTHU+JnqYB/RIdp3ORvkoMsslAsL7BTT7
 GJpy2Iy3fTOecomOf4i1Fh/If4F0L9Vgr0COlytxeNcO1hUMnv/vMy2Cy/1PMw1OBhzRukEKP
 ns28o0Mc/GeBUJyDO43u6aSBpfwZPz3a8u2gZJvcj/fxT+RKcFa/CvFn7pFVqS06RXI49WIiC
 YwdPHlD3ccVutrOocZxHoDxd0e2QTC3ZH60S+ZBkqxBbWBQDxwJlwDv368H1HtYYMeE785uiP
 x1pezQpEQxsmn7Wi2hDhpI1FOpcngttM2CQ8MH4JmIMCTOqBfsCGoO597e7bCaeKtaeB9bxfP
 LB+bXAnLGvDjYIxg9AhZHNoxD2US2X2GTvPYfr8eYr1JVCbDthZ3d7qMppa1zX9Uu41tjpsgf
 8zACXVKv5i8k2QvxC50DlSlpCONwmzZQj6mdtAm6wqGztwF7EQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v6 7/8] linux-user: Add support for
 FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls
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
Cc: riku.voipio@iki.fi, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls provide means for controlling
> formatting of a floppy drive.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h        | 3 +++
>  linux-user/syscall_defs.h  | 3 +++
>  linux-user/syscall_types.h | 5 +++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index c6b9d6a..622874b 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -114,6 +114,9 @@
>  
>       IOCTL(FDMSGON, 0, TYPE_NULL)
>       IOCTL(FDMSGOFF, 0, TYPE_NULL)
> +     IOCTL(FDFMTBEG, 0, TYPE_NULL)
> +     IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
> +     IOCTL(FDFMTEND, 0, TYPE_NULL)
>       IOCTL(FDFLUSH, 0, TYPE_NULL)
>       IOCTL(FDRESET, 0, TYPE_NULL)
>       IOCTL(FDRAWCMD, 0, TYPE_NULL)
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index fa69c6a..834a085 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -892,6 +892,9 @@ struct target_pollfd {
>  
>  #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
>  #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
> +#define TARGET_FDFMTBEG       TARGET_IO(2, 0x47)
> +#define TARGET_FDFMTTRK      TARGET_IOW(2, 0x48, struct target_format_descr)

target_format_descr is defined in the following patch. You don't need
it. Use format_descr from <linux/fd.h>

Thanks,
Laurent

