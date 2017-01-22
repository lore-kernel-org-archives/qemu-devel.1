Received: from eggs.gnu.org ([2001:4830:134:3::10]:36543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVC94-00018K-P6
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVC94-0001NW-1S
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:00:58 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVC93-0001NS-SJ
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 02:00:57 -0500
Received: by mail-pg0-x242.google.com with SMTP id t6so10731075pgt.1
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 23:00:56 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
	<alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
	<7178d6dd-4252-ad60-e1f0-51acffcd393c@twiddle.net>
	<d3ca01a3-b8ed-93fd-235a-bd9b3adad838@ispras.ru>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7f9b740e-20d5-2a6e-eaba-ffef5851e754@twiddle.net>
Date: Sat, 21 Jan 2017 23:00:53 -0800
MIME-Version: 1.0
In-Reply-To: <d3ca01a3-b8ed-93fd-235a-bd9b3adad838@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/18] tcg: add support for 128bit vector
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 01/19/2017 08:54 AM, Kirill Batuzov wrote:
>
> Wrappers issue emulation code instead of operation if it is not supported by host.
>
> tcg_gen_add_i32x4 looks like this:
>
> if (TCG_TARGET_HAS_add_i32x4) {
>     tcg_gen_op3_v128(INDEX_op_add_i32x4, args[0], args[1], args[2]);
> } else {
>     for (i = 0; i < 4; i++) {
>         tcg_gen_ld_i32(...);
>         tcg_gen_ld_i32(...);
>         tcg_gen_add_i32(...);
>         tcg_gen_st_i32(...);
>     }
> }

To me that begs the question of why you wouldn't issue 4 adds on 4 i32 
registers instead.


r~
