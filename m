Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D648C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 20:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD04020789
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES70f0vQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD04020789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k87xQ-0005iD-36
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 16:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k87wf-0005H0-Tk
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 16:10:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36573
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k87wY-0003Oa-0M
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 16:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597781447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y3TRU5bbsZVRnQjiaRy+xVKPlW8BAXTFAbZCN+aeCmM=;
 b=ES70f0vQtGI5/KFec0AdfzmsgIs1rMCOEbI4+imjsk/39lqYg2eZfgCE3gwvV5IxinYOFt
 ydsVtKxow1XqutNmNyK3nmgoNarzllZv3JgGkXLphMwRiWj7IOqDNI2gPXfvL1bsLjT8mP
 aT9ybIc+neqFfNNe9EnuxLgQvCib8Ic=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-KQEoVNkRPBaDQuQPydiHuw-1; Tue, 18 Aug 2020 16:10:45 -0400
X-MC-Unique: KQEoVNkRPBaDQuQPydiHuw-1
Received: by mail-ed1-f72.google.com with SMTP id t30so8273541edi.12
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 13:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y3TRU5bbsZVRnQjiaRy+xVKPlW8BAXTFAbZCN+aeCmM=;
 b=pz8MEvXgtrsxgg5qF2Nap5Lwe2UV59aLdj4SWcxtoEc7L7aKm7AozUKLoee79tefuN
 a+Xe78wQ0p/Bqlw3EbEFuhLFsh0eWIA+lisZQ9hPeraf2kt2KAKdm113G0TrNrSc1AZQ
 fntr/DLKuxcOIwO+obo/7+RUjL+3uqk+IgFGJqAHBk5lAF4Stzxlmk/eGwIyErHHC+iC
 YnvBncS6YrQcjZhvDNU7UANVoYjWqwyFEXtl/tewCa3fzxes47seN1KJ3jzX9HU37dc3
 ItHEkrh8A45brdIsgCHM9MaYov/hO/cJsGBRAzdgBMU51x2xdrQp+xFtHYZt+C8QMo9l
 p+Uw==
X-Gm-Message-State: AOAM5310U75k1fInWNN9jnAd/Mf3UVhZprTydieyQql6G6CbEzw9uF42
 t//LqbBH0oG5I1W4eOIbigYu+45MF50DTNxrvPrtTNvisomlyRMkbfboUa6BpfRXQHRJoUefwqn
 JWPR54d3oh3eKQhNdPcNVsHTn6z+iEuo=
X-Received: by 2002:aa7:ce98:: with SMTP id y24mr21457534edv.76.1597781444292; 
 Tue, 18 Aug 2020 13:10:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznHBB4Led2Bvtr2vKtloMi7Dh8BQFzKKJvGj5OAX/0XdCwr4HlvBpvqbI794RsZVbL/L2gm+5XOjnp7EDJPI8=
X-Received: by 2002:aa7:ce98:: with SMTP id y24mr21457513edv.76.1597781444034; 
 Tue, 18 Aug 2020 13:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200818141025.21608-1-pbonzini@redhat.com>
 <CAFEAcA_k1iBQtkdRqQLYUNaJ6QuxHmbz47WpXHRhDgWKfHMm+A@mail.gmail.com>
In-Reply-To: <CAFEAcA_k1iBQtkdRqQLYUNaJ6QuxHmbz47WpXHRhDgWKfHMm+A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2020 22:10:32 +0200
Message-ID: <CABgObfYiTXMHRxPXKLS_NPXXqRxTnLX5ggA3JrX12AX4gV5tXQ@mail.gmail.com>
Subject: Re: [PULL 000/150] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000669ae905ad2c7bf8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 15:10:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000669ae905ad2c7bf8
Content-Type: text/plain; charset="UTF-8"

Ok I can see the -mms-bitfields here too, hopefully that's enough to debug
it.

