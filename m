Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C0C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4398206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjDpR1Cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4398206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTQR-0007lY-VT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iXTLg-0001qw-Gb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iXTLe-0005pq-33
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:00:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iXTLd-0005ir-Jx
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574269256;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rd5HkD3ml5yNG/M7ZQmLsim6VSixuyr4ufTDPpy/GGg=;
 b=EjDpR1Cx+/4RTG1U2b9ynQBvtyh7arLwYfVHGu6t1yZ1ITlemi/ZIMMlN4dBLEi28t8Lg3
 I/IED4ePexCty9B14snb+17RjnUgSOnz8Tfd3BZOs0NASC5Gt1tIn8XkI4XosbI26V9/GB
 vkxKGAW2vEzsYxJ1ev5IPZttI/AqOnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-M6pX-w-IN967TW37GxUOdg-1; Wed, 20 Nov 2019 12:00:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00771DC45;
 Wed, 20 Nov 2019 17:00:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8856605C7;
 Wed, 20 Nov 2019 17:00:50 +0000 (UTC)
Date: Wed, 20 Nov 2019 17:00:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
Message-ID: <20191120170047.GN2785116@redhat.com>
References: <20191120125444.31365-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191120125444.31365-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: M6pX-w-IN967TW37GxUOdg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 04:54:44PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Following the discussion in thread "[PATCH v3 13/33] serial: start
> making SerialMM a sysbus device", I'd like to recommend the usage of
> "self" variable to reference to the OOP-style method instance, as
> commonly done in various languages and in GObject world.

Looking at glib codebase, I don't see 'self' used all that
widely or consistently - much of gio/ uses an abbreviation
of the object type as the variable name.

>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 427699e0e4..cb6635af71 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -102,12 +102,38 @@ Rationale:
>  Naming
>  =3D=3D=3D=3D=3D=3D
> =20
> -Variables are lower_case_with_underscores; easy to type and read.  Struc=
tured
> -type names are in CamelCase; harder to type but standing out.  Enum type
> -names and function type names should also be in CamelCase.  Scalar type
> -names are lower_case_with_underscores_ending_with_a_t, like the POSIX
> -uint64_t and family.  Note that this last convention contradicts POSIX
> -and is therefore likely to be changed.
> +Variables are lower_case_with_underscores; easy to type and read.
> +
> +The most common naming for a variable is an abbreviation of the type
> +name.  Some common examples:
> +
> +.. code-block:: c
> +
> +    Object *obj;
> +    QVirtioSCSI *scsi;
> +    SerialMM *smm;
> +
> +When writing QOM/OOP-style function, a "self" variable allows to refer
> +without ambiguity to the instance of the method that is being
> +implemented (this is not very common in QEMU code base, but it is
> +often a good option to increase the readability and consistency,
> +making further refactoring easier as well).  Example:

For me the first "sniff test" for a new coding style guideline is
whether QEMU actually follows the rule to any significant extent
already. If not, then I think the benefit would have to be very
significant to justify defining it as a rule. We've historically
be quite reluctant to do bulk updates of existing code to apply
new coding styles. Without planning a bulk update, you end up
with a coding style that is followed by 1% of the code and ignored
by the other 99%.

As noted above, the common case in QEMU is for the variable to be an
abbreviation of the type name. The number of places using "*self" is
almost single digits. So I think the idea of standardizing on "self"
is already questionable for QEMU.


I think the reason for the current pattern of abbreviated type name
is that when we're inventing OOP features in C the impl of inheritance
is always sub-optimal, such that you frequently find a need to cast to
parent types.  So in any single method it is common to have multiple
variables all refering to the object "self", each cast to a different
type. To pick one simple example

    QIOChannelFile fioc =3D qio_channel_file_new(...)
    QIOChannel *ioc =3D QIO_CHANNEL(fioc)
    Object *obj =3D OBJECT(fioc)

    qio_channel_read_all(ioc, buf, len, erro);
    object_unref(obj);


I think that using the object type abbreviation for the variable name
is a good thing.  Arbitrarily picking "self" for one of those variables
is unhelpful, as you have to then look back to the declaration of "self"
to remind yourself whether "self" is an QOIChannelFile or a QIOChannel
or an Object.


Constrast with C++ / Java, where I think the use of "self" is a good
thing, because the language has built-in  OOP concepts, such that
you can call a method on any parent class without having to first
cast "self" to the parent type. IOW, in those languages you don't
have to care about the particular types in the class hierarchy when
operating on "self".  This isn't true of C / QEMU's QOM.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


