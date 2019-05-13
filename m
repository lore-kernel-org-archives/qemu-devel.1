Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2E2C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72001208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72001208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9b3-0003gX-JO
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:58:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ9XD-0000l5-Bi
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hQ9Pw-0003gq-8z
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:46:53 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hQ9Pv-0003gI-VI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:46:52 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MPp0l-1h4LIq2Lw3-00Mv6J; Mon, 13 May 2019 13:46:15 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1556905846-14074-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556905846-14074-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8acf2e45-f2c4-36aa-7064-d23aa3f1bca2@vivier.eu>
Date: Mon, 13 May 2019 13:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1556905846-14074-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:R279r3hxeBq9BzeqznatG1S6W1kc2XsOsiWlbNDMakhoU3pUTMS
	alC1lNgqANNf0uXsQ9TYg0ctWj28uIbNospsiduRPQkOibEqSfO9Zupu1Exa24zAjfmRrlD
	EMRnIK69JtHZkyxqtyo60hAbGhoauLGrkRNSN6T3CdLVqdJqcq9udWgCgkgFg2t/bLY8dmm
	5v680ktFwcKWfEAmjnAFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SAOMlRHzpTc=:uTkiH4IluFIK3eH1O3H5Tv
	t2vTYzBh4z7Vihj4oQ4PwqMYJREdvTbbOcyjMv4u6dEda0vL2UHfqUgaXwzjaEU5a9pm3TGpS
	NJPQCizjZ0YhpneYQKCYecaClYYjRM5zUsI+mLnDds7HET2YLYjDCb/tw9Cm1FG3vUMczuy+P
	aa71rxohufiV38gqt8BDlCMpvp9FD+rgTMlXUeM2iFxM0Mim8IUfv3q28IaIDWILIze2SeHjR
	LwDEryFby2C9192buoa0Bp3hbLgxeLIKKxE4CvFr35OifQ6G28seSaz7z5S4TYubpZgXMZXaq
	5J6cjqe4T3a0yAvZRKetqo22WaNz2vxczDGy408vitYRymFXY9RjtfFmdZ9dWU1NoWqIyUYRL
	qIFiSJpPPGt4N+GA2HqoT2rhgya44U92mT7+i4OSo2Y6JnoaTJyvUspWKR1T+0Uzo4c2HZwfD
	youV9324KOdtSjMjddbD6A4YEwAkMh4ujm4Mv2uR6BN7DM5pjrxtFRvspZmcUr+KwWO49Rzzc
	mU2UCw08QFs0fjHHEEQvCEXdmUurzGXl2h91CfiumAs8Qyqt0IH9Nb5b50xEcKDnJaO2Re3Pg
	00rWSjLzKeYUlbpV3pYlJJqEOKcuPSRN389YNleSNczM5UgG49x+RXvolY6HhLMMUcC6+C9Bd
	7MME3GggYJ5/CbrK5GdLgAZM9qP36SqIGe+TF7bDIt85q/RZjdN7+c/Z6yyHZ2Bt3dPaHTUJY
	7wxrLHeYzN/hWIE7fF+o47x33CJB0PzI79jZPxQXl7PpG07XdJO5+ENCJrc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [PATCH v4 3/5] linux-user: Add support the
 SIOC<G|S>IFPFLAGS ioctls for all targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, thuth@redhat.com, daniel.santos@pobox.com,
	arikalo@wavecomp.com, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
	nchen@wavecomp.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/2019 19:50, Aleksandar Markovic wrote:
> From: Neng Chen <nchen@wavecomp.com>
> 
> Add support for getting and setting extended private flags of a
> network device via SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls.
> 
> The ioctl numeric values are platform-independent and determined by
> the file include/uapi/linux/sockios.h in Linux kernel source code:
> 
>    #define SIOCSIFPFLAGS 0x8934
>    #define SIOCGIFPFLAGS	0x8935
> 
> These ioctls get (or set) the field ifr_flags of type short in the
> structure ifreq. Such functionality is achieved in QEMU by using
> MK_STRUCT() and MK_PTR() macros with an appropriate argument, as
> it was done for existing similar cases.
> 
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-Id: <1554839486-3527-1-git-send-email-aleksandar.markovic@rt-rk.com>
> ---
>   linux-user/ioctls.h       | 2 ++
>   linux-user/syscall_defs.h | 2 ++
>   2 files changed, 4 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



