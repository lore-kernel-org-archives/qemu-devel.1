Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD466C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AE72074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AE72074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBb6-0001cZ-Qk
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEBa2-000177-ET
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:16:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEBZw-0002wY-VC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:16:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-0DSHmIvHMuWQ6a06fMsBLg-1; Fri, 04 Sep 2020 09:16:30 -0400
X-MC-Unique: 0DSHmIvHMuWQ6a06fMsBLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7030D4236C;
 Fri,  4 Sep 2020 13:16:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 409797E41A;
 Fri,  4 Sep 2020 13:16:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCCAD1132B59; Fri,  4 Sep 2020 15:16:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
Date: Fri, 04 Sep 2020 15:16:27 +0200
In-Reply-To: <20200810195019.25427-11-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Aug 2020 20:50:09 +0100")
Message-ID: <875z8t7kd0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
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

I'll miss the plain text output (I may get by with formatting the man
output, but even if that works, it's still an extra step).  Others may
miss the index.  Oh well, march of progress.

> As the GA ref is now part of the Sphinx 'interop' manual,
> we can delete the direct link from index.html.in.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
[...]
> diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
> new file mode 100644
> index 00000000000..013eac0bb53
> --- /dev/null
> +++ b/docs/interop/qemu-ga-ref.rst
> @@ -0,0 +1,4 @@
> +QEMU Guest Agent Protocol Reference
> +===================================
> +
> +.. qapi-doc:: qga/qapi-schema.json
> diff --git a/docs/interop/qemu-ga-ref.texi b/docs/interop/qemu-ga-ref.texi
> deleted file mode 100644
> index ddb76ce1c2a..00000000000
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

Does the interop manual carry an equivalent copyright notice?

[...]
> diff --git a/Makefile b/Makefile
> index 13dd708c4af..f0cca10b427 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -371,7 +371,7 @@ DOCS+=$(MANUAL_BUILDDIR)/tools/virtiofsd.1
>  endif
>  DOCS+=$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
> -DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
> +DOCS+=$(MANUAL_BUILDDIR)/interop/qemu-ga-ref.7
>  DOCS+=$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
>  DOCS+=$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
> @@ -800,11 +800,11 @@ distclean: clean
>  	rm -f config.log
>  	rm -f linux-headers/asm
>  	rm -f docs/version.texi
> -	rm -f docs/interop/qemu-ga-qapi.texi docs/interop/qemu-qmp-qapi.texi
> -	rm -f docs/interop/qemu-qmp-ref.7 docs/interop/qemu-ga-ref.7
> -	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
> -	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
> -	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
> +	rm -f docs/interop/qemu-qmp-qapi.texi
> +	rm -f docs/interop/qemu-qmp-ref.7
> +	rm -f docs/interop/qemu-qmp-ref.txt
> +	rm -f docs/interop/qemu-qmp-ref.pdf
> +	rm -f docs/interop/qemu-qmp-ref.html
>  	rm -rf .doctrees
>  	$(call clean-manual,devel)
>  	$(call clean-manual,interop)

Please update .gitignore. as well.

[...]

Comments apply to the next patch, too.


