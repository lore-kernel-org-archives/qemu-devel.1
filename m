Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F96C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D07F2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 19:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtfENR7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D07F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir5rb-0005XA-Ch
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 14:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ir5qc-0004p6-NS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ir5qa-00033o-FS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:58:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ir5qa-00032j-AE
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 14:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578945479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbndXZpoO8HAllO+g0klmbe7ZbTL7NNKLfYKWpgwpds=;
 b=KtfENR7BUiL+WGek4IXF4WkcUekQacQWYIVu5PxQS/rv0RjyxjTEcI1lWTkmRf+dIaTQv0
 oA1dhPUUAw+Z47jfQqyR5T+6ICmyO9YXOZRSHLkjySOlsPYBLRUkw3V1sfD7qTI5Y00vJx
 gZ1RlJWVtWXCagd1EP2C3c2GyJYz0kY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-BkGO9OmoPhCq4NtDx5d4xQ-1; Mon, 13 Jan 2020 14:57:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8763DBCB;
 Mon, 13 Jan 2020 19:57:55 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9434C60BF4;
 Mon, 13 Jan 2020 19:57:53 +0000 (UTC)
Subject: Re: [PATCH] qemu-nbd: Convert invocation documentation to rST
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200113180812.3442-1-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2b20b548-fb1f-2663-3614-03306595e5d7@redhat.com>
Date: Mon, 13 Jan 2020 13:57:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113180812.3442-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BkGO9OmoPhCq4NtDx5d4xQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/13/20 12:08 PM, Peter Maydell wrote:
> The qemu-nbd documentation is currently in qemu-nbd.texi in Texinfo
> format, which we present to the user as:
>   * a qemu-nbd manpage
>   * a section of the main qemu-doc HTML documentation
> 
> Convert the documentation to rST format, and present it to the user as:
>   * a qemu-nbd manpage
>   * part of the interop/ Sphinx manual
> 
> This follows the same pattern as commit 27a296fce982 did for the
> qemu-ga manpage.
> 

I'm not an rST expert, but trust that you compared the resulting 
renderings.  Is there a quick recipe for doing the build locally so I 
can easily inspect local artifacts myself?

> All the content of the old manpage is retained, except that I have
> dropped the "This is free software; see the source for copying
> conditions.  There is NO warranty..." text that was in the old AUTHOR
> section; Sphinx's manpage builder doesn't expect that much text in
> the AUTHOR section, and since none of our other manpages have it it
> seems easiest to delete it rather than try to figure out where else
> in the manpage to put it.

Reasonable.

> 
> The only other textual change is that I have had to give the
> --nocache option its own description ("Equivalent to --cache=none")
> because Sphinx doesn't have an equivalent of using item/itemx
> to share a description between two options.
> 
> Some minor aspects of the formatting have changed, to suit what is
> easiest for Sphinx to output. (The most notable is that Sphinx
> option section option syntax doesn't support '--option foo=bar'
> with bar underlined rather than bold, so we have to switch to
> '--option foo=BAR' instead.)

All fine by me.  If the resulting docs are more consistent between tools 
as a result of normalizations like this, it is a win.

> 
> The contents of qemu-option-trace.texi are now duplicated in
> docs/interop/qemu-option-trace.rst.inc, until such time as we complete
> the conversion of the other files which use it; since it has had only
> 3 changes in 3 years, this shouldn't be too awkward a burden.
> (We use .rst.inc because if this file fragment has a .rst extension
> then Sphinx complains about not seeing it in a toctree.)

Yes, that's fair for the short-term.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Another step forward for https://wiki.qemu.org/Features/Documentation
> (this is part of step 3 in the 'transition plan').
> [A
> ---

> +++ b/Makefile
> @@ -338,7 +338,7 @@ MANUAL_BUILDDIR := docs
>   endif
>   
>   ifdef BUILD_DOCS
> -DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
> +DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8

Worth splitting this long line, either with \-newline, or

>   DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
>   DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7

with additional DOCS+= lines?


> @@ -1005,7 +1005,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index
>   # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
>   build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>   # We assume all RST files in the manual's directory are used in it
> -manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
> +manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py

Another long line.

> +++ b/MAINTAINERS
> @@ -2503,6 +2503,7 @@ F: include/block/nbd*
>   F: qemu-nbd.*
>   F: blockdev-nbd.c
>   F: docs/interop/nbd.txt
> +F: docs/interop/qemu-nbd.rst
>   T: git https://repo.or.cz/qemu/ericb.git nbd

Would I be taking this patch through my NBD tree, or would you be 
bundling it with other doc patches?

> +++ b/docs/interop/qemu-nbd.rst
> @@ -0,0 +1,263 @@

> +.. option:: -s, --snapshot
> +
> +  Use *filename* as an external snapshot, create a temporary
> +  file with ``backing_file=``\ *filename*, redirect the write to
> +  the temporary one.

Pre-existing poor grammar. Better might be:

Use *filename* as an external snapshot, by creating a temporary file 
with ``backing_file=``\ *filename*, and redirecting writes to the 
temporary file.

But that could also be done as a separate patch, to keep this one as 
mechanical as possible on the conversion.

> +
> +.. option:: -l, --load-snapshot=SNAPSHOT_PARAM
> +
> +  Load an internal snapshot inside *filename* and export it
> +  as an read-only device, SNAPSHOT_PARAM format is

Similarly, s/an/a/


> +
> +Serve a read-only copy of just the first MBR partition of a guest
> +image over a Unix socket with as many as 5 simultaneous readers, with
> +a persistent process forked as a daemon:
> +
> +::
> +
> +  qemu-nbd --fork --persistent --shared=5 --socket=/path/to/sock \
> +    --partition=1 --read-only --format=qcow2 file.qcow2

Hmm - this example uses the deprecated --partition. And it was 
deprecated in 4.0.0. So 5.0 is a reasonable time to just nuke that code, 
and therefore this example - but as a separate patch (rather than 
touching up this example to use the spelling suggested in 
qemu-deprecated.texi).

> +
> +Expose the guest-visible contents of a qcow2 file via a block device
> +/dev/nbd0 (and possibly creating /dev/nbd0p1 and friends for
> +partitions found within), then disconnect the device when done.
> +Access to bind qemu-nbd to an /dev/nbd device generally requires root

s/an/a/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


