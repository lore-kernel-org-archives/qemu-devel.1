Received: from eggs.gnu.org ([2001:4830:134:3::10]:55587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCO8H-0006CI-12
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCO8D-0003g7-3c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:02:57 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eCO8C-0003fl-TE
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:02:53 -0500
Received: by mail-wr0-x244.google.com with SMTP id y42so2044432wrd.3
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 03:02:52 -0800 (PST)
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-7-alex.bennee@linaro.org>
	<20171108103416.GA8971@e103592.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171108103416.GA8971@e103592.cambridge.arm.com>
Date: Wed, 08 Nov 2017 11:02:50 +0000
Message-ID: <87lgjhqbhh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 06/10] configure: support CPPFLAGS
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

> On Tue, Nov 07, 2017 at 03:05:54PM +0000, Alex Benn=C3=A9e wrote:
>> Useful for accessing API's that are still brewing, e.g:
>>
>>   CROSS_PREFIX=3Daarch64-linux-gnu- \
>>     CPPFLAGS=3D-I/home/alex/lsrc/qemu/risu.git/sve-headers/include \
>>     ../configure
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  README    | 6 ++++++
>>  configure | 1 +
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/README b/README
>> index 9946e6e..fbe408d 100644
>> --- a/README
>> +++ b/README
>> @@ -26,6 +26,12 @@ Most useful is
>>     need this if you're not building on the target system
>>     (Example: CROSS_PREFIX=3Darm-linux-gnueabihf- )
>>
>> +Another useful flag is
>> + CPPFLAGS=3D which specified pre-processor flags, usually -I statements
>> +   for specifying extra include paths. Use this is you need something
>
> s/is/if/
>
>> +   from new kernel headers not installed on your system.
>> +   (Example: CPPFLAGS=3D-I/path/to/sve-kernel-headers/include)
>> +
>
> You should probably point out that the path should refer to headers
> installed by running 'make headers_install' in the Linux source.  This
> means we really test the uapi headers properly, and I don't get spurious
> bug reports about bad headers ;)

Will do. Thanks.
>
> [...]
>
> Cheers
> ---Dave


--
Alex Benn=C3=A9e
