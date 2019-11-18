Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E81C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3019A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZwLT0pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3019A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWd6g-0001nU-AF
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iWd62-0001HZ-S9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iWd61-0002Kp-RE
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:13:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iWd61-0002KX-Nr
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574068401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SXqocHGGObICQ0noNgGOSAzBTIvED8fRj2EMrEWyXg=;
 b=WZwLT0palhCcPsT8+GE83yG9XEB8jMs2yzxXh+3cxxDFYKcna9jLk2PJANS43tTO/5Di1Q
 W99Pb7g1TQjAEDPOqTMpFOd7e3j1GA6CLR9d5rhl7fJm80220pujiBJEfNnULx4tpktwnW
 G7tNV+IY4cCMAeGO3T35lSjouNx9Gls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-BbM8Zn0nNXmZ9F_Wp-UfGA-1; Mon, 18 Nov 2019 04:13:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45C9880268A;
 Mon, 18 Nov 2019 09:13:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
 [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9767760856;
 Mon, 18 Nov 2019 09:13:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4300C1138648; Mon, 18 Nov 2019 10:13:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH] buildfix: update texinfo menu
References: <20191023101956.19120-1-kraxel@redhat.com>
 <ba8b74e7-8c37-dc76-a77e-33448b698777@redhat.com>
Date: Mon, 18 Nov 2019 10:13:15 +0100
In-Reply-To: <ba8b74e7-8c37-dc76-a77e-33448b698777@redhat.com> (Laszlo Ersek's
 message of "Sat, 16 Nov 2019 20:12:34 +0100")
Message-ID: <87blt9y2c4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: BbM8Zn0nNXmZ9F_Wp-UfGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laszlo Ersek <lersek@redhat.com> writes:

> On 10/23/19 12:19, Gerd Hoffmann wrote:
>> Build error message:
>> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed featu=
res' despite being its Up target
>>=20
>> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload paramete=
r")
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  qemu-doc.texi | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 3c5022050f0f..3ddf5c0a6865 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -44,6 +44,7 @@
>>  * Security::
>>  * Implementation notes::
>>  * Deprecated features::
>> +* Recently removed features::
>>  * Supported build platforms::
>>  * License::
>>  * Index::
>>=20
>
> Can this patch be included in v4.2.0-rc2 please?

Cc'ing qemu-trivial again, might be a workable path into -rc2.


