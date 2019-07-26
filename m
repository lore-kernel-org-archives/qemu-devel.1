Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C36DC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D0421734
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D0421734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr3qa-0004pM-NZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hr3qO-0004QX-HU
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hr3qM-0008Mf-NP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:17:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hr3qM-0008GF-D9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:17:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N5max-1iRnWS2FWF-017AxG; Fri, 26 Jul 2019 19:17:07 +0200
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190725131645.19501-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4045bd6c-6bf7-356f-a62e-f2f4f61a948d@vivier.eu>
Date: Fri, 26 Jul 2019 19:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725131645.19501-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:91QzA/uV9rn7j3eXt9OofZhC0Me68pPb6/ZApIsVuPahn8qkGjA
 PuHVOwzTkEmVrlLnvcOrbPNj7FGeIZ2A+S7IX4kG51VJ/mPOk1v8Kidok3y0Sb2/thnSEg2
 VURcv+WRZVKHtSUtsVFZLYT8MzjDVJzuMdBhlFP/SWYYDek/EvXoYZB5oN5mo140YcxGOhZ
 m4TJV/PVNOg0DiNDKND0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HL4UM9vKvAE=:SMSLVv5Eo1NwmeKWkd80vx
 cvh5ER6HgG/cyvBBQu6CnqSUcQolHJME7/7701pi3Z4NlTP4N3yYIuKKxLhl8mYShUGivDZwg
 7m51GWL+RPubGhEfhlLoLAvfyzg4XukmGaZEMVfbeIbUb+w/4AYaSAMq9CGSbUzHLbU/hn2bx
 sfV0c4fw0k0CHZJbex4egZMi1WGJongOY7mTXtgdXwhDFuaaSQ/jFVqJTCyNt54S0zixomrbz
 wE+Kh85s1j+4+V92clU8lgoeyxmKtQQKwfCmPwZsnTFvaiaZmlrTLnGS5Mt3WhJEpExhCczjh
 S924CwOBGA3iG9oxEXaO9Iy5hocbBBSaxCFfd6qr+YW/aHxPnhrfanbfyfH6DOVfmwO8U4FVu
 gWlfn+DPVS6moNHK0CzdmlzLp3AnEjm6uxWk6zk+3ILRw/fOnpN1136pfAdnd8dU/vJKMnRlE
 RaKsVaqaOJmMdGpK3QMibIohrwAu0OeOKX4tUm7cYe5Ayl1BN/TAPklCj6jb19GJ6CLHsXEB6
 FUSWJUQZ//DZohmMCuq6Vomv4XblsvUkJLD8IllXZ746wY3ChKsB9/zjhtrYO9yHpEbuO6ly9
 jSs1aXMOkFVGnsAo51B4j31OUuwhO/b76Mi4yj0rPthGgn7bjTQEEtMpxAWn854G49I3xA0G8
 Pd5/iqnMRvNEBXw6kauw17zsp58Wzpn78lcpn3c5uN2jVa5F2RkT1BgbS19XTQJt09brKXYp2
 N2+iByQK5ajHKk3GrZIj3eRIqKxnaCkptL5udq20NdzTM96PxLFIjvni7Hc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: Re: [Qemu-devel] [PATCH for-4.1] linux-user: Make sigaltstack
 stacks per-thread
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
Cc: Riku Voipio <riku.voipio@iki.fi>, patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/07/2019 à 15:16, Peter Maydell a écrit :
> The alternate signal stack set up by the sigaltstack syscall is
> supposed to be per-thread.  We were incorrectly implementing it as
> process-wide.  This causes problems for guest binaries that rely on
> this.  Notably the Go runtime does, and so we were seeing crashes
> caused by races where two guest threads might incorrectly both
> execute on the same stack simultaneously.
> 
> Replace the global target_sigaltstack_used with a field
> sigaltstack_used in the TaskState, and make all the references to the
> old global instead get a pointer to the TaskState and use the field.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1696773
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've marked this as "for-4.1" but it is quite late in the release
> cycle and I think this could use more testing than I have given it...
> 
> Thanks are due to:
>  * the original bug reporter, for providing a nice simple test case
>  * rr, for allowing me to capture and forensically examine a single
>    example of the failure
>  * the Go project for having a good clear HACKING.md that explained
>    their stack usage and mentioned specifically that signal stacks
>    are per-thread (per-M, in their terms)
>  * a colleague, for prodding me into actually spending the necessary
>    two days grovelling through gdb sessions and logs to figure out
>    what was actually going wrong
> ---
>  linux-user/qemu.h          |  2 ++
>  linux-user/signal-common.h |  1 -
>  linux-user/hppa/signal.c   |  3 ++-
>  linux-user/main.c          |  5 +++++
>  linux-user/signal.c        | 35 +++++++++++++++++++----------------
>  5 files changed, 28 insertions(+), 18 deletions(-)

Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

This patch seems also to fix failure of LTP test waitpid02.

Thanks,
Laurent


