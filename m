Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9940AC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E57020850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 20:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E57020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54183 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEfrw-0005Bk-QL
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 16:00:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfr7-0004pY-E9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfr6-0008LS-1x
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:59:29 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hEfr3-0008Iz-C7; Thu, 11 Apr 2019 15:59:25 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N3sye-1goF1F07Rw-00zr51; Thu, 11 Apr 2019 21:59:21 +0200
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
	<philmd@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
	<marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
References: <20181126105125.30973-1-marcandre.lureau@redhat.com>
	<7c5bc3fe-116e-f29c-977d-cac890bdfa93@redhat.com>
	<1d019621-50b2-1118-a477-e7fffc8147ff@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <6ee8f393-2760-9b06-cc7f-8d9e5ce48930@vivier.eu>
Date: Thu, 11 Apr 2019 21:59:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1d019621-50b2-1118-a477-e7fffc8147ff@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EWguRcnj1A+qsP0wYlLZ2qPObA0AKdv0l7M9Kh6VpEq81y2cfKO
	XEZv76R6oFbIDwT1uWOMGIetVkpzZ2RN6cobt2xSK8vX98s5QpMQNOaTyaJraiGtfNIo+m/
	qFTWFtG82tRxheBd+T2ifKMlabjszb7pL4tnhMPfXca4iz6CeQn6R1pFYahOgVCqfmdHltR
	dxazKyxw/XU0RUuqFM2mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNjd7XjmRfg=:MKWZf18XDBXP41zoLsmk9J
	6EOBqoP+ysyqBmtEoa0DtGK/z+YxFxqP+WbUsoXnXclxYFOfB/qOyZelLzX+jvMjZvl9PNtOb
	Vbw1ffO4dLVnqmus/eQbLDkKpzezf3PJt6gbLBMeXZCp5y1/qCPq15mT29urz3+G/aUpqOrVW
	zJPuCppHkHmT92wrvIXJL5eyWf9lH62xyqjxEvfzQnRubS9qzEUzNz7Midj21yJaQa55fu4hI
	hr6GRgCCLjptw2k9uCkeb97veEq8bAQ/nK6Ew49KlRtJFNZTbIXWFWpgZAUso+o+IEqXXVcgP
	+hLnYJ4EBRDYONfd50g7irNJWnRJM4Eur0/7DbIs4k18cvLde+VfQVEiBpr0xGDjsuVVQFnc0
	SO0sZYzEpmWmqdt8ewS0FfghrrrmD+1XxfXSVGslqKurYMcdKtvUaKrYlkDzTYkoJGDhHijO2
	wYTNB5xaRLp88PmqGo6/MeF2g8Y7PLPWGQvPkEv7DLRp5G0vALXsVh4ZsPJVgSffDYkYac7lm
	inEeBC5hpgVvIvLm7Ix9l/Y1rhK2IQ1N8vh/SS/Sw7VYlI6NjoB0ZD2B9sdFlFmdWCVLVtGHG
	RK320OSvEJDBUbq5UI+PMDUDz7S3RzRuSOsM+r5jkSTE8HM6hF6VJirDcWKOhIwFYbcfLXxWL
	llX1Hfe7Wi8pPdkF8dLrtIsFqw7q0hrrQ3PfwPUny8bR85ZMAHlikVJr/wSa8XFVluJ33XHc2
	HsX8TrhFSRCEmD7UrdvmFATVISdeoRiGcysF6fIkA3A5YeSmsrCDKRs/6vI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] doc: fix the configuration
 path
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411195919.uuZSw93PL92n3eAerFGJ5Vfe7ywnoJVk4EqTh16RpoI@z>

On 30/03/2019 17:30, Thomas Huth wrote:
> On 07/02/2019 17.31, Philippe Mathieu-Daudé wrote:
>> On 11/26/18 11:51 AM, Marc-André Lureau wrote:
>>> Use a CONFDIR variable to show the configured sysconf path in the
>>> generated documentations (html, man pages etc).
>>>
>>> Related to:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1644985
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>> ---
>>>  Makefile     | 9 ++++++---
>>>  qemu-ga.texi | 4 ++--
>>>  2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 9cc4dae1a6..a39c231d1c 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -932,11 +932,14 @@ ui/shader.o: $(SRC_PATH)/ui/shader.c \
>>>  MAKEINFO=makeinfo
>>>  MAKEINFOINCLUDES= -I docs -I $(<D) -I $(@D)
>>>  MAKEINFOFLAGS=--no-split --number-sections $(MAKEINFOINCLUDES)
>>> -TEXI2PODFLAGS=$(MAKEINFOINCLUDES) "-DVERSION=$(VERSION)"
>>> +TEXI2PODFLAGS=$(MAKEINFOINCLUDES) -DVERSION="$(VERSION)" -DCONFDIR="$(qemu_confdir)"
>>>  TEXI2PDFFLAGS=$(if $(V),,--quiet) -I $(SRC_PATH) $(MAKEINFOINCLUDES)
>>>  
>>> -docs/version.texi: $(SRC_PATH)/VERSION
>>> -	$(call quiet-command,echo "@set VERSION $(VERSION)" > $@,"GEN","$@")
>>> +docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
>>> +	$(call quiet-command,(\
>>> +		echo "@set VERSION $(VERSION)" && \
>>> +		echo "@set CONFDIR $(qemu_confdir)" \
>>> +	)> $@,"GEN","$@")
>>>  
>>>  %.html: %.texi docs/version.texi
>>>  	$(call quiet-command,LC_ALL=C $(MAKEINFO) $(MAKEINFOFLAGS) --no-headers \
>>> diff --git a/qemu-ga.texi b/qemu-ga.texi
>>> index 4c7a8fd163..f00ad830f2 100644
>>> --- a/qemu-ga.texi
>>> +++ b/qemu-ga.texi
>>> @@ -30,7 +30,7 @@ set user's password
>>>  @end itemize
>>>  
>>>  qemu-ga will read a system configuration file on startup (located at
>>> -@file{/etc/qemu/qemu-ga.conf} by default), then parse remaining
>>> +@file{@value{CONFDIR}/qemu-ga.conf} by default), then parse remaining
>>>  configuration options on the command line. For the same key, the last
>>>  option wins, but the lists accumulate (see below for configuration
>>>  file format).
>>> @@ -58,7 +58,7 @@ file format).
>>>    Enable fsfreeze hook. Accepts an optional argument that specifies
>>>    script to run on freeze/thaw. Script will be called with
>>>    'freeze'/'thaw' arguments accordingly (default is
>>> -  @samp{/etc/qemu/fsfreeze-hook}). If using -F with an argument, do
>>> +  @samp{@value{CONFDIR}/fsfreeze-hook}). If using -F with an argument, do
>>>    not follow -F with a space (for example:
>>>    @samp{-F/var/run/fsfreezehook.sh}).
> 
> Ping^2
> 
> I think this could also go via qemu-trivial...?
> 
>  Thomas
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

