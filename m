Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315A7C55186
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 09:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F132D20767
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 09:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Z8gHRUoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F132D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSHAi-0008HT-3K
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 05:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jSH9C-0007XX-VR
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jSH99-00084Z-IJ
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:30:52 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:55504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jSH98-0007kU-LH
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:30:51 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id AA7882E1574;
 Sat, 25 Apr 2020 12:30:42 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 qGq5qR0xVI-UfQC9cD9; Sat, 25 Apr 2020 12:30:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587807042; bh=95wksq+DOqFTqSI3eN3YwPwKQPhqsS9ut077EjmfilM=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=Z8gHRUoOzAoli/QOfRvQ7H3N0YdPgaOHnqDCgjT7bvijZ71/VPAQFqmHGAv4DkMSD
 T9TsHndgYRa/jq7LjWEf8itZE+MQUiiOPGEsi2daZRweBGw8WesmlfFzZmOLuqZzwQ
 c87QWwVAei5+RNP4QERweORmtFRTzgUbx7OjnY10=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7607::1:7])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 fgHhaeMJ2Z-UfXeBAJC; Sat, 25 Apr 2020 12:30:41 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Sat, 25 Apr 2020 12:30:40 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH v1 1/7] contrib/vhost-user-blk: add option to
 simulate disconnect on init
Message-ID: <20200425093030.GA28992@dimastep-nix>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <52a4ae2d18ee0d810355d84ab83623a2e9ffa405.1587667007.git.dimastep@yandex-team.ru>
 <20200422160206.GA30919@localhost.localdomain>
 <CAMxuvaxaOTO3gmCfNjFRDk-MXfcK20d2aaN+zUHUhtRFN=pPsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxaOTO3gmCfNjFRDk-MXfcK20d2aaN+zUHUhtRFN=pPsw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 05:30:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 95.108.205.193
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 12:17:54PM +0200, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Apr 24, 2020 at 4:32 AM Raphael Norwitz
> <raphael.norwitz@nutanix.com> wrote:
> >
> > I’m not opposed to adding this kind of debugging functionality to the
> > vhost-user-blk sample. It could be helpful to easily test these cases
> > in the future.
> >
> > That said, I'm not sure how others will feel about adding these kind
> > of debugging capabilities to libvhost-user. Marc-Andre, thoughts?
> 
> Maybe we should only enable this code if LIBVHOST_USER_DEBUG is set?
> 
> And to make logging silent by default, we shouldn't print them unless
> VHOST_USER_DEBUG env is set?
Yes, it is a good idea to move this code under LIBVHOST_USER_DEBUG.
Agree. Will update it in version 2, but need more feedback on other
patches first.

> 
> >
> > If we go this route I would prefer to add the debugging options to the
> > vhost-user-blk sample in a separate patch.
> >
> > On Thu, Apr 23, 2020 at 09:39:32PM +0300, Dima Stepanov wrote:
> > >
> > > Add "--simulate-disconnect-stage" option for the testing purposes.
> > > This option can be used to test the vhost-user reconnect functionality:
> > >   ./vhost-user-blk ... --simulate-disconnect-stage=<CASENUM>
> > > In this case the daemon will "crash" in the middle of the VHOST comands
> > > communication. Case nums are as follows:
> > >   1 - make assert in the handler of the SET_VRING_CALL command
> > >   2 - make assert in the handler of the SET_VRING_NUM command
> > > Main purpose is to test QEMU reconnect functionality. Such fail
> > > injection should not lead to QEMU crash and should be handled
> > > successfully.
> > > Also update the "GOptionEntry entries" definition with the final NULL
> > > item according to API.
> > >
> > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > > ---
> > >  contrib/libvhost-user/libvhost-user.c   | 30 ++++++++++++++++++++++++++++++
> > >  contrib/libvhost-user/libvhost-user.h   | 13 +++++++++++++
> > >  contrib/vhost-user-blk/vhost-user-blk.c | 14 +++++++++++++-
> > >  3 files changed, 56 insertions(+), 1 deletion(-)
> >
> 

