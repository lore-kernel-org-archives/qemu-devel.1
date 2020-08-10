Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557F5206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 10:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQoypGuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557F5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k554l-0007r3-I5
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 06:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k553y-0006zb-E2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:29:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k553w-00029G-Uc
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 06:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597055392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za5DNiUncgceOHs2f2E+7rlc/2IrxHziQ2J9MqtFWVY=;
 b=JQoypGuHm9eY0p3DftJS5hlewEJ6K5emrSfdI4BKVM50SIbelkmjtmi7gEeSpjbwqiz8j5
 CJVPCdkFkXokGa17G2Mhy8iR4sYVCAsok+iIlvTREKNHrdYaM2jl/2SP1JEtmUdGUYl6gm
 7Dt4XfgDvGRWnUCp3lgoC6+6WAUCguQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-W3xUvwhSPNSWrmwNXMzZag-1; Mon, 10 Aug 2020 06:29:50 -0400
X-MC-Unique: W3xUvwhSPNSWrmwNXMzZag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A2118014D7;
 Mon, 10 Aug 2020 10:29:49 +0000 (UTC)
Received: from gondolin (ovpn-112-218.ams2.redhat.com [10.36.112.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 337BA5D9CC;
 Mon, 10 Aug 2020 10:29:48 +0000 (UTC)
Date: Mon, 10 Aug 2020 12:29:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] docs/system/s390x: Add a chapter about s390x boot devices
Message-ID: <20200810122945.773f0349.cohuck@redhat.com>
In-Reply-To: <d94f794a-1fb0-2251-38c2-7828f8cb8d9b@redhat.com>
References: <20200806150507.12073-1-thuth@redhat.com>
 <20200810121847.5ab4e227.cohuck@redhat.com>
 <d94f794a-1fb0-2251-38c2-7828f8cb8d9b@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 12:20:53 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 8/10/20 12:18 PM, Cornelia Huck wrote:
> > On Thu,  6 Aug 2020 17:05:07 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >  =20
> >> Booting on s390x is a little bit different compared to other architect=
ures.
> >> Let's add some information for people who are not yet used to this.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  docs/system/s390x/bootdevices.rst | 82 ++++++++++++++++++++++++++++++=
+
> >>  docs/system/target-s390x.rst      |  1 +
> >>  2 files changed, 83 insertions(+)
> >>  create mode 100644 docs/system/s390x/bootdevices.rst
> >>
> >> diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/boo=
tdevices.rst
> >> new file mode 100644
> >> index 0000000000..68f0ffd450
> >> --- /dev/null
> >> +++ b/docs/system/s390x/bootdevices.rst
> >> @@ -0,0 +1,82 @@
> >> +Boot devices on s390x
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +Booting with bootindex parameter
> >> +--------------------------------
> >> +
> >> +For classical mainframe guests (i.e. LPAR or z/VM installations), you=
 always
> >> +have to exactly specify the disk where you want to boot from (or "IPL=
" from, =20
> >=20
> > s/exactly/explictly/ ? =20
>=20
> Or "to explicit the disk ..."?

Hm, not sure what that means?


