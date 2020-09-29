Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F246C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B944E20897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGQiKotw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B944E20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNB0Y-0004G0-Sq
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNAzb-0003Hs-0i
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNAzX-0004bF-SF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:28:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601368085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FGYncMo7Q21yqmF9CFdKdGo4NP1zXrwpentcDWXIz/c=;
 b=iGQiKotwv/EXfrQnbdQFr7Wyv9UCuyIlFTurl40E7sa3IWHaX3ukM6PpTBlnHM6u1vfmkD
 lla7zDpdNrdWGcIT8rOkqA3rHmZwBqt4lVu6aWqJoTarXDB5mFPQLt4OMPNOZj4uiEx8rL
 HzXTuFuXWoyXT5WRgC9WucORkXo/H2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-h42Zro3lM5yLUR-XfZXG5w-1; Tue, 29 Sep 2020 04:28:02 -0400
X-MC-Unique: h42Zro3lM5yLUR-XfZXG5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76646425EB;
 Tue, 29 Sep 2020 08:28:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F29E27A41F;
 Tue, 29 Sep 2020 08:28:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7AD90113864A; Tue, 29 Sep 2020 10:27:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 09/21] docs/interop: Convert qemu-qmp-ref to rST
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-10-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:27:59 +0200
In-Reply-To: <20200925162316.21205-10-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:04 +0100")
Message-ID: <87a6x90yy8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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

> Convert qemu-qmp-ref to rST format. This includes dropping
> the plain-text, pdf and info format outputs for this document;
> as with all our other Sphinx-based documentation, we provide
> HTML and manpage only.
>
> The qemu-qmp-ref.rst is somewhat more stripped down than
> the .texi was, because we do not (currently) attempt to
> generate indexes for the commands, events and data types
> being documented.
>
> Again, we drop the direct link from index.html.in now that
> the QMP ref is part of the interop manual.
>
> This commit removes the code from the root meson.build file that
> handled the various Texinfo-based outputs, because we no longer
> generate any documentation except for the Sphinx HTML manuals and the
> manpages, and the code can't handle having an empty list of files
> to process.. We'll do further cleanup of the remainders of

Extra period.

