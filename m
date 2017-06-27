Received: from eggs.gnu.org ([2001:4830:134:3::10]:34372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPghP-0005Ny-Gh
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPghM-0002s3-FS
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:57:55 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:35595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPghM-0002rw-B7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:57:52 -0400
Received: by mail-qk0-x22d.google.com with SMTP id 16so15872808qkg.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 19:57:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838191990.6497.6153382313093413628.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <895e8e6e-05ef-a673-96c1-f5c231137b0a@twiddle.net>
Date: Mon, 26 Jun 2017 19:57:48 -0700
MIME-Version: 1.0
In-Reply-To: <149838191990.6497.6153382313093413628.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 07/26] target: [tcg,
 i386] Refactor init_disas_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On 06/25/2017 02:12 AM, Lluís Vilanova wrote:
> +    DisasContext *dc = container_of(db, DisasContext, base);
>       CPUX86State *env = cpu->env_ptr;
> -    DisasContext dc1, *dc = &dc1;
> -    DisasContextBase *db = &dc1.base;
> -    uint32_t flags;
> -    target_ulong cs_base;
> -    int num_insns;
> -    int max_insns;
> -
> -    /* generate intermediate code */
> -    db->pc_first = tb->pc;
> -    cs_base = tb->cs_base;
> -    flags = tb->flags;
> +    uint32_t flags = db->tb->flags;
> +    target_ulong cs_base = db->tb->cs_base;

As a nit, it would be better for the compiler if you keep only one of the two 
pointers {dc,db} live.  That is, once you've used container_of, always use 
dc->base instead of db.


r~
