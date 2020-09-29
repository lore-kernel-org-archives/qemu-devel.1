Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D2C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E009720739
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+/fJjKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E009720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAty-0006fn-Q4
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNAsY-00062x-6m
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNAsS-0002MX-Nx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:20:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601367647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaIRdDznVGOkK7/AkhJcF1JYKITVXZAi5KX96QrFChE=;
 b=V+/fJjKvvkUCj17kC1CWNUs9/TL2cheThhzaqT9DBZyTEsDodL99hm6Q7/t9qHxpYrDAs3
 QpFKy3p063nolgmixuGbbFmriEw/bibAcKgd0HpGEVT/gQwHC0DnWDyL3TrJXwsGnzRspt
 50gQ22AoKhveRqUc3n7ljGyKbLUsobo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-e9iXGLfHMiOSeYdpMBLVow-1; Tue, 29 Sep 2020 04:20:43 -0400
X-MC-Unique: e9iXGLfHMiOSeYdpMBLVow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA597801F95;
 Tue, 29 Sep 2020 08:20:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 805EE27BC8;
 Tue, 29 Sep 2020 08:20:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 13735113864A; Tue, 29 Sep 2020 10:20:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 08/21] docs/interop: Convert qemu-ga-ref to rST
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-9-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:20:40 +0200
In-Reply-To: <20200925162316.21205-9-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:03 +0100")
Message-ID: <87tuvh0zaf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Convert qemu-ga-ref to rST format. This includes dropping
> the plain-text, pdf and info format outputs for this document;
> as with all our other Sphinx-based documentation, we provide
> HTML and manpage only.
>
> The qemu-ga-ref.rst is somewhat more stripped down than
> the .texi was, because we do not (currently) attempt to
> generate indexes for the commands, events and data types
> being documented.
>
> As the GA ref is now part of the Sphinx 'interop' manual,
> we can delete the direct link from index.html.in.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/index.html.in            |  1 -
>  docs/interop/conf.py          |  2 +
>  docs/interop/index.rst        |  1 +
>  docs/interop/qemu-ga-ref.rst  |  9 ++++
>  docs/interop/qemu-ga-ref.texi | 80 -----------------------------------
>  docs/meson.build              |  1 +
>  meson.build                   |  3 --
>  MAINTAINERS                   |  2 +-
>  qga/meson.build               |  3 +-
>  9 files changed, 15 insertions(+), 87 deletions(-)
>  create mode 100644 docs/interop/qemu-ga-ref.rst
>  delete mode 100644 docs/interop/qemu-ga-ref.texi
>
> diff --git a/docs/index.html.in b/docs/index.html.in
> index ca28047881e..5b0f4e2bc2c 100644
> --- a/docs/index.html.in
> +++ b/docs/index.html.in
> @@ -13,7 +13,6 @@
>              <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
>              <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
>              <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
> -            <li><a href="interop/qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
>          </ul>
>      </body>
>  </html>
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index 42ce7e3d365..e83632e0108 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -19,4 +19,6 @@ html_theme_options['description'] = u'System Emulation Management and Interopera
>  man_pages = [
>      ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
>       ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
> +    ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
> +     [], 7),
>  ]

Why do you make the description a unicode legacy literal?  I see it
matches existing entries.  I'd like to know regardless :)

For what it's worth, the kernel's Documentation/conf.py uses a plain
string there.

> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 006f9864208..738cdbe185e 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -18,6 +18,7 @@ Contents:
>     live-block-operations
>     pr-helper
>     qemu-ga
> +   qemu-ga-ref
>     vhost-user
>     vhost-user-gpu
>     vhost-vdpa
> diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
> new file mode 100644
> index 00000000000..669019de71d
> --- /dev/null
> +++ b/docs/interop/qemu-ga-ref.rst
> @@ -0,0 +1,9 @@
> +QEMU Guest Agent Protocol Reference
> +===================================
> +
> +..
> +   TODO: the old texinfo manual used to note that this manual
> +   is GPL-v2-or-later. We should make that reader-visible
> +   both here and in our Sphinx manuals more generally.
> +
> +.. qapi-doc:: qga/qapi-schema.json
> diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
> deleted file mode 100644
> index a23cc2ed7f6..00000000000
> --- a/docs/interop/qemu-ga-ref.texi
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -\input texinfo
> -@setfilename qemu-ga-ref.info
> -
> -@include version.texi
> -
> -@exampleindent 0
> -@paragraphindent 0
> -
> -@settitle QEMU Guest Agent Protocol Reference
> -
> -@iftex
> -@center @image{docs/qemu_logo}
> -@end iftex
> -
> -@copying
> -This is the QEMU Guest Agent Protocol reference manual.
> -
> -Copyright @copyright{} 2016 The QEMU Project developers
> -
> -@quotation
> -This manual is free documentation: you can redistribute it and/or
> -modify it under the terms of the GNU General Public License as
> -published by the Free Software Foundation, either version 2 of the
> -License, or (at your option) any later version.
> -
> -This manual is distributed in the hope that it will be useful, but
> -WITHOUT ANY WARRANTY; without even the implied warranty of
> -MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -General Public License for more details.
> -
> -You should have received a copy of the GNU General Public License
> -along with this manual.  If not, see http://www.gnu.org/licenses/.
> -@end quotation
> -@end copying
> -
> -@dircategory QEMU
> -@direntry
> -* QEMU-GA-Ref: (qemu-ga-ref).   QEMU Guest Agent Protocol Reference
> -@end direntry
> -
> -@titlepage
> -@title Guest Agent Protocol Reference Manual
> -@subtitle QEMU version @value{VERSION}

