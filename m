Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9460DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E34B2469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEs379Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E34B2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7nZo-00023u-Gt
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7nZ6-0001Od-3e
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7nZ4-0003o4-Df
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:52:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54061
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7nZ4-0003ku-9c
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582926777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68swnIfBuQtwppgQHJ9zuYmbASxyKXn34Zr2qKEULZQ=;
 b=hEs379PibBVuLwf+jA5R9pBm5hfDKWpI+Fn+Vr+gKEbjjTdgkpj3C9BYtXP7+8BMzyPiG7
 npTZhYme+wuHZQah8yn8u7oU9w+0du42Kn3q2o/IZSkB2KQTTOSEL9K/nTTrdpsuAS6ewL
 Dfgr1p0WCC7Znn2KTVK24B+4ZdqtB2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-mjMeMdwYOCmLxpCpubdqBQ-1; Fri, 28 Feb 2020 16:52:55 -0500
X-MC-Unique: mjMeMdwYOCmLxpCpubdqBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97946801E67;
 Fri, 28 Feb 2020 21:52:54 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D29E60C18;
 Fri, 28 Feb 2020 21:52:54 +0000 (UTC)
Date: Fri, 28 Feb 2020 16:52:53 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 4/4] target/i386: Add notes for versioned CPU models
Message-ID: <20200228215253.GB494511@habkost.net>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-5-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200212081328.7385-5-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 04:13:28PM +0800, Tao Xu wrote:
> Add which features are added or removed in this version. Remove the
> changed model-id in versioned CPU models, to keep the model name
> unchanged at /proc/cpuinfo inside the VM.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v2:
>     - correct the note of Cascadelake v3 (Xiaoyao)
> ---
>  target/i386/cpu.c | 54 ++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 81a039beb6..739ef4ce91 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2278,10 +2278,9 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              {
>                  .version =3D 2,
>                  .alias =3D "Nehalem-IBRS",
> +                .note =3D "IBRS",
>                  .props =3D (PropValue[]) {
>                      { "spec-ctrl", "on" },
> -                    { "model-id",
> -                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)"=
 },
>                      { /* end of list */ }

Changing model-id is guest-visible, so we can't do this.  The
same applies to the other models where model-id is being removed.

I suggest using the .note property only on the CPU model versions
that don't have custom model-id set yet, or when existing
information on model-id is incomplete.

For future CPU model versions, we can start using only .note and
stop changing model-id.

--=20
Eduardo


