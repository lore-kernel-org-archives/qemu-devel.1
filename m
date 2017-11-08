Received: from eggs.gnu.org ([2001:4830:134:3::10]:55496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCO7k-0005uv-5B
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCO7e-0003N6-KW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:02:24 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:52856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eCO7e-0003MX-Cw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:02:18 -0500
Received: by mail-wm0-x229.google.com with SMTP id t139so9899954wmt.1
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 03:02:18 -0800 (PST)
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171108103630.GB8971@e103592.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171108103630.GB8971@e103592.cambridge.arm.com>
Date: Wed, 08 Nov 2017 11:02:15 +0000
Message-ID: <87mv3xqbig.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 00/10] Initial support for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Martin <Dave.Martin@arm.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>


Dave Martin <Dave.Martin@arm.com> writes:

> On Tue, Nov 07, 2017 at 03:05:48PM +0000, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> These patches apply on-top of the last clean-up series:
>>
>>   Subject: [RISU PATCH 0/7] Add @Group support and some aarch64.risu cle=
anups
>>   Date: Tue, 31 Oct 2017 14:54:37 +0000
>>   Message-Id: <20171031145444.13766-1-alex.bennee@linaro.org>
>>
>> This series adds support for SVE to RISU. Most of the initial patches
>> are plumbing changes to better support arch specific option flags
>> (cleaning up a TODO in the process). I also needed to ensure configure
>> actually honoured CPPFLAGS so it could be passed yet to be released
>> headers.
>
> Should there be a getauxval(AT_HWCAP) & HWCAP_SVE check in this series
> somewhere?
>
> I don't know enough about how RISU is structured to know whether/where
> this is needed.

That would be a saner runtime check to do but it's a balance as RISU is
a fairly specialist tool which kind of assumes people know what they are
doing.

The current check is on SVE_MAGIC in the header files which does mean a
binary compiled on an SVE headered system is now carrying about a much
larger register dump even when run without the --test-sve flag.

Whether it makes sense to be more flexible is a call I'll leave up to
Peter.

>
> [...]
>
> Cheers
> ---Dave


--
Alex Benn=C3=A9e
