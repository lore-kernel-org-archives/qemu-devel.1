Received: from eggs.gnu.org ([209.51.188.92]:54783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gpvWQ-0000ff-Ns
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gpvWP-0007wE-NU
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:39:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gpvWP-0007un-Cz
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 08:39:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id h50so7759790ede.5
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 05:39:48 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <154895817139.23946.447932217302238590@ebba9967afc0>
References: <154895817139.23946.447932217302238590@ebba9967afc0>
Date: Sat, 02 Feb 2019 14:39:46 +0100
Message-ID: <87y36yqpgd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 0/8] i386/kvm/hyper-v: refactor and
 implement 'hv-stimer-direct' and 'hv-all' enlightenments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rkagan@virtuozzo.com, ehabkost@redhat.com, rth@twiddle.net

no-reply@patchew.org writes:

> === OUTPUT BEGIN ===
> 1/8 Checking commit 345a0718e21e (Update linux headers (5.0-rc2))
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #1646: 
> new file mode 100644
>
> ERROR: code indent should never use tabs
> #3980: FILE: scripts/update-linux-headers.sh:126:
> +^Icp "$tmpdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"$
>
> WARNING: line over 80 characters
> #3983: FILE: scripts/update-linux-headers.sh:129:
> +        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
>
> WARNING: line over 80 characters
> #3984: FILE: scripts/update-linux-headers.sh:130:
> +       cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
>
> ERROR: code indent should never use tabs
> #3984: FILE: scripts/update-linux-headers.sh:130:
> +^Icp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"$
>

I saw these before submitting, however, these are linux headers and we
take them as-is with scripts/update-linux-headers.sh: I don't think it
is worth it to modify these headers just to silence patchew.

-- 
Vitaly
