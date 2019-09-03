Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E83C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A6B208E4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A6B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BNZ-0001Xi-S7
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i5B1T-00048O-BH
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i5B1R-0004fM-O1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i5B1R-0004eh-Gq
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:47:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F6378980E4;
 Tue,  3 Sep 2019 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-245.rdu2.redhat.com
 [10.10.123.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3664B1001B00;
 Tue,  3 Sep 2019 15:47:04 +0000 (UTC)
Date: Tue, 3 Sep 2019 11:47:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190903154702.GA16524@localhost.localdomain>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
 <20190903150824.GA14836@localhost.localdomain>
 <db34f470-5983-7965-c5b4-2b624fbe8e1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <db34f470-5983-7965-c5b4-2b624fbe8e1b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 03 Sep 2019 15:47:08 +0000 (UTC)
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
Cc: ldoktor@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 05:22:48PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/3/19 5:08 PM, Cleber Rosa wrote:
> > On Thu, Aug 29, 2019 at 11:46:15AM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> >>
> >> class avocado.utils.ssh.Session(address, credentials)
> >>
> >>   Parameters:=09
> >>
> >>     credentials (tuple)
> >>          username and path to a key for authentication purposes
> >>
> >> The current test uses username + password.
> >> Can we use this credentials with the Avocado module?
> >> (The image used is prebuilt).
> >>
> >=20
> > I'm working on adding password based authentication.  To keep the API
> > the same, I'm thinking of checking if the second credential item is a=
n
> > existing file, if it is, assume one containing a key.  If not, assume
> > it's a password.
>=20
> Why not use a dictionary? Keys would be explicit.
>

Now it's clear that a dict would've been the best option from the
beginning, but I was wrongly optimistic, and biased by the
"avocado.utils.vmimage" + "avocado.utils.cloudinit" combination, that
we'd only have to deal with key based auth.

So the question now is really how to evolve the API, either breaking
the current version or not.  At this time, I'd try to keep the API
unchanged, given that it still feels logical that the tuple is about
credentials, just that the second item can be either a path to a key
or password.

Thoughts?
- Cleber.

> > This should make the use simple in the case of keys:
> >=20
> >   with Session(('hostname', port),
> >                ('username', '/path/to/key')) as session:
> >       session.cmd('cmd')
> >=20
> > And passwords:
> >=20
> >   with Session(('hostname', port),
> >                ('username', 'p@ssw0rD')) as session:
> >       session.cmd('cmd')
> >=20
> > It's being tracked here:
> >   https://trello.com/c/uetpIgML/1517-avocadoutilssh-implement-passwor=
d-based-auth
> >=20
> > I'll try to have it in Avocado's 72.0 release due next week.
> >=20
> > Let me know how that sounds, and thanks for the feedback.
> > - Cleber.
> >=20

