Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1713C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C17620801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5fZacex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C17620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Q1v-0002CR-Pz
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4Q09-00075X-Ar
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4Q08-0004E5-5a
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4Q08-0004Dk-1f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582121215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhB7lmN0qB2Pga86CdTqEFtxk4kdiETWB+OIeCW8p9E=;
 b=Y5fZacexm3YOKKFlcGbOpW764RjePE5xiXXP4ew7T0hokxavLnvzck6IlFQsAYwAhRViH3
 nC31lG5hiu2W4zrTMAnLzLzYImWZfAZWO7zlrC5edvRdJVelA1hxZzQ1KPx3O5tjksBox/
 Qh1aUUIHS2F4GWDpVeJEXUxzinfag08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-iDBEASRTPlmt_6OX0aT1Rg-1; Wed, 19 Feb 2020 09:06:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50B5613FB;
 Wed, 19 Feb 2020 14:06:40 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0709F6106A;
 Wed, 19 Feb 2020 14:06:40 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 22D8B3E04F0; Wed, 19 Feb 2020 15:06:38 +0100 (CET)
Date: Wed, 19 Feb 2020 15:06:38 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] This small series does two things:
Message-ID: <20200219140638.GY24572@paraplu>
References: <20200219114607.1855-1-kchamart@redhat.com>
 <158211395491.21924.8902047009395541691@a1bbccc8075a>
MIME-Version: 1.0
In-Reply-To: <158211395491.21924.8902047009395541691@a1bbccc8075a>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iDBEASRTPlmt_6OX0aT1Rg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 04:05:56AM -0800, no-reply@patchew.org wrote:

[...]

> The full log is available at
> http://patchew.org/logs/20200219114607.1855-1-kchamart@redhat.com/testing=
.docker-mingw@fedora/?type=3Dmessage.

Patchew is right -- I forgot the Makefile changes.  Hence the failure:

    make: *** No rule to make target 'docs/qemu-cpu-models.texi', needed
    by 'qemu-doc.html'.  Stop.

v2 upcoming.

[...]

--=20
/kashyap


