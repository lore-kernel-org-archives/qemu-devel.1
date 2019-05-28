Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D3EC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB98D2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB98D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVewu-0006SN-5V
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:27:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVew2-00067k-3K
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVew0-0007rm-NB
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:26:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hVevz-000740-PA
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:26:44 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MDykM-1hLjH80DGG-00A0W5; Tue, 28 May 2019 18:25:10 +0200
To: qemu-devel@nongnu.org
References: <20190523175413.14448-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c0a61d30-ff62-a70c-67fd-49db6ddc03f5@vivier.eu>
Date: Tue, 28 May 2019 18:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190523175413.14448-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YY+0ra0XfJrI0vDTN4edSgZC7Qy30eM4/HN6y90c0oLh3LEqxv9
	jjV36AG0EpKbiXCV5M57lEvKV2jCJb1xVbX5F+6Xccqf5ENQJ4ZmhypEyUZTkiMvEGeG9ig
	C42nytG84/KLvfyyOoZr61pvbRyfPNlMXMeEZ4RxZtFWTOMlGxsppX7RRY7Tn8F7hisAlWE
	8X8drpO5QF53lQXpykBLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0fS33RN1C+g=:vG2CGk5k7c2mbowkUTTwvx
	/bJMwmXRmHb9CeWb6oJqF432sptG9v+TK60+r0bW9p6buUs7VwrcsYblB8lC9BUBiO5Eck/X4
	ItqyLm3cMmeoyvxaLd0USn1H3XWyZi8jahbKvfOaRwSYLM49sW4/Gc3Y89cabfhTQssdgTjdm
	YwEZNHkVyapBHKbjcwB+3Ye+prDKuTjTXlWtRL4sSWTa1DZiR6WpRKECRNrH6sh2SLlEmK22Y
	c+HKoEdxqWyWqkWGZN6HnbFDTG9jcLAh42JTx0IMAe76RXEnuY1QmZSS9muEJbwHGXUI5xNBX
	sqUk4Bffz37+pSj1Jk+SRzRVTyHXjcljIcK7xXpHeafUf37/5oCRppDqDGo2pp4Hgd5k3E4Ag
	eMcTyzaugoA1/mcYfEt+rnFFQFx5L8e/2p2jPDrShcvTCVNKzYTqxSdMJXlV8xPBVUs31jwMQ
	2YO3xH4y6zYRMMl8V4/0pFCOiPskWiqL9nBKnAYSOubFXJIhnO2nPmsfk4yY/tcHbF8ee/dYK
	VldwMttgj+q5dDzMJgUYACXg5SNTmp/FLKG36RpYQ7ERqPOMzyhB9xC/SpoXuwIIovSZqsShk
	oq5g7uyVUw0Ix7xEuN/RuUBnnpVghQUqA3yp2Ds0lY2duiwu5GexgxYznQ7w3j1ylpCPzUAss
	5ftmyJPx/smXKmtptjtpKZ97cOyNJEZ61nHL/0qAqSb2F/2rZrdWiLtovQAftPTMl8qJ7W7NG
	EUbSzkzeCUQnPns+Kym03N5v3ofqOLTv2I5pPV1G4kjniFN0B+HbvXJvBiA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix __NR_semtimedop undeclared
 error
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/2019 19:54, Laurent Vivier wrote:
> In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
> defined if __NR_msgsnd is defined.
> 
> But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
> __NR_semtimedop and it breaks the QEMU build.
> 
> __NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd_n32.h
> but not in asm-mips/unistd_o32.h.
> 
> Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
> updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtimedop.
> It introduces __NR_semtimedop_time64 instead.
> 
> This patch fixes the problem by checking for each __NR_XXX symbol
> before defining the corresponding syscall.
> 
> Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/syscall.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)

This only fixes the problem at build time, but the changes in the kernel 
headers introduce also a regression at execution time:

if the host kernel doesn't implement the syscall, the syscall fails 
(ENOSYS) whereas it was working before because it was using ipc() 
instead. I have this problem with a Fedora 28 on ppc64 
(5.0.16-100.fc28.ppc64) (LTP test msgctl07).

I'm preparing a fix.

Thanks,
Laurent

