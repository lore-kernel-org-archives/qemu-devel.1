Received: from eggs.gnu.org ([2001:4830:134:3::10]:36762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHUCL-000161-8h
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHUCH-0003CJ-B0
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:32:13 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHUCH-0003By-66
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:32:09 -0500
Received: by mail-qt0-x242.google.com with SMTP id u42so23471356qte.7
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 04:32:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171122084157.11480-1-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <757102c5-41ad-8fe7-03f0-255e27ad43f3@amsat.org>
Date: Wed, 22 Nov 2017 09:32:04 -0300
MIME-Version: 1.0
In-Reply-To: <20171122084157.11480-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 11/22/2017 05:41 AM, Juan Quintela wrote:
> This commit started use tb_unlock() and tlb_set_dirty() on non TCG
> code.  Add the function as stubs.
> 
> commit 27266271977c5a30f2f7d493e042be1897827bdd
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Nov 20 18:08:27 2017 +0000
> 
>     exec.c: Factor out before/after actions for notdirty memory writes
>     ....
> 

Maybe pasting the sha-1 is enough "Since 272662719 those stubs are missing".

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Updating the subject ("accel: fix compiling without TCG"?):

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  accel/stubs/tcg-stub.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index 5dd480b1a2..ee575a8718 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -20,3 +20,11 @@
>  void tb_flush(CPUState *cpu)
>  {
>  }
> +
> +void tb_unlock(void)
> +{
> +}
> +
> +void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
> +{
> +}
> 
