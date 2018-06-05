Received: from eggs.gnu.org ([2001:4830:134:3::10]:39395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQArY-0005hk-Jf
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQArX-0005El-DU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:14:56 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQArX-0005EN-6S
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:14:55 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so2486574oth.8
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 05:14:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54f54010-ad2d-7df0-8838-b2ddc7668875@vivier.eu>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
	<54f54010-ad2d-7df0-8838-b2ddc7668875@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 13:14:34 +0100
Message-ID: <CAFEAcA9b==mGZQUAoPDCt1zbqxT3RmTa0XoQZvuPb17L0NYbMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

On 5 June 2018 at 13:05, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 05/06/2018 =C3=A0 12:52, Peter Maydell a =C3=A9crit :
>> On 5 June 2018 at 06:27, Richard Henderson <richard.henderson@linaro.org=
> wrote:
>>> On Fedora 28, one can no longer build a static qemu.  We depend on libr=
aries
>>> for which Fedora no longer ships static versions.
>>
>> Do you mean you can't build the system binaries statically (that's
>> never really been very supported), or that you can't do a build
>> with configure --disable-system --disable-tools --static ?
>>
>> The latter would be more concerning.
>
> On Fedora I have also to disable gcrypt, nettle and libiscsi because we
> don't have the statically linked libraries, but we don't need them with
> linux-user.

Do we actually try to link with those for linux-user? If not,
maybe we could make configure a bit more helpful about not
requiring you to manually --disable-foo them.

thanks
-- PMM
