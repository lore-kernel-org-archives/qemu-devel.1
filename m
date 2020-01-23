Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E593621835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0fgRODA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E593621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuj3R-0006o1-2T
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iugQX-0005s9-EM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iugQW-0003Rz-9y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:37:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iugQW-0003RS-5q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579801075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wGmO6YBR71OibQ64YooA/A7r4z8iH4NhJle//Uq18Yk=;
 b=X0fgRODAbHiIML3J9JMr/P/Dnt5MQQePZZ4RmleOXdJSHolcupLqCE/Om4FD4qAR+pJZEK
 24RUKRj0OMxBiv9dXFMpARWw4+iJznGl0u+nj8H8t7eTf8r3KMitW/8QIo6cNLsdekb1KV
 VVICEMPF1NOCuqXTxapLk9dA/y2dEG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-NUS_HrbPNXGsvrNbejww9w-1; Thu, 23 Jan 2020 12:19:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA781854337;
 Thu, 23 Jan 2020 17:18:59 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-109.ams2.redhat.com [10.36.117.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 900323AE;
 Thu, 23 Jan 2020 17:18:58 +0000 (UTC)
Date: Thu, 23 Jan 2020 18:18:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Maintainers, please add Message-Id: when merging patches
Message-ID: <20200123171857.GC5021@linux.fritz.box>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <20200122122831.GB13482@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200122122831.GB13482@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NUS_HrbPNXGsvrNbejww9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.01.2020 um 13:28 hat Kevin Wolf geschrieben:
> Am 22.01.2020 um 13:02 hat Stefan Hajnoczi geschrieben:
> > Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag. =
 Hooray!
> >=20
> > Message-Id: references the patch email that a commit was merged from.
> > This information is helpful to anyone wishing to refer back to email
> > discussions and patch series.
> >=20
> > Please use git-am(1) -m/--message-id or set am.messageid in your git-co=
nfig(1).
>=20
> I've had -m in my scripts for a while (last time someone asked me to
> make the change, I guess), but it wasn't effective, because my .muttrc
> has 'set pipe_decode' enabled, which doesn't only decode the output, but
> also throws away most headers.
>=20
> I seem to remember that this was necessary at some point because
> otherwise some mails just wouldn't apply. Maybe 'git am' works better
> these days and can actually parse the mails that used to give me
> problems. I'll give it a try and disable pipe_decode.

Here is the first patch for which it failed for me:

Message-ID: <20200123124357.124019-1-felipe@nutanix.com>

The problem seems to be related to line endings because the patch that
git-apply sees eventually has "\r\n" whereas the file to be patched has
only "\n".

If I understand correctly (this is a bit of guesswork after reading man
pages and trying out a few options), git-mailsplit would normally get
rid of the "\r". However, this specific patch email is base64 encoded,
so the encoded "\r" characters survive this stage.

git-mailinfo later decodes the email, but doesn't seem to do anything
about "\r" again, so it survives this one as well. This means feeding a
patch with the wrong line endings to git-apply, which just fails.

Any suggestion how to fix this? (For this patch, I just enabled
pipe_decode again, so no Message-Id tag for it.)

Kevin


