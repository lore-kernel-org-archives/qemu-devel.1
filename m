Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF8C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCDE2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/9i1P1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCDE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kPw-00045e-Gh
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j8kP6-0003Ho-VX
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j8kP5-0004LP-JJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:42:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25765
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j8kP5-0004LL-De
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583152955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKBuXnpCgf/tFbuK7SnTY0CTULCUyE/bhjiuF4rGfV0=;
 b=P/9i1P1pHysG8pofeKJoe4kyJTuGmV/DtHJI0uszAYxPWW6Qes7E2KrxwOOmOUfDXavUPD
 A4cLMJwDgm1uRc6KyTipgaUi69zfYSLdeKUXCLj9KRpMyd7WACr4mgLvIQOYq2U40Tn6qJ
 yl13WfuvgRZr7eY+iOLvvmYH9LBopeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-ciwMdTZ-OFCRuU48ik8B9g-1; Mon, 02 Mar 2020 07:42:33 -0500
X-MC-Unique: ciwMdTZ-OFCRuU48ik8B9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A35E8017CC;
 Mon,  2 Mar 2020 12:42:32 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EA8A19C4F;
 Mon,  2 Mar 2020 12:42:32 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 11FA13E0489; Mon,  2 Mar 2020 13:42:30 +0100 (CET)
Date: Mon, 2 Mar 2020 13:42:29 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 32/33] docs: Remove old texinfo sources
Message-ID: <20200302124229.GW24572@paraplu>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-33-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200228153619.9906-33-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On Fri, Feb 28, 2020 at 03:36:18PM +0000, Peter Maydell wrote:
> We can now delete the old .texi files, which we have been keeping in
> the tree as a parallel set of documentation to the new rST sources.
> The only remaining use of Texinfo is the autogenerated manuals
> and HTML documents created from the QAPI JSON doc comments.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS                        |   5 +-
>  docs/system/build-platforms.texi   |  67 ----
>  docs/system/cpu-models-mips.texi   | 157 ----------
>  docs/system/cpu-models-x86.texi    | 482 -----------------------------
>  docs/system/deprecated.texi        | 377 ----------------------
>  docs/system/gdb.texi               |  71 -----
>  docs/system/images.texi            |  88 ------
>  docs/system/invocation.texi        | 240 --------------
>  docs/system/ivshmem.texi           |  60 ----
>  docs/system/keys.texi              |  43 ---
>  docs/system/license.texi           |   9 -
>  docs/system/linuxboot.texi         |  27 --
>  docs/system/managed-startup.texi   |  35 ---
>  docs/system/monitor.texi           |  34 --
>  docs/system/mux-chardev.texi       |  44 ---
>  docs/system/net.texi               |  96 ------
>  docs/system/qemu-option-trace.texi |  28 --
>  docs/system/quickstart.texi        |  12 -
>  docs/system/security.texi          | 167 ----------
>  docs/system/target-arm.texi        | 245 ---------------
>  docs/system/target-i386.texi       |  91 ------
>  docs/system/target-m68k.texi       |  25 --
>  docs/system/target-mips.texi       | 150 ---------
>  docs/system/target-ppc.texi        |  52 ----
>  docs/system/target-sparc.texi      |  68 ----
>  docs/system/target-sparc64.texi    |  38 ---
>  docs/system/target-xtensa.texi     |  35 ---
>  docs/system/tls.texi               | 329 --------------------
>  docs/system/usb.texi               | 115 -------
>  docs/system/vnc-security.texi      | 196 ------------
>  qemu-doc.texi                      | 201 ------------
>  31 files changed, 1 insertion(+), 3586 deletions(-)

Nice diff-stat; "negative code" for the win! :-)

(Yes, yes, we do add them back in a different form elsewhere...)


Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

--=20
/kashyap