Il mar 18 ago 2020, 21:27 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Tue, 18 Aug 2020 at 15:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
> d0ed6a69d399ae193959225cdeaa9382746c91cc:
> >
> >   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 3aecbe785d65e3b92a3617c60e4d226362d9bdd5:
> >
> >   docs: convert build system documentation to rST (2020-08-18 10:02:43
> -0400)
>
>
> With what I think is the latest version of this pullreq
> (commit ea922aa50b2a8688) w32 crossbuilds still fail, even
> after a complete blow-away-builddir and rebuild from scratch.
>
> ccache cc -Itarget/s390x/gen-features.p -Itarget/s390x
> -I../../target/s390x -fdiagnostics-color=always -pipe
> -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Werror -g -MD -MQ
> target/s390x/gen-features.p/gen-features.c.o -MF
> target/s390x/gen-features.p/gen-features.c.o.d -o
> target/s390x/gen-features.p/gen-features.c.o -c
> ../../target/s390x/gen-features.c
> cc -Ilibqemu-s390x-softmmu.fa.p -I. -I../.. -Itarget/s390x
> -I../../target/s390x -Iqapi -Itrace -Iui -Iui/shader
> -I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/pixman-1
> -I/home/petmay01/qemu-for-merges/dtc/libfdt
> -I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/glib-2.0
> -I/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/glib-2.0/include
> -I/home/petmay01/qemu-for-merges/capstone/include
> -fdiagnostics-color=always -pipe -Wall -Winvalid-pch -Werror
> -std=gnu99 -g -Werror -mms-bitfields -m32 -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
> -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes
> -fno-strict-aliasing -fno-common -fwrapv -Werror
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wempty-body -Wnested-externs -Wendif-labels -Wno-missing-include-dirs
> -Wno-psabi -fstack-protector-strong -iquote
> /home/petmay01/qemu-for-merges/tcg/i386 -iquote . -iquote
> /home/petmay01/qemu-for-merges -iquote
> /home/petmay01/qemu-for-merges/accel/tcg -iquote
> /home/petmay01/qemu-for-merges/include -iquote
> /home/petmay01/qemu-for-merges/disas/libvixl -DNEED_CPU_H
> '-DCONFIG_TARGET="s390x-softmmu-config-target.h"'
> '-DCONFIG_DEVICES="s390x-softmmu-config-devices.h"' -MP -o
> target/s390x/gen-features target/s390x/gen-features.p/gen-features.c.o
> -Wl,--as-needed -Wl,--allow-shlib-undefined
> /usr/bin/ld: i386:x86-64 architecture of input file
> `target/s390x/gen-features.p/gen-features.c.o' is incompatible with
> i386 output
> /usr/bin/ld: target/s390x/gen-features.p/gen-features.c.o: file class
> ELFCLASS64 incompatible with ELFCLASS32
> /usr/bin/ld: final link failed: File in wrong format
> collect2: error: ld returned 1 exit status
>
> This is supposed to be building an executable for the
> host, but something has gone wrong with the flags passed
> to cc for the link. In particular:
>
> -I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/pixman-1
> and similar are for target-compiles, not host-compiles;
> -m32 is the immediate cause of the linker failure since
> it's asking the host cc to do a 32-bit build, which then
> barfs when fed the 64-bit .o file;
> -mms-bitfields is an option that only makes sense for the
> target windows builds.
>
> The flags used for the cc-to-build-o-file look more reasonable
> (though they're missing a lot of -W options that we could
> probably pass it).
>
> thanks
> -- PMM
>
>

--000000000000669ae905ad2c7bf8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ok I can see the -mms-bitfields here too, hopefully that&=
#39;s enough to debug it.</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">Il mar 18 ago 2020, 21:27 Peter Maydell &lt;<a hre=
f=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha s=
critto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, 18 Aug 2020 at 15:1=
4, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit d0ed6a69d399ae193959225cdeaa9382746=
c91cc:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Update version for v5.1.0 release (2020-08-11 17:07:03 +01=
00)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git</=
a> tags/for-upstream<br>
&gt;<br>
&gt; for you to fetch changes up to 3aecbe785d65e3b92a3617c60e4d226362d9bdd=
5:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0docs: convert build system documentation to rST (2020-08-1=
8 10:02:43 -0400)<br>
<br>
<br>
With what I think is the latest version of this pullreq<br>
(commit ea922aa50b2a8688) w32 crossbuilds still fail, even<br>
after a complete blow-away-builddir and rebuild from scratch.<br>
<br>
ccache cc -Itarget/s390x/gen-features.p -Itarget/s390x<br>
-I../../target/s390x -fdiagnostics-color=3Dalways -pipe<br>
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Werror -g -MD -MQ<br>
target/s390x/gen-features.p/gen-features.c.o -MF<br>
target/s390x/gen-features.p/gen-features.c.o.d -o<br>
target/s390x/gen-features.p/gen-features.c.o -c<br>
../../target/s390x/gen-features.c<br>
cc -Ilibqemu-s390x-softmmu.fa.p -I. -I../.. -Itarget/s390x<br>
-I../../target/s390x -Iqapi -Itrace -Iui -Iui/shader<br>
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/pixman-1<br>
-I/home/petmay01/qemu-for-merges/dtc/libfdt<br>
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/glib-2.0<br>
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/glib-2.0/include<br>
-I/home/petmay01/qemu-for-merges/capstone/include<br>
-fdiagnostics-color=3Dalways -pipe -Wall -Winvalid-pch -Werror<br>
-std=3Dgnu99 -g -Werror -mms-bitfields -m32 -D_GNU_SOURCE<br>
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes<br>
-Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prototypes<br>
-fno-strict-aliasing -fno-common -fwrapv -Werror<br>
-Wold-style-declaration -Wold-style-definition -Wtype-limits<br>
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers<br>
-Wempty-body -Wnested-externs -Wendif-labels -Wno-missing-include-dirs<br>
-Wno-psabi -fstack-protector-strong -iquote<br>
/home/petmay01/qemu-for-merges/tcg/i386 -iquote . -iquote<br>
/home/petmay01/qemu-for-merges -iquote<br>
/home/petmay01/qemu-for-merges/accel/tcg -iquote<br>
/home/petmay01/qemu-for-merges/include -iquote<br>
/home/petmay01/qemu-for-merges/disas/libvixl -DNEED_CPU_H<br>
&#39;-DCONFIG_TARGET=3D&quot;s390x-softmmu-config-target.h&quot;&#39;<br>
&#39;-DCONFIG_DEVICES=3D&quot;s390x-softmmu-config-devices.h&quot;&#39; -MP=
 -o<br>
target/s390x/gen-features target/s390x/gen-features.p/gen-features.c.o<br>
-Wl,--as-needed -Wl,--allow-shlib-undefined<br>
/usr/bin/ld: i386:x86-64 architecture of input file<br>
`target/s390x/gen-features.p/gen-features.c.o&#39; is incompatible with<br>
i386 output<br>
/usr/bin/ld: target/s390x/gen-features.p/gen-features.c.o: file class<br>
ELFCLASS64 incompatible with ELFCLASS32<br>
/usr/bin/ld: final link failed: File in wrong format<br>
collect2: error: ld returned 1 exit status<br>
<br>
This is supposed to be building an executable for the<br>
host, but something has gone wrong with the flags passed<br>
to cc for the link. In particular:<br>
<br>
-I/usr/lib/mxe/usr/i686-w64-mingw32.shared/include/pixman-1<br>
and similar are for target-compiles, not host-compiles;<br>
-m32 is the immediate cause of the linker failure since<br>
it&#39;s asking the host cc to do a 32-bit build, which then<br>
barfs when fed the 64-bit .o file;<br>
-mms-bitfields is an option that only makes sense for the<br>
target windows builds.<br>
<br>
The flags used for the cc-to-build-o-file look more reasonable<br>
(though they&#39;re missing a lot of -W options that we could<br>
probably pass it).<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div>

--000000000000669ae905ad2c7bf8--


