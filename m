Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB7C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B146120721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGk45Zev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYJm-0005ul-Ru
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVYIv-00056J-Vm
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:26:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVYIu-0001A1-89
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588587986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QW7XtodOHUNpl2659rcQBuJs1zjkixKe/FSSUqBKT4=;
 b=LGk45Zevgo1yxY+M1jk5QibcYq9UFl9npS3jN2qmrSgsoRSddrT4Igx5Xl/AIJAjm1DqBR
 Vtrp7JMjSBE0gSxqWKXfkZ7KVFn7jBZifL8yh6Ns7WZzqKPnMHpOxF/CPsp9DTd1FZ+mQh
 4tLEnvn4sXTgcWzYg3ErF3LoE8Mu1lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-BxdgTI7VNMWhXepLEzTgLQ-1; Mon, 04 May 2020 06:26:25 -0400
X-MC-Unique: BxdgTI7VNMWhXepLEzTgLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63127100CCC7;
 Mon,  4 May 2020 10:26:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2074419C58;
 Mon,  4 May 2020 10:26:21 +0000 (UTC)
Message-ID: <65da8db487fb0e0a5f1001a55477af47246c3206.camel@redhat.com>
Subject: Re: [PATCH v3 00/14] LUKS: encryption slot management using amend
 interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Mon, 04 May 2020 13:26:20 +0300
In-Reply-To: <20200504101925.GH115875@redhat.com>
References: <20200503184324.12506-1-mlevitsk@redhat.com>
 <20200504101925.GH115875@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-05-04 at 11:19 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Sun, May 03, 2020 at 09:43:10PM +0300, Maxim Levitsky wrote:
> > Hi!
> > Here is the updated series of my patches, incorporating all the feedbac=
k I received.
> >=20
> > This implements the API interface that we agreed upon except that I mer=
ged the
> > LUKSKeyslotActive/LUKSKeyslotInactive union into a struct because other=
wise
> > I need nested unions which are not supported currently by QAPI parser.
> > This didn't change the API and thus once support for nested unions is t=
here,
> > it can always be implemented in backward compatible way.
> >=20
> > I hope that this series will finally be considered for merging, since I=
 am somewhat running
> > out of time to finish this task.
> >=20
> > Patches are strictly divided by topic to 3 groups, and each group depen=
ds on former groups.
> >=20
> > * Patches 1,2 implement qcrypto generic amend interface, including defi=
nition
> >   of structs used in crypto.json and implement this in luks crypto driv=
er
> >   Nothing is exposed to the user at this stage
> >=20
> > * Patches 3-9 use the code from patches 1,2 to implement qemu-img amend=
 based encryption slot management
> >   for luks and for qcow2, and add a bunch of iotests to cover that.
> >=20
> > * Patches 10-13 add x-blockdev-amend (I'll drop the -x prefix if you li=
ke), and wire it
> >   to luks and qcow2 driver to implement qmp based encryption slot manag=
ement also using
> >   the code from patches 1,2, and also add a bunch of iotests to cover t=
his.
> >=20
> > Tested with -raw,-qcow2 and -luks iotests and 'make check'
> >=20
> > V3: rebased, addressed most of the review feedback.
> > For now I kept the slot bitmap code since I am not sure that replacing =
it will be better.
>=20
> I'm still of the opinion that the bitmaps code should be replaced.
> With this current design we are iterating over the slot of keys slots
> 4 times, doing different checks/logic in each iteration. This is really
> not nice for understanding how the code works. IMHO we should be iteratin=
g
> at most twice - once to validate the requested configuration, and once
> to apply the requested configuration.   Even if there si duplication of
> logic in between the delete/add key codepaths, I think it will be better
> as the logic for each operation will be in one place.
>=20
>=20
> Regards,
> Daniel

All right then, I also agree kind of that these iterations aren't
that nice. I just wanted to do this in the same way the spec defines it,
which is currently kind of independent of how key add/remove operation.

I'll send updated code soon.

Best regards,
=09Maxim Levitsky


