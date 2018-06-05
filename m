Received: from eggs.gnu.org ([2001:4830:134:3::10]:59746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQCHZ-0000eY-Jj
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQCHT-0003Pd-Nv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:45:53 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQCHT-0003Nz-9A
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:45:47 -0400
Received: by mail-pl0-x241.google.com with SMTP id c23-v6so1534256plz.12
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 06:45:47 -0700 (PDT)
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55f8f5d0-4372-9d6a-99c9-6736ded191f9@linaro.org>
Date: Tue, 5 Jun 2018 06:45:42 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

On 06/05/2018 03:52 AM, Peter Maydell wrote:
> On 5 June 2018 at 06:27, Richard Henderson <richard.henderson@linaro.org> wrote:
>> On Fedora 28, one can no longer build a static qemu.  We depend on libraries
>> for which Fedora no longer ships static versions.
> 
> Do you mean you can't build the system binaries statically (that's
> never really been very supported), or that you can't do a build
> with configure --disable-system --disable-tools --static ?

You're right that I can build with --disable-tools.
Although even there I have to also manually fiddle capstone.

I'm annoyed that "pkg-config --exists --static foo" does not really do what it
implies (to me at least), since Fedora does not ship the static library.


r~
