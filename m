Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B0C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C435213F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 13:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C435213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSiR7-0002pD-Sc
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 09:34:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSiPS-0001tF-M2
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSiPQ-0004ps-Sp
	for qemu-devel@nongnu.org; Mon, 20 May 2019 09:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSiPO-0004nN-PL; Mon, 20 May 2019 09:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 665F530C1215;
	Mon, 20 May 2019 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6695C221;
	Mon, 20 May 2019 13:32:38 +0000 (UTC)
Date: Mon, 20 May 2019 15:32:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190520133236.GG5699@localhost.localdomain>
References: <20190515075917.24980-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515075917.24980-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Mon, 20 May 2019 13:32:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BPATCH_0/2=5D_qemu-img=2Etexi=3A_Provid?=
 =?utf-8?q?e_more_info_on_some_commands=E2=80=99_output?=
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.05.2019 um 09:59 hat Max Reitz geschrieben:
> Most qemu-img subcommands that have (optional) JSON output don=E2=80=99=
t
> describe the structure of their JSON output -- but having a fixed,
> well-known output structure kind of is the point of having JSON output
> at all.  Therefore, patch 1 in this series makes every such command not=
e
> which QAPI type their JSON output has in the qemu-img man page.  (The
> exception to this is the map subcommand, which does not emit a
> QAPI-typed object.  It already has a description of the structure of it=
s
> output object, though.)
>=20
> That should be enough to thoroughly explain the machine-readable output=
.
> But we can also do better for the human-readable output: qemu-img info
> emits quite a bit of information, and not all of it is self-explanatory=
.
> In patch 2, I=E2=80=99ve tried to provide some potentially missing expl=
anation.

Thanks, applied to the block branch.

Kevin

