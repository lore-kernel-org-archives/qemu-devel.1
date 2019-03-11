Received: from eggs.gnu.org ([209.51.188.92]:42543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3Emz-0002TC-Ts
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3EdU-0000Hf-2S
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3EdT-0000FV-Np
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:42:08 -0400
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bevglf.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f21d90a7-e406-2ee2-3706-e5effe3b2c7c@redhat.com>
Date: Mon, 11 Mar 2019 07:42:01 +0100
MIME-Version: 1.0
In-Reply-To: <87r2bevglf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/03/2019 17.28, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Hi all,
>>
>> lately I have been thinking of converting the QEMU build system to
>> Meson.  Meson is a relatively new build system that can replace
>> Autotools or hand-written Makefiles such as QEMU; as a die-hard
>> Autotools fan, I must say that Meson is by far better than anything else
>> that has ever tried to replace Autotools, and actually has the potential
>> to do so.
>>
>> Advantages of Meson that directly matter for QEMU include:
> [...]
>> - ease of distributing a full copy of Meson to support distros that ship
>> an older version (no dependencies apart from Python 3.5).  At 40000
>> lines of Python, Meson is relatively small.
> 
> Meson is licensed under the Apache 2 license.  QEMU as a whole is
> licensed under GPLv2 (and no later versions).  From
> <https://www.gnu.org/licenses/license-list.html#apache2>:
> 
>     This is a free software license, compatible with version 3 of the
>     GNU GPL.
> 
>     Please note that this license is not compatible with GPL version 2,
>     because it has some requirements that are not in that GPL version.
>     These include certain patent termination and indemnification
>     provisions.  The patent termination provision is a good thing, which
>     is why we recommend the Apache 2.0 license for substantial programs
>     over other lax permissive licenses.
> 
> Can we distribute Meson along with QEMU anyway?

Sure, as long as we make it clear that it is a separate executable (with
its own license), and do not link the meson code into the QEMU binary.

 Thomas
