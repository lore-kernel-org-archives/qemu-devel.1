Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB7C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DB32187F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUeIJMFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DB32187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSObe-0006m9-5z
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iSOaq-00065V-36
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iSOao-00060F-Tq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:55:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iSOao-0005zF-Qj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573059338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dylhWcoxyv77J3MhchLo5iYDxE7fIHdTxz3lad+Pwg=;
 b=dUeIJMFmEjde45C1qQdc+YVTJQNs0de6T3MutcQdIQAyp+XaLNB43lYHqCnDZY5/Y3F3+Z
 Ck/HdupW22nb85Kdy3nomNqaVdpSBrrrKIaCzL7TBUH+RL7XQUqzCfSGLDtF4qchFfKssO
 0KpLegofDlBZaEtRFHwRrWGWMvD1q/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-DIo13hcnP9WIwsW3W4ktgw-1; Wed, 06 Nov 2019 11:55:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F23C8017DD;
 Wed,  6 Nov 2019 16:55:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAD9F60BE0;
 Wed,  6 Nov 2019 16:55:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CA2211385C9; Wed,  6 Nov 2019 17:55:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] numa: Add missing \n to error message
References: <157304440026.351774.14607704217028190097.stgit@bahia.lan>
 <bb828956-28b3-9fe7-1d57-ceb723a32997@vivier.eu>
 <20191106151246.2bf44314@bahia.lan>
Date: Wed, 06 Nov 2019 17:55:32 +0100
In-Reply-To: <20191106151246.2bf44314@bahia.lan> (Greg Kurz's message of "Wed, 
 6 Nov 2019 15:12:46 +0100")
Message-ID: <875zjxosfv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DIo13hcnP9WIwsW3W4ktgw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-trivial@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Wed, 6 Nov 2019 14:01:01 +0100
> Laurent Vivier <laurent@vivier.eu> wrote:
>
>> Le 06/11/2019 =C3=A0 13:46, Greg Kurz a =C3=A9crit=C2=A0:
>> > If memory allocation fails when using -mem-path, QEMU is supposed to p=
rint
>> > out a message to indicate that fallback to anonymous RAM is deprecated=
. This
>> > is done with error_printf() which does output buffering. As a conseque=
nce,
>> > the message is only printed at the next flush, eg. when quiting QEMU, =
and
>> > it also lacks a trailing newline:
>> >=20
>> > qemu-system-ppc64: unable to map backing store for guest RAM: Cannot a=
llocate memory
>> > qemu-system-ppc64: warning: falling back to regular RAM allocation
>> > QEMU 4.1.50 monitor - type 'help' for more information
>> > (qemu) q
>> > This is deprecated. Make sure that -mem-path  specified path has suffi=
cient resources to allocate -m specified RAM amountgreg@boss02:~/Work/qemu/=
qemu-spapr$
>> >=20
>> > Add the missing \n to fix both issues.
>> >=20
>> > Fixes: cb79224b7e4b "deprecate -mem-path fallback to anonymous RAM"
>> > Signed-off-by: Greg Kurz <groug@kaod.org>
>> > ---
>> >  hw/core/numa.c |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/hw/core/numa.c b/hw/core/numa.c
>> > index 038c96d4abc6..e3332a984f7c 100644
>> > --- a/hw/core/numa.c
>> > +++ b/hw/core/numa.c
>> > @@ -503,7 +503,7 @@ static void allocate_system_memory_nonnuma(MemoryR=
egion *mr, Object *owner,
>> >              warn_report("falling back to regular RAM allocation");
>> >              error_printf("This is deprecated. Make sure that -mem-pat=
h "
>> >                           " specified path has sufficient resources to=
 allocate"
>> > -                         " -m specified RAM amount");
>> > +                         " -m specified RAM amount\n");
>> >              /* Legacy behavior: if allocation failed, fall back to
>> >               * regular RAM allocation.
>> >               */
>> >=20
>> >=20
>>=20
>> Why is this an error_printf() and not an error_report()?
>>=20
>
> Because CODING_STYLE suggests to do so I guess:
>
> Reporting errors to the human user
> ----------------------------------
>
> Do not use printf(), fprintf() or monitor_printf().  Instead, use
> error_report() or error_vreport() from error-report.h.  This ensures the
> error is reported in the right place (current monitor or stderr), and in
> a uniform format.
>
> Use error_printf() & friends to print additional information. <=3D=3D=3D

You're right.

Since I have nothing queued up right now, I'd prefer to have this go via
qemu-trivial.

> error_report() prints the current location.  In certain common cases
> like command line parsing, the current location is tracked
> automatically.  To manipulate it manually, use the loc_``*``() from
> error-report.h.


