Received: from eggs.gnu.org ([2001:4830:134:3::10]:35793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWm3l-0004RN-80
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWm3i-0005Gc-Fk
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:43:05 -0500
References: <03506cf0-a204-f619-8ee4-4990a5e69af5@cea.fr>
	<CAAdtpL5BdqUvHpVTpKuJ6R+yEHGi7U6T9rUK2PbL3nwC7F_3jA@mail.gmail.com>
	<271fd922-943a-f092-d714-697320e9ea21@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fae4435d-2b31-204c-7c5d-4bc19a122d12@vivier.eu>
Date: Tue, 11 Dec 2018 18:42:30 +0100
MIME-Version: 1.0
In-Reply-To: <271fd922-943a-f092-d714-697320e9ea21@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Fixes i386 xchgq test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, fabrice.desclaux@cea.fr, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, camille.mougey@cea.fr

Le 10/12/2018 à 20:42, Richard Henderson a écrit :
> On 12/10/18 1:26 PM, Philippe Mathieu-Daudé wrote:
>> Hi Fabrice,
>>
>> On Fri, Dec 7, 2018 at 5:06 PM <fabrice.desclaux@cea.fr> wrote:
>>>
>>> As "xchg" reads and writes both operands, the "+m" is required to avoid
>>> undefined behavior on -O2 compilation.
>>>
>>> Signed-off-by: Fabrice Desclaux <fabrice.desclaux@cea.fr>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