> Texinfo support in subsequent commits.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/index.html.in             |  1 -
>  docs/interop/conf.py           |  2 +
>  docs/interop/index.rst         |  1 +
>  docs/interop/qemu-qmp-ref.rst  |  9 ++++
>  docs/interop/qemu-qmp-ref.texi | 80 ---------------------------------
>  docs/meson.build               |  1 +
>  meson.build                    | 82 ----------------------------------
>  qapi/meson.build               |  4 +-
>  8 files changed, 14 insertions(+), 166 deletions(-)
>  create mode 100644 docs/interop/qemu-qmp-ref.rst
>  delete mode 100644 docs/interop/qemu-qmp-ref.texi
>
> diff --git a/docs/index.html.in b/docs/index.html.in
> index 5b0f4e2bc2c..33db4396ac8 100644
> --- a/docs/index.html.in
> +++ b/docs/index.html.in
> @@ -12,7 +12,6 @@
>              <li><a href="tools/index.html">Tools Guide</a></li>
>              <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
>              <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
> -            <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
>          </ul>
>      </body>
>  </html>
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index e83632e0108..43de386d33d 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -21,4 +21,6 @@ man_pages = [
>       ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
>      ('qemu-ga-ref', 'qemu-ga-ref', u'QEMU Guest Agent Protocol Reference',
>       [], 7),
> +    ('qemu-qmp-ref', 'qemu-qmp-ref', u'QEMU QMP Reference Manual',
> +     [], 7),
>  ]
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 738cdbe185e..cd78d679d82 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -19,6 +19,7 @@ Contents:
>     pr-helper
>     qemu-ga
>     qemu-ga-ref
> +   qemu-qmp-ref
>     vhost-user
>     vhost-user-gpu
>     vhost-vdpa
> diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
> new file mode 100644
> index 00000000000..0c416fcaac2
> --- /dev/null
> +++ b/docs/interop/qemu-qmp-ref.rst
> @@ -0,0 +1,9 @@
> +QEMU QMP Reference Manual
> +=========================
> +
> +..
> +   TODO: the old texinfo manual used to note that this manual
> +   is GPL-v2-or-later. We should make that reader-visible
> +   both here and in our Sphinx manuals more generally.
> +
> +.. qapi-doc:: qapi/qapi-schema.json
> diff --git a/docs/interop/qemu-qmp-ref.texi b/docs/interop/qemu-qmp-ref.texi
> deleted file mode 100644
> index ea1d7fe6c2d..00000000000
> --- a/docs/interop/qemu-qmp-ref.texi
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -\input texinfo
> -@setfilename qemu-qmp-ref.info
> -
> -@include version.texi
> -
> -@exampleindent 0
> -@paragraphindent 0
> -
> -@settitle QEMU QMP Reference Manual
> -
> -@iftex
> -@center @image{docs/qemu_logo}
> -@end iftex
> -
> -@copying
> -This is the QEMU QMP reference manual.
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
> -* QEMU-QMP-Ref: (qemu-qmp-ref). QEMU QMP Reference Manual
> -@end direntry
> -
> -@titlepage
> -@title QMP Reference Manual
> -@subtitle QEMU version @value{VERSION}
> -@page
> -@vskip 0pt plus 1filll
> -@insertcopying
> -@end titlepage
> -
> -@contents
> -
> -@ifnottex
> -@node Top
> -@top QEMU QMP reference
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
> -@include qapi/qapi-doc.texi
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
> index 2569dd52ad6..69097e2ca07 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -16,6 +16,7 @@ if build_docs
>      'interop' : {
>          'qemu-ga.8': (have_tools ? 'man8' : ''),
>          'qemu-ga-ref.7': 'man7',
> +        'qemu-qmp-ref.7': 'man7',
>      },
>      'tools': {
>          'qemu-img.1': (have_tools ? 'man1' : ''),
> diff --git a/meson.build b/meson.build
> index c01c6230b3f..73d675ca834 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1203,88 +1203,6 @@ if 'CONFIG_GTK' in config_host
>    subdir('po')
>  endif
>  
> -if build_docs
> -  makeinfo = find_program('makeinfo', required: build_docs)
> -
> -  docs_inc = [
> -    '-I', meson.current_source_dir(),
> -    '-I', meson.current_build_dir() / 'docs',
> -    '-I', '@OUTDIR@',
> -  ]
> -
> -  version_texi = configure_file(output: 'version.texi',
> -                              input: 'version.texi.in',
> -                              configuration: {'VERSION': meson.project_version(),
> -                                              'qemu_confdir': config_host['qemu_confdir']})
> -
> -  texi = {
> -    'qemu-qmp-ref': ['docs/interop/qemu-qmp-ref.texi', qapi_doc_texi, version_texi],
> -  }
> -
> -  if makeinfo.found()
> -    cmd = [
> -      'env', 'LC_ALL=C', makeinfo, '--no-split', '--number-sections', docs_inc,
> -      '@INPUT0@', '-o', '@OUTPUT@',
> -    ]
> -    foreach ext, args: {
> -        'info': [],
> -        'html': ['--no-headers', '--html'],
> -        'txt': ['--no-headers', '--plaintext'],
> -    }
> -      t = []
> -      foreach doc, input: texi
> -        output = doc + '.' + ext
> -        t += custom_target(output,
> -                      input: input,
> -                      output: output,
> -                      install: true,
> -                      install_dir: qemu_docdir / 'interop',
> -                      command: cmd + args)
> -      endforeach
> -      alias_target(ext, t)
> -    endforeach
> -  endif
> -
> -  texi2pdf = find_program('texi2pdf', required: false)
> -
> -  if texi2pdf.found()
> -    pdfs = []
> -    foreach doc, input: texi
> -      output = doc + '.pdf'
> -      pdfs += custom_target(output,
> -                    input: input,
> -                    output: output,
> -                    command: [texi2pdf, '-q', docs_inc, '@INPUT0@', '-o', '@OUTPUT@'],
> -                    build_by_default: false)
> -    endforeach
> -    alias_target('pdf', pdfs)
> -  endif
> -
> -  texi2pod = find_program('scripts/texi2pod.pl')
> -  pod2man = find_program('pod2man', required: build_docs)
> -
> -  if pod2man.found()
> -    foreach doc, input: texi
> -      man = doc + '.7'
> -      pod = custom_target(man + '.pod',
> -                          input: input,
> -                          output: man + '.pod',
> -                          command: [texi2pod,
> -                                    '-DVERSION="' + meson.project_version() + '"',
> -                                    '-DCONFDIR="' + config_host['qemu_confdir'] + '"',
> -                                    '@INPUT0@', '@OUTPUT@'])
> -      man = custom_target(man,
> -                          input: pod,
> -                          output: man,
> -                          capture: true,
> -                          install: true,
> -                          install_dir: get_option('mandir') / 'man7',
> -                          command: [pod2man, '--utf8', '--section=7', '--center=" "',
> -                                    '--release=" "', '@INPUT@'])
> -    endforeach
> -  endif
> -endif
> -
>  if host_machine.system() == 'windows'
>    nsis_cmd = [
>      find_program('scripts/nsis.py'),
> diff --git a/qapi/meson.build b/qapi/meson.build
> index 2b2872a41d8..a287ca5d9d7 100644
> --- a/qapi/meson.build
> +++ b/qapi/meson.build
> @@ -97,7 +97,7 @@ foreach module : qapi_all_modules
>  endforeach
>  
>  qapi_files = custom_target('shared QAPI source files',
> -  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs + ['qapi-doc.texi'],
> +  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
>    input: [ files('qapi-schema.json') ],
>    command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
>    depend_files: [ qapi_inputs, qapi_gen_depends ])
> @@ -121,5 +121,3 @@ foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
>    specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: qapi_files[i])
>    i = i + 1
>  endforeach
> -
> -qapi_doc_texi = qapi_files[i]

Doesn't storage-daemon/qapi/meson.build need a similar update?

My comments on the previous patch apply.


