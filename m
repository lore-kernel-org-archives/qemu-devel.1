Received: from eggs.gnu.org ([2001:4830:134:3::10]:39888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVvgp-0005Kb-NW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVvgo-0004T0-N4
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:11:07 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-2-marcandre.lureau@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3194d27e-b81f-8000-fdf5-24509efa170f@twiddle.net>
Date: Thu, 13 Jul 2017 22:10:55 -1000
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/29] i386: use ROUND_UP macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 07/13/2017 06:31 AM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check (with the option OnlyAlignUp)
> to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> Reviewed-by: Juan Quintela<quintela@redhat.com>
> ---
>   target/i386/arch_dump.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
