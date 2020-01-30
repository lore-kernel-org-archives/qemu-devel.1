Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE4C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50929206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeHyUUzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50929206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7Y7-0004gt-Im
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 05:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ix7XI-0003ku-IE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ix7XG-0007Ua-De
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:59:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20236
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ix7XF-0007UC-5W
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580381936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAn/BK9a8a0TPlwxOUlMkc1UiazTkKEzUjQ0RIxKVpY=;
 b=OeHyUUzRlsprFp49LwhidCHtNkJ9h/z0GOgVFvKB72BVg5Q/suBx0Xznu9GWI/8lJM6F3/
 S9PSCOhaDc6V33c92ILRB5bD5r6YO7UU6I+M0qPWqmP1kOb+PP4bQ3WhJJqA05nhH7HCHC
 vsnUC94ZZJkmi+R+MJTm5Wfh6GhHmtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-hYOj0MC_MoqOZLuHm6YUYQ-1; Thu, 30 Jan 2020 05:58:55 -0500
X-MC-Unique: hYOj0MC_MoqOZLuHm6YUYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F18B2800D48;
 Thu, 30 Jan 2020 10:58:53 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-25.ams2.redhat.com [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3E3977927;
 Thu, 30 Jan 2020 10:58:41 +0000 (UTC)
Date: Thu, 30 Jan 2020 11:58:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/10] tests/qemu-iotests/check: Update to match Python 3
 interpreter
Message-ID: <20200130105839.GB6438@linux.fritz.box>
References: <20200129231402.23384-1-philmd@redhat.com>
 <20200129231402.23384-11-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200129231402.23384-11-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.01.2020 um 00:14 hat Philippe Mathieu-Daud=E9 geschrieben:
> All the iotests Python scripts have been converted to search for
> the Python 3 interpreter. Update the ./check script accordingly.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 2890785a10..2e7d29d570 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -825,7 +825,7 @@ do
> =20
>          start=3D$(_wallclock)
> =20
> -        if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/=
env python" ]; then
> +        if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/=
env python3" ]; then
>              if $python_usable; then
>                  run_command=3D"$PYTHON $seq"
>              else

Changing some test cases in patch 2 and only updating ./check now breaks
bisectability.

I'm not sure why you separated patch 2 and 8. I think the easiest way
would be to change all qemu-iotests cases in the same patch and also
update ./check in that patch.

Otherwise, you'd have to change ./check in patch 2 to accept both
versions and could possibly remove the "python" version again here.

Kevin


