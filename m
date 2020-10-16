Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E0CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F102206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F102206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTM13-00062W-0A
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTLzl-0004fo-Qh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:25:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34101)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTLzj-0004OH-Ll
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:25:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id x1so1593583eds.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 02:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nHMcq9ZJzEzkpIGzkAZHy8k8gpsa6PMByxp2uXZs5eA=;
 b=McSLa6FdZWht7tBI67Lt8IizM6e+gKobiyR0D9Y/NRhl1QbWp/PNvD40y8Us8jg/Cu
 L6/0ZfPlfQHg925+kZf7ARaXYxSgnMxJ4LDIKDFjy6jQ8ODggWrhw3NyJ6lfOgqDCgAB
 2Pc0vBP6hoKfyJ4yHPv9+QlbCT30/ehFwEZxXbJQ0sRtSPV4a7bcQzUUV2CUgRV8sL3d
 Yv7PxrdSIi3ebotFVXKnzOK+604r017m07k3KVfhOVFEkUY33Du1JRkkt8/DXKrnfMKZ
 N//qVP1SQOMApjLqWRy1ug349YcqjAFBgAg3H9tTO8QM2UDn+DpkHicqQmuIMDjJOpIr
 82qg==
X-Gm-Message-State: AOAM532fUNW/w0rI1OENKsdbJYmH7pskWYg8mzMDvbi999be879KpfCa
 O1YcRGls+WozzLsyrHFd9t1DaUQEJHHU1jZbhA0=
X-Google-Smtp-Source: ABdhPJyLrfiqSB1AEfDRO0Iyj5Im5fasR/rjpDt8DA9Tv9+1PFPz4NCncuwt0vbu+85H0hVmr/sXm03QBttF41GJdRE=
X-Received: by 2002:aa7:c256:: with SMTP id y22mr2862323edo.324.1602840349403; 
 Fri, 16 Oct 2020 02:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201016091447.1552469-1-pbonzini@redhat.com>
