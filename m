Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8398C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FF220866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FF220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrUF-0004zj-Iq
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrD9-0003be-2T
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:31 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:46861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrD6-0001Wz-JE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:30 -0400
Received: by mail-qv1-f46.google.com with SMTP id di5so3039982qvb.13
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jitkdYcjeayspJVVJ0UxUprYAeKS3h1ZR5VKH/KAGWM=;
 b=HbOd1EVxzSUJAkScfgWs3+dE5hOFhHHUPYrlJRW3Ng5/lVLY8cATjZaokgAq5TFUnA
 N034nCxjhjm7G12Aohei7Mk7Fq631C7Jg6uQBRkElJ6nYPyY0k7XK2t1qyU+Rg9wff4Q
 q20o/3Lhrh/RL1CPWUrK+f4e2z3PsMOV/G+xKhsyVbKhietInDRfmaSPCZx9pY/n/2yr
 oDVrJv1SAAXtxAul319CQmPIUXJADkyyTV4Lm01Ebj8poy8rkVjv0FvhUqgNblzSTInm
 qWbbtfC2byz0wk8z7IqG8GEV4RGmnMv8asMI5AphX+fVCv694emM9VMSDDjqWXDOOPV/
 mBCA==
X-Gm-Message-State: AOAM530NVROm2Ie8f0B+gG+OUOmH1j5Kip0Wv1ie6IKr5Ny9ZpEYoYr8
 0bGF1iDe3q4MAdvVlsaBrGwUH5F2ttPwJXH2RF2Nzqgs
X-Google-Smtp-Source: ABdhPJy1A/LN0Av7gXcZ9usoo3Lzt26VImwuHKHryL2+UUtFEd+d+F4CSb9OwgmaNEfp84HDLqgdFEAkmFDDppQcKVg=
X-Received: by 2002:a0c:dc90:: with SMTP id n16mr3018564qvk.168.1598908767694; 
 Mon, 31 Aug 2020 14:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-2-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:17:42 +0200
Message-ID: <CAAdtpL41qk-+Yo=S_gRH=XWGa=dCBqDHkjXCzuJkWefeXae2_g@mail.gmail.com>
Subject: Re: [PATCH 1/4] tracetool: add output filename command-line argument
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000020718a05ae32f5c2"
Received-SPF: pass client-ip=209.85.219.46;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qv1-f46.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:19:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000020718a05ae32f5c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 16:30, Stefan Hajnoczi <stefanha@redhat.com> a =
=C3=A9crit :

