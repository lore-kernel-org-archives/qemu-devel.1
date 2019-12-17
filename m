Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67CEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B7821835
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxZ2tU7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B7821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihG6f-0008QQ-Jy
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihG0Z-00008C-Ni
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihG0V-0003Aj-Hm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:47:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihG0U-0003AA-AU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576601253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TyMfOmVwxZHG0er0HbkabROkpDlIzP2fMhLhONe7t/Y=;
 b=CxZ2tU7NrFzYk7KokanKllkvijk46ziMV8qsOOKIGtX3lrh7ov2DPNCrAJv6stSK1ryAZ6
 uZcfEukKaxquM0aqfwQp1BzD1X0/zBmtBkb0nreHFxbOHByPzxyN8DxoU2yYbpUdXWM4kb
 3BREI8VaxILdIBEFL5VA9O2NpHPq4nE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-2QsDyCCmPvyAsvzDOc3MYg-1; Tue, 17 Dec 2019 11:47:32 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B07C5107ACCA;
 Tue, 17 Dec 2019 16:47:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-149.ams2.redhat.com [10.36.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A37B6B566;
 Tue, 17 Dec 2019 16:47:27 +0000 (UTC)
Subject: Re: [PATCH v2] docs: build an index page for the HTML docs
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191111102157.440664-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <22747677-3ea5-b0f3-aaa8-20d501364d7d@redhat.com>
Date: Tue, 17 Dec 2019 17:47:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111102157.440664-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2QsDyCCmPvyAsvzDOc3MYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/2019 11.21, Stefan Hajnoczi wrote:
> There is no index.html start page for the QEMU HTML documentation.  An
> index page is needed so that documentation can be browsed easily on the
> web.
> 
> This patch adds an index.html.in template file where the QEMU version
> number is expanded.  It is written in HTML instead of using the existing
> sphinx (rST) and texi documentation generators because they are
> heavyweight and would make this harder.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile           |  6 ++++++
>  docs/index.html.in | 17 +++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 docs/index.html.in
> 
> diff --git a/Makefile b/Makefile
> index aa9d1a42aa..581bc68918 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -347,6 +347,7 @@ DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/
>  DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
>  DOCS+=docs/qemu-block-drivers.7
>  DOCS+=docs/qemu-cpu-models.7
> +DOCS+=$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
>  DOCS+=fsdev/virtfs-proxy-helper.1
>  endif
> @@ -818,6 +819,7 @@ install-sphinxdocs: sphinxdocs
>  
>  install-doc: $(DOCS) install-sphinxdocs
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
> +	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
> @@ -1024,6 +1026,10 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
>  $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
>  	$(call build-manual,interop,man)
>  
> +$(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
> +	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
> +             "GEN","$@")
> +
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< > $@,"GEN","$@")
>  
> diff --git a/docs/index.html.in b/docs/index.html.in
> new file mode 100644
> index 0000000000..c2df85a185
> --- /dev/null
> +++ b/docs/index.html.in
> @@ -0,0 +1,17 @@
> +<!DOCTYPE html>
> +<html>

https://validator.w3.org/ says:

"Warning: Consider adding a lang attribute to the html start tag to
declare the language of this document."

... it's just a warning though, but in case you respin, you might want
to add it.

> +    <head>
> +        <meta charset="UTF-8">
> +        <title>QEMU @@VERSION@@ Documentation</title>
> +    </head>
> +    <body>
> +        <h1>QEMU @@VERSION@@ Documentation</h1>
> +        <ul>
> +            <li><a href="qemu-doc.html">User Documentation</a></li>
> +            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
> +            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
> +            <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
> +            <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
> +        </ul>
> +    </body>
> +</html>
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


