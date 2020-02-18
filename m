Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE1AC3403A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2AF2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdk5dEUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2AF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42Tx-0000bk-F1
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j42Fb-0000R9-H4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j42Fa-0002bX-7n
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:45:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j42Fa-0002b0-4b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvPMrqgbCH6xzcLVv+2ozwseNWKvasb6EywNstUiTMw=;
 b=Gdk5dEUUfMQBBhcceM9iop18tymuaQWMOC24fLTFQj4zYwKT7PmB8WAn8kphf2elCeoHa5
 0yQRbIe+HtjrzekrBGD3tofu0MiNtuOZdMnCSgfSTZ8MWLBgtDnhUxekLr6XN0bCfr6Yit
 QGir6q72JBrCrKkvc9R514iL5AJKsXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-hOvjQARFMkmVH-7HnQ3EqA-1; Tue, 18 Feb 2020 07:45:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB5D1005514;
 Tue, 18 Feb 2020 12:45:11 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 890EE60C87;
 Tue, 18 Feb 2020 12:45:09 +0000 (UTC)
Date: Tue, 18 Feb 2020 13:44:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/2] docs: rstfy vfio-ap documentation
Message-ID: <20200218134451.23c77b1f.cohuck@redhat.com>
In-Reply-To: <CAFEAcA8JQN8zDczCEarYxngEWsgQ84zCicmWBu=+E5vFe6U7Qg@mail.gmail.com>
References: <20200213162942.14177-1-cohuck@redhat.com>
 <20200213162942.14177-3-cohuck@redhat.com>
 <d0fb1979-7041-e21e-29f1-a38e3f2dd7e9@linux.ibm.com>
 <CAFEAcA8JQN8zDczCEarYxngEWsgQ84zCicmWBu=+E5vFe6U7Qg@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: hOvjQARFMkmVH-7HnQ3EqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 18:54:37 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 13 Feb 2020 at 18:38, Pierre Morel <pmorel@linux.ibm.com>
> wrote:> However it may be because I do not use the right tools.
> > Did not find which one I am suppose to use.
> > Currently using:
> > rst2latex vfio-ap.rst > vfio-ap.tex && pdflatex vfio-ap.tex  
> 
> The only supported way to build the docs is with Sphinx.
> 
> Option 1:
> 
> If you have the right versions of the tools installed
> then running "make" in the usual way will build HTML docs
> into the docs/ subdirectory of your build directory.
> Passing --enable-docs to configure will cause it to complain
> if you're missing a tool rather than silently not building
> the docs. This is what we expect most users to be doing.
> 
> Option 2:
> 
> You can run Sphinx 'manually' with something like
>  sphinx-build docs /tmp/sphinx-out
> which will build a single big fat manual into the
> specified output directory (here /tmp/sphinx-out).
> This option is provided mostly so that sites like
> 'readthedocs' can produce the documentation without having
> to run our Makefiles.
> 
> PDF is not an officially supported (by us) output format,
> but if you really want it you can generate it with
>  sphinx-build -b latex docs /tmp/sphinx-out
>  cd /tmp/sphinx-out
>  make
> which will generate a QEMU.pdf in /tmp/sphinx-out.
> 
> We're unlikely to want to make tweaks to the documentation
> sources to fix infelicities in the formatting of the PDF,
> though.

FWIW, using option 2 to produce a pdf seems to end up with something
decent-looking with these patches applied. (Lots of warnings from
LaTex, but that seems preexisting.)


