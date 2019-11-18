Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9707C2192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMrQqq3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9707C2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlTs-0003Rf-QR
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iWlSu-0002SQ-Qg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iWlSs-0002pq-7k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:09:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iWlSp-0002ju-IZ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574100565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nv6NvDeo2Od3giRB78KY5Ol3Ivn/MUlFOSVJLkG9CwM=;
 b=jMrQqq3SnBhZjwslPyOo7Lbr7VOjo+nk93m3g4TeOs62HEPLcda/E7xgYhULO0S5vBQbOn
 +xAUu9P2/sJyePhjzf45g7QyPS+SJvMMiJJ7tmFMNBJNThBZmSh+63rFjCsdj/E9mIES+n
 pOYtMtdksdTRSmEps6psqNkhboHBRf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-f-ev4bMvMXOyGcLRQUKONg-1; Mon, 18 Nov 2019 13:09:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB5C28018A2;
 Mon, 18 Nov 2019 18:09:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF55160D0B;
 Mon, 18 Nov 2019 18:09:14 +0000 (UTC)
Subject: Re: [PATCH] buildfix: update texinfo menu
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20191023101956.19120-1-kraxel@redhat.com>
 <ba8b74e7-8c37-dc76-a77e-33448b698777@redhat.com>
 <87blt9y2c4.fsf@dusky.pond.sub.org>
 <CAFEAcA8yQm7B7Cdif8GtzL_67io_-DvHZzV6H+Aiy+L0CaP2Rg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4765031e-0946-51a7-b3a8-6ee8d8d37c15@redhat.com>
Date: Mon, 18 Nov 2019 19:09:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yQm7B7Cdif8GtzL_67io_-DvHZzV6H+Aiy+L0CaP2Rg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: f-ev4bMvMXOyGcLRQUKONg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 12:08, Peter Maydell wrote:
> On Mon, 18 Nov 2019 at 09:13, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>> On 10/23/19 12:19, Gerd Hoffmann wrote:
>>>> Build error message:
>>>> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed fea=
tures' despite being its Up target
>>>>
>>>> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload parame=
ter")
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>>  qemu-doc.texi | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>>>> index 3c5022050f0f..3ddf5c0a6865 100644
>>>> --- a/qemu-doc.texi
>>>> +++ b/qemu-doc.texi
>>>> @@ -44,6 +44,7 @@
>>>>  * Security::
>>>>  * Implementation notes::
>>>>  * Deprecated features::
>>>> +* Recently removed features::
>>>>  * Supported build platforms::
>>>>  * License::
>>>>  * Index::
>>>>
>>>
>>> Can this patch be included in v4.2.0-rc2 please?
>>
>> Cc'ing qemu-trivial again, might be a workable path into -rc2.
>=20
> I've just applied it directly to master.

Thank you!
Laszlo

> (Not sure why none
> of my build test machines complain about the error.)
>=20
> thanks
> -- PMM
>=20


