Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B75DC2BC73
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3296B2068E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tw5TwvBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3296B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQ77-000256-84
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icPwO-00071R-Qc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icPwF-0004CP-QD
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:23:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icPwF-00042T-Gc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575447788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=M7PLcuWzqR7A8JXPu5+TjG+etr9xv2YQOD7ko7JU46g=;
 b=Tw5TwvBNmvMwdVJYqeda5+cnTpqbWgn0d2BMwdE45zPcQmy9PlvZJNqEGyCjm9ShR9sY0w
 3LtuXnBBm1vEALih2IHv5zdl1o26+qX0GbU76v72RL8KU2Wdw09RDbjCZINgari141VXra
 OjKJ9tgz/CYQN/A0Ts1JyH4ogjODxyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-1XhqYje2O2u92dIYloJTAg-1; Wed, 04 Dec 2019 03:23:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B5EC800D5A;
 Wed,  4 Dec 2019 08:23:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D355119C68;
 Wed,  4 Dec 2019 08:23:03 +0000 (UTC)
Subject: Re: [PATCH] scripts: Fix undefinited name 'file' error for python3
To: Han Han <hhan@redhat.com>, qemu-trivial@nongnu.org
References: <20191113131655.307847-1-hhan@redhat.com>
 <CAHjf+S_miSm8ygAadObVnif1LKejA=j9OFae+OV5Oe-TedByyQ@mail.gmail.com>
 <CAHjf+S8LVAMjuvXNhE5MyAirpFE7NgUsn6YDHX7yLPgK4brW2g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1427d438-5d2a-7cc6-fd2c-c0fa95f229aa@redhat.com>
Date: Wed, 4 Dec 2019 09:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHjf+S8LVAMjuvXNhE5MyAirpFE7NgUsn6YDHX7yLPgK4brW2g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1XhqYje2O2u92dIYloJTAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/2019 07.48, Han Han wrote:
> Anyone help to review it?

 Hi!

When sending patches to the qemu-devel mailing list, please always make
sure to put the corresponding maintainers on CC:, otherwise your mails
might get lost in the high traffic of the mailing list. For this case,
it would have been good to CC: the "Migration" and "Python script"
maintainers, see the corresponding sections of the MAINTAINERS file in
the top most directory of the QEMU sources.

Anyway, it seems someone else ran into the same issue already, too, and
 it got already fixed here:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De8d0ac5801edda91412e5

  Thomas


> On Tue, Nov 26, 2019 at 1:54 PM Han Han <hhan@redhat.com
> <mailto:hhan@redhat.com>> wrote:
>=20
>     ping
>=20
>     On Wed, Nov 13, 2019 at 9:17 PM Han Han <hhan@redhat.com
>     <mailto:hhan@redhat.com>> wrote:
>=20
>         In python3, 'file' is no longer a keyword for file type object.
>         So it
>         will can error when run the scripts by python3:
>=20
>         $ python3 ./scripts/vmstate-static-checker.py -s 4.0.json -d
>         4.1.json
>         Traceback (most recent call last):
>         =C2=A0 File "./scripts/vmstate-static-checker.py", line 431, in <=
module>
>         =C2=A0 =C2=A0 sys.exit(main())
>         =C2=A0 File "./scripts/vmstate-static-checker.py", line 378, in m=
ain
>         =C2=A0 =C2=A0 parser.add_argument('-s', '--src', type=3Dfile, req=
uired=3DTrue,
>         NameError: name 'file' is not defined
>=20
>         Replace file type to argparse.FileType('r').
>=20
>         Signed-off-by: Han Han <hhan@redhat.com <mailto:hhan@redhat.com>>
>         ---
>         =C2=A0scripts/vmstate-static-checker.py | 4 ++--
>         =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
>         diff --git a/scripts/vmstate-static-checker.py
>         b/scripts/vmstate-static-checker.py
>         index d3467288..14f199a0 100755
>         --- a/scripts/vmstate-static-checker.py
>         +++ b/scripts/vmstate-static-checker.py
>         @@ -375,9 +375,9 @@ def main():
>         =C2=A0 =C2=A0 =C2=A0help_text =3D "Parse JSON-formatted vmstate d=
umps from QEMU
>         in files SRC and DEST.=C2=A0 Checks whether migration from SRC to
>         DEST QEMU versions would break based on the VMSTATE information
>         contained within the JSON outputs.=C2=A0 The JSON output is creat=
ed
>         from a QEMU invocation with the -dump-vmstate parameter and a
>         filename argument to it.=C2=A0 Other parameters to QEMU do not
>         matter, except the -M (machine type) parameter."
>=20
>         =C2=A0 =C2=A0 =C2=A0parser =3D argparse.ArgumentParser(descriptio=
n=3Dhelp_text)
>         -=C2=A0 =C2=A0 parser.add_argument('-s', '--src', type=3Dfile, re=
quired=3DTrue,
>         +=C2=A0 =C2=A0 parser.add_argument('-s', '--src',
>         type=3Dargparse.FileType('r'), required=3DTrue,
>         =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D'json dump from src qemu')
>         -=C2=A0 =C2=A0 parser.add_argument('-d', '--dest', type=3Dfile, r=
equired=3DTrue,
>         +=C2=A0 =C2=A0 parser.add_argument('-d', '--dest',
>         type=3Dargparse.FileType('r'), required=3DTrue,
>         =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D'json dump from dest qemu')
>         =C2=A0 =C2=A0 =C2=A0parser.add_argument('--reverse', required=3DF=
alse, default=3DFalse,
>         =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0action=3D'store_true',
>         --=20
>         2.23.0
>=20
>=20
>=20
> --=20
> Best regards,
> -----------------------------------
> Han Han
> Quality Engineer
> Redhat.
>=20
> Email: hhan@redhat.com <mailto:hhan@redhat.com>
> Phone: +861065339333


