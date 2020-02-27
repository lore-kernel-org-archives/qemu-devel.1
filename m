Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AFC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9C524695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqAdlLfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9C524695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GqI-00040y-By
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j7GpR-0002rj-A5
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j7GpP-00065O-Vn
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:55:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j7GpP-000650-RT
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582800939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvu5MuC86moQeGsXQWIF/uKOA4LWvd7jChCLwCbMqu4=;
 b=FqAdlLfT1+9AOUcE62LF8ADHKvQ65yr37U8IaW8VDdmTPh3MWqdsSOss2PyZ0+DtWWRV77
 yxcMEtw8qSsm8pBpO5AozroxcIpXsWeqaBX5SOXKMeaaq/HBrZRQDPmyQCPI84Y7QGka3V
 YHd6oMKaKZyWW+Q8/4aS1GsywtkPX/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-3g1gwifZNAKPduA1GA3jDA-1; Thu, 27 Feb 2020 05:55:37 -0500
X-MC-Unique: 3g1gwifZNAKPduA1GA3jDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87918DB61;
 Thu, 27 Feb 2020 10:55:36 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4754A1001B09;
 Thu, 27 Feb 2020 10:55:30 +0000 (UTC)
Date: Thu, 27 Feb 2020 11:55:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
Message-ID: <20200227105528.GC7493@linux.fritz.box>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200219163815.GD1085125@stefanha-x1.localdomain>
 <CAJAkqrXaqmT2pR4K1x06AeQZHvUWp-fcqnbKZq_45czO96v5PA@mail.gmail.com>
 <20200227074114.GB83512@stefanha-x1.localdomain>
 <CAJAkqrWUJWLdT+6b_XmHFwnzhhbYei2SakCKVW0Rf92HJgoZDw@mail.gmail.com>
 <20200227100206.GA7493@linux.fritz.box>
 <CAJAkqrW_Euur3HjWaK6E-TAjT1dmjA1fz1oPwKSt7_pOC3=S+w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJAkqrW_Euur3HjWaK6E-TAjT1dmjA1fz1oPwKSt7_pOC3=S+w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: bharatlkmlkvm@gmail.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.02.2020 um 11:28 hat Coiby Xu geschrieben:
> > > we still need customized vu_message_read because libvhost-user assume=
s
> > > we will always get a full-size VhostUserMsg and hasn't taken care of
> > > this short read case. I will improve libvhost-user's vu_message_read
> > > by making it keep reading from socket util getting enough bytes. I
> > > assume short read is a rare case thus introduced performance penalty
> > > would be negligible.
>=20
> > In any case, please make sure that we use the QIOChannel functions
> > called from a coroutine in QEMU so that it will never block, but the
> > coroutine can just yield while it's waiting for more bytes.
>=20
> But if I am not wrong, libvhost-user is supposed to be indepdent from
> the main QEMU code. So it can't use the QIOChannel functions if we
> simply modify exiting vu_message_read to address the short read issue.
> In v3 & v4, I extended libvhost-user to allow vu_message_read to be
> replaced by one which will depend on the main QEMU code. I'm not sure
> which way is better.

The way your latest patches have it, with a separate read function,
works for me.

You could probably change libvhost-user to reimplement the same
functionality, and it might be an improvement for other users of the
library, but it's also code duplication and doesn't provide more value
in the context of the vhost-user export in QEMU.

The point that's really important to me is just that we never block when
we run inside QEMU because that would actually stall the guest. This
means busy waiting in a tight loop until read() returns enough bytes is
not acceptable in QEMU.

Kevin

> On Thu, Feb 27, 2020 at 6:02 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 27.02.2020 um 10:53 hat Coiby Xu geschrieben:
> > > Thank you for reminding me of this socket short read issue! It seems
> > > we still need customized vu_message_read because libvhost-user assume=
s
> > > we will always get a full-size VhostUserMsg and hasn't taken care of
> > > this short read case. I will improve libvhost-user's vu_message_read
> > > by making it keep reading from socket util getting enough bytes. I
> > > assume short read is a rare case thus introduced performance penalty
> > > would be negligible.
> >
> > In any case, please make sure that we use the QIOChannel functions
> > called from a coroutine in QEMU so that it will never block, but the
> > coroutine can just yield while it's waiting for more bytes.
> >
> > Kevin
> >
> > > On Thu, Feb 27, 2020 at 3:41 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> > > >
> > > > On Wed, Feb 26, 2020 at 11:18:41PM +0800, Coiby Xu wrote:
> > > > > Hi Stefan,
> > > > >
> > > > > Thank you for reviewing my code!
> > > > >
> > > > > I tried to reach you on IRC. But somehow either you missed my mes=
sage
> > > > > or I missed your reply. So I will reply by email instead.
> > > > >
> > > > > If we use qio_channel_set_aio_fd_handler to monitor G_IO_IN event=
,
> > > > > i.e. use vu_dispatch as the read handler, then we can re-use
> > > > > vu_message_read. And "removing the blocking recv from libvhost-us=
er"
> > > > > isn't necessary because "the operation of poll() and ppoll() is n=
ot
> > > > > affected by the O_NONBLOCK flag" despite that we use
> > > > > qio_channel_set_blocking before calling qio_channel_set_aio_fd_ha=
ndler
> > > > > to make recv non-blocking.
> > > >
> > > > I'm not sure I understand.  poll() just says whether the file descr=
iptor
> > > > is readable.  It does not say whether enough bytes are readable :).=
  So
> > > > our callback will be invoked if there is 1 byte ready, but when we =
try
> > > > to read 20 bytes either it will block (without O_NONBLOCK) or retur=
n
> > > > only 1 byte (with O_NONBLOCK).  Neither case is okay, so I expect t=
hat
> > > > code changes will be necessary.
> > > >
> > > > But please go ahead and send the next revision and I'll take a look=
.
> > > >
> > > > Stefan
> > >
> > >
> > >
> > > --
> > > Best regards,
> > > Coiby
> > >
> >
>=20
>=20
> --=20
> Best regards,
> Coiby
>=20


