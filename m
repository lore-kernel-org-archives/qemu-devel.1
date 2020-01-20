Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA565C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721B6217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a35Ql7F5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721B6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXZG-0001Nt-JC
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1itXYc-0000m6-F2
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1itXYY-0005aO-SW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:57:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1itXYY-0005Zr-OO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579528649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJLrBNy1+PdxffzWL40NiG3sfvYGAQcLDPgW4OWfqJo=;
 b=a35Ql7F55tjno/i3hS/Cz+OZ1RNid2Ew4bzY4GKtLG6vWmAlz215E+VLpiLr8wqnc7GoY5
 nfhESqjgAfMnuRpuQXaZv4JWg7kkIqUJQzpcNSpBR4PzUZ3htOW8In8K1ePfAlm7h4enkp
 JM5UREUW22oinKMqdkXX6BbZN2xBR2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-abBUnD00PoeTfowzlYu64g-1; Mon, 20 Jan 2020 08:57:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5254018A8C80;
 Mon, 20 Jan 2020 13:57:27 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-251.ams2.redhat.com
 [10.36.116.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53E9D60C05;
 Mon, 20 Jan 2020 13:57:19 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 6912F3E0489; Mon, 20 Jan 2020 14:57:17 +0100 (CET)
Date: Mon, 20 Jan 2020 14:57:17 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200120135717.GC20791@paraplu>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20200102144722.GL121208@stefanha-x1.localdomain>
 <20200116110314.GA24159@paraplu>
 <20200120095554.GA345995@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200120095554.GA345995@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: abBUnD00PoeTfowzlYu64g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 09:55:54AM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 16, 2020 at 12:03:14PM +0100, Kashyap Chamarthy wrote:

[...]

> > I'm reasonably happy with it (particularly the persistent history
> > captured in ~/.qmp-shell_history), and it has some "known issues" that
> > can trip up a new user.  The one that immediately jumps to mind:
> > asynchronous events won't be printed without a prompt from the user --
> > e.g. after a `blockdev-commit`, you won't see BLOCK_JOB_{READY,
> > COMPLETED} events printed unless you manually hit enter from the
> > 'qmp-shell'.

[...]

> John and I discussed async events in the past.  qmp-shell currently uses
> the input() built-in function.  If we modify it with a
> select(2)/poll(2)-style function that monitors both stdin and the QMP
> socket then it could print QMP events as soon as they are received.
>=20
> There might be a nicer way of doing it, but pseudo-code for the idea is:
>=20
>   def input_with_events(prompt):
>       while True:
>           print(prompt, end=3D'', flush=3DTrue)
>           readable_files =3D select([sys.stdin, qmp_socket])
>           if qmp_socket in readable_files:
>               print_qmp_events()
>=20
>       # stdin is ready, read a line
>       return input()

Thanks for the suggestion.  The Python 'select' module[1] indeed seems
to provide access to select() and poll() Linux system calls.

[1] https://docs.python.org/3/library/select.html

--=20
/kashyap


