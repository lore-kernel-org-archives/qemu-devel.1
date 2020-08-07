Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AD5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95841221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95841221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42AG-0000gw-T2
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k429T-0008KR-9o
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:11:15 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k429O-0004JP-J6
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:11:15 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MORVA-1kNCtp3oZq-00Prod; Fri, 07 Aug 2020 15:11:01 +0200
Subject: Re: [PATCH v2 1/3] linux-user: Add generic 'termbits.h' for some archs
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
 <20200723210233.349690-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <e554bdae-0987-af28-24b5-63c555722b9a@vivier.eu>
Date: Fri, 7 Aug 2020 15:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723210233.349690-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OCXqHcwE7sqvOK/lM2OyK6dKJULjidhblgbl6U5EYSZ2WQL4oEu
 tbIcQ2IyidJkW8clfJt/WSGsbGb+amTGWNJ+Pt43sbY/0ELiBb1gE4XIRKVUOzwFESejMgn
 6FbH32hC8RC7VT3dLbXrGxD+A5kYjKM9RWdaKtxj49uvgBZbsGtbZgNDF1D5HOQZN19QYgh
 5R+kIZxb4am1IO9lPC9ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8O0lpns3vOs=:yuLg0NGuxWsJvw6XerHaxu
 QSvKVSePK2hRsqvJX/uHiC/+vDXE5fN22XBHBDx1FZnDp61FFzqRRXje8uIwYD1sOw1Eo4PCG
 IiVUSDfFd+UvjQL3fbTjOy64r7VTolvO0lEq64/NsnFj58oS3wNsMGOisTpM7tezHMLwm4NQc
 EIzwy/S+zN7pWSy+NlcCm0tDffRXj5KdyXhtiWkLOR8BaP9lY6xzk1UEHN7yFH4BH1eHjn7/p
 Yqm1wZlNMPJYMh99h/yLavjT77RfNFiog8/G37Kn+QQQptzZvBalvMyyQFZURdZIMlqqOOA1V
 UK8SzCCqQpkxRxgfGPXpRs+GMwIsSX+f72PjMorW8zlzVW8V6LZqe4YKkBlc061QuoTYJHGx7
 aBQWNCFxMQqjQSNv7JMfQFS8BoF5QlgtJgJhyMYYDCJ9lyRROn1gm7SIJgUCVOYeO0Fd+9+T/
 o36S/SDcT59OQitcPAb1OVWEUqd8aBykUyhJ3dYtIhjuUYlDp1ih77z7f/PL0u78mEUv0UU77
 VPcPebF1X7Oys0zNUtxYeRR4OosBS/SoC1kXurAeejHS4dPSumGQnO3wCpjS6j5KLzUjbF1Ak
 +6IsAFVO4YbPSbSfk2Pbnmwtt7F8MbfP2mPgb37ifdDkQLA7sKezw6HNQVyzIvkeRHFQNcqBb
 wpRicLyzTCfqBI2rycV0oEZ7JCTIZ9tlm1IoYi+S0lHV/5N2vOb23ZM9RZSmlTV5XVgSOnVeK
 DfQX469/eMsinaudv2jGxpeEkJqltXwLfwGrTKurZUuB2ZcUm1LF5dy8qwcfftm7qvoTSpItE
 mJXHKcqCS7CxfR+L/ymWeESy0o0HUQ3HsCIe/7ISS6+yJg7B8eBc9zFmxdbzk4BnxfywQST
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:22:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/07/2020 à 23:02, Filip Bozuta a écrit :
> This patch introduces a generic 'termbits.h' file for following
> archs: 'aarch64', 'arm', 'i386, 'm68k', 'microblaze', 'nios2',
> 'openrisc', 'riscv', 's390x', 'x86_64'.
> 
> Since all of these archs have the same termios flag values and
> same ioctl_tty numbers, there is no need for a separate 'termbits.h'
> file for each one of them. For that reason one generic 'termbits.h'
> file was added for all of them and an '#include' directive was
> added for this generic file in every arch 'termbits.h' file.
> 
> Also, some of the flag values that were missing were added in this
> generic file so that it matches the generic 'termibts.h' and 'ioctls.h'
> files from the kernel: 'asm-generic/termbits.h' and 'asm-generic/ioctls.h'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/aarch64/termbits.h    | 228 +---------------------
>  linux-user/arm/termbits.h        | 223 +---------------------
>  linux-user/generic/termbits.h    | 318 +++++++++++++++++++++++++++++++
>  linux-user/i386/termbits.h       | 233 +---------------------
>  linux-user/m68k/termbits.h       | 234 +----------------------
>  linux-user/microblaze/termbits.h | 220 +--------------------
>  linux-user/nios2/termbits.h      | 228 +---------------------
>  linux-user/openrisc/termbits.h   | 302 +----------------------------
>  linux-user/riscv/termbits.h      | 228 +---------------------
>  linux-user/s390x/termbits.h      | 289 +---------------------------
>  linux-user/tilegx/termbits.h     | 276 +--------------------------
>  linux-user/x86_64/termbits.h     | 254 +-----------------------
>  12 files changed, 329 insertions(+), 2704 deletions(-)
>  create mode 100644 linux-user/generic/termbits.h
> 
> diff --git a/linux-user/aarch64/termbits.h b/linux-user/aarch64/termbits.h
> index 0ab448d090..b1d4f4fedb 100644
> --- a/linux-user/aarch64/termbits.h
> +++ b/linux-user/aarch64/termbits.h
> @@ -1,227 +1 @@
> -/* from asm/termbits.h */
> -/* NOTE: exactly the same as i386 */
> -
> -#ifndef LINUX_USER_AARCH64_TERMBITS_H
> -#define LINUX_USER_AARCH64_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;                    /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];                /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000  /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR    0
> -#define TARGET_VQUIT    1
> -#define TARGET_VERASE   2
> -#define TARGET_VKILL    3
> -#define TARGET_VEOF     4
> -#define TARGET_VTIME    5
> -#define TARGET_VMIN     6
> -#define TARGET_VSWTC    7
> -#define TARGET_VSTART   8
> -#define TARGET_VSTOP    9
> -#define TARGET_VSUSP    10
> -#define TARGET_VEOL     11
> -#define TARGET_VREPRINT 12
> -#define TARGET_VDISCARD 13
> -#define TARGET_VWERASE  14
> -#define TARGET_VLNEXT   15
> -#define TARGET_VEOL2    16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS           0x5401
> -#define TARGET_TCSETS           0x5402
> -#define TARGET_TCSETSW          0x5403
> -#define TARGET_TCSETSF          0x5404
> -#define TARGET_TCGETA           0x5405
> -#define TARGET_TCSETA           0x5406
> -#define TARGET_TCSETAW          0x5407
> -#define TARGET_TCSETAF          0x5408
> -#define TARGET_TCSBRK           0x5409
> -#define TARGET_TCXONC           0x540A
> -#define TARGET_TCFLSH           0x540B
> -
> -#define TARGET_TIOCEXCL         0x540C
> -#define TARGET_TIOCNXCL         0x540D
> -#define TARGET_TIOCSCTTY        0x540E
> -#define TARGET_TIOCGPGRP        0x540F
> -#define TARGET_TIOCSPGRP        0x5410
> -#define TARGET_TIOCOUTQ         0x5411
> -#define TARGET_TIOCSTI          0x5412
> -#define TARGET_TIOCGWINSZ       0x5413
> -#define TARGET_TIOCSWINSZ       0x5414
> -#define TARGET_TIOCMGET         0x5415
> -#define TARGET_TIOCMBIS         0x5416
> -#define TARGET_TIOCMBIC         0x5417
> -#define TARGET_TIOCMSET         0x5418
> -#define TARGET_TIOCGSOFTCAR     0x5419
> -#define TARGET_TIOCSSOFTCAR     0x541A
> -#define TARGET_FIONREAD         0x541B
> -#define TARGET_TIOCINQ          TARGET_FIONREAD
> -#define TARGET_TIOCLINUX        0x541C
> -#define TARGET_TIOCCONS         0x541D
> -#define TARGET_TIOCGSERIAL      0x541E
> -#define TARGET_TIOCSSERIAL      0x541F
> -#define TARGET_TIOCPKT          0x5420
> -#define TARGET_FIONBIO          0x5421
> -#define TARGET_TIOCNOTTY        0x5422
> -#define TARGET_TIOCSETD         0x5423
> -#define TARGET_TIOCGETD         0x5424
> -#define TARGET_TCSBRKP          0x5425 /* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT   0x5426 /* For debugging only */
> -#define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
> -#define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
> -#define TARGET_TIOCGSID         0x5429 /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
> -        /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
> -        /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
> -        /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX          0x5451
> -#define TARGET_FIOASYNC         0x5452
> -#define TARGET_TIOCSERCONFIG    0x5453
> -#define TARGET_TIOCSERGWILD     0x5454
> -#define TARGET_TIOCSERSWILD     0x5455
> -#define TARGET_TIOCGLCKTRMIOS   0x5456
> -#define TARGET_TIOCSLCKTRMIOS   0x5457
> -#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR    0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI  0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI  0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT      0x545C
> -        /* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT     0x545D
> -        /* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA              0
> -#define TARGET_TIOCPKT_FLUSHREAD         1
> -#define TARGET_TIOCPKT_FLUSHWRITE        2
> -#define TARGET_TIOCPKT_STOP              4
> -#define TARGET_TIOCPKT_START             8
> -#define TARGET_TIOCPKT_NOSTOP           16
> -#define TARGET_TIOCPKT_DOSTOP           32
> -
> -#define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/arm/termbits.h b/linux-user/arm/termbits.h
> index e555cff105..b1d4f4fedb 100644
> --- a/linux-user/arm/termbits.h
> +++ b/linux-user/arm/termbits.h
> @@ -1,222 +1 @@
> -/* from asm/termbits.h */
> -/* NOTE: exactly the same as i386 */
> -
> -#ifndef LINUX_USER_ARM_TERMBITS_H
> -#define LINUX_USER_ARM_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;                    /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];                /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000  /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR	0
> -#define TARGET_VQUIT	1
> -#define TARGET_VERASE	2
> -#define TARGET_VKILL	3
> -#define TARGET_VEOF	4
> -#define TARGET_VTIME	5
> -#define TARGET_VMIN	6
> -#define TARGET_VSWTC	7
> -#define TARGET_VSTART	8
> -#define TARGET_VSTOP	9
> -#define TARGET_VSUSP	10
> -#define TARGET_VEOL	11
> -#define TARGET_VREPRINT	12
> -#define TARGET_VDISCARD	13
> -#define TARGET_VWERASE	14
> -#define TARGET_VLNEXT	15
> -#define TARGET_VEOL2	16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS		0x5401
> -#define TARGET_TCSETS		0x5402
> -#define TARGET_TCSETSW		0x5403
> -#define TARGET_TCSETSF		0x5404
> -#define TARGET_TCGETA		0x5405
> -#define TARGET_TCSETA		0x5406
> -#define TARGET_TCSETAW		0x5407
> -#define TARGET_TCSETAF		0x5408
> -#define TARGET_TCSBRK		0x5409
> -#define TARGET_TCXONC		0x540A
> -#define TARGET_TCFLSH		0x540B
> -
> -#define TARGET_TIOCEXCL	0x540C
> -#define TARGET_TIOCNXCL	0x540D
> -#define TARGET_TIOCSCTTY	0x540E
> -#define TARGET_TIOCGPGRP	0x540F
> -#define TARGET_TIOCSPGRP	0x5410
> -#define TARGET_TIOCOUTQ	0x5411
> -#define TARGET_TIOCSTI		0x5412
> -#define TARGET_TIOCGWINSZ	0x5413
> -#define TARGET_TIOCSWINSZ	0x5414
> -#define TARGET_TIOCMGET	0x5415
> -#define TARGET_TIOCMBIS	0x5416
> -#define TARGET_TIOCMBIC	0x5417
> -#define TARGET_TIOCMSET	0x5418
> -#define TARGET_TIOCGSOFTCAR	0x5419
> -#define TARGET_TIOCSSOFTCAR	0x541A
> -#define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		TARGET_FIONREAD
> -#define TARGET_TIOCLINUX	0x541C
> -#define TARGET_TIOCCONS	0x541D
> -#define TARGET_TIOCGSERIAL	0x541E
> -#define TARGET_TIOCSSERIAL	0x541F
> -#define TARGET_TIOCPKT		0x5420
> -#define TARGET_FIONBIO		0x5421
> -#define TARGET_TIOCNOTTY	0x5422
> -#define TARGET_TIOCSETD	0x5423
> -#define TARGET_TIOCGETD	0x5424
> -#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT	0x5426  /* For debugging only */
> -#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX		0x5451
> -#define TARGET_FIOASYNC	0x5452
> -#define TARGET_TIOCSERCONFIG	0x5453
> -#define TARGET_TIOCSERGWILD	0x5454
> -#define TARGET_TIOCSERSWILD	0x5455
> -#define TARGET_TIOCGLCKTRMIOS	0x5456
> -#define TARGET_TIOCSLCKTRMIOS	0x5457
> -#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA		 0
> -#define TARGET_TIOCPKT_FLUSHREAD	 1
> -#define TARGET_TIOCPKT_FLUSHWRITE	 2
> -#define TARGET_TIOCPKT_STOP		 4
> -#define TARGET_TIOCPKT_START		 8
> -#define TARGET_TIOCPKT_NOSTOP		16
> -#define TARGET_TIOCPKT_DOSTOP		32
> -
> -#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/generic/termbits.h b/linux-user/generic/termbits.h
> new file mode 100644
> index 0000000000..6675e0d1ab
> --- /dev/null
> +++ b/linux-user/generic/termbits.h
> @@ -0,0 +1,318 @@
> +/* Derived from asm-generic/termbits.h */
> +
> +#ifndef GENERIC_TERMBITS_H
> +#define GENERIC_TERMBITS_H
> +
> +typedef unsigned char   target_cc_t;        /* cc_t */
> +typedef unsigned int    target_speed_t;     /* speed_t */
> +typedef unsigned int    target_tcflag_t;    /* tcflag_t */
> +
> +#define TARGET_NCCS 19
> +
> +struct target_termios {
> +    target_tcflag_t c_iflag;         /* input mode flags */
> +    target_tcflag_t c_oflag;         /* output mode flags */
> +    target_tcflag_t c_cflag;         /* control mode flags */
> +    target_tcflag_t c_lflag;         /* local mode flags */
> +    target_cc_t c_line;              /* line discipline */
> +    target_cc_t c_cc[TARGET_NCCS];   /* control characters */
> +};
> +
> +struct target_termios2 {
> +    target_tcflag_t c_iflag;       /* input mode flags */
> +    target_tcflag_t c_oflag;       /* output mode flags */
> +    target_tcflag_t c_cflag;       /* control mode flags */
> +    target_tcflag_t c_lflag;       /* local mode flags */
> +    target_cc_t c_line;            /* line discipline */
> +    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
> +    target_speed_t c_ispeed;       /* input speed */
> +    target_speed_t c_ospeed;       /* output speed */
> +};
> +
> +struct target_ktermios {
> +    target_tcflag_t c_iflag;       /* input mode flags */
> +    target_tcflag_t c_oflag;       /* output mode flags */
> +    target_tcflag_t c_cflag;       /* control mode flags */
> +    target_tcflag_t c_lflag;       /* local mode flags */
> +    target_cc_t c_line;            /* line discipline */
> +    target_cc_t c_cc[TARGET_NCCS]; /* control characters */
> +    target_speed_t c_ispeed;       /* input speed */
> +    target_speed_t c_ospeed;       /* output speed */
> +};
> +
> +/* c_cc character offsets */
> +#define TARGET_VINTR    0
> +#define TARGET_VQUIT    1
> +#define TARGET_VERASE   2
> +#define TARGET_VKILL    3
> +#define TARGET_VEOF     4
> +#define TARGET_VTIME    5
> +#define TARGET_VMIN     6
> +#define TARGET_VSWTC    7
> +#define TARGET_VSTART   8
> +#define TARGET_VSTOP    9
> +#define TARGET_VSUSP    10
> +#define TARGET_VEOL     11
> +#define TARGET_VREPRINT 12
> +#define TARGET_VDISCARD 13
> +#define TARGET_VWERASE  14
> +#define TARGET_VLNEXT   15
> +#define TARGET_VEOL2    16
> +
> +/* c_iflag bits */
> +#define TARGET_IGNBRK   0000001
> +#define TARGET_BRKINT   0000002
> +#define TARGET_IGNPAR   0000004
> +#define TARGET_PARMRK   0000010
> +#define TARGET_INPCK    0000020
> +#define TARGET_ISTRIP   0000040
> +#define TARGET_INLCR    0000100
> +#define TARGET_IGNCR    0000200
> +#define TARGET_ICRNL    0000400
> +#define TARGET_IUCLC    0001000
> +#define TARGET_IXON     0002000
> +#define TARGET_IXANY    0004000
> +#define TARGET_IXOFF    0010000
> +#define TARGET_IMAXBEL  0020000
> +#define TARGET_IUTF8    0040000
> +
> +/* c_oflag bits */
> +#define TARGET_OPOST    0000001
> +#define TARGET_OLCUC    0000002
> +#define TARGET_ONLCR    0000004
> +#define TARGET_OCRNL    0000010
> +#define TARGET_ONOCR    0000020
> +#define TARGET_ONLRET   0000040
> +#define TARGET_OFILL    0000100
> +#define TARGET_OFDEL    0000200
> +#define TARGET_NLDLY    0000400
> +#define  TARGET_NL0     0000000
> +#define  TARGET_NL1     0000400
> +#define TARGET_CRDLY    0003000
> +#define  TARGET_CR0     0000000
> +#define  TARGET_CR1     0001000
> +#define  TARGET_CR2     0002000
> +#define  TARGET_CR3     0003000
> +#define TARGET_TABDLY   0014000
> +#define  TARGET_TAB0    0000000
> +#define  TARGET_TAB1    0004000
> +#define  TARGET_TAB2    0010000
> +#define  TARGET_TAB3    0014000
> +#define  TARGET_XTABS   0014000
> +#define TARGET_BSDLY    0020000
> +#define  TARGET_BS0     0000000
> +#define  TARGET_BS1     0020000
> +#define TARGET_VTDLY    0040000
> +#define  TARGET_VT0     0000000
> +#define  TARGET_VT1     0040000
> +#define TARGET_FFDLY    0100000
> +#define  TARGET_FF0     0000000
> +#define  TARGET_FF1     0100000
> +
> +/* c_cflag bit meaning */
> +#define TARGET_CBAUD      0010017
> +#define  TARGET_B0        0000000  /* hang up */
> +#define  TARGET_B50       0000001
> +#define  TARGET_B75       0000002
> +#define  TARGET_B110      0000003
> +#define  TARGET_B134      0000004
> +#define  TARGET_B150      0000005
> +#define  TARGET_B200      0000006
> +#define  TARGET_B300      0000007
> +#define  TARGET_B600      0000010
> +#define  TARGET_B1200     0000011
> +#define  TARGET_B1800     0000012
> +#define  TARGET_B2400     0000013
> +#define  TARGET_B4800     0000014
> +#define  TARGET_B9600     0000015
> +#define  TARGET_B19200    0000016
> +#define  TARGET_B38400    0000017
> +#define  TARGET_EXTA      TARGET_B19200
> +#define  TARGET_EXTB      TARGET_B38400
> +#define TARGET_CSIZE      0000060
> +#define  TARGET_CS5       0000000
> +#define  TARGET_CS6       0000020
> +#define  TARGET_CS7       0000040
> +#define  TARGET_CS8       0000060
> +#define TARGET_CSTOPB     0000100
> +#define TARGET_CREAD      0000200
> +#define TARGET_PARENB     0000400
> +#define TARGET_PARODD     0001000
> +#define TARGET_HUPCL      0002000
> +#define TARGET_CLOCAL     0004000
> +#define TARGET_CBAUDEX    0010000
> +#define  TARGET_BOTHER    0010000
> +#define  TARGET_B57600    0010001
> +#define  TARGET_B115200   0010002
> +#define  TARGET_B230400   0010003
> +#define  TARGET_B460800   0010004
> +#define  TARGET_B500000   0010005
> +#define  TARGET_B576000   0010006
> +#define  TARGET_B921600   0010007
> +#define  TARGET_B1000000  0010010
> +#define  TARGET_B1152000  0010011
> +#define  TARGET_B1500000  0010012
> +#define  TARGET_B2000000  0010013
> +#define  TARGET_B2500000  0010014
> +#define  TARGET_B3000000  0010015
> +#define  TARGET_B3500000  0010016
> +#define  TARGET_B4000000  0010017
> +#define TARGET_CIBAUD     002003600000  /* input baud rate (not used) */
> +#define TARGET_CMSPAR     010000000000  /* mark or space (stick) parity */
> +#define TARGET_CRTSCTS    020000000000  /* flow control */
> +
> +#define TARGET_IBSHIFT    16            /* Shift from CBAUD to CIBAUD */
> +
> +/* c_lflag bits */
> +#define TARGET_ISIG       0000001
> +#define TARGET_ICANON     0000002
> +#define TARGET_XCASE      0000004
> +#define TARGET_ECHO       0000010
> +#define TARGET_ECHOE      0000020
> +#define TARGET_ECHOK      0000040
> +#define TARGET_ECHONL     0000100
> +#define TARGET_NOFLSH     0000200
> +#define TARGET_TOSTOP     0000400
> +#define TARGET_ECHOCTL    0001000
> +#define TARGET_ECHOPRT    0002000
> +#define TARGET_ECHOKE     0004000
> +#define TARGET_FLUSHO     0010000
> +#define TARGET_PENDIN     0040000
> +#define TARGET_IEXTEN     0100000
> +#define TARGET_EXTPROC    0200000
> +
> +/* tcflow() and TCXONC use these */
> +#define TARGET_TCOOFF          0
> +#define TARGET_TCOON           1
> +#define TARGET_TCIOFF          2
> +#define TARGET_TCION           3
> +
> +/* tcflush() and TCFLSH use these */
> +#define TARGET_TCIFLUSH        0
> +#define TARGET_TCOFLUSH        1
> +#define TARGET_TCIOFLUSH       2
> +
> +/* tcsetattr uses these */
> +#define TARGET_TCSANOW         0
> +#define TARGET_TCSADRAIN       1
> +#define TARGET_TCSAFLUSH       2
> +
> +/* Derived from include/uapi/asm-generic/ioctls.h */
> +
> +#define TARGET_TCGETS           0x5401
> +#define TARGET_TCSETS           0x5402
> +#define TARGET_TCSETSW          0x5403
> +#define TARGET_TCSETSF          0x5404
> +#define TARGET_TCGETA           0x5405
> +#define TARGET_TCSETA           0x5406
> +#define TARGET_TCSETAW          0x5407
> +#define TARGET_TCSETAF          0x5408
> +#define TARGET_TCSBRK           0x5409
> +#define TARGET_TCXONC           0x540A
> +#define TARGET_TCFLSH           0x540B
> +
> +#define TARGET_TIOCEXCL         0x540C
> +#define TARGET_TIOCNXCL         0x540D
> +#define TARGET_TIOCSCTTY        0x540E
> +#define TARGET_TIOCGPGRP        0x540F
> +#define TARGET_TIOCSPGRP        0x5410
> +#define TARGET_TIOCOUTQ         0x5411
> +#define TARGET_TIOCSTI          0x5412
> +#define TARGET_TIOCGWINSZ       0x5413
> +#define TARGET_TIOCSWINSZ       0x5414
> +#define TARGET_TIOCMGET         0x5415
> +#define TARGET_TIOCMBIS         0x5416
> +#define TARGET_TIOCMBIC         0x5417
> +#define TARGET_TIOCMSET         0x5418
> +#define TARGET_TIOCGSOFTCAR     0x5419
> +#define TARGET_TIOCSSOFTCAR     0x541A
> +#define TARGET_FIONREAD         0x541B
> +#define TARGET_TIOCINQ          TARGET_FIONREAD
> +#define TARGET_TIOCLINUX        0x541C
> +#define TARGET_TIOCCONS         0x541D
> +#define TARGET_TIOCGSERIAL      0x541E
> +#define TARGET_TIOCSSERIAL      0x541F
> +#define TARGET_TIOCPKT          0x5420
> +#define TARGET_FIONBIO          0x5421
> +#define TARGET_TIOCNOTTY        0x5422
> +#define TARGET_TIOCSETD         0x5423
> +#define TARGET_TIOCGETD         0x5424
> +#define TARGET_TCSBRKP          0x5425 /* Needed for POSIX tcsendbreak() */
> +#define TARGET_TIOCTTYGSTRUCT   0x5426 /* For debugging only */
> +#define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
> +#define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
> +#define TARGET_TIOCGSID         0x5429 /* Return the session ID of FD */
> +#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct target_termios2)
> +#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct target_termios2)
> +#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct target_termios2)
> +#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct target_termios2)
> +#define TARGET_TIOCGRS485       0x542E
> +#ifndef TARGET_TIOCSRS485
> +#define TARGET_TIOCSRS485       0x542F
> +#endif
> +/* Get Pty Number (of pty-mux device) */
> +#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
> +/* Lock/unlock Pty */
> +#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
> +
> +/* Get primary device node of /dev/console */
> +#define TARGET_TIOCGDEV        TARGET_IOR('T', 0x32, unsigned int)
> +#define TARGET_TCGETX          0x5432 /* SYS5 TCGETX compatibility */
> +#define TARGET_TCSETX          0x5433
> +#define TARGET_TCSETXF         0x5434
> +#define TARGET_TCSETXW         0x5435
> +/* pty: generate signal */
> +#define TARGET_TIOCSIG         TARGET_IOW('T', 0x36, int)
> +#define TARGET_TIOCVHANGUP     0x5437
> +/* Get packet mode state */
> +#define TARGET_TIOCGPKT        TARGET_IOR('T', 0x38, int)
> +/* Get Pty lock state */
> +#define TARGET_TIOCGPTLCK      TARGET_IOR('T', 0x39, int)
> +/* Get exclusive mode state */
> +#define TARGET_TIOCGEXCL       TARGET_IOR('T', 0x40, int)
> +/* Safely open the slave */
> +#define TARGET_TIOCGPTPEER     TARGET_IO('T', 0x41)
> +#define TARGET_TIOCGISO7816    TARGET_IOR('T', 0x42, struct serial_iso7816)
> +#define TARGET_TIOCSISO7816    TARGET_IOWR('T', 0x43, struct serial_iso7816)
> +
> +#define TARGET_FIONCLEX         0x5450 /* these numbers need to be adjusted */
> +#define TARGET_FIOCLEX          0x5451
> +#define TARGET_FIOASYNC         0x5452
> +#define TARGET_TIOCSERCONFIG    0x5453
> +#define TARGET_TIOCSERGWILD     0x5454
> +#define TARGET_TIOCSERSWILD     0x5455
> +#define TARGET_TIOCGLCKTRMIOS   0x5456
> +#define TARGET_TIOCSLCKTRMIOS   0x5457
> +#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
> +#define TARGET_TIOCSERGETLSR    0x5459 /* Get line status register */
> +#define TARGET_TIOCSERGETMULTI  0x545A /* Get multiport config  */
> +#define TARGET_TIOCSERSETMULTI  0x545B /* Set multiport config */
> +
> +/* wait for a change on serial input line(s) */
> +#define TARGET_TIOCMIWAIT       0x545C
> +/* read serial port inline interrupt counts */
> +#define TARGET_TIOCGICOUNT      0x545D
> +#define TARGET_TIOCGHAYESESP    0x545E  /* Get Hayes ESP configuration */
> +#define TARGET_TIOCSHAYESESP    0x545F  /* Set Hayes ESP configuration */
> +
> +/*
> + * Some arches already define TARGET_FIOQSIZE due to a historical
> + * conflict with a Hayes modem-specific ioctl value.
> + */
> +#ifndef TARGET_FIOQSIZE
> +# define TARGET_FIOQSIZE        0x5460
> +#endif
> +
> +/* Used for packet mode */
> +#define TARGET_TIOCPKT_DATA              0
> +#define TARGET_TIOCPKT_FLUSHREAD         1
> +#define TARGET_TIOCPKT_FLUSHWRITE        2
> +#define TARGET_TIOCPKT_STOP              4
> +#define TARGET_TIOCPKT_START             8
> +#define TARGET_TIOCPKT_NOSTOP            16
> +#define TARGET_TIOCPKT_DOSTOP            32
> +#define TARGET_TIOCPKT_IOCTL             64
> +
> +#define TARGET_TIOCSER_TEMT     0x01 /* Transmitter physically empty */
> +
> +#endif
> diff --git a/linux-user/i386/termbits.h b/linux-user/i386/termbits.h
> index 88264bbde7..b1d4f4fedb 100644
> --- a/linux-user/i386/termbits.h
> +++ b/linux-user/i386/termbits.h
> @@ -1,232 +1 @@
> -/* from asm/termbits.h */
> -
> -#ifndef LINUX_USER_I386_TERMBITS_H
> -#define LINUX_USER_I386_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;                    /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];                /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define  TARGET_B500000 0010005
> -#define  TARGET_B576000 0010006
> -#define  TARGET_B921600 0010007
> -#define  TARGET_B1000000 0010010
> -#define  TARGET_B1152000 0010011
> -#define  TARGET_B1500000 0010012
> -#define  TARGET_B2000000 0010013
> -#define  TARGET_B2500000 0010014
> -#define  TARGET_B3000000 0010015
> -#define  TARGET_B3500000 0010016
> -#define  TARGET_B4000000 0010017
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000  /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR	0
> -#define TARGET_VQUIT	1
> -#define TARGET_VERASE	2
> -#define TARGET_VKILL	3
> -#define TARGET_VEOF	4
> -#define TARGET_VTIME	5
> -#define TARGET_VMIN	6
> -#define TARGET_VSWTC	7
> -#define TARGET_VSTART	8
> -#define TARGET_VSTOP	9
> -#define TARGET_VSUSP	10
> -#define TARGET_VEOL	11
> -#define TARGET_VREPRINT	12
> -#define TARGET_VDISCARD	13
> -#define TARGET_VWERASE	14
> -#define TARGET_VLNEXT	15
> -#define TARGET_VEOL2	16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS		0x5401
> -#define TARGET_TCSETS		0x5402
> -#define TARGET_TCSETSW		0x5403
> -#define TARGET_TCSETSF		0x5404
> -#define TARGET_TCGETA		0x5405
> -#define TARGET_TCSETA		0x5406
> -#define TARGET_TCSETAW		0x5407
> -#define TARGET_TCSETAF		0x5408
> -#define TARGET_TCSBRK		0x5409
> -#define TARGET_TCXONC		0x540A
> -#define TARGET_TCFLSH		0x540B
> -
> -#define TARGET_TIOCEXCL	0x540C
> -#define TARGET_TIOCNXCL	0x540D
> -#define TARGET_TIOCSCTTY	0x540E
> -#define TARGET_TIOCGPGRP	0x540F
> -#define TARGET_TIOCSPGRP	0x5410
> -#define TARGET_TIOCOUTQ	0x5411
> -#define TARGET_TIOCSTI		0x5412
> -#define TARGET_TIOCGWINSZ	0x5413
> -#define TARGET_TIOCSWINSZ	0x5414
> -#define TARGET_TIOCMGET	0x5415
> -#define TARGET_TIOCMBIS	0x5416
> -#define TARGET_TIOCMBIC	0x5417
> -#define TARGET_TIOCMSET	0x5418
> -#define TARGET_TIOCGSOFTCAR	0x5419
> -#define TARGET_TIOCSSOFTCAR	0x541A
> -#define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		TARGET_FIONREAD
> -#define TARGET_TIOCLINUX	0x541C
> -#define TARGET_TIOCCONS	0x541D
> -#define TARGET_TIOCGSERIAL	0x541E
> -#define TARGET_TIOCSSERIAL	0x541F
> -#define TARGET_TIOCPKT		0x5420
> -#define TARGET_FIONBIO		0x5421
> -#define TARGET_TIOCNOTTY	0x5422
> -#define TARGET_TIOCSETD	0x5423
> -#define TARGET_TIOCGETD	0x5424
> -#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT	0x5426  /* For debugging only */
> -#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX		0x5451
> -#define TARGET_FIOASYNC	0x5452
> -#define TARGET_TIOCSERCONFIG	0x5453
> -#define TARGET_TIOCSERGWILD	0x5454
> -#define TARGET_TIOCSERSWILD	0x5455
> -#define TARGET_TIOCGLCKTRMIOS	0x5456
> -#define TARGET_TIOCSLCKTRMIOS	0x5457
> -#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA		 0
> -#define TARGET_TIOCPKT_FLUSHREAD	 1
> -#define TARGET_TIOCPKT_FLUSHWRITE	 2
> -#define TARGET_TIOCPKT_STOP		 4
> -#define TARGET_TIOCPKT_START		 8
> -#define TARGET_TIOCPKT_NOSTOP		16
> -#define TARGET_TIOCPKT_DOSTOP		32
> -
> -#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/m68k/termbits.h b/linux-user/m68k/termbits.h
> index 23840aa968..b1d4f4fedb 100644
> --- a/linux-user/m68k/termbits.h
> +++ b/linux-user/m68k/termbits.h
> @@ -1,233 +1 @@
> -/* from asm/termbits.h */
> -/* NOTE: exactly the same as i386 */
> -
> -#ifndef LINUX_USER_M68K_TERMBITS_H
> -#define LINUX_USER_M68K_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;                    /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];                /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define  TARGET_B500000 0010005
> -#define  TARGET_B576000 0010006
> -#define  TARGET_B921600 0010007
> -#define  TARGET_B1000000 0010010
> -#define  TARGET_B1152000 0010011
> -#define  TARGET_B1500000 0010012
> -#define  TARGET_B2000000 0010013
> -#define  TARGET_B2500000 0010014
> -#define  TARGET_B3000000 0010015
> -#define  TARGET_B3500000 0010016
> -#define  TARGET_B4000000 0010017
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000  /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR	0
> -#define TARGET_VQUIT	1
> -#define TARGET_VERASE	2
> -#define TARGET_VKILL	3
> -#define TARGET_VEOF	4
> -#define TARGET_VTIME	5
> -#define TARGET_VMIN	6
> -#define TARGET_VSWTC	7
> -#define TARGET_VSTART	8
> -#define TARGET_VSTOP	9
> -#define TARGET_VSUSP	10
> -#define TARGET_VEOL	11
> -#define TARGET_VREPRINT	12
> -#define TARGET_VDISCARD	13
> -#define TARGET_VWERASE	14
> -#define TARGET_VLNEXT	15
> -#define TARGET_VEOL2	16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS		0x5401
> -#define TARGET_TCSETS		0x5402
> -#define TARGET_TCSETSW		0x5403
> -#define TARGET_TCSETSF		0x5404
> -#define TARGET_TCGETA		0x5405
> -#define TARGET_TCSETA		0x5406
> -#define TARGET_TCSETAW		0x5407
> -#define TARGET_TCSETAF		0x5408
> -#define TARGET_TCSBRK		0x5409
> -#define TARGET_TCXONC		0x540A
> -#define TARGET_TCFLSH		0x540B
> -
> -#define TARGET_TIOCEXCL	0x540C
> -#define TARGET_TIOCNXCL	0x540D
> -#define TARGET_TIOCSCTTY	0x540E
> -#define TARGET_TIOCGPGRP	0x540F
> -#define TARGET_TIOCSPGRP	0x5410
> -#define TARGET_TIOCOUTQ	0x5411
> -#define TARGET_TIOCSTI		0x5412
> -#define TARGET_TIOCGWINSZ	0x5413
> -#define TARGET_TIOCSWINSZ	0x5414
> -#define TARGET_TIOCMGET	0x5415
> -#define TARGET_TIOCMBIS	0x5416
> -#define TARGET_TIOCMBIC	0x5417
> -#define TARGET_TIOCMSET	0x5418
> -#define TARGET_TIOCGSOFTCAR	0x5419
> -#define TARGET_TIOCSSOFTCAR	0x541A
> -#define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		TARGET_FIONREAD
> -#define TARGET_TIOCLINUX	0x541C
> -#define TARGET_TIOCCONS	0x541D
> -#define TARGET_TIOCGSERIAL	0x541E
> -#define TARGET_TIOCSSERIAL	0x541F
> -#define TARGET_TIOCPKT		0x5420
> -#define TARGET_FIONBIO		0x5421
> -#define TARGET_TIOCNOTTY	0x5422
> -#define TARGET_TIOCSETD	0x5423
> -#define TARGET_TIOCGETD	0x5424
> -#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT	0x5426  /* For debugging only */
> -#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX		0x5451
> -#define TARGET_FIOASYNC	0x5452
> -#define TARGET_TIOCSERCONFIG	0x5453
> -#define TARGET_TIOCSERGWILD	0x5454
> -#define TARGET_TIOCSERSWILD	0x5455
> -#define TARGET_TIOCGLCKTRMIOS	0x5456
> -#define TARGET_TIOCSLCKTRMIOS	0x5457
> -#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA		 0
> -#define TARGET_TIOCPKT_FLUSHREAD	 1
> -#define TARGET_TIOCPKT_FLUSHWRITE	 2
> -#define TARGET_TIOCPKT_STOP		 4
> -#define TARGET_TIOCPKT_START		 8
> -#define TARGET_TIOCPKT_NOSTOP		16
> -#define TARGET_TIOCPKT_DOSTOP		32
> -
> -#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/microblaze/termbits.h b/linux-user/microblaze/termbits.h
> index 17db8a4473..b1d4f4fedb 100644
> --- a/linux-user/microblaze/termbits.h
> +++ b/linux-user/microblaze/termbits.h
> @@ -1,219 +1 @@
> -/* from asm/termbits.h */
> -
> -#ifndef LINUX_USER_MICROBLAZE_TERMBITS_H
> -#define LINUX_USER_MICROBLAZE_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;                    /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];                /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CRTSCTS   020000000000          /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR	0
> -#define TARGET_VQUIT	1
> -#define TARGET_VERASE	2
> -#define TARGET_VKILL	3
> -#define TARGET_VEOF	4
> -#define TARGET_VTIME	5
> -#define TARGET_VMIN	6
> -#define TARGET_VSWTC	7
> -#define TARGET_VSTART	8
> -#define TARGET_VSTOP	9
> -#define TARGET_VSUSP	10
> -#define TARGET_VEOL	11
> -#define TARGET_VREPRINT	12
> -#define TARGET_VDISCARD	13
> -#define TARGET_VWERASE	14
> -#define TARGET_VLNEXT	15
> -#define TARGET_VEOL2	16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS		0x5401
> -#define TARGET_TCSETS		0x5402
> -#define TARGET_TCSETSW		0x5403
> -#define TARGET_TCSETSF		0x5404
> -#define TARGET_TCGETA		0x5405
> -#define TARGET_TCSETA		0x5406
> -#define TARGET_TCSETAW		0x5407
> -#define TARGET_TCSETAF		0x5408
> -#define TARGET_TCSBRK		0x5409
> -#define TARGET_TCXONC		0x540A
> -#define TARGET_TCFLSH		0x540B
> -
> -#define TARGET_TIOCEXCL	0x540C
> -#define TARGET_TIOCNXCL	0x540D
> -#define TARGET_TIOCSCTTY	0x540E
> -#define TARGET_TIOCGPGRP	0x540F
> -#define TARGET_TIOCSPGRP	0x5410
> -#define TARGET_TIOCOUTQ	0x5411
> -#define TARGET_TIOCSTI		0x5412
> -#define TARGET_TIOCGWINSZ	0x5413
> -#define TARGET_TIOCSWINSZ	0x5414
> -#define TARGET_TIOCMGET	0x5415
> -#define TARGET_TIOCMBIS	0x5416
> -#define TARGET_TIOCMBIC	0x5417
> -#define TARGET_TIOCMSET	0x5418
> -#define TARGET_TIOCGSOFTCAR	0x5419
> -#define TARGET_TIOCSSOFTCAR	0x541A
> -#define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		TARGET_FIONREAD
> -#define TARGET_TIOCLINUX	0x541C
> -#define TARGET_TIOCCONS	0x541D
> -#define TARGET_TIOCGSERIAL	0x541E
> -#define TARGET_TIOCSSERIAL	0x541F
> -#define TARGET_TIOCPKT		0x5420
> -#define TARGET_FIONBIO		0x5421
> -#define TARGET_TIOCNOTTY	0x5422
> -#define TARGET_TIOCSETD	0x5423
> -#define TARGET_TIOCGETD	0x5424
> -#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT	0x5426  /* For debugging only */
> -#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX		0x5451
> -#define TARGET_FIOASYNC	0x5452
> -#define TARGET_TIOCSERCONFIG	0x5453
> -#define TARGET_TIOCSERGWILD	0x5454
> -#define TARGET_TIOCSERSWILD	0x5455
> -#define TARGET_TIOCGLCKTRMIOS	0x5456
> -#define TARGET_TIOCSLCKTRMIOS	0x5457
> -#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA		 0
> -#define TARGET_TIOCPKT_FLUSHREAD	 1
> -#define TARGET_TIOCPKT_FLUSHWRITE	 2
> -#define TARGET_TIOCPKT_STOP		 4
> -#define TARGET_TIOCPKT_START		 8
> -#define TARGET_TIOCPKT_NOSTOP		16
> -#define TARGET_TIOCPKT_DOSTOP		32
> -
> -#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/nios2/termbits.h b/linux-user/nios2/termbits.h
> index 425a2fe6ef..b1d4f4fedb 100644
> --- a/linux-user/nios2/termbits.h
> +++ b/linux-user/nios2/termbits.h
> @@ -1,227 +1 @@
> -/* from asm/termbits.h */
> -/* NOTE: exactly the same as i386 */
> -
> -#ifndef LINUX_USER_NIOS2_TERMBITS_H
> -#define LINUX_USER_NIOS2_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;                    /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];                /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000  /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR    0
> -#define TARGET_VQUIT    1
> -#define TARGET_VERASE   2
> -#define TARGET_VKILL    3
> -#define TARGET_VEOF     4
> -#define TARGET_VTIME    5
> -#define TARGET_VMIN     6
> -#define TARGET_VSWTC    7
> -#define TARGET_VSTART   8
> -#define TARGET_VSTOP    9
> -#define TARGET_VSUSP    10
> -#define TARGET_VEOL     11
> -#define TARGET_VREPRINT 12
> -#define TARGET_VDISCARD 13
> -#define TARGET_VWERASE  14
> -#define TARGET_VLNEXT   15
> -#define TARGET_VEOL2    16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS           0x5401
> -#define TARGET_TCSETS           0x5402
> -#define TARGET_TCSETSW          0x5403
> -#define TARGET_TCSETSF          0x5404
> -#define TARGET_TCGETA           0x5405
> -#define TARGET_TCSETA           0x5406
> -#define TARGET_TCSETAW          0x5407
> -#define TARGET_TCSETAF          0x5408
> -#define TARGET_TCSBRK           0x5409
> -#define TARGET_TCXONC           0x540A
> -#define TARGET_TCFLSH           0x540B
> -
> -#define TARGET_TIOCEXCL         0x540C
> -#define TARGET_TIOCNXCL         0x540D
> -#define TARGET_TIOCSCTTY        0x540E
> -#define TARGET_TIOCGPGRP        0x540F
> -#define TARGET_TIOCSPGRP        0x5410
> -#define TARGET_TIOCOUTQ         0x5411
> -#define TARGET_TIOCSTI          0x5412
> -#define TARGET_TIOCGWINSZ       0x5413
> -#define TARGET_TIOCSWINSZ       0x5414
> -#define TARGET_TIOCMGET         0x5415
> -#define TARGET_TIOCMBIS         0x5416
> -#define TARGET_TIOCMBIC         0x5417
> -#define TARGET_TIOCMSET         0x5418
> -#define TARGET_TIOCGSOFTCAR     0x5419
> -#define TARGET_TIOCSSOFTCAR     0x541A
> -#define TARGET_FIONREAD         0x541B
> -#define TARGET_TIOCINQ          TARGET_FIONREAD
> -#define TARGET_TIOCLINUX        0x541C
> -#define TARGET_TIOCCONS         0x541D
> -#define TARGET_TIOCGSERIAL      0x541E
> -#define TARGET_TIOCSSERIAL      0x541F
> -#define TARGET_TIOCPKT          0x5420
> -#define TARGET_FIONBIO          0x5421
> -#define TARGET_TIOCNOTTY        0x5422
> -#define TARGET_TIOCSETD         0x5423
> -#define TARGET_TIOCGETD         0x5424
> -#define TARGET_TCSBRKP          0x5425 /* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT   0x5426 /* For debugging only */
> -#define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
> -#define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
> -#define TARGET_TIOCGSID         0x5429 /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
> -        /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
> -        /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
> -        /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX          0x5451
> -#define TARGET_FIOASYNC         0x5452
> -#define TARGET_TIOCSERCONFIG    0x5453
> -#define TARGET_TIOCSERGWILD     0x5454
> -#define TARGET_TIOCSERSWILD     0x5455
> -#define TARGET_TIOCGLCKTRMIOS   0x5456
> -#define TARGET_TIOCSLCKTRMIOS   0x5457
> -#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR    0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI  0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI  0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT      0x545C
> -        /* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT     0x545D
> -        /* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA              0
> -#define TARGET_TIOCPKT_FLUSHREAD         1
> -#define TARGET_TIOCPKT_FLUSHWRITE        2
> -#define TARGET_TIOCPKT_STOP              4
> -#define TARGET_TIOCPKT_START             8
> -#define TARGET_TIOCPKT_NOSTOP           16
> -#define TARGET_TIOCPKT_DOSTOP           32
> -
> -#define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/openrisc/termbits.h b/linux-user/openrisc/termbits.h
> index 7a635ffbc6..b1d4f4fedb 100644
> --- a/linux-user/openrisc/termbits.h
> +++ b/linux-user/openrisc/termbits.h
> @@ -1,301 +1 @@
> -#ifndef LINUX_USER_OPENRISC_TERMBITS_H
> -#define LINUX_USER_OPENRISC_TERMBITS_H
> -
> -typedef unsigned char   target_openrisc_cc;        /*cc_t*/
> -typedef unsigned int    target_openrisc_speed;     /*speed_t*/
> -typedef unsigned int    target_openrisc_tcflag;    /*tcflag_t*/
> -
> -#define TARGET_NCCS 19
> -struct target_termios {
> -    target_openrisc_tcflag c_iflag;               /* input mode flags */
> -    target_openrisc_tcflag c_oflag;               /* output mode flags */
> -    target_openrisc_tcflag c_cflag;               /* control mode flags */
> -    target_openrisc_tcflag c_lflag;               /* local mode flags */
> -    target_openrisc_cc c_line;                    /* line discipline */
> -    target_openrisc_cc c_cc[TARGET_NCCS];         /* control characters */
> -};
> -
> -struct target_termios2 {
> -    target_openrisc_tcflag c_iflag;               /* input mode flags */
> -    target_openrisc_tcflag c_oflag;               /* output mode flags */
> -    target_openrisc_tcflag c_cflag;               /* control mode flags */
> -    target_openrisc_tcflag c_lflag;               /* local mode flags */
> -    target_openrisc_cc c_line;                    /* line discipline */
> -    target_openrisc_cc c_cc[TARGET_NCCS];         /* control characters */
> -    target_openrisc_speed c_ispeed;               /* input speed */
> -    target_openrisc_speed c_ospeed;               /* output speed */
> -};
> -
> -struct target_termios3 {
> -    target_openrisc_tcflag c_iflag;               /* input mode flags */
> -    target_openrisc_tcflag c_oflag;               /* output mode flags */
> -    target_openrisc_tcflag c_cflag;               /* control mode flags */
> -    target_openrisc_tcflag c_lflag;               /* local mode flags */
> -    target_openrisc_cc c_line;                    /* line discipline */
> -    target_openrisc_cc c_cc[TARGET_NCCS];         /* control characters */
> -    target_openrisc_speed c_ispeed;               /* input speed */
> -    target_openrisc_speed c_ospeed;               /* output speed */
> -};
> -
> -/* c_cc characters */
> -#define TARGET_VINTR 0
> -#define TARGET_VQUIT 1
> -#define TARGET_VERASE 2
> -#define TARGET_VKILL 3
> -#define TARGET_VEOF 4
> -#define TARGET_VTIME 5
> -#define TARGET_VMIN 6
> -#define TARGET_VSWTC 7
> -#define TARGET_VSTART 8
> -#define TARGET_VSTOP 9
> -#define TARGET_VSUSP 10
> -#define TARGET_VEOL 11
> -#define TARGET_VREPRINT 12
> -#define TARGET_VDISCARD 13
> -#define TARGET_VWERASE 14
> -#define TARGET_VLNEXT 15
> -#define TARGET_VEOL2 16
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define TARGET_NL0     0000000
> -#define TARGET_NL1     0000400
> -#define TARGET_CRDLY   0003000
> -#define TARGET_CR0     0000000
> -#define TARGET_CR1     0001000
> -#define TARGET_CR2     0002000
> -#define TARGET_CR3     0003000
> -#define TARGET_TABDLY  0014000
> -#define TARGET_TAB0    0000000
> -#define TARGET_TAB1    0004000
> -#define TARGET_TAB2    0010000
> -#define TARGET_TAB3    0014000
> -#define TARGET_XTABS   0014000
> -#define TARGET_BSDLY   0020000
> -#define TARGET_BS0     0000000
> -#define TARGET_BS1     0020000
> -#define TARGET_VTDLY   0040000
> -#define TARGET_VT0     0000000
> -#define TARGET_VT1     0040000
> -#define TARGET_FFDLY   0100000
> -#define TARGET_FF0     0000000
> -#define TARGET_FF1     0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD    0010017
> -#define TARGET_B0       0000000                /* hang up */
> -#define TARGET_B50      0000001
> -#define TARGET_B75      0000002
> -#define TARGET_B110     0000003
> -#define TARGET_B134     0000004
> -#define TARGET_B150     0000005
> -#define TARGET_B200     0000006
> -#define TARGET_B300     0000007
> -#define TARGET_B600     0000010
> -#define TARGET_B1200    0000011
> -#define TARGET_B1800    0000012
> -#define TARGET_B2400    0000013
> -#define TARGET_B4800    0000014
> -#define TARGET_B9600    0000015
> -#define TARGET_B19200   0000016
> -#define TARGET_B38400   0000017
> -#define TARGET_EXTA     B19200
> -#define TARGET_EXTB     B38400
> -#define TARGET_CSIZE    0000060
> -#define TARGET_CS5      0000000
> -#define TARGET_CS6      0000020
> -#define TARGET_CS7      0000040
> -#define TARGET_CS8      0000060
> -#define TARGET_CSTOPB   0000100
> -#define TARGET_CREAD    0000200
> -#define TARGET_PARENB   0000400
> -#define TARGET_PARODD   0001000
> -#define TARGET_HUPCL    0002000
> -#define TARGET_CLOCAL   0004000
> -#define TARGET_CBAUDEX  0010000
> -#define TARGET_BOTHER   0010000
> -#define TARGET_B57600   0010001
> -#define TARGET_B115200  0010002
> -#define TARGET_B230400  0010003
> -#define TARGET_B460800  0010004
> -#define TARGET_B500000  0010005
> -#define TARGET_B576000  0010006
> -#define TARGET_B921600  0010007
> -#define TARGET_B1000000 0010010
> -#define TARGET_B1152000 0010011
> -#define TARGET_B1500000 0010012
> -#define TARGET_B2000000 0010013
> -#define TARGET_B2500000 0010014
> -#define TARGET_B3000000 0010015
> -#define TARGET_B3500000 0010016
> -#define TARGET_B4000000 0010017
> -#define TARGET_CIBAUD   002003600000   /* input baud rate */
> -#define TARGET_CMSPAR   010000000000   /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS  020000000000   /* flow control */
> -
> -#define TARGET_IBSHIFT   16            /* Shift from CBAUD to CIBAUD */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -#define TARGET_EXTPROC 0200000
> -
> -/* tcflow() and TCXONC use these */
> -#define TARGET_TCOOFF          0
> -#define TARGET_TCOON           1
> -#define TARGET_TCIOFF          2
> -#define TARGET_TCION           3
> -
> -/* tcflush() and TCFLSH use these */
> -#define TARGET_TCIFLUSH        0
> -#define TARGET_TCOFLUSH        1
> -#define TARGET_TCIOFLUSH       2
> -
> -/* tcsetattr uses these */
> -#define TARGET_TCSANOW         0
> -#define TARGET_TCSADRAIN       1
> -#define TARGET_TCSAFLUSH       2
> -
> -/* ioctls */
> -#define TARGET_TCGETS          0x5401
> -#define TARGET_TCSETS          0x5402
> -#define TARGET_TCSETSW         0x5403
> -#define TARGET_TCSETSF         0x5404
> -#define TARGET_TCGETA          0x5405
> -#define TARGET_TCSETA          0x5406
> -#define TARGET_TCSETAW         0x5407
> -#define TARGET_TCSETAF         0x5408
> -#define TARGET_TCSBRK          0x5409
> -#define TARGET_TCXONC          0x540A
> -#define TARGET_TCFLSH          0x540B
> -#define TARGET_TIOCEXCL        0x540C
> -#define TARGET_TIOCNXCL        0x540D
> -#define TARGET_TIOCSCTTY       0x540E
> -#define TARGET_TIOCGPGRP       0x540F
> -#define TARGET_TIOCSPGRP       0x5410
> -#define TARGET_TIOCOUTQ        0x5411
> -#define TARGET_TIOCSTI         0x5412
> -#define TARGET_TIOCGWINSZ      0x5413
> -#define TARGET_TIOCSWINSZ      0x5414
> -#define TARGET_TIOCMGET        0x5415
> -#define TARGET_TIOCMBIS        0x5416
> -#define TARGET_TIOCMBIC        0x5417
> -#define TARGET_TIOCMSET        0x5418
> -#define TARGET_TIOCGSOFTCAR    0x5419
> -#define TARGET_TIOCSSOFTCAR    0x541A
> -#define TARGET_FIONREAD        0x541B
> -#define TARGET_TIOCINQ         FIONREAD
> -#define TARGET_TIOCLINUX       0x541C
> -#define TARGET_TIOCCONS        0x541D
> -#define TARGET_TIOCGSERIAL     0x541E
> -#define TARGET_TIOCSSERIAL     0x541F
> -#define TARGET_TIOCPKT         0x5420
> -#define TARGET_FIONBIO         0x5421
> -#define TARGET_TIOCNOTTY       0x5422
> -#define TARGET_TIOCSETD        0x5423
> -#define TARGET_TIOCGETD        0x5424
> -#define TARGET_TCSBRKP         0x5425  /* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCSBRK        0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK        0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID        0x5429  /* Return the session ID of FD */
> -#define TARGET_TCGETS2         TARGET_IOR('T', 0x2A, struct termios2)
> -#define TARGET_TCSETS2         TARGET_IOW('T', 0x2B, struct termios2)
> -#define TARGET_TCSETSW2        TARGET_IOW('T', 0x2C, struct termios2)
> -#define TARGET_TCSETSF2        TARGET_IOW('T', 0x2D, struct termios2)
> -#define TARGET_TIOCGRS485      0x542E
> -#ifndef TARGET_TIOCSRS485
> -#define TARGET_TIOCSRS485      0x542F
> -#endif
> -/* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCGPTN        TARGET_IOR('T', 0x30, unsigned int)
> -/* Lock/unlock Pty */
> -#define TARGET_TIOCSPTLCK      TARGET_IOW('T', 0x31, int)
> -/* Safely open the slave */
> -#define TARGET_TIOCGPTPEER     TARGET_IO('T', 0x41)
> -/* Get primary device node of /dev/console */
> -#define TARGET_TIOCGDEV        TARGET_IOR('T', 0x32, unsigned int)
> -#define TARGET_TCGETX          0x5432 /* SYS5 TCGETX compatibility */
> -#define TARGET_TCSETX          0x5433
> -#define TARGET_TCSETXF         0x5434
> -#define TARGET_TCSETXW         0x5435
> -/* pty: generate signal */
> -#define TARGET_TIOCSIG         TARGET_IOW('T', 0x36, int)
> -#define TARGET_TIOCVHANGUP     0x5437
> -
> -#define TARGET_FIONCLEX        0x5450
> -#define TARGET_FIOCLEX         0x5451
> -#define TARGET_FIOASYNC        0x5452
> -#define TARGET_TIOCSERCONFIG   0x5453
> -#define TARGET_TIOCSERGWILD    0x5454
> -#define TARGET_TIOCSERSWILD    0x5455
> -#define TARGET_TIOCGLCKTRMIOS  0x5456
> -#define TARGET_TIOCSLCKTRMIOS  0x5457
> -#define TARGET_TIOCSERGSTRUCT  0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCMIWAIT      0x545C
> -/* read serial port inline interrupt counts */
> -#define TARGET_TIOCGICOUNT     0x545D
> -
> -/*
> - * Some arches already define TARGET_FIOQSIZE due to a historical
> - * conflict with a Hayes modem-specific ioctl value.
> - */
> -#ifndef TARGET_FIOQSIZE
> -#define TARGET_FIOQSIZE        0x5460
> -#endif
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA             0
> -#define TARGET_TIOCPKT_FLUSHREAD        1
> -#define TARGET_TIOCPKT_FLUSHWRITE       2
> -#define TARGET_TIOCPKT_STOP             4
> -#define TARGET_TIOCPKT_START            8
> -#define TARGET_TIOCPKT_NOSTOP          16
> -#define TARGET_TIOCPKT_DOSTOP          32
> -#define TARGET_TIOCPKT_IOCTL           64
> -
> -#define TARGET_TIOCSER_TEMT    0x01    /* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/riscv/termbits.h b/linux-user/riscv/termbits.h
> index 5e0af0dd3f..b1d4f4fedb 100644
> --- a/linux-user/riscv/termbits.h
> +++ b/linux-user/riscv/termbits.h
> @@ -1,227 +1 @@
> -/* from asm/termbits.h */
> -/* NOTE: exactly the same as i386 */
> -
> -#ifndef LINUX_USER_RISCV_TERMBITS_H
> -#define LINUX_USER_RISCV_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -struct target_termios {
> -    unsigned int c_iflag;               /* input mode flags */
> -    unsigned int c_oflag;               /* output mode flags */
> -    unsigned int c_cflag;               /* control mode flags */
> -    unsigned int c_lflag;               /* local mode flags */
> -    unsigned char c_line;               /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];    /* control characters */
> -};
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK  0000001
> -#define TARGET_BRKINT  0000002
> -#define TARGET_IGNPAR  0000004
> -#define TARGET_PARMRK  0000010
> -#define TARGET_INPCK   0000020
> -#define TARGET_ISTRIP  0000040
> -#define TARGET_INLCR   0000100
> -#define TARGET_IGNCR   0000200
> -#define TARGET_ICRNL   0000400
> -#define TARGET_IUCLC   0001000
> -#define TARGET_IXON    0002000
> -#define TARGET_IXANY   0004000
> -#define TARGET_IXOFF   0010000
> -#define TARGET_IMAXBEL 0020000
> -#define TARGET_IUTF8   0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST   0000001
> -#define TARGET_OLCUC   0000002
> -#define TARGET_ONLCR   0000004
> -#define TARGET_OCRNL   0000010
> -#define TARGET_ONOCR   0000020
> -#define TARGET_ONLRET  0000040
> -#define TARGET_OFILL   0000100
> -#define TARGET_OFDEL   0000200
> -#define TARGET_NLDLY   0000400
> -#define   TARGET_NL0   0000000
> -#define   TARGET_NL1   0000400
> -#define TARGET_CRDLY   0003000
> -#define   TARGET_CR0   0000000
> -#define   TARGET_CR1   0001000
> -#define   TARGET_CR2   0002000
> -#define   TARGET_CR3   0003000
> -#define TARGET_TABDLY  0014000
> -#define   TARGET_TAB0  0000000
> -#define   TARGET_TAB1  0004000
> -#define   TARGET_TAB2  0010000
> -#define   TARGET_TAB3  0014000
> -#define   TARGET_XTABS 0014000
> -#define TARGET_BSDLY   0020000
> -#define   TARGET_BS0   0000000
> -#define   TARGET_BS1   0020000
> -#define TARGET_VTDLY   0040000
> -#define   TARGET_VT0   0000000
> -#define   TARGET_VT1   0040000
> -#define TARGET_FFDLY   0100000
> -#define   TARGET_FF0   0000000
> -#define   TARGET_FF1   0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD   0010017
> -#define  TARGET_B0     0000000         /* hang up */
> -#define  TARGET_B50    0000001
> -#define  TARGET_B75    0000002
> -#define  TARGET_B110   0000003
> -#define  TARGET_B134   0000004
> -#define  TARGET_B150   0000005
> -#define  TARGET_B200   0000006
> -#define  TARGET_B300   0000007
> -#define  TARGET_B600   0000010
> -#define  TARGET_B1200  0000011
> -#define  TARGET_B1800  0000012
> -#define  TARGET_B2400  0000013
> -#define  TARGET_B4800  0000014
> -#define  TARGET_B9600  0000015
> -#define  TARGET_B19200 0000016
> -#define  TARGET_B38400 0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE   0000060
> -#define   TARGET_CS5   0000000
> -#define   TARGET_CS6   0000020
> -#define   TARGET_CS7   0000040
> -#define   TARGET_CS8   0000060
> -#define TARGET_CSTOPB  0000100
> -#define TARGET_CREAD   0000200
> -#define TARGET_PARENB  0000400
> -#define TARGET_PARODD  0001000
> -#define TARGET_HUPCL   0002000
> -#define TARGET_CLOCAL  0004000
> -#define TARGET_CBAUDEX 0010000
> -#define  TARGET_B57600  0010001
> -#define  TARGET_B115200 0010002
> -#define  TARGET_B230400 0010003
> -#define  TARGET_B460800 0010004
> -#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
> -#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000  /* flow control */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG    0000001
> -#define TARGET_ICANON  0000002
> -#define TARGET_XCASE   0000004
> -#define TARGET_ECHO    0000010
> -#define TARGET_ECHOE   0000020
> -#define TARGET_ECHOK   0000040
> -#define TARGET_ECHONL  0000100
> -#define TARGET_NOFLSH  0000200
> -#define TARGET_TOSTOP  0000400
> -#define TARGET_ECHOCTL 0001000
> -#define TARGET_ECHOPRT 0002000
> -#define TARGET_ECHOKE  0004000
> -#define TARGET_FLUSHO  0010000
> -#define TARGET_PENDIN  0040000
> -#define TARGET_IEXTEN  0100000
> -
> -/* c_cc character offsets */
> -#define TARGET_VINTR    0
> -#define TARGET_VQUIT    1
> -#define TARGET_VERASE   2
> -#define TARGET_VKILL    3
> -#define TARGET_VEOF     4
> -#define TARGET_VTIME    5
> -#define TARGET_VMIN     6
> -#define TARGET_VSWTC    7
> -#define TARGET_VSTART   8
> -#define TARGET_VSTOP    9
> -#define TARGET_VSUSP    10
> -#define TARGET_VEOL     11
> -#define TARGET_VREPRINT 12
> -#define TARGET_VDISCARD 13
> -#define TARGET_VWERASE  14
> -#define TARGET_VLNEXT   15
> -#define TARGET_VEOL2    16
> -
> -/* ioctls */
> -
> -#define TARGET_TCGETS           0x5401
> -#define TARGET_TCSETS           0x5402
> -#define TARGET_TCSETSW          0x5403
> -#define TARGET_TCSETSF          0x5404
> -#define TARGET_TCGETA           0x5405
> -#define TARGET_TCSETA           0x5406
> -#define TARGET_TCSETAW          0x5407
> -#define TARGET_TCSETAF          0x5408
> -#define TARGET_TCSBRK           0x5409
> -#define TARGET_TCXONC           0x540A
> -#define TARGET_TCFLSH           0x540B
> -
> -#define TARGET_TIOCEXCL         0x540C
> -#define TARGET_TIOCNXCL         0x540D
> -#define TARGET_TIOCSCTTY        0x540E
> -#define TARGET_TIOCGPGRP        0x540F
> -#define TARGET_TIOCSPGRP        0x5410
> -#define TARGET_TIOCOUTQ         0x5411
> -#define TARGET_TIOCSTI          0x5412
> -#define TARGET_TIOCGWINSZ       0x5413
> -#define TARGET_TIOCSWINSZ       0x5414
> -#define TARGET_TIOCMGET         0x5415
> -#define TARGET_TIOCMBIS         0x5416
> -#define TARGET_TIOCMBIC         0x5417
> -#define TARGET_TIOCMSET         0x5418
> -#define TARGET_TIOCGSOFTCAR     0x5419
> -#define TARGET_TIOCSSOFTCAR     0x541A
> -#define TARGET_FIONREAD         0x541B
> -#define TARGET_TIOCINQ          TARGET_FIONREAD
> -#define TARGET_TIOCLINUX        0x541C
> -#define TARGET_TIOCCONS         0x541D
> -#define TARGET_TIOCGSERIAL      0x541E
> -#define TARGET_TIOCSSERIAL      0x541F
> -#define TARGET_TIOCPKT          0x5420
> -#define TARGET_FIONBIO          0x5421
> -#define TARGET_TIOCNOTTY        0x5422
> -#define TARGET_TIOCSETD         0x5423
> -#define TARGET_TIOCGETD         0x5424
> -#define TARGET_TCSBRKP          0x5425 /* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCTTYGSTRUCT   0x5426 /* For debugging only */
> -#define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
> -#define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
> -#define TARGET_TIOCGSID         0x5429 /* Return the session ID of FD */
> -#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
> -        /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
> -        /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
> -        /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX          0x5451
> -#define TARGET_FIOASYNC         0x5452
> -#define TARGET_TIOCSERCONFIG    0x5453
> -#define TARGET_TIOCSERGWILD     0x5454
> -#define TARGET_TIOCSERSWILD     0x5455
> -#define TARGET_TIOCGLCKTRMIOS   0x5456
> -#define TARGET_TIOCSLCKTRMIOS   0x5457
> -#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR    0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI  0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI  0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT      0x545C
> -        /* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT     0x545D
> -        /* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA              0
> -#define TARGET_TIOCPKT_FLUSHREAD         1
> -#define TARGET_TIOCPKT_FLUSHWRITE        2
> -#define TARGET_TIOCPKT_STOP              4
> -#define TARGET_TIOCPKT_START             8
> -#define TARGET_TIOCPKT_NOSTOP           16
> -#define TARGET_TIOCPKT_DOSTOP           32
> -
> -#define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/s390x/termbits.h b/linux-user/s390x/termbits.h
> index 9affa8f41a..b1d4f4fedb 100644
> --- a/linux-user/s390x/termbits.h
> +++ b/linux-user/s390x/termbits.h
> @@ -1,288 +1 @@
> -/*
> - *  include/asm-s390/termbits.h
> - *
> - *  S390 version
> - *
> - *  Derived from "include/asm-i386/termbits.h"
> - */
> -
> -#ifndef LINUX_USER_S390X_TERMBITS_H
> -#define LINUX_USER_S390X_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -struct target_termios {
> -    unsigned int c_iflag;		/* input mode flags */
> -    unsigned int c_oflag;		/* output mode flags */
> -    unsigned int c_cflag;		/* control mode flags */
> -    unsigned int c_lflag;		/* local mode flags */
> -    unsigned char c_line;			/* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];		/* control characters */
> -};
> -
> -struct target_termios2 {
> -    unsigned int c_iflag;		/* input mode flags */
> -    unsigned int c_oflag;		/* output mode flags */
> -    unsigned int c_cflag;		/* control mode flags */
> -    unsigned int c_lflag;		/* local mode flags */
> -    unsigned char c_line;			/* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];		/* control characters */
> -    unsigned int c_ispeed;		/* input speed */
> -    unsigned int c_ospeed;		/* output speed */
> -};
> -
> -struct target_ktermios {
> -    unsigned int c_iflag;		/* input mode flags */
> -    unsigned int c_oflag;		/* output mode flags */
> -    unsigned int c_cflag;		/* control mode flags */
> -    unsigned int c_lflag;		/* local mode flags */
> -    unsigned char c_line;			/* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];		/* control characters */
> -    unsigned int c_ispeed;		/* input speed */
> -    unsigned int c_ospeed;		/* output speed */
> -};
> -
> -/* c_cc characters */
> -#define TARGET_VINTR 0
> -#define TARGET_VQUIT 1
> -#define TARGET_VERASE 2
> -#define TARGET_VKILL 3
> -#define TARGET_VEOF 4
> -#define TARGET_VTIME 5
> -#define TARGET_VMIN 6
> -#define TARGET_VSWTC 7
> -#define TARGET_VSTART 8
> -#define TARGET_VSTOP 9
> -#define TARGET_VSUSP 10
> -#define TARGET_VEOL 11
> -#define TARGET_VREPRINT 12
> -#define TARGET_VDISCARD 13
> -#define TARGET_VWERASE 14
> -#define TARGET_VLNEXT 15
> -#define TARGET_VEOL2 16
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK	0000001
> -#define TARGET_BRKINT	0000002
> -#define TARGET_IGNPAR	0000004
> -#define TARGET_PARMRK	0000010
> -#define TARGET_INPCK	0000020
> -#define TARGET_ISTRIP	0000040
> -#define TARGET_INLCR	0000100
> -#define TARGET_IGNCR	0000200
> -#define TARGET_ICRNL	0000400
> -#define TARGET_IUCLC	0001000
> -#define TARGET_IXON	0002000
> -#define TARGET_IXANY	0004000
> -#define TARGET_IXOFF	0010000
> -#define TARGET_IMAXBEL	0020000
> -#define TARGET_IUTF8	0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST	0000001
> -#define TARGET_OLCUC	0000002
> -#define TARGET_ONLCR	0000004
> -#define TARGET_OCRNL	0000010
> -#define TARGET_ONOCR	0000020
> -#define TARGET_ONLRET	0000040
> -#define TARGET_OFILL	0000100
> -#define TARGET_OFDEL	0000200
> -#define TARGET_NLDLY	0000400
> -#define TARGET_NL0	0000000
> -#define TARGET_NL1	0000400
> -#define TARGET_CRDLY	0003000
> -#define TARGET_CR0	0000000
> -#define TARGET_CR1	0001000
> -#define TARGET_CR2	0002000
> -#define TARGET_CR3	0003000
> -#define TARGET_TABDLY	0014000
> -#define TARGET_TAB0	0000000
> -#define TARGET_TAB1	0004000
> -#define TARGET_TAB2	0010000
> -#define TARGET_TAB3	0014000
> -#define TARGET_XTABS	0014000
> -#define TARGET_BSDLY	0020000
> -#define TARGET_BS0	0000000
> -#define TARGET_BS1	0020000
> -#define TARGET_VTDLY	0040000
> -#define TARGET_VT0	0000000
> -#define TARGET_VT1	0040000
> -#define TARGET_FFDLY	0100000
> -#define TARGET_FF0	0000000
> -#define TARGET_FF1	0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD	0010017
> -#define TARGET_B0	0000000		/* hang up */
> -#define TARGET_B50	0000001
> -#define TARGET_B75	0000002
> -#define TARGET_B110	0000003
> -#define TARGET_B134	0000004
> -#define TARGET_B150	0000005
> -#define TARGET_B200	0000006
> -#define TARGET_B300	0000007
> -#define TARGET_B600	0000010
> -#define TARGET_B1200	0000011
> -#define TARGET_B1800	0000012
> -#define TARGET_B2400	0000013
> -#define TARGET_B4800	0000014
> -#define TARGET_B9600	0000015
> -#define TARGET_B19200	0000016
> -#define TARGET_B38400	0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE	0000060
> -#define TARGET_CS5	0000000
> -#define TARGET_CS6	0000020
> -#define TARGET_CS7	0000040
> -#define TARGET_CS8	0000060
> -#define TARGET_CSTOPB	0000100
> -#define TARGET_CREAD	0000200
> -#define TARGET_PARENB	0000400
> -#define TARGET_PARODD	0001000
> -#define TARGET_HUPCL	0002000
> -#define TARGET_CLOCAL	0004000
> -#define TARGET_CBAUDEX 0010000
> -#define TARGET_BOTHER  0010000
> -#define TARGET_B57600  0010001
> -#define TARGET_B115200 0010002
> -#define TARGET_B230400 0010003
> -#define TARGET_B460800 0010004
> -#define TARGET_B500000 0010005
> -#define TARGET_B576000 0010006
> -#define TARGET_B921600 0010007
> -#define TARGET_B1000000 0010010
> -#define TARGET_B1152000 0010011
> -#define TARGET_B1500000 0010012
> -#define TARGET_B2000000 0010013
> -#define TARGET_B2500000 0010014
> -#define TARGET_B3000000 0010015
> -#define TARGET_B3500000 0010016
> -#define TARGET_B4000000 0010017
> -#define TARGET_CIBAUD	  002003600000	/* input baud rate */
> -#define TARGET_CMSPAR	  010000000000		/* mark or space (stick) parity */
> -#define TARGET_CRTSCTS	  020000000000		/* flow control */
> -
> -#define TARGET_IBSHIFT	  16		/* Shift from CBAUD to CIBAUD */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG	0000001
> -#define TARGET_ICANON	0000002
> -#define TARGET_XCASE	0000004
> -#define TARGET_ECHO	0000010
> -#define TARGET_ECHOE	0000020
> -#define TARGET_ECHOK	0000040
> -#define TARGET_ECHONL	0000100
> -#define TARGET_NOFLSH	0000200
> -#define TARGET_TOSTOP	0000400
> -#define TARGET_ECHOCTL	0001000
> -#define TARGET_ECHOPRT	0002000
> -#define TARGET_ECHOKE	0004000
> -#define TARGET_FLUSHO	0010000
> -#define TARGET_PENDIN	0040000
> -#define TARGET_IEXTEN	0100000
> -
> -/* tcflow() and TCXONC use these */
> -#define	TARGET_TCOOFF		0
> -#define	TARGET_TCOON		1
> -#define	TARGET_TCIOFF		2
> -#define	TARGET_TCION		3
> -
> -/* tcflush() and TCFLSH use these */
> -#define	TARGET_TCIFLUSH	0
> -#define	TARGET_TCOFLUSH	1
> -#define	TARGET_TCIOFLUSH	2
> -
> -/* tcsetattr uses these */
> -#define	TARGET_TCSANOW		0
> -#define	TARGET_TCSADRAIN	1
> -#define	TARGET_TCSAFLUSH	2
> -
> -/*
> - *  include/asm-s390/ioctls.h
> - *
> - *  S390 version
> - *
> - *  Derived from "include/asm-i386/ioctls.h"
> - */
> -
> -/* 0x54 is just a magic number to make these relatively unique ('T') */
> -
> -#define TARGET_TCGETS		0x5401
> -#define TARGET_TCSETS		0x5402
> -#define TARGET_TCSETSW		0x5403
> -#define TARGET_TCSETSF		0x5404
> -#define TARGET_TCGETA		0x5405
> -#define TARGET_TCSETA		0x5406
> -#define TARGET_TCSETAW		0x5407
> -#define TARGET_TCSETAF		0x5408
> -#define TARGET_TCSBRK		0x5409
> -#define TARGET_TCXONC		0x540A
> -#define TARGET_TCFLSH		0x540B
> -#define TARGET_TIOCEXCL	0x540C
> -#define TARGET_TIOCNXCL	0x540D
> -#define TARGET_TIOCSCTTY	0x540E
> -#define TARGET_TIOCGPGRP	0x540F
> -#define TARGET_TIOCSPGRP	0x5410
> -#define TARGET_TIOCOUTQ	0x5411
> -#define TARGET_TIOCSTI		0x5412
> -#define TARGET_TIOCGWINSZ	0x5413
> -#define TARGET_TIOCSWINSZ	0x5414
> -#define TARGET_TIOCMGET	0x5415
> -#define TARGET_TIOCMBIS	0x5416
> -#define TARGET_TIOCMBIC	0x5417
> -#define TARGET_TIOCMSET	0x5418
> -#define TARGET_TIOCGSOFTCAR	0x5419
> -#define TARGET_TIOCSSOFTCAR	0x541A
> -#define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		FIONREAD
> -#define TARGET_TIOCLINUX	0x541C
> -#define TARGET_TIOCCONS	0x541D
> -#define TARGET_TIOCGSERIAL	0x541E
> -#define TARGET_TIOCSSERIAL	0x541F
> -#define TARGET_TIOCPKT		0x5420
> -#define TARGET_FIONBIO		0x5421
> -#define TARGET_TIOCNOTTY	0x5422
> -#define TARGET_TIOCSETD	0x5423
> -#define TARGET_TIOCGETD	0x5424
> -#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TCGETS2		_IOR('T',0x2A, struct termios2)
> -#define TARGET_TCSETS2		_IOW('T',0x2B, struct termios2)
> -#define TARGET_TCSETSW2	_IOW('T',0x2C, struct termios2)
> -#define TARGET_TCSETSF2	_IOW('T',0x2D, struct termios2)
> -#define TARGET_TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX		0x5451
> -#define TARGET_FIOASYNC	0x5452
> -#define TARGET_TIOCSERCONFIG	0x5453
> -#define TARGET_TIOCSERGWILD	0x5454
> -#define TARGET_TIOCSERSWILD	0x5455
> -#define TARGET_TIOCGLCKTRMIOS	0x5456
> -#define TARGET_TIOCSLCKTRMIOS	0x5457
> -#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> -#define TARGET_FIOQSIZE	0x545E
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA		 0
> -#define TARGET_TIOCPKT_FLUSHREAD	 1
> -#define TARGET_TIOCPKT_FLUSHWRITE	 2
> -#define TARGET_TIOCPKT_STOP		 4
> -#define TARGET_TIOCPKT_START		 8
> -#define TARGET_TIOCPKT_NOSTOP		16
> -#define TARGET_TIOCPKT_DOSTOP		32
> -
> -#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/tilegx/termbits.h b/linux-user/tilegx/termbits.h
> index 966daec088..b1d4f4fedb 100644
> --- a/linux-user/tilegx/termbits.h
> +++ b/linux-user/tilegx/termbits.h
> @@ -1,275 +1 @@
> -#ifndef TILEGX_TERMBITS_H
> -#define TILEGX_TERMBITS_H
> -
> -/* From asm-generic/termbits.h, which is used by tilegx */
> -
> -#define TARGET_NCCS 19
> -struct target_termios {
> -    unsigned int c_iflag;             /* input mode flags */
> -    unsigned int c_oflag;             /* output mode flags */
> -    unsigned int c_cflag;             /* control mode flags */
> -    unsigned int c_lflag;             /* local mode flags */
> -    unsigned char c_line;             /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];  /* control characters */
> -};
> -
> -struct target_termios2 {
> -    unsigned int c_iflag;             /* input mode flags */
> -    unsigned int c_oflag;             /* output mode flags */
> -    unsigned int c_cflag;             /* control mode flags */
> -    unsigned int c_lflag;             /* local mode flags */
> -    unsigned char c_line;             /* line discipline */
> -    unsigned char c_cc[TARGET_NCCS];  /* control characters */
> -    unsigned int c_ispeed;            /* input speed */
> -    unsigned int c_ospeed;            /* output speed */
> -};
> -
> -/* c_cc characters */
> -#define TARGET_VINTR     0
> -#define TARGET_VQUIT     1
> -#define TARGET_VERASE    2
> -#define TARGET_VKILL     3
> -#define TARGET_VEOF      4
> -#define TARGET_VTIME     5
> -#define TARGET_VMIN      6
> -#define TARGET_VSWTC     7
> -#define TARGET_VSTART    8
> -#define TARGET_VSTOP     9
> -#define TARGET_VSUSP     10
> -#define TARGET_VEOL      11
> -#define TARGET_VREPRINT  12
> -#define TARGET_VDISCARD  13
> -#define TARGET_VWERASE   14
> -#define TARGET_VLNEXT    15
> -#define TARGET_VEOL2     16
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK    0000001
> -#define TARGET_BRKINT    0000002
> -#define TARGET_IGNPAR    0000004
> -#define TARGET_PARMRK    0000010
> -#define TARGET_INPCK     0000020
> -#define TARGET_ISTRIP    0000040
> -#define TARGET_INLCR     0000100
> -#define TARGET_IGNCR     0000200
> -#define TARGET_ICRNL     0000400
> -#define TARGET_IUCLC     0001000
> -#define TARGET_IXON      0002000
> -#define TARGET_IXANY     0004000
> -#define TARGET_IXOFF     0010000
> -#define TARGET_IMAXBEL   0020000
> -#define TARGET_IUTF8     0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST     0000001
> -#define TARGET_OLCUC     0000002
> -#define TARGET_ONLCR     0000004
> -#define TARGET_OCRNL     0000010
> -#define TARGET_ONOCR     0000020
> -#define TARGET_ONLRET    0000040
> -#define TARGET_OFILL     0000100
> -#define TARGET_OFDEL     0000200
> -#define TARGET_NLDLY     0000400
> -#define   TARGET_NL0     0000000
> -#define   TARGET_NL1     0000400
> -#define TARGET_CRDLY     0003000
> -#define   TARGET_CR0     0000000
> -#define   TARGET_CR1     0001000
> -#define   TARGET_CR2     0002000
> -#define   TARGET_CR3     0003000
> -#define TARGET_TABDLY    0014000
> -#define   TARGET_TAB0    0000000
> -#define   TARGET_TAB1    0004000
> -#define   TARGET_TAB2    0010000
> -#define   TARGET_TAB3    0014000
> -#define   TARGET_XTABS   0014000
> -#define TARGET_BSDLY     0020000
> -#define   TARGET_BS0     0000000
> -#define   TARGET_BS1     0020000
> -#define TARGET_VTDLY     0040000
> -#define   TARGET_VT0     0000000
> -#define   TARGET_VT1     0040000
> -#define TARGET_FFDLY     0100000
> -#define   TARGET_FF0     0000000
> -#define   TARGET_FF1     0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD     0010017
> -#define  TARGET_B0       0000000        /* hang up */
> -#define  TARGET_B50      0000001
> -#define  TARGET_B75      0000002
> -#define  TARGET_B110     0000003
> -#define  TARGET_B134     0000004
> -#define  TARGET_B150     0000005
> -#define  TARGET_B200     0000006
> -#define  TARGET_B300     0000007
> -#define  TARGET_B600     0000010
> -#define  TARGET_B1200    0000011
> -#define  TARGET_B1800    0000012
> -#define  TARGET_B2400    0000013
> -#define  TARGET_B4800    0000014
> -#define  TARGET_B9600    0000015
> -#define  TARGET_B19200   0000016
> -#define  TARGET_B38400   0000017
> -#define TARGET_EXTA      TARGET_B19200
> -#define TARGET_EXTB      TARGET_B38400
> -#define TARGET_CSIZE     0000060
> -#define   TARGET_CS5     0000000
> -#define   TARGET_CS6     0000020
> -#define   TARGET_CS7     0000040
> -#define   TARGET_CS8     0000060
> -#define TARGET_CSTOPB    0000100
> -#define TARGET_CREAD     0000200
> -#define TARGET_PARENB    0000400
> -#define TARGET_PARODD    0001000
> -#define TARGET_HUPCL     0002000
> -#define TARGET_CLOCAL    0004000
> -#define TARGET_CBAUDEX   0010000
> -#define    TARGET_BOTHER 0010000
> -#define    TARGET_B57600 0010001
> -#define   TARGET_B115200 0010002
> -#define   TARGET_B230400 0010003
> -#define   TARGET_B460800 0010004
> -#define   TARGET_B500000 0010005
> -#define   TARGET_B576000 0010006
> -#define   TARGET_B921600 0010007
> -#define  TARGET_B1000000 0010010
> -#define  TARGET_B1152000 0010011
> -#define  TARGET_B1500000 0010012
> -#define  TARGET_B2000000 0010013
> -#define  TARGET_B2500000 0010014
> -#define  TARGET_B3000000 0010015
> -#define  TARGET_B3500000 0010016
> -#define  TARGET_B4000000 0010017
> -#define TARGET_CIBAUD    002003600000    /* input baud rate */
> -#define TARGET_CMSPAR    010000000000    /* mark or space (stick) parity */
> -#define TARGET_CRTSCTS   020000000000    /* flow control */
> -
> -#define TARGET_IBSHIFT   16        /* Shift from CBAUD to CIBAUD */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG      0000001
> -#define TARGET_ICANON    0000002
> -#define TARGET_XCASE     0000004
> -#define TARGET_ECHO      0000010
> -#define TARGET_ECHOE     0000020
> -#define TARGET_ECHOK     0000040
> -#define TARGET_ECHONL    0000100
> -#define TARGET_NOFLSH    0000200
> -#define TARGET_TOSTOP    0000400
> -#define TARGET_ECHOCTL   0001000
> -#define TARGET_ECHOPRT   0002000
> -#define TARGET_ECHOKE    0004000
> -#define TARGET_FLUSHO    0010000
> -#define TARGET_PENDIN    0040000
> -#define TARGET_IEXTEN    0100000
> -#define TARGET_EXTPROC   0200000
> -
> -/* tcflow() and TCXONC use these */
> -#define TARGET_TCOOFF    0
> -#define TARGET_TCOON     1
> -#define TARGET_TCIOFF    2
> -#define TARGET_TCION     3
> -
> -/* tcflush() and TCFLSH use these */
> -#define TARGET_TCIFLUSH  0
> -#define TARGET_TCOFLUSH  1
> -#define TARGET_TCIOFLUSH 2
> -
> -/* tcsetattr uses these */
> -#define TARGET_TCSANOW   0
> -#define TARGET_TCSADRAIN 1
> -#define TARGET_TCSAFLUSH 2
> -
> -/* From asm-generic/ioctls.h, which is used by tilegx */
> -
> -#define TARGET_TCGETS                   0x5401
> -#define TARGET_TCSETS                   0x5402
> -#define TARGET_TCSETSW                  0x5403
> -#define TARGET_TCSETSF                  0x5404
> -#define TARGET_TCGETA                   0x5405
> -#define TARGET_TCSETA                   0x5406
> -#define TARGET_TCSETAW                  0x5407
> -#define TARGET_TCSETAF                  0x5408
> -#define TARGET_TCSBRK                   0x5409
> -#define TARGET_TCXONC                   0x540A
> -#define TARGET_TCFLSH                   0x540B
> -#define TARGET_TIOCEXCL                 0x540C
> -#define TARGET_TIOCNXCL                 0x540D
> -#define TARGET_TIOCSCTTY                0x540E
> -#define TARGET_TIOCGPGRP                0x540F
> -#define TARGET_TIOCSPGRP                0x5410
> -#define TARGET_TIOCOUTQ                 0x5411
> -#define TARGET_TIOCSTI                  0x5412
> -#define TARGET_TIOCGWINSZ               0x5413
> -#define TARGET_TIOCSWINSZ               0x5414
> -#define TARGET_TIOCMGET                 0x5415
> -#define TARGET_TIOCMBIS                 0x5416
> -#define TARGET_TIOCMBIC                 0x5417
> -#define TARGET_TIOCMSET                 0x5418
> -#define TARGET_TIOCGSOFTCAR             0x5419
> -#define TARGET_TIOCSSOFTCAR             0x541A
> -#define TARGET_FIONREAD                 0x541B
> -#define TARGET_TIOCINQ                  TARGET_FIONREAD
> -#define TARGET_TIOCLINUX                0x541C
> -#define TARGET_TIOCCONS                 0x541D
> -#define TARGET_TIOCGSERIAL              0x541E
> -#define TARGET_TIOCSSERIAL              0x541F
> -#define TARGET_TIOCPKT                  0x5420
> -#define TARGET_FIONBIO                  0x5421
> -#define TARGET_TIOCNOTTY                0x5422
> -#define TARGET_TIOCSETD                 0x5423
> -#define TARGET_TIOCGETD                 0x5424
> -#define TARGET_TCSBRKP                  0x5425
> -#define TARGET_TIOCSBRK                 0x5427
> -#define TARGET_TIOCCBRK                 0x5428
> -#define TARGET_TIOCGSID                 0x5429
> -#define TARGET_TCGETS2                  TARGET_IOR('T', 0x2A, struct termios2)
> -#define TARGET_TCSETS2                  TARGET_IOW('T', 0x2B, struct termios2)
> -#define TARGET_TCSETSW2                 TARGET_IOW('T', 0x2C, struct termios2)
> -#define TARGET_TCSETSF2                 TARGET_IOW('T', 0x2D, struct termios2)
> -#define TARGET_TIOCGRS485               0x542E
> -#define TARGET_TIOCSRS485               0x542F
> -#define TARGET_TIOCGPTN                 TARGET_IOR('T', 0x30, unsigned int)
> -#define TARGET_TIOCSPTLCK               TARGET_IOW('T', 0x31, int)
> -#define TARGET_TIOCGDEV                 TARGET_IOR('T', 0x32, unsigned int)
> -#define TARGET_TCGETX                   0x5432
> -#define TARGET_TCSETX                   0x5433
> -#define TARGET_TCSETXF                  0x5434
> -#define TARGET_TCSETXW                  0x5435
> -#define TARGET_TIOCSIG                  TARGET_IOW('T', 0x36, int)
> -#define TARGET_TIOCVHANGUP              0x5437
> -#define TARGET_TIOCGPKT                 TARGET_IOR('T', 0x38, int)
> -#define TARGET_TIOCGPTLCK               TARGET_IOR('T', 0x39, int)
> -#define TARGET_TIOCGEXCL                TARGET_IOR('T', 0x40, int)
> -#define TARGET_TIOCGPTPEER              TARGET_IO('T', 0x41)
> -
> -#define TARGET_FIONCLEX                 0x5450
> -#define TARGET_FIOCLEX                  0x5451
> -#define TARGET_FIOASYNC                 0x5452
> -#define TARGET_TIOCSERCONFIG            0x5453
> -#define TARGET_TIOCSERGWILD             0x5454
> -#define TARGET_TIOCSERSWILD             0x5455
> -#define TARGET_TIOCGLCKTRMIOS           0x5456
> -#define TARGET_TIOCSLCKTRMIOS           0x5457
> -#define TARGET_TIOCSERGSTRUCT           0x5458
> -#define TARGET_TIOCSERGETLSR            0x5459
> -#define TARGET_TIOCSERGETMULTI          0x545A
> -#define TARGET_TIOCSERSETMULTI          0x545B
> -
> -#define TARGET_TIOCMIWAIT               0x545C
> -#define TARGET_TIOCGICOUNT              0x545D
> -#define TARGET_FIOQSIZE                 0x5460
> -
> -#define TARGET_TIOCPKT_DATA             0
> -#define TARGET_TIOCPKT_FLUSHREAD        1
> -#define TARGET_TIOCPKT_FLUSHWRITE       2
> -#define TARGET_TIOCPKT_STOP             4
> -#define TARGET_TIOCPKT_START            8
> -#define TARGET_TIOCPKT_NOSTOP           16
> -#define TARGET_TIOCPKT_DOSTOP           32
> -#define TARGET_TIOCPKT_IOCTL            64
> -
> -#define TARGET_TIOCSER_TEMT             0x01
> -
> -#endif
> +#include "../generic/termbits.h"
> diff --git a/linux-user/x86_64/termbits.h b/linux-user/x86_64/termbits.h
> index c8bb5996b1..b1d4f4fedb 100644
> --- a/linux-user/x86_64/termbits.h
> +++ b/linux-user/x86_64/termbits.h
> @@ -1,253 +1 @@
> -#ifndef LINUX_USER_X86_64_TERMBITS_H
> -#define LINUX_USER_X86_64_TERMBITS_H
> -
> -#define TARGET_NCCS 19
> -
> -typedef unsigned char	target_cc_t;
> -typedef unsigned int	target_speed_t;
> -typedef unsigned int	target_tcflag_t;
> -struct target_termios {
> -	target_tcflag_t c_iflag;		/* input mode flags */
> -	target_tcflag_t c_oflag;		/* output mode flags */
> -	target_tcflag_t c_cflag;		/* control mode flags */
> -	target_tcflag_t c_lflag;		/* local mode flags */
> -	target_cc_t c_line;			/* line discipline */
> -	target_cc_t c_cc[TARGET_NCCS];		/* control characters */
> -};
> -
> -/* c_cc characters */
> -#define TARGET_VINTR 0
> -#define TARGET_VQUIT 1
> -#define TARGET_VERASE 2
> -#define TARGET_VKILL 3
> -#define TARGET_VEOF 4
> -#define TARGET_VTIME 5
> -#define TARGET_VMIN 6
> -#define TARGET_VSWTC 7
> -#define TARGET_VSTART 8
> -#define TARGET_VSTOP 9
> -#define TARGET_VSUSP 10
> -#define TARGET_VEOL 11
> -#define TARGET_VREPRINT 12
> -#define TARGET_VDISCARD 13
> -#define TARGET_VWERASE 14
> -#define TARGET_VLNEXT 15
> -#define TARGET_VEOL2 16
> -
> -/* c_iflag bits */
> -#define TARGET_IGNBRK	0000001
> -#define TARGET_BRKINT	0000002
> -#define TARGET_IGNPAR	0000004
> -#define TARGET_PARMRK	0000010
> -#define TARGET_INPCK	0000020
> -#define TARGET_ISTRIP	0000040
> -#define TARGET_INLCR	0000100
> -#define TARGET_IGNCR	0000200
> -#define TARGET_ICRNL	0000400
> -#define TARGET_IUCLC	0001000
> -#define TARGET_IXON	0002000
> -#define TARGET_IXANY	0004000
> -#define TARGET_IXOFF	0010000
> -#define TARGET_IMAXBEL	0020000
> -#define TARGET_IUTF8	0040000
> -
> -/* c_oflag bits */
> -#define TARGET_OPOST	0000001
> -#define TARGET_OLCUC	0000002
> -#define TARGET_ONLCR	0000004
> -#define TARGET_OCRNL	0000010
> -#define TARGET_ONOCR	0000020
> -#define TARGET_ONLRET	0000040
> -#define TARGET_OFILL	0000100
> -#define TARGET_OFDEL	0000200
> -#define TARGET_NLDLY	0000400
> -#define   TARGET_NL0	0000000
> -#define   TARGET_NL1	0000400
> -#define TARGET_CRDLY	0003000
> -#define   TARGET_CR0	0000000
> -#define   TARGET_CR1	0001000
> -#define   TARGET_CR2	0002000
> -#define   TARGET_CR3	0003000
> -#define TARGET_TABDLY	0014000
> -#define   TARGET_TAB0	0000000
> -#define   TARGET_TAB1	0004000
> -#define   TARGET_TAB2	0010000
> -#define   TARGET_TAB3	0014000
> -#define   TARGET_XTABS	0014000
> -#define TARGET_BSDLY	0020000
> -#define   TARGET_BS0	0000000
> -#define   TARGET_BS1	0020000
> -#define TARGET_VTDLY	0040000
> -#define   TARGET_VT0	0000000
> -#define   TARGET_VT1	0040000
> -#define TARGET_FFDLY	0100000
> -#define   TARGET_FF0	0000000
> -#define   TARGET_FF1	0100000
> -
> -/* c_cflag bit meaning */
> -#define TARGET_CBAUD	0010017
> -#define  TARGET_B0	0000000		/* hang up */
> -#define  TARGET_B50	0000001
> -#define  TARGET_B75	0000002
> -#define  TARGET_B110	0000003
> -#define  TARGET_B134	0000004
> -#define  TARGET_B150	0000005
> -#define  TARGET_B200	0000006
> -#define  TARGET_B300	0000007
> -#define  TARGET_B600	0000010
> -#define  TARGET_B1200	0000011
> -#define  TARGET_B1800	0000012
> -#define  TARGET_B2400	0000013
> -#define  TARGET_B4800	0000014
> -#define  TARGET_B9600	0000015
> -#define  TARGET_B19200	0000016
> -#define  TARGET_B38400	0000017
> -#define TARGET_EXTA B19200
> -#define TARGET_EXTB B38400
> -#define TARGET_CSIZE	0000060
> -#define   TARGET_CS5	0000000
> -#define   TARGET_CS6	0000020
> -#define   TARGET_CS7	0000040
> -#define   TARGET_CS8	0000060
> -#define TARGET_CSTOPB	0000100
> -#define TARGET_CREAD	0000200
> -#define TARGET_PARENB	0000400
> -#define TARGET_PARODD	0001000
> -#define TARGET_HUPCL	0002000
> -#define TARGET_CLOCAL	0004000
> -#define TARGET_CBAUDEX 0010000
> -#define	   TARGET_BOTHER 0010000		/* non standard rate */
> -#define    TARGET_B57600 0010001
> -#define   TARGET_B115200 0010002
> -#define   TARGET_B230400 0010003
> -#define   TARGET_B460800 0010004
> -#define   TARGET_B500000 0010005
> -#define   TARGET_B576000 0010006
> -#define   TARGET_B921600 0010007
> -#define  TARGET_B1000000 0010010
> -#define  TARGET_B1152000 0010011
> -#define  TARGET_B1500000 0010012
> -#define  TARGET_B2000000 0010013
> -#define  TARGET_B2500000 0010014
> -#define  TARGET_B3000000 0010015
> -#define  TARGET_B3500000 0010016
> -#define  TARGET_B4000000 0010017
> -#define TARGET_CIBAUD	  002003600000	/* input baud rate */
> -#define TARGET_CMSPAR	  010000000000		/* mark or space (stick) parity */
> -#define TARGET_CRTSCTS	  020000000000		/* flow control */
> -
> -#define TARGET_IBSHIFT	  8		/* Shift from CBAUD to CIBAUD */
> -
> -/* c_lflag bits */
> -#define TARGET_ISIG	0000001
> -#define TARGET_ICANON	0000002
> -#define TARGET_XCASE	0000004
> -#define TARGET_ECHO	0000010
> -#define TARGET_ECHOE	0000020
> -#define TARGET_ECHOK	0000040
> -#define TARGET_ECHONL	0000100
> -#define TARGET_NOFLSH	0000200
> -#define TARGET_TOSTOP	0000400
> -#define TARGET_ECHOCTL	0001000
> -#define TARGET_ECHOPRT	0002000
> -#define TARGET_ECHOKE	0004000
> -#define TARGET_FLUSHO	0010000
> -#define TARGET_PENDIN	0040000
> -#define TARGET_IEXTEN	0100000
> -
> -/* tcflow() and TCXONC use these */
> -#define	TARGET_TCOOFF		0
> -#define	TARGET_TCOON		1
> -#define	TARGET_TCIOFF		2
> -#define	TARGET_TCION		3
> -
> -/* tcflush() and TCFLSH use these */
> -#define	TARGET_TCIFLUSH	0
> -#define	TARGET_TCOFLUSH	1
> -#define	TARGET_TCIOFLUSH	2
> -
> -/* tcsetattr uses these */
> -#define	TARGET_TCSANOW		0
> -#define	TARGET_TCSADRAIN	1
> -#define	TARGET_TCSAFLUSH	2
> -
> -#define TARGET_TCGETS		0x5401
> -#define TARGET_TCSETS		0x5402
> -#define TARGET_TCSETSW		0x5403
> -#define TARGET_TCSETSF		0x5404
> -#define TARGET_TCGETA		0x5405
> -#define TARGET_TCSETA		0x5406
> -#define TARGET_TCSETAW		0x5407
> -#define TARGET_TCSETAF		0x5408
> -#define TARGET_TCSBRK		0x5409
> -#define TARGET_TCXONC		0x540A
> -#define TARGET_TCFLSH		0x540B
> -#define TARGET_TIOCEXCL	0x540C
> -#define TARGET_TIOCNXCL	0x540D
> -#define TARGET_TIOCSCTTY	0x540E
> -#define TARGET_TIOCGPGRP	0x540F
> -#define TARGET_TIOCSPGRP	0x5410
> -#define TARGET_TIOCOUTQ	0x5411
> -#define TARGET_TIOCSTI		0x5412
> -#define TARGET_TIOCGWINSZ	0x5413
> -#define TARGET_TIOCSWINSZ	0x5414
> -#define TARGET_TIOCMGET	0x5415
> -#define TARGET_TIOCMBIS	0x5416
> -#define TARGET_TIOCMBIC	0x5417
> -#define TARGET_TIOCMSET	0x5418
> -#define TARGET_TIOCGSOFTCAR	0x5419
> -#define TARGET_TIOCSSOFTCAR	0x541A
> -#define TARGET_FIONREAD	0x541B
> -#define TARGET_TIOCINQ		FIONREAD
> -#define TARGET_TIOCLINUX	0x541C
> -#define TARGET_TIOCCONS	0x541D
> -#define TARGET_TIOCGSERIAL	0x541E
> -#define TARGET_TIOCSSERIAL	0x541F
> -#define TARGET_TIOCPKT		0x5420
> -#define TARGET_FIONBIO		0x5421
> -#define TARGET_TIOCNOTTY	0x5422
> -#define TARGET_TIOCSETD	0x5423
> -#define TARGET_TIOCGETD	0x5424
> -#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
> -#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
> -#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
> -#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
> -#define TARGET_TCGETS2          TARGET_IOR('T',0x2A, struct termios2)
> -#define TARGET_TCSETS2          TARGET_IOW('T',0x2B, struct termios2)
> -#define TARGET_TCSETSW2         TARGET_IOW('T',0x2C, struct termios2)
> -#define TARGET_TCSETSF2         TARGET_IOW('T',0x2D, struct termios2)
> -#define TARGET_TIOCGPTN         TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
> -#define TARGET_TIOCSPTLCK       TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
> -#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
> -
> -#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
> -#define TARGET_FIOCLEX		0x5451
> -#define TARGET_FIOASYNC	0x5452
> -#define TARGET_TIOCSERCONFIG	0x5453
> -#define TARGET_TIOCSERGWILD	0x5454
> -#define TARGET_TIOCSERSWILD	0x5455
> -#define TARGET_TIOCGLCKTRMIOS	0x5456
> -#define TARGET_TIOCSLCKTRMIOS	0x5457
> -#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
> -#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
> -#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
> -#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
> -
> -#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
> -#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
> -#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
> -#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
> -#define TARGET_FIOQSIZE       0x5460
> -
> -/* Used for packet mode */
> -#define TARGET_TIOCPKT_DATA		 0
> -#define TARGET_TIOCPKT_FLUSHREAD	 1
> -#define TARGET_TIOCPKT_FLUSHWRITE	 2
> -#define TARGET_TIOCPKT_STOP		 4
> -#define TARGET_TIOCPKT_START		 8
> -#define TARGET_TIOCPKT_NOSTOP		16
> -#define TARGET_TIOCPKT_DOSTOP		32
> -
> -#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
> -
> -#endif
> +#include "../generic/termbits.h"
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

