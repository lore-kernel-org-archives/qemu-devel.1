Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC296C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9912720830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9912720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDxKM-0006iH-Gt
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 16:26:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDxJZ-0006N4-Lx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hDxJX-0001Zi-0q
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:25:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:44726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hDxJT-0001WH-6U
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:25:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hDxJO-0005Uc-9D
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 20:25:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 304872E80CC
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 20:25:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2019 20:16:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ekline pmaydell
X-Launchpad-Bug-Reporter: Erik Kline (ekline)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <154907151753.31178.12938166708527410326.malonedeb@gac.canonical.com>
	<155481790266.8592.9119116041656314996.malone@wampee.canonical.com>
	<CAAedzxqBuP98u=YkrK7NU7p7eECODcxHcvspTc09c0+FHFxNnA@mail.gmail.com>
Message-Id:
 <CAFEAcA9X+srbS8gFm-D3KwHZ=PBjTeswkJb3nRK+Hp4geD9-Bg@mail.gmail.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18920";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 347c150585c7ce181791439c60cb72a4f1c411fe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1814352] Re: SIOCGIFNAME takes a struct ifreq
 not an integer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1814352 <1814352@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409201629.n-cAY-X5j9Yp_LiavhZZcTa6U6eyAJO-VBGDAG6uxKk@z>

On Wed, 10 Apr 2019 at 01:26, Erik Kline <1814352@bugs.launchpad.net> wrote:
> Sure.  Looking at HEAD, and even the surrounding the lines, I think I
> should have tried STRUCT_short_ifreq instead of STRUCT_int_ifreq, though
> I'm not sure what the real difference would be.

The multiple STRUCT_*_ifreq are working around the fact that
our MK_STRUCT infrastructure can't handle unions. The struct
ifreq is a char array followed by a union whose members are
various different types. You should use the STRUCT_*_ifreq
corresponding to whatever type the union field used by this
particular ioctl is. For SIOCGIFNAME the ifr_ifindex is read,
and that's an int, so you want STRUCT_int_ifreq. (If you used
the 'short' version by mistake this would probably break for the
case of big-endian guest and little-endian host or vice-versa
because we'd swap the wrong amount of data.)

thanks
-- PMM

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814352

Title:
  SIOCGIFNAME takes a struct ifreq not an integer

Status in QEMU:
  Confirmed

Bug description:
  The ioctl SIOCGIFNAME takes a pointer to a struct ifreq, not an
  integer.  This leads to if_indextoname() not correctly returning
  interface names (well, not if they're longer than 4 characters
  including the trailing NULL ;-).

  This is observed on v3.1.0.

  The following one-line patch will be sent to the qemu-devel mailing
  list:

  """
  diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
  index ae8951625f..37501f575c 100644
  --- a/linux-user/ioctls.h
  +++ b/linux-user/ioctls.h
  @@ -178,7 +178,7 @@
   #endif /* CONFIG_USBFS */
   =

     IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
  -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
  +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
     IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq=
)))
     IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
     IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifr=
eq)))
  """

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814352/+subscriptions

