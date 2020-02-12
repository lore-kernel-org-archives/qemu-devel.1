Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D5C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2FE206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idrC24WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2FE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sNN-0005IF-Pr
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1sIJ-0006CE-As
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1sIH-0003YC-TM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1sIH-0003Xf-QK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5J1NmlKT51UIPJrGuRotD396iRbfSlhQwifrmbpGGqs=;
 b=idrC24WFldIF1+vwVWQ59g6nCacmBMEHVQzXPjS5Kzr8tJqO38mIdkWvpGy+ZMufqPsS4V
 GMSazs3/39bYw0j53PnHZQt6x06qk8k7UV0Q/N/6O76kFC/eXxM8/+6ZtvkLx+4Yn5rF4w
 RkdYvG8orwkTfhYJ8IfAJmkkOpiT8so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-CH3gFwC2P06gcXqj6SxJIg-1; Wed, 12 Feb 2020 08:43:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77615DBA6;
 Wed, 12 Feb 2020 13:43:04 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD02360499;
 Wed, 12 Feb 2020 13:43:02 +0000 (UTC)
Message-ID: <30f453121830b64c752e384e1a1ed546ffb557a7.camel@redhat.com>
Subject: Re: [PATCH] nbd-client: Support leading / in NBD URI
From: Maxim Levitsky <mlevitsk@redhat.com>
To: =?ISO-8859-1?Q?J=E1n?= Tomko <jtomko@redhat.com>, Eric Blake
 <eblake@redhat.com>
Date: Wed, 12 Feb 2020 15:42:51 +0200
In-Reply-To: <20200212133304.GC2893@lpt>
References: <20200212023101.1162686-1-eblake@redhat.com>
 <20200212133304.GC2893@lpt>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CH3gFwC2P06gcXqj6SxJIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, "open
 list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-02-12 at 14:33 +0100, J=C3=A1n Tomko wrote:
> On Tue, Feb 11, 2020 at 08:31:01PM -0600, Eric Blake wrote:
> > The NBD URI specification [1] states that only one leading slash at
> > the beginning of the URI path component is stripped, not all such
> > slashes.  This becomes important to a patch I just proposed to nbdkit
> > [2], which would allow the exportname to select a file embedded within
> > an ext2 image: ext2fs demands an absolute pathname beginning with '/',
> > and because qemu was inadvertantly stripping it, my nbdkit patch had
> > to work around the behavior.
> >=20
> > [1] https://github.com/NetworkBlockDevice/nbd/blob/master/doc/uri.md
> > [2] https://www.redhat.com/archives/libguestfs/2020-February/msg00109.h=
tml
> >=20
> > Note that the qemu bug only affects handling of URIs such as
> > nbd://host:port//abs/path (where '/abs/path' should be the export
> > name); it is still possible to use --image-opts and pass the desired
> > export name with a leading slash directly through JSON even without
> > this patch.
> >=20
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> > block/nbd.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
>=20
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
>=20
> Jano
Note that I had a bug open for this.
https://bugzilla.redhat.com/show_bug.cgi?id=3D1728545

I expected this to be a feature to be honest,
and was afraid to break existing users that might rely on this.

Best regards,
=09Maxim Levitsky


