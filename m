Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF0EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B947A2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxrWl/F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B947A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kO5-00029t-0F
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j8kNR-0001dV-3G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j8kNP-0003OL-PF
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:40:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48671
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j8kNP-0003Nw-Kk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583152850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUsoMonTprETmrs8Z1eSIRtccI37lLV5R8rutzxcF/I=;
 b=bxrWl/F5MUJE8ZmvaeJSECKrPiYqApmquaRkZmr/uTjt70KMY18IqhwuDHMXnGjwAWRm+j
 wpsnTfcQLMqY6mQ+VFex9SBvgh3ul60KTmmF/VdKArHz+N7k4QSwOAak3wohHfDDHxAzeg
 GLUncSKY1vKCBC2+NlLG52ikTKoesyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-zZ8E7ElEMoeXzxwaFj1Bgw-1; Mon, 02 Mar 2020 07:40:47 -0500
X-MC-Unique: zZ8E7ElEMoeXzxwaFj1Bgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3181C13E5;
 Mon,  2 Mar 2020 12:40:46 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1EF25DA2C;
 Mon,  2 Mar 2020 12:40:45 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 2466D3E0489; Mon,  2 Mar 2020 13:40:44 +0100 (CET)
Date: Mon, 2 Mar 2020 13:40:44 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 14/33] docs: Create defs.rst.inc as a place to define
 substitutions
Message-ID: <20200302124044.GV24572@paraplu>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-15-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200228153619.9906-15-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 03:36:00PM +0000, Peter Maydell wrote:
> Rather than accumulating generally useful rST substitution
> definitions in individual rST files, create a defs.rst.inc where we
> can define these.  To start with it has the |qemu_system| definition
> from qemu-block-drivers.rst.
>=20
> Add a comment noting a pitfall where putting literal markup in the
> definition of |qemu_system| makes it misrender manpage output; this
> means the point-of-use must handle the literal markup (which is
> almost always done by having it inside a parsed-literal block).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

> ---
>  Makefile                           |  1 +
>  docs/conf.py                       |  6 ++++++
>  docs/defs.rst.inc                  | 11 +++++++++++
>  docs/system/qemu-block-drivers.rst |  2 --
>  4 files changed, 18 insertions(+), 2 deletions(-)
>  create mode 100644 docs/defs.rst.inc
>=20
> diff --git a/Makefile b/Makefile
> index 7e60a435426..26bbd334438 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1052,6 +1052,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
>  build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" $(SPHI=
NX_BUILD) $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D release=3D"$(F=
ULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 =
,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>  # We assume all RST files in the manual's directory are used in it
>  manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
> +              $(SRC_PATH)/docs/defs.rst.inc \
>                $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
>  # Macro to write out the rule and dependencies for building manpages
>  # Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,ext=
radeps])
> diff --git a/docs/conf.py b/docs/conf.py
> index 7588bf192ee..960043cb860 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -132,6 +132,12 @@ suppress_warnings =3D ["ref.option"]
>  # style document building; our Makefile always sets the variable.
>  confdir =3D os.getenv('CONFDIR', "/etc/qemu")
>  rst_epilog =3D ".. |CONFDIR| replace:: ``" + confdir + "``\n"
> +# We slurp in the defs.rst.inc and literally include it into rst_epilog,
> +# because Sphinx's include:: directive doesn't work with absolute paths
> +# and there isn't any one single relative path that will work for all
> +# documents and for both via-make and direct sphinx-build invocation.
> +with open(os.path.join(qemu_docdir, 'defs.rst.inc')) as f:

I didn't know about the above quirk; thanks for the explanatory comment.

> +    rst_epilog +=3D f.read()
> =20
>  # -- Options for HTML output -------------------------------------------=
---
> =20
> diff --git a/docs/defs.rst.inc b/docs/defs.rst.inc
> new file mode 100644
> index 00000000000..ae80d2f35d8
> --- /dev/null
> +++ b/docs/defs.rst.inc
> @@ -0,0 +1,11 @@
> +..
> +   Generally useful rST substitution definitions. This is included for
> +   all rST files as part of the epilogue by docs/conf.py.  conf.py
> +   also defines some dynamically generated substitutions like CONFDIR.
> +
> +   Note that |qemu_system| is intended to be used inside a parsed-litera=
l
> +   block: the definition must not include extra literal formatting with
> +   ``..``: this works in the HTML output but the manpages will end up
> +   misrendered with following normal text incorrectly in boldface.

Thanks for documenting the above bit here.  (I learnt about it from you
on IRC.)

> +.. |qemu_system| replace:: qemu-system-x86_64
> diff --git a/docs/system/qemu-block-drivers.rst b/docs/system/qemu-block-=
drivers.rst
> index 7ca890ea23a..bd99d4fa8eb 100644
> --- a/docs/system/qemu-block-drivers.rst
> +++ b/docs/system/qemu-block-drivers.rst
> @@ -3,8 +3,6 @@
>  QEMU block drivers reference
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =20
> -.. |qemu_system| replace:: qemu-system-x86_64
> -
>  Synopsis
>  --------
> =20
> --=20
> 2.20.1
>=20

--=20
/kashyap


