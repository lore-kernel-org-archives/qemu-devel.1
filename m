Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D6C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6C12070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 10:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6C12070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdBU4-0002f3-Od
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 06:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdBSA-0001Xk-C4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdBS9-00017u-At
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:35:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hdBS9-0000wd-49
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 06:35:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F3A931628E6
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BBCA7D50E;
 Tue, 18 Jun 2019 10:34:50 +0000 (UTC)
Date: Tue, 18 Jun 2019 12:34:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190618103449.GE4296@localhost.localdomain>
References: <20190617184903.19436-1-armbru@redhat.com>
 <20190617184903.19436-17-armbru@redhat.com>
 <20190618090153.GE28525@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190618090153.GE28525@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 18 Jun 2019 10:34:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 16/16] vl: Deprecate -mon pretty=... for HMP
 monitors
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.06.2019 um 11:01 hat Daniel P. Berrang=E9 geschrieben:
> On Mon, Jun 17, 2019 at 08:49:03PM +0200, Markus Armbruster wrote:
> > From: Kevin Wolf <kwolf@redhat.com>
> >=20
> > The -mon pretty=3Don|off switch of the -mon option applies only to QM=
P
> > monitors. It's silently ignored for HMP. Deprecate this combination s=
o
> > that we can make it an error in future versions.
>=20
> No objection to merging this PR as is, but how about we extend the
> deprecation to QMP too ?
>=20
> I was responsible for adding this option back in 2010 and I don't
> think I've used it since 2012 when I added pretty printing support
> to scripts/qmp/qmp-shell. I struggle to imagine good reasons for
> using QMP directly with pretty printing, as opposed to doing it
> via qmp-shell or another wrapper tool.

qemu-iotests uses it. It doesn't only make the output (and espeically
diffs on failure) much more readable, but in fact also avoids very long
lines in the refernce output that used to break patch emails when we
didn't use pretty printing yet.

So let's keep it for QMP, please.

Kevin

