Received: from eggs.gnu.org ([2001:4830:134:3::10]:36668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQAiU-0001k8-9N
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQAiP-0006r9-Al
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:05:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fQAiP-0006q3-0e
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:05:29 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <54f54010-ad2d-7df0-8838-b2ddc7668875@vivier.eu>
Date: Tue, 5 Jun 2018 14:05:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

Le 05/06/2018 à 12:52, Peter Maydell a écrit :
> On 5 June 2018 at 06:27, Richard Henderson <richard.henderson@linaro.org> wrote:
>> On Fedora 28, one can no longer build a static qemu.  We depend on libraries
>> for which Fedora no longer ships static versions.
> 
> Do you mean you can't build the system binaries statically (that's
> never really been very supported), or that you can't do a build
> with configure --disable-system --disable-tools --static ?
> 
> The latter would be more concerning.

On Fedora I have also to disable gcrypt, nettle and libiscsi because we
don't have the statically linked libraries, but we don't need them with
linux-user.

Thanks,
Laurent
