Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188EAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1808215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1808215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ARO-0000ep-0y
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i5AQD-0000CU-Po
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i5AQC-0004kY-L7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:08:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i5AQC-0004jq-Fj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:08:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C4FB86E86F;
 Tue,  3 Sep 2019 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-245.rdu2.redhat.com
 [10.10.123.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A6B35DC1B;
 Tue,  3 Sep 2019 15:08:26 +0000 (UTC)
Date: Tue, 3 Sep 2019 11:08:24 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190903150824.GA14836@localhost.localdomain>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 03 Sep 2019 15:08:39 +0000 (UTC)
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

On Thu, Aug 29, 2019 at 11:46:15AM +0200, Philippe Mathieu-Daud=E9 wrote:
>=20
> class avocado.utils.ssh.Session(address, credentials)
>=20
>   Parameters:=09
>=20
>     credentials (tuple)
>          username and path to a key for authentication purposes
>=20
> The current test uses username + password.
> Can we use this credentials with the Avocado module?
> (The image used is prebuilt).
>=20

I'm working on adding password based authentication.  To keep the API
the same, I'm thinking of checking if the second credential item is an
existing file, if it is, assume one containing a key.  If not, assume
it's a password.

This should make the use simple in the case of keys:

  with Session(('hostname', port),
               ('username', '/path/to/key')) as session:
      session.cmd('cmd')

And passwords:

  with Session(('hostname', port),
               ('username', 'p@ssw0rD')) as session:
      session.cmd('cmd')

It's being tracked here:
  https://trello.com/c/uetpIgML/1517-avocadoutilssh-implement-password-ba=
sed-auth

I'll try to have it in Avocado's 72.0 release due next week.

Let me know how that sounds, and thanks for the feedback.
- Cleber.

