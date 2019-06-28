Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E6CC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FB02086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 20:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FB02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgxqJ-0006zo-D5
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 16:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgxoo-0006Ke-5F
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgxom-0000WO-4v
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:50:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgxol-0000VC-Oi
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 16:50:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so7524033wre.12
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 13:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=WODsPXVWFuzC3YF2MW2SUuRQdJkPvXQJyDflquSxQwQ=;
 b=na6sZSX/9x+AKmKUUq2Ol5WUzDIlDO/V0Cg6VvZjHNRrAMvTgsd+tBYf08hWMia8Bf
 pmc+XjalSrm3Jc/NxBKuHNgzhSyeP5RwJ/dTJ1NgksGZzJ28bwUWJRwwXIMo46xc6RsB
 5qP88IcqyJKcSjJRGygxlutUtBnh1wTf3HeCUONsQPkNqRedgmfBiiE2BkygbuMcQXZr
 TSqVqE6cbENHB1+LIbjLjyYW8M+E23NFeQ1NFlL+lBnMNd2Kfm59y6HchxovNaLJvAgX
 cbFr+54UZggfUG/R7KMp4YpXFOfjiS7wEJt/BxgGVBVERBeucEULS31uJDUF5Tp/pSTO
 zVUA==
X-Gm-Message-State: APjAAAWNpbxNCXnbGKnjoY2MG/nz78Y+DOZka+Y+rO4EVZlfCq4grz6T
 ZeDLEeslTXX9Mzvu0a4KQLhqW/g6sxE=
X-Google-Smtp-Source: APXvYqwYPfmdVLD249hC//sQbcvnx8RHErN2ggYgzgeBk22q1gsUdwRy5dMwKdlMlfcJ5430RzznOg==
X-Received: by 2002:adf:9267:: with SMTP id 94mr4414647wrj.109.1561754998396; 
 Fri, 28 Jun 2019 13:49:58 -0700 (PDT)
Received: from dritchie.redhat.com (73.red-88-25-212.staticip.rima-tde.net.
 [88.25.212.73])
 by smtp.gmail.com with ESMTPSA id s63sm2172960wme.17.2019.06.28.13.49.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 13:49:53 -0700 (PDT)
References: <20190628115349.60293-1-slp@redhat.com>
 <283ec3e9-92e9-e43b-66c9-419b302d90ca@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <283ec3e9-92e9-e43b-66c9-419b302d90ca@redhat.com>
Date: Fri, 28 Jun 2019 22:49:49 +0200
Message-ID: <87sgrtwi36.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 0/4] Introduce the microvm machine type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/06/19 13:53, Sergio Lopez wrote:
>> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>>  -kernel vmlinux -append "console=ttyS0 root=/dev/vda" \
>>  -nodefaults -no-user-config \
>>  -drive id=test,file=test.img,format=raw,if=none \
>>  -device virtio-blk-device,drive=test \
>>  -netdev tap,id=tap0,script=no,downscript=no \
>>  -device virtio-net-device,netdev=tap0 \
>>  -serial stdio
>
> I think the "non-legacy" mode can be obtained from the "legacy" one just
> with -nodefaults (which all sane management should be using anyway), so
> legacy=on can actually be the default. :)

I'm a bit confused here. The "legacy" boolean property in the microvm
machine type is used to indicate that QEMU should instantiate an i8259
PIC and an ISA bus (mainly to have easy access to "isa-serial"), instead
of relying on KVM's LAPIC+IOAPIC exclusively.

> I think this is interesting.  I'd love to have it optionally provide a
> device tree as well.  It's not very common on x86 and most distro
> kernels don't support device tree, but it would provide a more
> out-of-the-box experience and it may even be a drop-in replacement for
> q35 or pc as far as Kata is concerned.

I guess generating a dtb and having the kernel parse it will eat some
valuable microseconds but, as you say, it may be a good idea adding it
in the future, as long it's optional.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0WfW0ACgkQ9GknjS8M
AjXeSRAArUuNHSCbZ+JyrqNORgnx5ub8/+MGt3tss3z1Zfk5cVGe4B5lYL2Z3IGp
fyx/Bor3liaGuRHkJT1a/DuZv98TXuVohnxd2jAtp0NFe/u11X85G6ExcKVj562j
ADkZilGe1TQ0Deww5Wz/OACunNEwFBY+1AJ3JrEY9dpkSj2pzLzX3BcBihqh7SKs
eiNILHNSXsbABVcSkfiYB8S8Mz1R5OQrZ25f9nFwiUxqxlQVkQ1LzxTA4m9l2pFA
ke1RuNHEeEd0Jz5eAy8EwdSBavVMJsGzoiFMH98VETBTpwME2v98LIB+0m4Vo0G3
HKi6OYav0o5w3Mxul8m4pY9sqlvIVNmIu2dHmJI8niGJ69CmBWKN+WrDtGBvxGzL
Hr/1HXigD0JANBx2LuCREJDvpBTG+68O9tRDxcDakJEhLgFKgP+UpSV37DZxQyYb
Bt+HdQQ9uWAck7zkJboUvecxkYprnBhWk7SC8C58UmsieAzcqU2v7U2+AYQ/1sks
V+Am9gCTfC8C9FeqJFK6ahQvb8S+BQbk3uD/kIvT0z2zd0PX5SVAPxzRYpTFmAYV
v3/cS9OMk+2PI72jqKpjb9IReZIqcxat1q9yT/Him0XF7GUegc/6r6QPGkX0vc7C
0k+SQFAH5FwUNieaEEU4F4MKQNw08atGlHuh/3TXmTjMcc5E/to=
=LACg
-----END PGP SIGNATURE-----
--=-=-=--