In-Reply-To: <20201016091447.1552469-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Oct 2020 11:25:36 +0200
Message-ID: <CAAdtpL4ZjbPZ=-YgPLMV+Ubb8nEgGzB9jC0=7=F5rz9KxUVtFA@mail.gmail.com>
Subject: Re: [PATCH] meson: move SPHINX_ARGS references within "if build_docs"
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a86ed005b1c65998"
Received-SPF: pass client-ip=209.85.208.68;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 05:25:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a86ed005b1c65998
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2020 11:15, Paolo Bonzini <pbonzini@redhat.com> a =C3=A9cri=
t :

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  tests/qapi-schema/meson.build | 88 +++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 44 deletions(-)
>
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.buil=
d
> index 1f222a7a13..66c7f04cf8 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -219,53 +219,53 @@ qapi_doc =3D custom_target('QAPI doc',
>                                      '-p', 'doc-good-', '@INPUT0@' ],
>                           depend_files: qapi_gen_depends)
>
> -# Test the document-comment document generation code by running a test
> schema
> -# file through Sphinx's plain-text builder and comparing the result
> against
> -# a golden reference. This is in theory susceptible to failures if Sphin=
x
> -# changes its output, but the text output has historically been very
> stable
> -# (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
> -# texinfo or HTML generation, both of which have had changes. We might
> -# need to add more sophisticated logic here in future for some sort of
> -# fuzzy comparison if future Sphinx versions produce different text,
> -# but for now the simple comparison suffices.
> -qapi_doc_out =3D custom_target('QAPI rST doc',
> -                             output: ['doc-good.txt'],
> -                             input: files('doc-good.json',
> 'doc-good.rst'),
> -                             build_by_default: build_docs,
> -                             depend_files: sphinx_extn_depends,
> -                             # We use -E to suppress Sphinx's caching,
> because
> -                             # we want it to always really run the QAPI
> doc
> -                             # generation code. It also means we don't
> -                             # clutter up the build dir with the cache.
> -                             command: [SPHINX_ARGS,
> -                                       '-b', 'text', '-E',
> -                                       '-c', meson.source_root() / 'docs=
',
> -                                       '-D', 'master_doc=3Ddoc-good',
> -                                       meson.current_source_dir(),
> -                                       meson.current_build_dir()])
> +if build_docs
> +  # Test the document-comment document generation code by running a test
> schema
> +  # file through Sphinx's plain-text builder and comparing the result
> against
> +  # a golden reference. This is in theory susceptible to failures if
> Sphinx
> +  # changes its output, but the text output has historically been very
> stable
> +  # (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
> +  # texinfo or HTML generation, both of which have had changes. We might
> +  # need to add more sophisticated logic here in future for some sort of
> +  # fuzzy comparison if future Sphinx versions produce different text,
> +  # but for now the simple comparison suffices.
> +  qapi_doc_out =3D custom_target('QAPI rST doc',
> +                               output: ['doc-good.txt'],
> +                               input: files('doc-good.json',
> 'doc-good.rst'),
> +                               build_by_default: true,
> +                               depend_files: sphinx_extn_depends,
> +                               # We use -E to suppress Sphinx's caching,
> because
> +                               # we want it to always really run the QAP=
I
> doc
> +                               # generation code. It also means we don't
> +                               # clutter up the build dir with the cache=
.
> +                               command: [SPHINX_ARGS,
> +                                         '-b', 'text', '-E',
> +                                         '-c', meson.source_root() /
> 'docs',
> +                                         '-D', 'master_doc=3Ddoc-good',
> +                                         meson.current_source_dir(),
> +                                         meson.current_build_dir()])
>
> -# Fix possible inconsistency in line endings in generated output and
> -# in the golden reference (which could otherwise cause test failures
> -# on Windows hosts). Unfortunately diff --strip-trailing-cr
> -# is GNU-diff only. The odd-looking perl is because we must avoid
> -# using an explicit '\' character in the command arguments to
> -# a custom_target(), as Meson will unhelpfully replace it with a '/'
> -# (https://github.com/mesonbuild/meson/issues/1564)
> -qapi_doc_out_nocr =3D custom_target('QAPI rST doc newline-sanitized',
> -                                  output: ['doc-good.txt.nocr'],
> -                                  input: qapi_doc_out[0],
> -                                  build_by_default: build_docs,
> -                                  command: ['perl', '-pe', '$x =3D chr 1=
3;
> s/$x$//', '@INPUT@'],
> -                                  capture: true)
> +  # Fix possible inconsistency in line endings in generated output and
> +  # in the golden reference (which could otherwise cause test failures
> +  # on Windows hosts). Unfortunately diff --strip-trailing-cr
> +  # is GNU-diff only. The odd-looking perl is because we must avoid
> +  # using an explicit '\' character in the command arguments to
> +  # a custom_target(), as Meson will unhelpfully replace it with a '/'
> +  # (https://github.com/mesonbuild/meson/issues/1564)
> +  qapi_doc_out_nocr =3D custom_target('QAPI rST doc newline-sanitized',
> +                                    output: ['doc-good.txt.nocr'],
> +                                    input: qapi_doc_out[0],
> +                                    build_by_default: true,
> +                                    command: ['perl', '-pe', '$x =3D chr
> 13; s/$x$//', '@INPUT@'],
> +                                    capture: true)
>
> -qapi_doc_ref_nocr =3D custom_target('QAPI rST doc reference
> newline-sanitized',
> -                                  output: ['doc-good.ref.nocr'],
> -                                  input: files('doc-good.txt'),
> -                                  build_by_default: build_docs,
> -                                  command: ['perl', '-pe', '$x =3D chr 1=
3;
> s/$x$//', '@INPUT@'],
> -                                  capture: true)
> +  qapi_doc_ref_nocr =3D custom_target('QAPI rST doc reference
> newline-sanitized',
> +                                    output: ['doc-good.ref.nocr'],
> +                                    input: files('doc-good.txt'),
> +                                    build_by_default: true,
> +                                    command: ['perl', '-pe', '$x =3D chr
> 13; s/$x$//', '@INPUT@'],
> +                                    capture: true)
>
> -if build_docs
>    # "full_path()" needed here to work around
>    # https://github.com/mesonbuild/meson/issues/7585
>    test('QAPI rST doc', diff, args: ['-u',
> qapi_doc_ref_nocr[0].full_path(),
> --
> 2.26.2
>
>
>

--000000000000a86ed005b1c65998
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRp
cj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+TGUgdmVuLiAxNiBvY3QuIDIwMjAgMTE6MTUsIFBh
b2xvIEJvbnppbmkgJmx0OzxhIGhyZWY9Im1haWx0bzpwYm9uemluaUByZWRoYXQuY29tIj5wYm9u
emluaUByZWRoYXQuY29tPC9hPiZndDsgYSDDqWNyaXTCoDo8YnI+PC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+U2lnbmVkLW9mZi1ieTogUGFvbG8gQm9u
emluaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnBib256aW5pQHJlZGhhdC5jb20iIHRhcmdldD0iX2Js
YW5rIiByZWw9Im5vcmVmZXJyZXIiPnBib256aW5pQHJlZGhhdC5jb208L2E+Jmd0Ozxicj48L2Js
b2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0i
YXV0byI+UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJt
YWlsdG86ZjRidWdAYW1zYXQub3JnIj5mNGJ1Z0BhbXNhdC5vcmc8L2E+Jmd0Ozxicj48L2Rpdj48
ZGl2IGRpcj0iYXV0byI+PGJyPjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAg
MCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQot
LS08YnI+DQrCoHRlc3RzL3FhcGktc2NoZW1hL21lc29uLmJ1aWxkIHwgODggKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS08YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRp
b25zKCspLCA0NCBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvdGVzdHMvcWFw
aS1zY2hlbWEvbWVzb24uYnVpbGQgYi90ZXN0cy9xYXBpLXNjaGVtYS9tZXNvbi5idWlsZDxicj4N
CmluZGV4IDFmMjIyYTdhMTMuLjY2YzdmMDRjZjggMTAwNjQ0PGJyPg0KLS0tIGEvdGVzdHMvcWFw
aS1zY2hlbWEvbWVzb24uYnVpbGQ8YnI+DQorKysgYi90ZXN0cy9xYXBpLXNjaGVtYS9tZXNvbi5i
dWlsZDxicj4NCkBAIC0yMTksNTMgKzIxOSw1MyBAQCBxYXBpX2RvYyA9IGN1c3RvbV90YXJnZXQo
JiMzOTtRQVBJIGRvYyYjMzk7LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJiMzOTstcCYjMzk7LCAmIzM5O2RvYy1nb29kLSYjMzk7
LCAmIzM5O0BJTlBVVDBAJiMzOTsgXSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkZXBlbmRfZmlsZXM6IHFhcGlfZ2VuX2RlcGVuZHMpPGJyPg0KPGJyPg0KLSMg
VGVzdCB0aGUgZG9jdW1lbnQtY29tbWVudCBkb2N1bWVudCBnZW5lcmF0aW9uIGNvZGUgYnkgcnVu
bmluZyBhIHRlc3Qgc2NoZW1hPGJyPg0KLSMgZmlsZSB0aHJvdWdoIFNwaGlueCYjMzk7cyBwbGFp
bi10ZXh0IGJ1aWxkZXIgYW5kIGNvbXBhcmluZyB0aGUgcmVzdWx0IGFnYWluc3Q8YnI+DQotIyBh
IGdvbGRlbiByZWZlcmVuY2UuIFRoaXMgaXMgaW4gdGhlb3J5IHN1c2NlcHRpYmxlIHRvIGZhaWx1
cmVzIGlmIFNwaGlueDxicj4NCi0jIGNoYW5nZXMgaXRzIG91dHB1dCwgYnV0IHRoZSB0ZXh0IG91
dHB1dCBoYXMgaGlzdG9yaWNhbGx5IGJlZW4gdmVyeSBzdGFibGU8YnI+DQotIyAobm8gY2hhbmdl
cyBiZXR3ZWVuIFNwaGlueCAxLjYgYW5kIDMuMCksIHNvIGl0IGlzIGEgYmV0dGVyIGJldCB0aGFu
PGJyPg0KLSMgdGV4aW5mbyBvciBIVE1MIGdlbmVyYXRpb24sIGJvdGggb2Ygd2hpY2ggaGF2ZSBo
YWQgY2hhbmdlcy4gV2UgbWlnaHQ8YnI+DQotIyBuZWVkIHRvIGFkZCBtb3JlIHNvcGhpc3RpY2F0
ZWQgbG9naWMgaGVyZSBpbiBmdXR1cmUgZm9yIHNvbWUgc29ydCBvZjxicj4NCi0jIGZ1enp5IGNv
bXBhcmlzb24gaWYgZnV0dXJlIFNwaGlueCB2ZXJzaW9ucyBwcm9kdWNlIGRpZmZlcmVudCB0ZXh0
LDxicj4NCi0jIGJ1dCBmb3Igbm93IHRoZSBzaW1wbGUgY29tcGFyaXNvbiBzdWZmaWNlcy48YnI+
DQotcWFwaV9kb2Nfb3V0ID0gY3VzdG9tX3RhcmdldCgmIzM5O1FBUEkgclNUIGRvYyYjMzk7LDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG91dHB1dDog
WyYjMzk7ZG9jLWdvb2QudHh0JiMzOTtdLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlucHV0OiBmaWxlcygmIzM5O2RvYy1nb29kLmpzb24mIzM5Oywg
JiMzOTtkb2MtZ29vZC5yc3QmIzM5OyksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYnVpbGRfYnlfZGVmYXVsdDogYnVpbGRfZG9jcyw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXBlbmRfZmlsZXM6IHNw
aGlueF9leHRuX2RlcGVuZHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIyBXZSB1c2UgLUUgdG8gc3VwcHJlc3MgU3BoaW54JiMzOTtzIGNhY2hpbmcs
IGJlY2F1c2U8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAjIHdlIHdhbnQgaXQgdG8gYWx3YXlzIHJlYWxseSBydW4gdGhlIFFBUEkgZG9jPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIyBnZW5lcmF0aW9uIGNv
ZGUuIEl0IGFsc28gbWVhbnMgd2UgZG9uJiMzOTt0PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIyBjbHV0dGVyIHVwIHRoZSBidWlsZCBkaXIgd2l0aCB0
aGUgY2FjaGUuPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY29tbWFuZDogW1NQSElOWF9BUkdTLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWImIzM5OywgJiMzOTt0ZXh0
JiMzOTssICYjMzk7LUUmIzM5Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1jJiMzOTssIG1lc29uLnNvdXJjZV9y
b290KCkgLyAmIzM5O2RvY3MmIzM5Oyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1EJiMzOTssICYjMzk7bWFzdGVy
X2RvYz1kb2MtZ29vZCYjMzk7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1lc29uLmN1cnJlbnRfc291cmNlX2RpcigpLDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG1lc29uLmN1cnJlbnRfYnVpbGRfZGlyKCldKTxicj4NCitpZiBidWlsZF9kb2NzPGJy
Pg0KK8KgICMgVGVzdCB0aGUgZG9jdW1lbnQtY29tbWVudCBkb2N1bWVudCBnZW5lcmF0aW9uIGNv
ZGUgYnkgcnVubmluZyBhIHRlc3Qgc2NoZW1hPGJyPg0KK8KgICMgZmlsZSB0aHJvdWdoIFNwaGlu
eCYjMzk7cyBwbGFpbi10ZXh0IGJ1aWxkZXIgYW5kIGNvbXBhcmluZyB0aGUgcmVzdWx0IGFnYWlu
c3Q8YnI+DQorwqAgIyBhIGdvbGRlbiByZWZlcmVuY2UuIFRoaXMgaXMgaW4gdGhlb3J5IHN1c2Nl
cHRpYmxlIHRvIGZhaWx1cmVzIGlmIFNwaGlueDxicj4NCivCoCAjIGNoYW5nZXMgaXRzIG91dHB1
dCwgYnV0IHRoZSB0ZXh0IG91dHB1dCBoYXMgaGlzdG9yaWNhbGx5IGJlZW4gdmVyeSBzdGFibGU8
YnI+DQorwqAgIyAobm8gY2hhbmdlcyBiZXR3ZWVuIFNwaGlueCAxLjYgYW5kIDMuMCksIHNvIGl0
IGlzIGEgYmV0dGVyIGJldCB0aGFuPGJyPg0KK8KgICMgdGV4aW5mbyBvciBIVE1MIGdlbmVyYXRp
b24sIGJvdGggb2Ygd2hpY2ggaGF2ZSBoYWQgY2hhbmdlcy4gV2UgbWlnaHQ8YnI+DQorwqAgIyBu
ZWVkIHRvIGFkZCBtb3JlIHNvcGhpc3RpY2F0ZWQgbG9naWMgaGVyZSBpbiBmdXR1cmUgZm9yIHNv
bWUgc29ydCBvZjxicj4NCivCoCAjIGZ1enp5IGNvbXBhcmlzb24gaWYgZnV0dXJlIFNwaGlueCB2
ZXJzaW9ucyBwcm9kdWNlIGRpZmZlcmVudCB0ZXh0LDxicj4NCivCoCAjIGJ1dCBmb3Igbm93IHRo
ZSBzaW1wbGUgY29tcGFyaXNvbiBzdWZmaWNlcy48YnI+DQorwqAgcWFwaV9kb2Nfb3V0ID0gY3Vz
dG9tX3RhcmdldCgmIzM5O1FBUEkgclNUIGRvYyYjMzk7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG91dHB1dDogWyYjMzk7ZG9jLWdvb2QudHh0
JiMzOTtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlucHV0OiBmaWxlcygmIzM5O2RvYy1nb29kLmpzb24mIzM5OywgJiMzOTtkb2MtZ29vZC5y
c3QmIzM5OyksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYnVpbGRfYnlfZGVmYXVsdDogdHJ1ZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXBlbmRfZmlsZXM6IHNwaGlueF9leHRuX2RlcGVu
ZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IyBXZSB1c2UgLUUgdG8gc3VwcHJlc3MgU3BoaW54JiMzOTtzIGNhY2hpbmcsIGJlY2F1c2U8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAjIHdlIHdh
bnQgaXQgdG8gYWx3YXlzIHJlYWxseSBydW4gdGhlIFFBUEkgZG9jPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIyBnZW5lcmF0aW9uIGNvZGUuIEl0
IGFsc28gbWVhbnMgd2UgZG9uJiMzOTt0PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIyBjbHV0dGVyIHVwIHRoZSBidWlsZCBkaXIgd2l0aCB0aGUg
Y2FjaGUuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY29tbWFuZDogW1NQSElOWF9BUkdTLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCYjMzk7LWImIzM5OywgJiMzOTt0
ZXh0JiMzOTssICYjMzk7LUUmIzM5Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1jJiMzOTssIG1lc29uLnNv
dXJjZV9yb290KCkgLyAmIzM5O2RvY3MmIzM5Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmIzM5Oy1EJiMzOTssICYj
Mzk7bWFzdGVyX2RvYz1kb2MtZ29vZCYjMzk7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1lc29uLmN1cnJlbnRfc291
cmNlX2RpcigpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1lc29uLmN1cnJlbnRfYnVpbGRfZGlyKCldKTxicj4NCjxi
cj4NCi0jIEZpeCBwb3NzaWJsZSBpbmNvbnNpc3RlbmN5IGluIGxpbmUgZW5kaW5ncyBpbiBnZW5l
cmF0ZWQgb3V0cHV0IGFuZDxicj4NCi0jIGluIHRoZSBnb2xkZW4gcmVmZXJlbmNlICh3aGljaCBj
b3VsZCBvdGhlcndpc2UgY2F1c2UgdGVzdCBmYWlsdXJlczxicj4NCi0jIG9uIFdpbmRvd3MgaG9z
dHMpLiBVbmZvcnR1bmF0ZWx5IGRpZmYgLS1zdHJpcC10cmFpbGluZy1jcjxicj4NCi0jIGlzIEdO
VS1kaWZmIG9ubHkuIFRoZSBvZGQtbG9va2luZyBwZXJsIGlzIGJlY2F1c2Ugd2UgbXVzdCBhdm9p
ZDxicj4NCi0jIHVzaW5nIGFuIGV4cGxpY2l0ICYjMzk7XCYjMzk7IGNoYXJhY3RlciBpbiB0aGUg
Y29tbWFuZCBhcmd1bWVudHMgdG88YnI+DQotIyBhIGN1c3RvbV90YXJnZXQoKSwgYXMgTWVzb24g
d2lsbCB1bmhlbHBmdWxseSByZXBsYWNlIGl0IHdpdGggYSAmIzM5Oy8mIzM5Ozxicj4NCi0jICg8
YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbWVzb25idWlsZC9tZXNvbi9pc3N1ZXMvMTU2NCIg
cmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1
Yi5jb20vbWVzb25idWlsZC9tZXNvbi9pc3N1ZXMvMTU2NDwvYT4pPGJyPg0KLXFhcGlfZG9jX291
dF9ub2NyID0gY3VzdG9tX3RhcmdldCgmIzM5O1FBUEkgclNUIGRvYyBuZXdsaW5lLXNhbml0aXpl
ZCYjMzk7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBvdXRwdXQ6IFsmIzM5O2RvYy1nb29kLnR4dC5ub2NyJiMzOTtdLDxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnB1dDogcWFw
aV9kb2Nfb3V0WzBdLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBidWlsZF9ieV9kZWZhdWx0OiBidWlsZF9kb2NzLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb21tYW5kOiBbJiMz
OTtwZXJsJiMzOTssICYjMzk7LXBlJiMzOTssICYjMzk7JHggPSBjaHIgMTM7IHMvJHgkLy8mIzM5
OywgJiMzOTtASU5QVVRAJiMzOTtdLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXB0dXJlOiB0cnVlKTxicj4NCivCoCAjIEZpeCBwb3Nz
aWJsZSBpbmNvbnNpc3RlbmN5IGluIGxpbmUgZW5kaW5ncyBpbiBnZW5lcmF0ZWQgb3V0cHV0IGFu
ZDxicj4NCivCoCAjIGluIHRoZSBnb2xkZW4gcmVmZXJlbmNlICh3aGljaCBjb3VsZCBvdGhlcndp
c2UgY2F1c2UgdGVzdCBmYWlsdXJlczxicj4NCivCoCAjIG9uIFdpbmRvd3MgaG9zdHMpLiBVbmZv
cnR1bmF0ZWx5IGRpZmYgLS1zdHJpcC10cmFpbGluZy1jcjxicj4NCivCoCAjIGlzIEdOVS1kaWZm
IG9ubHkuIFRoZSBvZGQtbG9va2luZyBwZXJsIGlzIGJlY2F1c2Ugd2UgbXVzdCBhdm9pZDxicj4N
CivCoCAjIHVzaW5nIGFuIGV4cGxpY2l0ICYjMzk7XCYjMzk7IGNoYXJhY3RlciBpbiB0aGUgY29t
bWFuZCBhcmd1bWVudHMgdG88YnI+DQorwqAgIyBhIGN1c3RvbV90YXJnZXQoKSwgYXMgTWVzb24g
d2lsbCB1bmhlbHBmdWxseSByZXBsYWNlIGl0IHdpdGggYSAmIzM5Oy8mIzM5Ozxicj4NCivCoCAj
ICg8YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vbWVzb25idWlsZC9tZXNvbi9pc3N1ZXMvMTU2
NCIgcmVsPSJub3JlZmVycmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dp
dGh1Yi5jb20vbWVzb25idWlsZC9tZXNvbi9pc3N1ZXMvMTU2NDwvYT4pPGJyPg0KK8KgIHFhcGlf
ZG9jX291dF9ub2NyID0gY3VzdG9tX3RhcmdldCgmIzM5O1FBUEkgclNUIGRvYyBuZXdsaW5lLXNh
bml0aXplZCYjMzk7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBvdXRwdXQ6IFsmIzM5O2RvYy1nb29kLnR4dC5ub2NyJiMzOTtdLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpbnB1dDogcWFwaV9kb2Nfb3V0WzBdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBidWlsZF9ieV9kZWZhdWx0OiB0cnVlLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
b21tYW5kOiBbJiMzOTtwZXJsJiMzOTssICYjMzk7LXBlJiMzOTssICYjMzk7JHggPSBjaHIgMTM7
IHMvJHgkLy8mIzM5OywgJiMzOTtASU5QVVRAJiMzOTtdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXB0dXJlOiB0cnVlKTxicj4N
Cjxicj4NCi1xYXBpX2RvY19yZWZfbm9jciA9IGN1c3RvbV90YXJnZXQoJiMzOTtRQVBJIHJTVCBk
b2MgcmVmZXJlbmNlIG5ld2xpbmUtc2FuaXRpemVkJiMzOTssPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG91dHB1dDogWyYjMzk7ZG9jLWdv
b2QucmVmLm5vY3ImIzM5O10sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlucHV0OiBmaWxlcygmIzM5O2RvYy1nb29kLnR4dCYjMzk7KSw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
YnVpbGRfYnlfZGVmYXVsdDogYnVpbGRfZG9jcyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29tbWFuZDogWyYjMzk7cGVybCYjMzk7LCAm
IzM5Oy1wZSYjMzk7LCAmIzM5OyR4ID0gY2hyIDEzOyBzLyR4JC8vJiMzOTssICYjMzk7QElOUFVU
QCYjMzk7XSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgY2FwdHVyZTogdHJ1ZSk8YnI+DQorwqAgcWFwaV9kb2NfcmVmX25vY3IgPSBjdXN0
b21fdGFyZ2V0KCYjMzk7UUFQSSByU1QgZG9jIHJlZmVyZW5jZSBuZXdsaW5lLXNhbml0aXplZCYj
Mzk7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBvdXRwdXQ6IFsmIzM5O2RvYy1nb29kLnJlZi5ub2NyJiMzOTtdLDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnB1dDog
ZmlsZXMoJiMzOTtkb2MtZ29vZC50eHQmIzM5OyksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJ1aWxkX2J5X2RlZmF1bHQ6IHRydWUs
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGNvbW1hbmQ6IFsmIzM5O3BlcmwmIzM5OywgJiMzOTstcGUmIzM5OywgJiMzOTskeCA9IGNo
ciAxMzsgcy8keCQvLyYjMzk7LCAmIzM5O0BJTlBVVEAmIzM5O10sPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhcHR1cmU6IHRydWUp
PGJyPg0KPGJyPg0KLWlmIGJ1aWxkX2RvY3M8YnI+DQrCoCDCoCMgJnF1b3Q7ZnVsbF9wYXRoKCkm
cXVvdDsgbmVlZGVkIGhlcmUgdG8gd29yayBhcm91bmQ8YnI+DQrCoCDCoCMgPGEgaHJlZj0iaHR0
cHM6Ly9naXRodWIuY29tL21lc29uYnVpbGQvbWVzb24vaXNzdWVzLzc1ODUiIHJlbD0ibm9yZWZl
cnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL21lc29u
YnVpbGQvbWVzb24vaXNzdWVzLzc1ODU8L2E+PGJyPg0KwqAgwqB0ZXN0KCYjMzk7UUFQSSByU1Qg
ZG9jJiMzOTssIGRpZmYsIGFyZ3M6IFsmIzM5Oy11JiMzOTssIHFhcGlfZG9jX3JlZl9ub2NyWzBd
LmZ1bGxfcGF0aCgpLDxicj4NCi0tIDxicj4NCjIuMjYuMjxicj4NCjxicj4NCjxicj4NCjwvYmxv
Y2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--000000000000a86ed005b1c65998--

