Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD96C3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557F522CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 17:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557F522CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Cbx-0000Cs-CN
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 13:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5Cb7-0007oe-KP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5Cb6-00050p-F5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:28:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5Cb6-00050D-9l
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 13:28:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D7A97300413D;
 Tue,  3 Sep 2019 17:28:02 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 044005D6B2;
 Tue,  3 Sep 2019 17:27:59 +0000 (UTC)
Date: Tue, 3 Sep 2019 14:27:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190903172758.GR3694@habkost.net>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
 <20190903150824.GA14836@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190903150824.GA14836@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 03 Sep 2019 17:28:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 11:08:24AM -0400, Cleber Rosa wrote:
> On Thu, Aug 29, 2019 at 11:46:15AM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> >=20
> > class avocado.utils.ssh.Session(address, credentials)
> >=20
> >   Parameters:=09
> >=20
> >     credentials (tuple)
> >          username and path to a key for authentication purposes
> >=20
> > The current test uses username + password.
> > Can we use this credentials with the Avocado module?
> > (The image used is prebuilt).
> >=20
>=20
> I'm working on adding password based authentication.  To keep the API
> the same, I'm thinking of checking if the second credential item is an
> existing file, if it is, assume one containing a key.  If not, assume
> it's a password.
>=20
> This should make the use simple in the case of keys:
>=20
>   with Session(('hostname', port),
>                ('username', '/path/to/key')) as session:
>       session.cmd('cmd')
>=20
> And passwords:
>=20
>   with Session(('hostname', port),
>                ('username', 'p@ssw0rD')) as session:
>       session.cmd('cmd')

This would stop working as soon as a file named 'p@ssw0rD' gets
created.  Can the API be more explicit somehow?

Is there anything that prevents us from using keyword arguments?
e.g.:

  Session(..., username=3D'root', password=3D'p@ssw0rD')

>=20
> It's being tracked here:
>   https://trello.com/c/uetpIgML/1517-avocadoutilssh-implement-password-=
based-auth
>=20
> I'll try to have it in Avocado's 72.0 release due next week.
>=20
> Let me know how that sounds, and thanks for the feedback.
> - Cleber.

--=20
Eduardo

