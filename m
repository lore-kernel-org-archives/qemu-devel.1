Received: from eggs.gnu.org ([2001:4830:134:3::10]:53816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgZCy-0000gR-CI
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 13:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgZCu-0004Te-2C
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 13:28:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:38426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgZCt-0004TV-Qu
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 13:28:43 -0400
Received: by mail-pg1-x530.google.com with SMTP id k3-v6so7427866pgq.5
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 10:28:43 -0700 (PDT)
References: <20180720153932.8507-1-peter.maydell@linaro.org>
	<0b589622-ffaf-8ed7-c34b-77ada1d203fb@amsat.org>
	<CAFEAcA-Mc7S775QK5dt7+eqaZD0TSZhsNLrZauSNshfbQGx9fg@mail.gmail.com>
	<aa869c16-9577-bf7b-a5c7-b63673644a6f@linaro.org>
	<CAFEAcA9XXPsm8V45eYyK1kNdpOjS9gmrZM2MThu1VJ07dhwEPQ@mail.gmail.com>
	<40e694c6-9757-3f9e-b8c1-9d2fdd113328@linaro.org>
	<CAFEAcA_rsE7kNO7LkQhxcsMa9718c_kMYdgYAegesLmOFWWfMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <287d5d79-9607-9ec9-027a-d6b7dd717489@linaro.org>
Date: Fri, 20 Jul 2018 10:28:39 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rsE7kNO7LkQhxcsMa9718c_kMYdgYAegesLmOFWWfMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 ?] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On 07/20/2018 09:45 AM, Peter Maydell wrote:
>> For non-linux, I peeked at the OpenBSD man page, which says
>>
>>   The strsignal() function first appeared in AT&T System V
>>   Release 4 UNIX and was reimplemented for NetBSD 1.0.
>>
>> That suggests all of the extant BSDs should have it.
>>
>> MinGW has had the function since 2008.
>>
>> What other hosts do we support?
> 
> OSX, but that's I think OK as it inherits it from BSD.
> The configure script also has support for Solaris-variants
> and Haiku...

Solaris derives from SVR4, and so should have had it
since the beginning of time; certainly OpenSolaris does:
http://repo.or.cz/opensolaris.git/blob/HEAD:/usr/src/head/string.h#l94

Haiku has it as well:
https://git.haiku-os.org/haiku/tree/headers/posix/string.h#n75


r~
