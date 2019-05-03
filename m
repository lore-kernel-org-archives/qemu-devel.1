Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F291DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C793C20651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C793C20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMblA-0006VO-VE
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:14:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbjo-0005Os-RP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbjn-0007t6-2j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:12:44 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMbjl-0007r7-8w
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:12:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N4i3d-1geMeO1PZH-011mSI; Fri, 03 May 2019 19:12:39 +0200
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20181210165636.28366-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <98f62d5c-0c2a-9651-0dd6-961a243c4519@vivier.eu>
Date: Fri, 3 May 2019 19:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4fLQZfpuip7xTXAJcCSAwDBY5sYZTFcCMOFWwVuoZYMle9J1d2d
	102Da0pUw+JkXm3mHLPr7Z5D1rRmP0rLq9+lzJ65/vKIoX5SW2KXHziaR7Xi/7Tjz8QG0kw
	4OVc/ugWb5oVXFS7zgEwFLCpL/F2E9/kL4It674tHbh38NV9B9yMzWLvTSJfiZxF2nMODZT
	5rXCh2IkCqa9fA/v/8XTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GgNij2lPwA0=:Y9RmxAleW1OIcNX9sN0jED
	SiijowNuXfhLXH/UiUb8MnKl88RKtyDRy0vUogbITOiEHFlQcDuczSWmvmdG5oyf25qUqkskX
	dKcbFC3naMx3u26p0Xa/wZQuGDvUjs+zbTNZn/e1jPCtuzl4LJSMUloLmgOVNcDrhNOhuQayp
	x+2dfLzZzAimeh5KjOTXJGLR6xCoiWesbW7yYs0gNzgpXgada4J+vaRn8WXQY49FkN89X5mnB
	DUDBN/YCtF2e5OuvdI1KTSFZ0rBz121Qoow4yChVqPsXnPnqyEWSj/CDyvf9b2L7H0/Jy+PN+
	f0Oyu5w0wIlc+LaZm7gE3RMwXPsl5b8q7ihfp3v6Mb9i0h7Zsi17/TgJKycSxHegFVffglS+j
	AKs5jNsAd/5S1oB/uMqzf0Y4NWhGyjym0JU8sstu4H7dXaalxoniCJC/1FdtG9vi4QvN9MddV
	UTvYoSMWnpMTHNB0d1vwg43UeVFei17eJ+19F+RZWJeTAM2x2Njt+qN4+yCOF8g5XNZdkMwle
	bxliQpkyjKJrSTqsBzlPUojZWW41p1J/HO8T9jbMQpdkKPtK5Eh19l2tT4tXlDwz0T5hGtfgP
	mO0gNfzQtg8i0tim4As3Q+9TvwPHE0pEKeHNmFN+ANgsN82rNdzfdJWBTSNZPwnEVSy1YzDZV
	OxXBmsiudabUBKns6usuBzM9m7ZMWp1I/WAGLd5ILIhYJm1vwwe6Hc39m9X5IAMUvVJfgyLn9
	KiMy3cD/XddrNYD8qr47XODAbc7TtJ86+hMVHV00eZnsInYBZv7nYU6Zmkg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503171238.4onymdKuZUME0GdifdjvaTcO0Sp-p-smg0tkTAV0tHo@z>

On 10/12/2018 17:56, Peter Maydell wrote:
> This patchset converts the m68k target from the deprecated
> unassigned_access hook to the new transaction_failed hook.
> It's RFC for a couple of reasons:
>   * it's untested, since I don't have an m68k test image
>   * the second patch just makes "bus error while trying to
>     read page tables" be treated as a page fault, when it
>     should probably cause a fault reporting it as a bus error
>     of some kind
>   * I don't understand why the old unassigned_access hook
>     set the ATC bit in the MMU SSW, since the docs I have say
>     this should be set if the fault happened during a table
>     search, but cleared if it's just an ordinary bus-errored
>     data or insn access. Probably this is a pre-existing bug?

I think you're right. It must be cleared on bus error.

Thanks,
Laurent

