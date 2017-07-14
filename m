Received: from eggs.gnu.org ([2001:4830:134:3::10]:44416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dW4TV-0002Am-VX
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dW4TV-0008NL-AB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:33:58 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <150002001195.22386.4679134058536830996.stgit@frigg.lan>
	<150002534291.22386.13499916738708680298.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <28a48f7c-930a-389b-b39d-64c43654cd04@twiddle.net>
Date: Fri, 14 Jul 2017 07:33:46 -1000
MIME-Version: 1.0
In-Reply-To: <150002534291.22386.13499916738708680298.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 22/26] target/arm: [tcg] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 07/13/2017 11:42 PM, Lluís Vilanova wrote:
> -        dc->base.is_jmp = DISAS_SKIP;
> +        dc->base.is_jmp = DISAS_NORETURN;

Really should fold this back into the patch that introduced SKIP temporarily.


r~
