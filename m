Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB1FC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C24120645
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C24120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFzxd-0007uD-Lm
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 07:39:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hFzwr-0007cb-Mf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hFzwq-0003ur-T0
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:38:53 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:36666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hFzwq-0003ti-K7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:38:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id DC933BCF8;
	Mon, 15 Apr 2019 13:38:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqtQJwbmNBbF; Mon, 15 Apr 2019 13:38:44 +0200 (CEST)
Received: from function (dhcp-13-159.lip.ens-lyon.fr [140.77.13.159])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 0B947BCC2;
	Mon, 15 Apr 2019 13:38:44 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hFzwh-000086-KS; Mon, 15 Apr 2019 13:38:43 +0200
Date: Mon, 15 Apr 2019 13:38:43 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415113843.pcagpvrsankd2avw@function>
References: <20190415113431.12060-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415113431.12060-1-berrange@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a0c:e300::1
Subject: Re: [Qemu-devel] [PATCH] vl: set LC_MESSAGES and LC_CTYPE in main
 for all code
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415113843.xjAe_E-S0NKWb4Fn7oy_jWMHUS0Igiz8CMd4b6EEHWw@z>

Daniel P. Berrang=C3=A9, le lun. 15 avril 2019 12:34:31 +0100, a ecrit:
> Hardcoding LC_CTYPE to C.UTF-8 is a partial regression vs the above
> curses commit, since it will break the curses wide character handling
> for non-UTF-8 locales but this is unavoidable until QEMU is cleaned up
> to cope with non-UTF-8 locales fully.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Non-utf-8 environments should be rare enough that it will not be a real
concern.

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

