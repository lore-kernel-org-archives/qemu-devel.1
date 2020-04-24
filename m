Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4229C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA4F20736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk7c9rOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA4F20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRy8v-0003FR-I0
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRy8L-0002iF-8d
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jRy8J-0008U9-VF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:12:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jRy8J-0008TL-EG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587733962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6fqFJgBORPTB9O6MUq8PiAI7T6mzf/CFOre8tg54TTI=;
 b=Nk7c9rOkM+NkevHrq7vhJQnLFfL7DH4nAx5BNjUpNnMh6lpKE2eRxzcZxDUOrtPJvtZQTM
 G6jdOirv2x/ld2BhNH1wE5Zsgg4V0e0fs5KyfINVc2SNLq0QscIUKhAVR+bHUuWsfaYblX
 fXV3+kzxyBV7F5+laZOwdeBjsEVQKb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393--ZmoXhS3MDyeTjl8IYKtlg-1; Fri, 24 Apr 2020 09:12:40 -0400
X-MC-Unique: -ZmoXhS3MDyeTjl8IYKtlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E90A9100CCC3;
 Fri, 24 Apr 2020 13:12:37 +0000 (UTC)
Received: from localhost (ovpn-114-136.ams2.redhat.com [10.36.114.136])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F10465D714;
 Fri, 24 Apr 2020 13:12:31 +0000 (UTC)
Date: Fri, 24 Apr 2020 14:12:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 08/36] multi-process: Add stub functions to
 facilitate build of multi-process
Message-ID: <20200424131230.GA190507@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <647fa5bf70dbea7d2b4e47d2084dea3a66385433.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <647fa5bf70dbea7d2b4e47d2084dea3a66385433.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2020 at 09:13:43PM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index f884bb6180..f74c7e927b 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -20,6 +20,7 @@ stub-obj-y += migr-blocker.o
>  stub-obj-y += change-state-handler.o
>  stub-obj-y += monitor.o
>  stub-obj-y += monitor-core.o
> +stub-obj-y += get-fd.o
>  stub-obj-y += notify-event.o
>  stub-obj-y += qtest.o
>  stub-obj-y += replay.o

audio.c, vl-stub.c, and xen-mapcache.c are added by this patch but not
added to Makefile.objs?  Can they be removed?

This entire patch requires justification.  Stubs exist so that common
code can be linked without optional features.

For example, common code may call into kvm but that callback isn't
relevant when building with kvm accelerator support (e.g. say qemu-nbd).
That's where the stub function comes in.  It fulfills the dependency
without dragging in the actual kvm accelerator code.

Adding lots of stubs suggests you are building QEMU in a new way that
wasn't done before (this is true and expected for this patch series).  I
would like to understand the reason for these stubs though.  For
example, why do you need to stub audio?

Without a reason for each of these stubs we have no way of knowing if
they are actually used/needed.  Maybe an earlier version of the code
needed it but the latest version of the patch no longer does...

Stefan

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6i5b4ACgkQnKSrs4Gr
c8juNQgAq64wlBIGOMN4s9CT3ywba11Yr0emHUdfffYTB5HuCrdk6jfuv29i0YUa
4hmQWixbB08pl7EVANkpR+tmwnuoLtWnQ7Y9FCCa/5fddHvnCGONnSA4vp81ZOcb
1MAUrAa+sQpBATf5Qt3GYBtNmy71NIuVnqtYLQgkTiO2AjiX4jq1pkh+IX4ynTdc
SbeXaEgLn++GSTEQT0pBJ9GtQ0II84fZTq2AWJvtLUqnuk0RtCoaGaOOO8Y1oYYK
dKAtTd1+Crh3PpxMup+e9Bvh0LCdgWocIeCtguiU3jXFGm2njqhkxRUDr5EUSFaJ
o3aMRA09akm9ZA4JdQWEL/3sKtdJCg==
=zoFE
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


