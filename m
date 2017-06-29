Received: from eggs.gnu.org ([2001:4830:134:3::10]:48425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dQZTA-0004rI-Hf
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dQZT7-0000fq-EE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:26:52 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dQZT7-0000ek-7J
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:26:49 -0400
Received: by mail-wr0-x229.google.com with SMTP id 77so189569519wrb.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:26:47 -0700 (PDT)
References: <20170621154244.28309-1-alex.bennee@linaro.org>
	<20170621154244.28309-3-alex.bennee@linaro.org>
	<42ab61f5-47f3-030d-264b-78d3f11d8e20@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <42ab61f5-47f3-030d-264b-78d3f11d8e20@amsat.org>
Date: Thu, 29 Jun 2017 14:27:39 +0100
Message-ID: <87lgoax6t0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v6 02/10] build-all-archs: support
 cross building via docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 06/21/2017 12:42 PM, Alex Bennée wrote:> By default we use the QEMU
> projects qemu:debian-FOO-cross images as
>> RISU hackers are likely to be QEMU developers too. However any docker
>> tag can be passed on the command line.
>
> Any thought about starting to push images?

I think it comes down to how much we trust Docker Hub and how much we
trust whoever does the pushing. Would it be an automatic thing? From
shippable?

--
Alex Bennée
