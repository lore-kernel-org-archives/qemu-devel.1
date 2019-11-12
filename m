Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25310C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43DA21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnL3Hy1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43DA21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT27-0001Ih-4k
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iUT0y-0000Ky-JH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iUT0v-0001VZ-Ny
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:03:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iUT0u-0001VC-UE
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573552988;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEDxfOCECsOU6yR8VVeFKkQgLNRhacxG+v9Z9i4GeO4=;
 b=cnL3Hy1G2KHa/F81XYDVDMeL9uAatngQNvuf2Ap+D0XJNXXMzVrwTw15UbwlRvnarHRbfb
 sYhr0AfexYPfzOklnmOtzvRr8U22UCgxLDKc+x1tbkEso9DzGjpCF/Ajq7PdHnGa5UNSWW
 yDdEV6mVjJeDsyawHoRP3O9fplY/mis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-5y5cqkCqPnW-hLlmSOaVNQ-1; Tue, 12 Nov 2019 05:03:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7229F1800D63;
 Tue, 12 Nov 2019 10:03:01 +0000 (UTC)
Received: from redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DBB33DB2;
 Tue, 12 Nov 2019 10:02:56 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:02:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: API definition for LUKS key management
Message-ID: <20191112100253.GM2366658@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5y5cqkCqPnW-hLlmSOaVNQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 John Ferlan <jferlan@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 05:58:20PM +0200, Maxim Levitsky wrote:
> I will try to explain the interface with bunch of examples:

I want to fill in equiv examples from cryptsetup for sake
of comparison

> # adds a new password, defined by qemu secret 'sec0' to first unused slot
> # give user a error if all keyslots are occupied
> qemu-img amend --secret ... -o key-secret=3Dsec1 image.luks

  cryptsetup luksAddKey --key-file currentkey.txt \
                        --new-key-file newkey.txt \
                        /dev/mapper/foo

> # erases all keyslots that can be opened by password that is contained in=
 a qemu secret 'sec0'
> # active=3Doff means that the given password/keyslot won't be active afte=
r the operation
> qemu-img amend --secret ... -o key-secret=3Dsec0,active=3Doff image.luks


  cryptsetup luksRemoveKey --key-file currentkey.txt \
                           /dev/mapper/foo

> # erase the slot 5 (this is more low level command, less expected to be u=
sed)
> qemu-img amend --secret ... -o slot=3D5,active=3Doff image.luks

  cryptsetup luksKillSlot /dev/mapper/foo 5

> # add new secret to slot 5 (will fail if the slot is already marked as ac=
tive)
> qemu-img amend --secret ... -o slot=3D5,key-secret=3Dsec1 image.luks

  cryptsetup luksAddKey --key-file currentkey.txt \
                        --new-key-file newkey.txt \
=09=09=09--key-slot 5 \
                        /dev/mapper/foo

They look very different in syntax because they are taking two differnet
approaches.

The cryptsetup approach is functional, where the user states what action
they want performed.

The qemu-img amend approach is declarative, where the user expresses what
end state they want the image to be in.

The challenge is that the qemu-img proposal isn't fully declarative as
we are only partially expressing the end state, attempting to leave other
slots unspecified. This is good as it means we don't have to specify a
huge amount of data on the CLI. This is bad as makes it less obvious
what actual effects of the commands will be and I feel users will end
up needing to read the manual every time to re-learn it.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


