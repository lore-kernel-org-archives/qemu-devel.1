Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35925C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E292067C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E292067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJwaw-0006iP-0p
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 04:52:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJwZd-0005ux-De
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJwNP-0003hy-4L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:38:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJwNO-0003hF-Rm
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:38:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4500B46202;
	Fri, 26 Apr 2019 08:38:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05168177F8;
	Fri, 26 Apr 2019 08:38:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 2333D11AAA; Fri, 26 Apr 2019 10:38:30 +0200 (CEST)
Date: Fri, 26 Apr 2019 10:38:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Lin Ma <lma@suse.com>
Message-ID: <20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 26 Apr 2019 08:38:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] About pt-br keyboard layout
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426083830.rTJJ6FXIMYv_0p2HTnBGzdX-BIudmXRWwIQngVreZmk@z>

On Fri, Apr 26, 2019 at 04:09:12PM +0800, Lin Ma wrote:
> Hi all,
>=20
> While I launch qemu with vnc + pt-br keyboard layout on my pc, If I typ=
e
> shift + 6 in iPXE shell or grub shell via my usual 105-key keyboard,
> shift + 6 would be mapped to "(apostrophe), But IIUC the correct charac=
ter
> should be =A8(diaeresis) in pt-br layout.
>=20
> I'm wondering that is it the expected behavior? In other words, Does it=
 make
> sense if I want to type multi-character characters(say =C7 or =A8) with=
out guest
> os's help?

No.  -k is for translating keysyms back into the correct scancodes,
because this is what the (virtual) keyboard passes to the guest.
So -k must match the *hosts* keyboard layout.

Translating the scancodes into keysyms again is the job of the guest,
so that requires the keymapping you want to use being active in the
guest os.  Typically that would be the same you have on the host, but
that isn't required.  The guest can work with -- for example -- us
layout (like it is often the case in boot loaders).  Behavior should be
identical to physical hardware here.

HTH,
  Gerd


