Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37087C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0250D2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTMj9InS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0250D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwYv-00072B-5O
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jIwXu-0005QG-Ny
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jIwXr-0006YH-Mp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:41:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jIwXr-0006Ut-EZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585582906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uidjaBkqtj4/4grd9VI6Un3UwGaxGlgtGagN+4fy2c=;
 b=gTMj9InS9nGlhbA72ME9U2Gn9RGT+S2MQfmgCovEM6JSTy8cTW6yQSFFx9dwz3k/MxeMCA
 69UJuvcfjagdDaT3oY7dsXPpyd3Dk8Kjk8dykbz61Lsl+cnwOkoscI5K1zJANFeDeGLTEc
 jwi4VieEijTD5jj76yIMgsjCflU9M4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-oAfz0UbGONS4LQpN-Ifz0Q-1; Mon, 30 Mar 2020 11:41:41 -0400
X-MC-Unique: oAfz0UbGONS4LQpN-Ifz0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A78149D5;
 Mon, 30 Mar 2020 15:41:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFF2819925;
 Mon, 30 Mar 2020 15:41:38 +0000 (UTC)
Date: Mon, 30 Mar 2020 17:41:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 01/14] iotests: do a light delinting
Message-ID: <20200330154137.GE6139@linux.fritz.box>
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-2-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
> This doesn't fix everything in here, but it does help clean up the
> pylint report considerably.
>=20
> This should be 100% style changes only; the intent is to make pylint
> more useful by working on establishing a baseline for iotests that we
> can gate against in the future.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

> @@ -550,8 +546,8 @@ def flatten_qmp_object(self, obj, output=3DNone, base=
str=3D''):
>          if output is None:
>              output =3D dict()
>          if isinstance(obj, list):
> -            for i in range(len(obj)):
> -                self.flatten_qmp_object(obj[i], output, basestr + str(i)=
 + '.')
> +            for i, atom in enumerate(obj):
> +                self.flatten_qmp_object(atom, output, basestr + str(i) +=
 '.')

I think atom isn't strictly the right word because we expect nested data
structures (as shown by the recursive call). If I understand correctly,
what Python calls things in lists is "items".

Kevin


