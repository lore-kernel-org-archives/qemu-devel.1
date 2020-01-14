Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1352AC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CC22468B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CC22468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irN1W-00065s-Nn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irN07-0004ue-RP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irN04-0002lH-3R
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:16:59 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:44593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irN03-0002l2-QW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:16:56 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MFsER-1ismiW0KvX-00HNaf; Tue, 14 Jan 2020 15:16:39 +0100
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v5 01/20] linux-user: Fix some constants in termbits.h
Message-ID: <058379d1-02b2-f26b-001a-686433245da9@vivier.eu>
Date: Tue, 14 Jan 2020 15:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RM35Q3VQPkTbKTGv6qkbBSxsGJ4U79FVt5n3PnPz27ySD5fpZNm
 vV1BFmaRxyWWUZQPVoRFoUBsZGnqoQSnyz70pJpqjhvR1B1HtATXTj28wB9n4bzSpk+9x5W
 +QK2hQYhm/NVT2FhtDEMa/xob9bMCM5/bBf4rNRzXVm6GxYlHCGTov3claJmN+Rtrzk+OBz
 LCVRase8S4co1Ah+o4Wrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V7JmFddks9w=:6OzD2mfx4R4Dv5DV2AVk3v
 4r0hwEx1UJJvsd+7uXDs1AIXdSpAt26SxdNzhSlT4PNLLl4JAzmqgGzfqJWgydlHyEcL68oo/
 I68EI6rESNQ6AeJmoF1pFd+2xHjnxZF37OGNplDcljvwzmOIwug9ue/1BY3trI+daNf64FSVm
 ra5VRgj/nPeL8kZWsvV4n/EwYNylHPm/oAF0Qp15Vz1RUTn67nw7lV4i8xqtefoMhapUXUQL8
 kJyU/G8vKY4bfEXqT5eNoOzh6W+JkCZn/cAndMA/VSqlp7Gm+yR/8PMV79g2GEX1VMHqcay3Z
 0EMhica8EcSAc1PnVP0A0v+1b7DCZbevS6josZpZDgg99Nny3l6EZzkyikJjm35E4IVq3q5Ey
 k+TodqYMaK5h0huTjeOzuQgehRiiymia2lVe8ONBp3ysaEJ5Mz2rYdV6BjV9ZfaP8k46H6nUr
 b7mYGxrb/eWuSbi5/6qQ9nVPQhlGdy4lsqPvrJ0xgShfbLVqLNEcStaf1X8hx0Oe8sFZb9cQp
 YPKojYOpXX3DNpQq9MVoV5tOtzw4nsESgDYB2HetmPZa01vfSLuqOhQg7+siqQ2svMNSe8eBL
 wWqgA9gcyuYpvzvu8RAPDATD+vEPGPblgrSgoDN4AVdenELNLrdfq5duuLz1XD+ghj/N5GVvD
 fFM/NZgEcV24WFzCpzpqEc1ohr/asXsKzUT8DC4iSihCbRfdG8ToGU/EDYaKKpreZd866dEBe
 yxiKjElhriMlEWLWTHnuNDxXDvWAhifbJIC2ySBak0hnHruTpk7E+t0AvDU13y69DaDx3Rmp0
 8ZOmMqmR88n1Hy2PON2HBEMLe3BmEB4S7Lfn/7NnFncCQblarGStTk3JAZBirojTav3yNhGsu
 4Vzo/AUV+F+Sv8t4MCTMcNV8soCeQK/jfAhZTxAU0=
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
> Some constants were defined in terms of host, instead of target,
> as they should be.
> 
> Some additional trivial changes in this patch were forced by
> checkpatch.pl.
> 
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/aarch64/termbits.h    |   4 +-
>  linux-user/alpha/termbits.h      |  10 +--
>  linux-user/arm/termbits.h        |   4 +-
>  linux-user/cris/termbits.h       |   4 +-
>  linux-user/hppa/termbits.h       |   4 +-
>  linux-user/i386/termbits.h       |   4 +-
>  linux-user/m68k/termbits.h       |   4 +-
>  linux-user/microblaze/termbits.h |   4 +-
>  linux-user/mips/termbits.h       |   4 +-
>  linux-user/nios2/termbits.h      |   4 +-
>  linux-user/openrisc/termbits.h   |   6 +-
>  linux-user/ppc/termbits.h        |   4 +-
>  linux-user/riscv/termbits.h      |   4 +-
>  linux-user/s390x/termbits.h      |  26 ++++---
>  linux-user/sh4/termbits.h        |   4 +-
>  linux-user/sparc/termbits.h      |   4 +-
>  linux-user/sparc64/termbits.h    |   4 +-
>  linux-user/x86_64/termbits.h     |   6 +-
>  linux-user/xtensa/termbits.h     | 156 ++++++++++++++++++++++-----------------
>  19 files changed, 141 insertions(+), 119 deletions(-)
> 
...
> diff --git a/linux-user/s390x/termbits.h b/linux-user/s390x/termbits.h
> index 9affa8f..79a71c2 100644
> --- a/linux-user/s390x/termbits.h
> +++ b/linux-user/s390x/termbits.h
> @@ -128,8 +128,8 @@ struct target_ktermios {
>  #define TARGET_B9600	0000015
>  #define TARGET_B19200	0000016
>  #define TARGET_B38400	0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> +#define TARGET_EXTA     TARGET_B19200
> +#define TARGET_EXTB     TARGET_B38400
>  #define TARGET_CSIZE	0000060
>  #define TARGET_CS5	0000000
>  #define TARGET_CS6	0000020
> @@ -234,7 +234,7 @@ struct target_ktermios {
>  #define TARGET_TIOCGSOFTCAR	0x5419
>  #define TARGET_TIOCSSOFTCAR	0x541A
>  #define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		FIONREAD
> +#define TARGET_TIOCINQ      TARGET_FIONREAD
>  #define TARGET_TIOCLINUX	0x541C
>  #define TARGET_TIOCCONS	0x541D
>  #define TARGET_TIOCGSERIAL	0x541E
> @@ -248,14 +248,18 @@ struct target_ktermios {
>  #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
>  #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
>  #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TCGETS2		_IOR('T',0x2A, struct termios2)
> -#define TARGET_TCSETS2		_IOW('T',0x2B, struct termios2)
> -#define TARGET_TCSETSW2	_IOW('T',0x2C, struct termios2)
> -#define TARGET_TCSETSF2	_IOW('T',0x2D, struct termios2)
> -#define TARGET_TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> +#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct termios2)
> +#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct termios2)
> +#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct termios2)
> +#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct termios2)

should be target_termios2

> +/* Get Pty Number (of pty-mux device) */
> +#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
> +/* Lock/unlock Pty */
> +#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
> +/* Get real dev no below /dev/console */
> +#define TARGET_TIOCGDEV         TARGET_IOR('T', 0x32, unsigned int)
> +/* Safely open the slave */
> +#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
>  
>  #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
>  #define TARGET_FIOCLEX		0x5451
...
> diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
> index d1e09e6..d92fe9c 100644
> --- a/linux-user/xtensa/termbits.h
> +++ b/linux-user/xtensa/termbits.h
...
> @@ -286,43 +286,61 @@ struct target_ktermios {
>  # define TARGET_TIOCPKT_IOCTL      64
>  
>  
> -#define TARGET_TIOCNOTTY   _IO('T', 34)
> -#define TARGET_TIOCSETD    _IOW('T', 35, int)
> -#define TARGET_TIOCGETD    _IOR('T', 36, int)
> -#define TARGET_TCSBRKP     _IOW('T', 37, int)   /* Needed for POSIX tcsendbreak()*/
> -#define TARGET_TIOCSBRK    _IO('T', 39)         /* BSD compatibility */
> -#define TARGET_TIOCCBRK    _IO('T', 40)         /* BSD compatibility */
> -#define TARGET_TIOCGSID    _IOR('T', 41, pid_t) /* Return the session ID of FD*/
> -#define TARGET_TCGETS2     _IOR('T', 42, struct termios2)
> -#define TARGET_TCSETS2     _IOW('T', 43, struct termios2)
> -#define TARGET_TCSETSW2    _IOW('T', 44, struct termios2)
> -#define TARGET_TCSETSF2    _IOW('T', 45, struct termios2)
> -#define TARGET_TIOCGRS485  _IOR('T', 46, struct serial_rs485)
> -#define TARGET_TIOCSRS485  _IOWR('T', 47, struct serial_rs485)
> -#define TARGET_TIOCGPTN    _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK  _IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGDEV    _IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
> -#define TARGET_TIOCSIG     _IOW('T',0x36, int)  /* Generate signal on Pty slave */
> -#define TARGET_TIOCVHANGUP _IO('T', 0x37)
> -#define TARGET_TIOCGPKT    _IOR('T', 0x38, int) /* Get packet mode state */
> -#define TARGET_TIOCGPTLCK  _IOR('T', 0x39, int) /* Get Pty lock state */
> -#define TARGET_TIOCGEXCL   _IOR('T', 0x40, int) /* Get exclusive mode state */
> -#define TARGET_TIOCGPTPEER _IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_TIOCSERCONFIG   _IO('T', 83)
> -#define TARGET_TIOCSERGWILD    _IOR('T', 84,  int)
> -#define TARGET_TIOCSERSWILD    _IOW('T', 85,  int)
> +#define TARGET_TIOCNOTTY   TARGET_IO('T', 34)
> +#define TARGET_TIOCSETD    TARGET_IOW('T', 35, int)
> +#define TARGET_TIOCGETD    TARGET_IOR('T', 36, int)
> +/* Needed for POSIX tcsendbreak()*/
> +#define TARGET_TCSBRKP     TARGET_IOW('T', 37, int)
> +/* BSD compatibility */
> +#define TARGET_TIOCSBRK    TARGET_IO('T', 39)
> +/* BSD compatibility */
> +#define TARGET_TIOCCBRK    TARGET_IO('T', 40)
> +/* Return the session ID of FD*/
> +#define TARGET_TIOCGSID    TARGET_IOR('T', 41, pid_t)
> +#define TARGET_TCGETS2     TARGET_IOR('T', 42, struct termios2)
> +#define TARGET_TCSETS2     TARGET_IOW('T', 43, struct termios2)
> +#define TARGET_TCSETSW2    TARGET_IOW('T', 44, struct termios2)
> +#define TARGET_TCSETSF2    TARGET_IOW('T', 45, struct termios2)

should be target_termios2

Thanks,
Laurent

