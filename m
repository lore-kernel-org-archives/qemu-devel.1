Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B5C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B510E20656
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1xAjlUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B510E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT6b-00013u-Bf
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:29:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTT57-0007fb-TX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTT1M-0003cA-Cz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:27:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34176
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTT1L-0003bp-Vv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvU54z+jSpvnT7YyllIrfAKvIAPmjMrFdybZIm+Fsf8=;
 b=b1xAjlUpV/tYCI3/0oXxip9BtdamRh4fnsHQ/3lC1LBt1jRLtLrRugi28pCYyd/vBk6+96
 vgoya5WrHIVSdq4ZmnJam3g8lmBxXe7E/SaGLTEkRtdCUjMVbgEFXAww9fnNQUay4s3gCl
 mND1xOjIMW/1XRxsAhlRvis0q+OOR1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-k6MyDgyBNwGV37F2n_gB1w-1; Tue, 28 Apr 2020 12:23:40 -0400
X-MC-Unique: k6MyDgyBNwGV37F2n_gB1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3A52107ACF4;
 Tue, 28 Apr 2020 16:23:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBB17614C0;
 Tue, 28 Apr 2020 16:23:37 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:23:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 14/14] iotests: add tests for blockdev-amend
Message-ID: <20200428162326.GH1467943@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-15-mlevitsk@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-15-mlevitsk@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 08, 2020 at 05:19:03PM +0200, Maxim Levitsky wrote:
> This commit adds two tests that cover the
> new blockdev-amend functionality of luks and qcow2 driver
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  tests/qemu-iotests/302     | 278 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/302.out |  40 ++++++
>  tests/qemu-iotests/303     | 233 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/303.out |  33 +++++
>  tests/qemu-iotests/group   |   3 +
>  5 files changed, 587 insertions(+)
>  create mode 100755 tests/qemu-iotests/302
>  create mode 100644 tests/qemu-iotests/302.out
>  create mode 100755 tests/qemu-iotests/303
>  create mode 100644 tests/qemu-iotests/303.out

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


