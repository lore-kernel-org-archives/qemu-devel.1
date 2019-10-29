Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035FCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02AD421721
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 21:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaA+hnNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02AD421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPZWh-0001GT-1D
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 17:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iPZVO-0000bx-NP
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iPZVM-00018F-C7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:58:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iPZVM-00015c-29
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 17:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572386299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gAO6Tz/JyzfIA64BHp5YtN9WwYWVKH0/WTW8U4S+REQ=;
 b=eaA+hnNLOVxp3cRKUUpUesCseVbKxUcUaXBCBikks+vtgNWO1e5wuH+9FXTBUhaxoSoEBX
 QIcSmE1bscEtqyzV7gT02nDTqJRupy+T5kSdyZTh1hCYah6qczj0jOXvuzBlK9z0uu1PBS
 kYfxJUOahJvPHsEIZA+YngHEfxChPJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-l5XuWCsUPHubNivrzUZcDA-1; Tue, 29 Oct 2019 17:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 955191005500;
 Tue, 29 Oct 2019 21:58:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D37C5C1D8;
 Tue, 29 Oct 2019 21:58:06 +0000 (UTC)
Date: Tue, 29 Oct 2019 17:58:04 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/16] Python (acceptance tests) queue, 2019-10-28
Message-ID: <20191029215804.GA10923@localhost.localdomain>
References: <20191028235002.17691-1-crosa@redhat.com>
 <CAFEAcA9_ycm2nyJeAR-Y43VT6o6zkrUykNXJPQKYv8os107_wg@mail.gmail.com>
 <20191029215118.GA10535@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191029215118.GA10535@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: l5XuWCsUPHubNivrzUZcDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 05:51:28PM -0400, Cleber Rosa wrote:
> On Tue, Oct 29, 2019 at 09:13:45PM +0000, Peter Maydell wrote:
> > On Mon, 28 Oct 2019 at 23:50, Cleber Rosa <crosa@redhat.com> wrote:
> > >
> > > The following changes since commit aaffb853359829a37daaf883c773e8320b=
55c723:
> > >
> > >   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019=
-10-28' into staging (2019-10-28 14:40:01 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/clebergnu/qemu.git tags/python-next-pull-request
> > >
> > > for you to fetch changes up to efdb45bfd72745038909dfd1e970a827cb8d5d=
7e:
> > >
> > >   tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu (2019-10-2=
8 19:04:04 -0400)
> > >
> > > ----------------------------------------------------------------
> >=20
> > Hi; unless my scripts are driving gpg wrong, this seems to
> > have been signed with an expired gpg key:
> >=20
> > gpg: Signature made Mon 28 Oct 2019 23:43:11 GMT
> > gpg:                using RSA key 7ABB96EB8B46B94D5E0FE9BB657E8D33A5F20=
9F3
> > gpg: Good signature from "Cleber Rosa <crosa@redhat.com>" [expired]
> > gpg: Note: This key has expired!
> > Primary key fingerprint: 7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 =
09F3
> >=20
> >=20
> > thanks
> > -- PMM
>=20
> Hi Peter,
>=20
> Nothing wrong with your scripts.  I updated my key about a week ago,
> but I'm almost certain that the key servers that I sent it to was
> acting funky.
>=20
> After some further pushes, I see it on:
>=20
>   http://keys.gnupg.net/pks/lookup?op=3Dvindex&fingerprint=3Don&search=3D=
0x657E8D33A5F209F3
>=20
> ---
>=20
> Search results for '0x657e8d33a5f209f3'
> Type bits/keyID     cr. time   exp time   key expir
> pub  4096R/A5F209F3 2014-10-16           =20
> =09 Fingerprint=3D7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3=20
>=20
> uid Cleber Rosa <crosa@redhat.com>
> sig  sig3  A5F209F3 2014-10-16 __________ 2019-10-15 [selfsig]
> sig  sig   7657B59A 2014-10-16 __________ __________ Rud=E1 Moura <rmoura=
@redhat.com>
> sig  sig   2527436A 2019-03-05 __________ __________ Eric Blake <eblake@r=
edhat.com>
> sig  sig   984DC5A6 2019-03-06 __________ __________ Eduardo Habkost <eha=
bkost@redhat.com>
> sig  sig3  96799EF4 2019-03-06 __________ __________ Bandan Das <bsd@redh=
at.com>
> sig  sig3  A5F209F3 2019-10-22 __________ 2024-10-20 [selfsig]
>=20
> sub  4096R/5B75AD33 2014-10-16           =20
> sig sbind  A5F209F3 2014-10-16 __________ 2019-10-15 []
> sig sbind  A5F209F3 2019-10-22 __________ 2024-10-20 []
>=20
> ---
>=20
> And with a fresh environment:
>=20
>   $ podman run --rm -ti fedora:30
>   [root@afba6c046a22 /]# gpg --search-key 657E8D33A5F209F3
>   gpg: directory '/root/.gnupg' created
>   gpg: keybox '/root/.gnupg/pubring.kbx' created
>   gpg: data source: https://51.38.91.189:443
>   (1)     Cleber Rosa <crosa@redhat.com>
>             4096 bit RSA key 657E8D33A5F209F3, created: 2014-10-16, expir=
es: 2024-10-20
>   Keys 1-1 of 1 for "657E8D33A5F209F3".  Enter number(s), N)ext, or Q)uit=
 > 1
>   gpg: key 657E8D33A5F209F3: 4 signatures not checked due to missing keys
>   gpg: /root/.gnupg/trustdb.gpg: trustdb created
>   gpg: key 657E8D33A5F209F3: public key "Cleber Rosa <crosa@redhat.com>" =
imported
>   gpg: no ultimately trusted keys found
>   gpg: Total number processed: 1
>   gpg:               imported: 1
>=20
> ---
>=20
> So I guess "all" you'd need is a refresh.  Sorry for the inconvenience,
> and let me know if there's anything else I can do.
>=20
> - Cleber.

OK, so now I don't see the updated key anymore on the public key servers,
which confirms that I'm doing something wrong.

I'm trying to fix that situation.  Sorry for the inconvenience again.

- Cleber.


