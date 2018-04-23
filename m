Received: from eggs.gnu.org ([2001:4830:134:3::10]:44164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAcQY-0003zT-H4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAcQV-0003Ll-9n
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:26:46 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:46077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAcQV-0003L6-1g
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 10:26:43 -0400
Received: by mail-wr0-x22b.google.com with SMTP id p5-v6so14078435wre.12
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 07:26:42 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<ef2caf0d-4bd0-9383-5d2f-e1f0ba9f536b@linaro.org>
	<87sh7mkrsr.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87sh7mkrsr.fsf@linaro.org>
Date: Mon, 23 Apr 2018 15:26:40 +0100
Message-ID: <87r2n6knhb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 04/19/2018 03:58 AM, Alex Benn=C3=A9e wrote:
>>> What would be really
>>> helpful is if the respective maintainers could encode their EXACT
>>> STEPS for building their cross compilers into some docker recipes.
>>
>> I've just re-built my alphaev67 cross-environment and recorded everythin=
g.
<snip>
>> Starting without that seed tarball is hard, as previously mentioned.  For
>> better supported platforms than alpha you can typically pull the same fi=
les
>> from e.g. debian packages or a gentoo stage3 tarball.
>
> Hmm I was hoping I could use --without-sysroot to build a gcc just for
> building glibc and then re-build gcc once glibc was boot-strapped. But
> that doesn't seem to work...
>
> Maybe for alpha we just have to accept there is a blob of sysroot to get
> the build going? Of course we should probably host that blob on qemu's
> servers somewhere...

New plan - Debian Sid has gcc-alpha-linux-gnu on account of the
unofficial Debian Alpha port.

--
Alex Benn=C3=A9e