There is no obvious equivalent to @value{VERSION} in
docs/interop/qemu-ga-ref.rst.

The manual page generated from it has the version in the footer.  Good.

I can't find it in the generated HTML.  Not so good, but it wasn't there
before the patch, either.

The generated PDF had it on the title page.

Suggest to add a TODO comment like the one about the licensing
information.

> -@page
> -@vskip 0pt plus 1filll
> -@insertcopying
> -@end titlepage
> -
> -@contents
> -
> -@ifnottex
> -@node Top
> -@top QEMU Guest Agent protocol reference
> -@end ifnottex
> -
> -@menu
> -* API Reference::
> -* Commands and Events Index::
> -* Data Types Index::
> -@end menu
> -
> -@node API Reference
> -@chapter API Reference
> -
> -@c for texi2pod:
> -@c man begin DESCRIPTION
> -
> -@include qga/qga-qapi-doc.texi
> -
> -@c man end
> -
> -@node Commands and Events Index
> -@unnumbered Commands and Events Index
> -@printindex fn
> -
> -@node Data Types Index
> -@unnumbered Data Types Index
> -@printindex tp
> -
> -@bye
> diff --git a/docs/meson.build b/docs/meson.build
> index 50f367349b8..2569dd52ad6 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -15,6 +15,7 @@ if build_docs
>    man_pages = {
>      'interop' : {
>          'qemu-ga.8': (have_tools ? 'man8' : ''),
> +        'qemu-ga-ref.7': 'man7',
>      },
>      'tools': {
>          'qemu-img.1': (have_tools ? 'man1' : ''),
> diff --git a/meson.build b/meson.build
> index f4d1ab10968..c01c6230b3f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1220,9 +1220,6 @@ if build_docs
>    texi = {
>      'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, version_texi],
>    }
> -  if 'CONFIG_GUEST_AGENT' in config_host
> -    texi += {'qemu-ga-ref': ['docs/interop/qemu-ga-ref.texi', qga_qapi_doc_texi, version_texi]}
> -  endif
>  
>    if makeinfo.found()
>      cmd = [
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbddb0a7635..4b2705fc143 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2418,9 +2418,9 @@ M: Michael Roth <mdroth@linux.vnet.ibm.com>
>  S: Maintained
>  F: qga/
>  F: docs/interop/qemu-ga.rst
> +F: docs/interop/qemu-ga-ref.rst
>  F: scripts/qemu-guest-agent/
>  F: tests/test-qga.c
> -F: docs/interop/qemu-ga-ref.texi
>  T: git https://github.com/mdroth/qemu.git qga
>  
>  QOM
> diff --git a/qga/meson.build b/qga/meson.build
> index e5c5778a3e0..1c312b50cc9 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -16,7 +16,7 @@ qga_qapi_outputs = [
>  ]
>  
>  qga_qapi_files = custom_target('QGA QAPI files',
> -                               output: qga_qapi_outputs + ['qga-qapi-doc.texi'],
> +                               output: qga_qapi_outputs,
>                                 input: 'qapi-schema.json',
>                                 command: [ qapi_gen, '-o', 'qga', '-p', 'qga-', '@INPUT0@' ],
>                                 depend_files: qapi_gen_depends)
> @@ -27,7 +27,6 @@ foreach output: qga_qapi_outputs
>    qga_ss.add(qga_qapi_files[i])
>    i = i + 1
>  endforeach
> -qga_qapi_doc_texi = qga_qapi_files[i]
>  
>  qga_ss.add(files(
>    'commands.c',


