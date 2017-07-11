Received: from eggs.gnu.org ([2001:4830:134:3::10]:43244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUys7-0000wW-MM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUys4-0002D2-Dy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:22:51 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUys4-0002CV-9e
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:22:48 -0400
Received: by mail-qk0-f174.google.com with SMTP id d78so9930912qkb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:22:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942859571.8972.4761014660099212028.stgit@frigg.lan>
	<65f59b75-08c3-3872-6906-20060b5b4a28@twiddle.net>
	<87eftnhqpw.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <235bbfe6-6eb7-e61d-17e2-4ef6458e6488@twiddle.net>
Date: Tue, 11 Jul 2017 07:21:42 -1000
MIME-Version: 1.0
In-Reply-To: <87eftnhqpw.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 04/27] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/11/2017 06:40 AM, Lluís Vilanova wrote:
> Since other hooks can set db->is_jmp and return values (breakpoint_check), I'll
> stick with db->is_jmp instead. Then tb_start can return max_insns, and generic
> code can refine it with checks like single-stepping.

No, you misunderstand.  For SH4 I need to override single-stepping, icount, and 
anything else that produces a TB smaller than the atomic region.


r~
