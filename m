Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E9FC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC12220789
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGUllUZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC12220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBOl-0007Wz-T5
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNBNW-0006id-TA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNBNT-00085I-IN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:52:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601369570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tr21BcYE71nnyDKtN/LgqzQDV7sx8e+dPv9YoZAwbFE=;
 b=YGUllUZmFmp3J+LpX3mkNqBCw2fRlnaCFa6lbulPpuUU4Oas09O6XtoMA/KOFdecr6nMPQ
 l6AwrbGRIsJKtYm1i6+C8DYaBqicMpvKenBHHtk6fuDd4A/VxSvCRJ+d7pR2UaKMxJ3mK3
 gVZsaWTj/Zsc6aWkk5X83HP8TbFHg+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-FLV4B32ZN6GzxLVCf0TXkA-1; Tue, 29 Sep 2020 04:52:45 -0400
X-MC-Unique: FLV4B32ZN6GzxLVCf0TXkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE651074651;
 Tue, 29 Sep 2020 08:52:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE0357881E;
 Tue, 29 Sep 2020 08:52:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4054E113864A; Tue, 29 Sep 2020 10:52:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 14/21] meson.build: Make manuals depend on source to
 Sphinx extensions
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-15-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:52:43 +0200
In-Reply-To: <20200925162316.21205-15-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:09 +0100")
Message-ID: <874knhynfo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

> The automatic dependency handling for Sphinx manuals only makes the output
> depend on the input documentation files. This means that if you edit
> the Python source of an extension then the documentation won't be
> rebuilt.
>
> Create a list of all the source files for the extensions and add
> it to the dependencies for the manuals. This is similar to how we
> handle the qapi_gen_depends list.
>
> Because we don't try to identify which manuals are using which
> Sphinx extensions, a change to the source of one extension will
> always rebuild the entire manual set, not merely the manuals
> which have changed. This is acceptable because we don't change
> the extensions all that often.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/meson.build | 1 +
>  meson.build      | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/docs/meson.build b/docs/meson.build
> index 99da609e813..59fea873b10 100644
> --- a/docs/meson.build
> +++ b/docs/meson.build
> @@ -36,6 +36,7 @@ if build_docs
>                  output: [manual + '.stamp'],
>                  input: [files('conf.py'), files(manual / 'conf.py')],
>                  depfile: manual + '.d',
> +                depend_files: sphinx_extn_depends,
>                  command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
>                            '-Ddepfile_stamp=@OUTPUT0@',
>                            '-b', 'html', '-d', private_dir,
> diff --git a/meson.build b/meson.build
> index 6408ad442ea..3c07e75dbd5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -679,6 +679,14 @@ if get_option('werror')
>    SPHINX_ARGS += [ '-W' ]
>  endif
>  
> +sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
> +                        meson.source_root() / 'docs/sphinx/hxtool.py',
> +                        meson.source_root() / 'docs/sphinx/kerneldoc.py',
> +                        meson.source_root() / 'docs/sphinx/kernellog.py',
> +                        meson.source_root() / 'docs/sphinx/qapidoc.py',
> +                        meson.source_root() / 'docs/sphinx/qmp_lexer.py',
> +                        qapi_gen_depends ]
> +
>  # Collect sourcesets.
>  
>  util_ss = ss.source_set()

I touched docs/sphinx/qapidoc.py and the manual got rebuilt.  Good.

Same for scripts/qapi/gen.py.  Good, except it makes me disbelieve your
claim "we don't change the extensions all that often."

Any ideas beyond amending the commit message with something like "except
for the QAPI guys, pity the fools"?  ;)