> The tracetool.py script writes to stdout. This means the output filename
> is not available to the script. Add the output filename to the
> command-line so that the script has access to the filename.
>
> This also simplifies the tracetool.py invocation. It's no longer
> necessary to use meson's custom_build(capture : true) to save output.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/tracing.txt        |  3 ++-
>  meson.build                   |  3 +--
>  scripts/tracetool.py          | 12 +++++++-----
>  scripts/tracetool/__init__.py | 18 ++++++++++++++++--
>  trace/meson.build             | 23 ++++++++---------------
>  5 files changed, 34 insertions(+), 25 deletions(-)
>
> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 6144d9921b..c84d4c00ac 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -318,7 +318,8 @@ probes:
>                           --target-type system \
>                           --target-name x86_64 \
>                           --group=3Dall \
> -                         trace-events-all >qemu.stp
> +                         trace-events-all \
> +                         qemu.stp
>
>  To facilitate simple usage of systemtap where there merely needs to be
> printf
>  logging of certain probes, a helper script "qemu-trace-stap" is provided=
.
> diff --git a/meson.build b/meson.build
> index f0fe5f8799..fadeb0c268 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1037,7 +1037,6 @@ foreach target : target_dirs
>          custom_target(exe_name + stp['ext'],
>                        input: trace_events_all,
>                        output: exe_name + stp['ext'],
> -                      capture: true,
>                        install: stp['install'],
>                        install_dir: config_host['qemu_datadir'] /
> '../systemtap/tapset',
>                        command: [
> @@ -1046,7 +1045,7 @@ foreach target : target_dirs
>                          '--target-name=3D' + target_name,
>                          '--target-type=3D' + target_type,
>                          '--probe-prefix=3Dqemu.' + target_type + '.' +
> target_name,
> -                        '@INPUT@',
> +                        '@INPUT@', '@OUTPUT@'
>                        ])
>        endforeach
>      endif
> diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> index 31146242b7..ab7653a5ce 100644
> --- a/scripts/tracetool.py
> +++ b/scripts/tracetool.py
> @@ -16,7 +16,7 @@ __email__      =3D "stefanha@redhat.com"
>  import sys
>  import getopt
>
> -from tracetool import error_write, out
> +from tracetool import error_write, out, out_open
>  import tracetool.backend
>  import tracetool.format
>
> @@ -32,7 +32,7 @@ def error_opt(msg =3D None):
>      format_descr =3D "\n".join([ "    %-15s %s" % (n, d)
>                                 for n,d in tracetool.format.get_list() ])
>      error_write("""\
> -Usage: %(script)s --format=3D<format> --backends=3D<backends> [<options>=
]
> +Usage: %(script)s --format=3D<format> --backends=3D<backends> [<options>=
]
> <trace-events> ... <output>
>
>  Backends:
>  %(backends)s
> @@ -135,13 +135,15 @@ def main(args):
>          if probe_prefix is None:
>              probe_prefix =3D ".".join(["qemu", target_type, target_name]=
)
>
> -    if len(args) < 1:
> -        error_opt("missing trace-events filepath")
> +    if len(args) < 2:
> +        error_opt("missing trace-events and output filepaths")
>      events =3D []
> -    for arg in args:
> +    for arg in args[:-1]:
>          with open(arg, "r") as fh:
>              events.extend(tracetool.read_events(fh, arg))
>
> +    out_open(args[-1])
> +
>      try:
>          tracetool.generate(events, arg_group, arg_format, arg_backends,
>                             binary=3Dbinary, probe_prefix=3Dprobe_prefix)
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
> index 3ccfa1e116..98104fa50e 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -31,14 +31,28 @@ def error(*lines):
>      sys.exit(1)
>
>
> +out_filename =3D '<none>'
> +out_fobj =3D sys.stdout
>

These appear to be always overwritten (is initialization useful?)

Anyway:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

+
> +def out_open(filename):
> +    global out_filename, out_fobj
> +    out_filename =3D filename
> +    out_fobj =3D open(filename, 'wt')
> +
>  def out(*lines, **kwargs):
>      """Write a set of output lines.
>
>      You can use kwargs as a shorthand for mapping variables when
> formating all
>      the strings in lines.
> +
> +    The 'out_filename' kwarg is automatically added with the output
> filename.
>      """
> -    lines =3D [ l % kwargs for l in lines ]
> -    sys.stdout.writelines("\n".join(lines) + "\n")
> +    output =3D []
> +    for l in lines:
> +        kwargs['out_filename'] =3D out_filename
> +        output.append(l % kwargs)
> +
> +    out_fobj.writelines("\n".join(output) + "\n")
>
>  # We only want to allow standard C types or fixed sized
>  # integer types. We don't want QEMU specific types
> diff --git a/trace/meson.build b/trace/meson.build
> index 56e870848e..16eccc0c22 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -11,20 +11,17 @@ foreach dir : [ '.' ] + trace_events_subdirs
>    trace_h =3D custom_target(fmt.format('trace', 'h'),
>                            output: fmt.format('trace', 'h'),
>                            input: trace_events_file,
> -                          command: [ tracetool, group, '--format=3Dh',
> '@INPUT@' ],
> -                          capture: true)
> +                          command: [ tracetool, group, '--format=3Dh',
> '@INPUT@', '@OUTPUT@' ])
>    genh +=3D trace_h
>    trace_c =3D custom_target(fmt.format('trace', 'c'),
>                            output: fmt.format('trace', 'c'),
>                            input: trace_events_file,
> -                          command: [ tracetool, group, '--format=3Dc',
> '@INPUT@' ],
> -                          capture: true)
> +                          command: [ tracetool, group, '--format=3Dc',
> '@INPUT@', '@OUTPUT@' ])
>    if 'CONFIG_TRACE_UST' in config_host
>      trace_ust_h =3D custom_target(fmt.format('trace-ust', 'h'),
>                                  output: fmt.format('trace-ust', 'h'),
>                                  input: trace_events_file,
> -                                command: [ tracetool, group,
> '--format=3Dust-events-h', '@INPUT@' ],
> -                                capture: true)
> +                                command: [ tracetool, group,
> '--format=3Dust-events-h', '@INPUT@', '@OUTPUT@' ])
>      trace_ss.add(trace_ust_h, lttng, urcubp)
>      genh +=3D trace_ust_h
>    endif
> @@ -33,8 +30,7 @@ foreach dir : [ '.' ] + trace_events_subdirs
>      trace_dtrace =3D custom_target(fmt.format('trace-dtrace', 'dtrace'),
>                                   output: fmt.format('trace-dtrace',
> 'dtrace'),
>                                   input: trace_events_file,
> -                                 command: [ tracetool, group,
> '--format=3Dd', '@INPUT@' ],
> -                                 capture: true)
> +                                 command: [ tracetool, group,
> '--format=3Dd', '@INPUT@', '@OUTPUT@' ])
>      trace_dtrace_h =3D custom_target(fmt.format('trace-dtrace', 'h'),
>                                     output: fmt.format('trace-dtrace',
> 'h'),
>                                     input: trace_dtrace,
> @@ -66,9 +62,8 @@ foreach d : [
>    gen =3D custom_target(d[0],
>                  output: d[0],
>                  input: meson.source_root() / 'trace-events',
> -                command: [ tracetool, '--group=3Droot', '--format=3D@0@'=
.format(d[1]),
> '@INPUT@' ],
> -                build_by_default: true, # to be removed when added to a
> target
> -                capture: true)
> +                command: [ tracetool, '--group=3Droot', '--format=3D@0@'=
.format(d[1]),
> '@INPUT@', '@OUTPUT@' ],
> +                build_by_default: true) # to be removed when added to a
> target
>    specific_ss.add(gen)
>  endforeach
>
> @@ -76,13 +71,11 @@ if 'CONFIG_TRACE_UST' in config_host
>    trace_ust_all_h =3D custom_target('trace-ust-all.h',
>                                    output: 'trace-ust-all.h',
>                                    input: trace_events_files,
> -                                  command: [ tracetool, '--group=3Dall',
> '--format=3Dust-events-h', '@INPUT@' ],
> -                                  capture: true)
> +                                  command: [ tracetool, '--group=3Dall',
> '--format=3Dust-events-h', '@INPUT@', '@OUTPUT@' ])
>    trace_ust_all_c =3D custom_target('trace-ust-all.c',
>                                    output: 'trace-ust-all.c',
>                                    input: trace_events_files,
> -                                  command: [ tracetool, '--group=3Dall',
> '--format=3Dust-events-c', '@INPUT@' ],
> -                                  capture: true)
> +                                  command: [ tracetool, '--group=3Dall',
> '--format=3Dust-events-c', '@INPUT@', '@OUTPUT@' ])
>    trace_ss.add(trace_ust_all_h, trace_ust_all_c)
>    genh +=3D trace_ust_all_h
>  endif
> --
> 2.26.2
>
>

--00000000000020718a05ae32f5c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 16:30, Stefan Hajnoczi &lt;<=
a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; a =C3=A9c=
rit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">The tracetool.py script =
writes to stdout. This means the output filename<br>
is not available to the script. Add the output filename to the<br>
command-line so that the script has access to the filename.<br>
<br>
This also simplifies the tracetool.py invocation. It&#39;s no longer<br>
necessary to use meson&#39;s custom_build(capture : true) to save output.<b=
r>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/devel/tracing.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 3 +--<br>
=C2=A0scripts/tracetool.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 +++++++--=
---<br>
=C2=A0scripts/tracetool/__init__.py | 18 ++++++++++++++++--<br>
=C2=A0trace/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23=
 ++++++++---------------<br>
=C2=A05 files changed, 34 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt<br>
index 6144d9921b..c84d4c00ac 100644<br>
--- a/docs/devel/tracing.txt<br>
+++ b/docs/devel/tracing.txt<br>
@@ -318,7 +318,8 @@ probes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 --target-type system \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 --target-name x86_64 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 --group=3Dall \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0trace-events-all &gt;qemu.stp<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0trace-events-all \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qemu.stp<br>
<br>
=C2=A0To facilitate simple usage of systemtap where there merely needs to b=
e printf<br>
=C2=A0logging of certain probes, a helper script &quot;qemu-trace-stap&quot=
; is provided.<br>
diff --git a/meson.build b/meson.build<br>
index f0fe5f8799..fadeb0c268 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1037,7 +1037,6 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0custom_target(exe_name + stp[&#39;ext&#39=
;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0input: trace_events_all,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0output: exe_name + stp[&#39;ext&#39;],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 capture: true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0install: stp[&#39;install&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0install_dir: config_host[&#39;qemu_datadir&#39;] / &#39;../system=
tap/tapset&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0command: [<br>
@@ -1046,7 +1045,7 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;--target-name=3D&#39; + target_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;--target-type=3D&#39; + target_type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;--probe-prefix=3Dqemu.&#39; + target_type + &#39;.&#3=
9; + target_name,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;@INPUT@&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &#39;@INPUT@&#39;, &#39;@OUTPUT@&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0endforeach<br>
=C2=A0 =C2=A0 =C2=A0endif<br>
diff --git a/scripts/tracetool.py b/scripts/tracetool.py<br>
index 31146242b7..ab7653a5ce 100644<br>
--- a/scripts/tracetool.py<br>
+++ b/scripts/tracetool.py<br>
@@ -16,7 +16,7 @@ __email__=C2=A0 =C2=A0 =C2=A0 =3D &quot;<a href=3D"mailto=
:stefanha@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.=
com</a>&quot;<br>
=C2=A0import sys<br>
=C2=A0import getopt<br>
<br>
-from tracetool import error_write, out<br>
+from tracetool import error_write, out, out_open<br>
=C2=A0import tracetool.backend<br>
=C2=A0import tracetool.format<br>
<br>
@@ -32,7 +32,7 @@ def error_opt(msg =3D None):<br>
=C2=A0 =C2=A0 =C2=A0format_descr =3D &quot;\n&quot;.join([ &quot;=C2=A0 =C2=
=A0 %-15s %s&quot; % (n, d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for n,d in tracetool.format.get_list=
() ])<br>
=C2=A0 =C2=A0 =C2=A0error_write(&quot;&quot;&quot;\<br>
-Usage: %(script)s --format=3D&lt;format&gt; --backends=3D&lt;backends&gt; =
[&lt;options&gt;]<br>
+Usage: %(script)s --format=3D&lt;format&gt; --backends=3D&lt;backends&gt; =
[&lt;options&gt;] &lt;trace-events&gt; ... &lt;output&gt;<br>
<br>
=C2=A0Backends:<br>
=C2=A0%(backends)s<br>
@@ -135,13 +135,15 @@ def main(args):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if probe_prefix is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0probe_prefix =3D &quot;.&qu=
ot;.join([&quot;qemu&quot;, target_type, target_name])<br>
<br>
-=C2=A0 =C2=A0 if len(args) &lt; 1:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_opt(&quot;missing trace-events filepath&=
quot;)<br>
+=C2=A0 =C2=A0 if len(args) &lt; 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_opt(&quot;missing trace-events and outpu=
t filepaths&quot;)<br>
=C2=A0 =C2=A0 =C2=A0events =3D []<br>
-=C2=A0 =C2=A0 for arg in args:<br>
+=C2=A0 =C2=A0 for arg in args[:-1]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(arg, &quot;r&quot;) as fh:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0events.extend(tracetool.rea=
d_events(fh, arg))<br>
<br>
+=C2=A0 =C2=A0 out_open(args[-1])<br>
+<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tracetool.generate(events, arg_group, arg=
_format, arg_backends,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 binary=3Dbinary, probe_prefix=3Dprobe_prefix)<br>
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py<=
br>
index 3ccfa1e116..98104fa50e 100644<br>
--- a/scripts/tracetool/__init__.py<br>
+++ b/scripts/tracetool/__init__.py<br>
@@ -31,14 +31,28 @@ def error(*lines):<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
<br>
<br>
+out_filename =3D &#39;&lt;none&gt;&#39;<br>
+out_fobj =3D sys.stdout<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">These appear to be always overwritten (is initializ=
ation useful?)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Anyway:</=
div><div dir=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.69=
6px">Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:=
f4bug@amsat.org" style=3D"text-decoration:none;color:rgb(66,133,244);font-f=
amily:sans-serif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font=
-family:sans-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"aut=
o"><span style=3D"font-family:sans-serif;font-size:13.696px"><br></span></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
+<br>
+def out_open(filename):<br>
+=C2=A0 =C2=A0 global out_filename, out_fobj<br>
+=C2=A0 =C2=A0 out_filename =3D filename<br>
+=C2=A0 =C2=A0 out_fobj =3D open(filename, &#39;wt&#39;)<br>
+<br>
=C2=A0def out(*lines, **kwargs):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Write a set of output lines.<br>
<br>
=C2=A0 =C2=A0 =C2=A0You can use kwargs as a shorthand for mapping variables=
 when formating all<br>
=C2=A0 =C2=A0 =C2=A0the strings in lines.<br>
+<br>
+=C2=A0 =C2=A0 The &#39;out_filename&#39; kwarg is automatically added with=
 the output filename.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 lines =3D [ l % kwargs for l in lines ]<br>
-=C2=A0 =C2=A0 sys.stdout.writelines(&quot;\n&quot;.join(lines) + &quot;\n&=
quot;)<br>
+=C2=A0 =C2=A0 output =3D []<br>
+=C2=A0 =C2=A0 for l in lines:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 kwargs[&#39;out_filename&#39;] =3D out_filenam=
e<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output.append(l % kwargs)<br>
+<br>
+=C2=A0 =C2=A0 out_fobj.writelines(&quot;\n&quot;.join(output) + &quot;\n&q=
uot;)<br>
<br>
=C2=A0# We only want to allow standard C types or fixed sized<br>
=C2=A0# integer types. We don&#39;t want QEMU specific types<br>
diff --git a/trace/meson.build b/trace/meson.build<br>
index 56e870848e..16eccc0c22 100644<br>
--- a/trace/meson.build<br>
+++ b/trace/meson.build<br>
@@ -11,20 +11,17 @@ foreach dir : [ &#39;.&#39; ] + trace_events_subdirs<br=
>
=C2=A0 =C2=A0trace_h =3D custom_target(fmt.format(&#39;trace&#39;, &#39;h&#=
39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0output: fmt.format(&#39;trace&#39;, &#39;h&#39;),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0input: trace_events_file,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 command: [ tracetool, group, &#39;--format=3Dh&#39;, &#39=
;@INPUT@&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 command: [ tracetool, group, &#39;--format=3Dh&#39;, &#39=
;@INPUT@&#39;, &#39;@OUTPUT@&#39; ])<br>
=C2=A0 =C2=A0genh +=3D trace_h<br>
=C2=A0 =C2=A0trace_c =3D custom_target(fmt.format(&#39;trace&#39;, &#39;c&#=
39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0output: fmt.format(&#39;trace&#39;, &#39;c&#39;),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0input: trace_events_file,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 command: [ tracetool, group, &#39;--format=3Dc&#39;, &#39=
;@INPUT@&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 command: [ tracetool, group, &#39;--format=3Dc&#39;, &#39=
;@INPUT@&#39;, &#39;@OUTPUT@&#39; ])<br>
=C2=A0 =C2=A0if &#39;CONFIG_TRACE_UST&#39; in config_host<br>
=C2=A0 =C2=A0 =C2=A0trace_ust_h =3D custom_target(fmt.format(&#39;trace-ust=
&#39;, &#39;h&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: fmt.format(&#39;trace-=
ust&#39;, &#39;h&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: trace_events_file,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ tracetool, group, &#39;--=
format=3Dust-events-h&#39;, &#39;@INPUT@&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ tracetool, group, &#39;--=
format=3Dust-events-h&#39;, &#39;@INPUT@&#39;, &#39;@OUTPUT@&#39; ])<br>
=C2=A0 =C2=A0 =C2=A0trace_ss.add(trace_ust_h, lttng, urcubp)<br>
=C2=A0 =C2=A0 =C2=A0genh +=3D trace_ust_h<br>
=C2=A0 =C2=A0endif<br>
@@ -33,8 +30,7 @@ foreach dir : [ &#39;.&#39; ] + trace_events_subdirs<br>
=C2=A0 =C2=A0 =C2=A0trace_dtrace =3D custom_target(fmt.format(&#39;trace-dt=
race&#39;, &#39;dtrace&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: fmt.format(&#39;trace=
-dtrace&#39;, &#39;dtrace&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input: trace_events_file,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [ tracetool, group, &=
#39;--format=3Dd&#39;, &#39;@INPUT@&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0command: [ tracetool, group, &=
#39;--format=3Dd&#39;, &#39;@INPUT@&#39;, &#39;@OUTPUT@&#39; ])<br>
=C2=A0 =C2=A0 =C2=A0trace_dtrace_h =3D custom_target(fmt.format(&#39;trace-=
dtrace&#39;, &#39;h&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 output: fmt.format(&#3=
9;trace-dtrace&#39;, &#39;h&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input: trace_dtrace,<b=
r>
@@ -66,9 +62,8 @@ foreach d : [<br>
=C2=A0 =C2=A0gen =3D custom_target(d[0],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: d[0],=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: meson.=
source_root() / &#39;trace-events&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ traceto=
ol, &#39;--group=3Droot&#39;, &#39;--format=3D@0@&#39;.format(d[1]), &#39;@=
INPUT@&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_by_default: =
true, # to be removed when added to a target<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ traceto=
ol, &#39;--group=3Droot&#39;, &#39;--format=3D@0@&#39;.format(d[1]), &#39;@=
INPUT@&#39;, &#39;@OUTPUT@&#39; ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_by_default: =
true) # to be removed when added to a target<br>
=C2=A0 =C2=A0specific_ss.add(gen)<br>
=C2=A0endforeach<br>
<br>
@@ -76,13 +71,11 @@ if &#39;CONFIG_TRACE_UST&#39; in config_host<br>
=C2=A0 =C2=A0trace_ust_all_h =3D custom_target(&#39;trace-ust-all.h&#39;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: &#39;trace-ust-=
all.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: trace_events_fil=
es,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ tracetool, &#39;--=
group=3Dall&#39;, &#39;--format=3Dust-events-h&#39;, &#39;@INPUT@&#39; ],<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ tracetool, &#39;--=
group=3Dall&#39;, &#39;--format=3Dust-events-h&#39;, &#39;@INPUT@&#39;, &#3=
9;@OUTPUT@&#39; ])<br>
=C2=A0 =C2=A0trace_ust_all_c =3D custom_target(&#39;trace-ust-all.c&#39;,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: &#39;trace-ust-=
all.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: trace_events_fil=
es,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ tracetool, &#39;--=
group=3Dall&#39;, &#39;--format=3Dust-events-c&#39;, &#39;@INPUT@&#39; ],<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 capture: true)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 command: [ tracetool, &#39;--=
group=3Dall&#39;, &#39;--format=3Dust-events-c&#39;, &#39;@INPUT@&#39;, &#3=
9;@OUTPUT@&#39; ])<br>
=C2=A0 =C2=A0trace_ss.add(trace_ust_all_h, trace_ust_all_c)<br>
=C2=A0 =C2=A0genh +=3D trace_ust_all_h<br>
=C2=A0endif<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div></div>

--00000000000020718a05ae32f5c2--

