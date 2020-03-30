Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B9FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFE0206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POKiuXfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE0206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIx9n-0000nZ-Km
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jIx8m-0008AL-FZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jIx8k-0005RE-QC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:19:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jIx8k-0005QW-IJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585585194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHEAqRCYnJ/yCYLxc5/xSwCe24zmb5UFzAafIhc4Ztc=;
 b=POKiuXfRp3AM9QxdiIyCmfLGoYIhJ4lQyzbl30ery89UyXitL7H5eWRwH7kLvFGM+jXB+7
 xQQx4MD+KLI0REQ6AUdB0BZvk+ofqsHgComesRL1y0QLvCUOyi/XWVOAG4r010f0+NNGJd
 wvGMR88NWVMrMO+sVvu7qBxw66SgcM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-VfsL5pJQOXCNA9h0V-K0ng-1; Mon, 30 Mar 2020 12:19:49 -0400
X-MC-Unique: VfsL5pJQOXCNA9h0V-K0ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45AEE18C8C01;
 Mon, 30 Mar 2020 16:19:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B16E5C1B5;
 Mon, 30 Mar 2020 16:19:46 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:19:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 08/14] iotests: touch up log function signature
Message-ID: <20200330161945.GG6139@linux.fritz.box>
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-9-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-9-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 philmd@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.03.2020 um 00:20 hat John Snow geschrieben:
> Representing nested, recursive data structures in mypy is notoriously
> difficult; the best we can reliably do right now is denote the atom
> types as "Any" while describing the general shape of the data.
>=20
> Regardless, this fully annotates the log() function.
>=20
> Typing notes:
>=20
> TypeVar is a Type variable that can optionally be constrained by a
> sequence of possible types. This variable is bound per-invocation such
> that the signature for filter=3D() requires that its callables take e.g. =
a
> str and return a str.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

I like it. Does your version of mypy accept this? I actually get a
warning that doesn't make sense to me:

    iotests.py:392: error: Argument 1 to "info" of "Logger" has incompatibl=
e type "Dict[str, Any]"; expected "str"

The code looks like this:

    if isinstance(msg, (dict, list)):
        # Don't sort if it's already sorted
        do_sort =3D not isinstance(msg, OrderedDict)
        test_logger.info(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dinde=
nt))
    else:
        test_logger.info(msg)

I have no idea why it would think it can still be Dict[str, Any] in the
else branch. Even after adding an 'assert not instanceof(msg, dict), it
still thinks so.

Probably time to update for me...

Kevin


