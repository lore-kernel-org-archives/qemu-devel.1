Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNii8-0007Lk-0Z
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNii3-0003Zw-WA
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:42:32 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNii3-0003Zb-Q9
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:42:27 -0400
Received: by mail-wr0-x233.google.com with SMTP id c11so86912149wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:42:27 -0700 (PDT)
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
	<F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
	<f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
	<CAFEAcA-72bvtKsPHttUizYj8EvZJDfjUda7CeZe-tpRk73+NXw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-72bvtKsPHttUizYj8EvZJDfjUda7CeZe-tpRk73+NXw@mail.gmail.com>
Date: Wed, 21 Jun 2017 17:43:09 +0100
Message-ID: <87k245thpe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, G 3 <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Pranith Kumar <bobby.prani@gmail.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 21 June 2017 at 17:14, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> do you think you can add your test as a qtest, to run it with check-qtest?
>
> We don't yet have any mechanism for having tests that need to
> be compiled for the target architecture, do we?

I posted a proof of concept a while ago:

  Subject: [RFC/POC PATCH 0/4] Building TCG tests with emdebian cross compilers
  Date: Wed, 14 Dec 2016 17:12:40 +0000
  Message-Id: <20161214171244.26813-1-alex.bennee@linaro.org>

And I think Pranith respun his TCG tests cleanup with them. But that
work isn't merged yet.

>
> thanks
> -- PMM


--
Alex Bennée
