Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F3C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF4721872
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeNbYOnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF4721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9v6-00019H-Ow
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:39:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iU9u7-0008Tg-8S
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iU9u3-0000LI-M5
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:38:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iU9u3-0000L6-58
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573479525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BBDT0jUUH0LenC/4uCUQ61X1mh2+Z2LiKLJtyowLK7Q=;
 b=GeNbYOnlO3ImjhaaE4zOyt2T1FvWGZRi3za/esNOuTG2QcrxuuYU/K+9sTdUGxfkTQUAWQ
 eBrW9XV3mzxq+dYDwI2QFpMhtoVf9rFLUs6iAT4m+b6hKnXH8hBFIieWlluO7yy9Sddspl
 mNR46J/niNZs7exZZn8fPAtfnj41Q6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-9Jjl32T0OXO456_hCl17ag-1; Mon, 11 Nov 2019 08:38:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02A9D1005502;
 Mon, 11 Nov 2019 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0330160FCC;
 Mon, 11 Nov 2019 13:38:34 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] configure: Check bzip2 is available
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-3-philmd@redhat.com>
 <20191108114847.GM182396@redhat.com>
 <bc9c15f1-bb3f-5b5e-6b25-53821c2264c5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d0d5c272-27b6-6e38-5c29-718716f4bccb@redhat.com>
Date: Mon, 11 Nov 2019 14:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bc9c15f1-bb3f-5b5e-6b25-53821c2264c5@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 9Jjl32T0OXO456_hCl17ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 18.43, Laszlo Ersek wrote:
> On 11/08/19 12:48, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Nov 08, 2019 at 12:45:31PM +0100, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> The bzip2 tool is not included in default installations.
>>> On freshly installed systems, ./configure succeeds but 'make'
>>> might fail later:
>>>
>>>     BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>>   /bin/sh: bzip2: command not found
>>>   make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>>>   make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>>>   make: *** Waiting for unfinished jobs....
>>>
>>> Add a check in ./configure to warn the user if bzip2 is missing.
>>>
>>> Fixes: 536d2173b2b
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> v2: use better English (Daniel)
>>> (Not taking Daniel Reviewed-by because logic changed)
>>> ---
>>>  configure | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>
>>> diff --git a/configure b/configure
>>> index 9b322284c3..2b419a8039 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2147,6 +2147,7 @@ case " $target_list " in
>>>    ;;
>>>  esac
>>> =20
>>> +# Some firmware binaries are compressed with bzip2
>>
>> Squash into previous patch
>>
>>>  for target in $target_list; do
>>>    case "$target" in
>>>      arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
>>> @@ -2154,6 +2155,9 @@ for target in $target_list; do
>>>        ;;
>>>    esac
>>>  done
>>> +if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
>>> +  error_exit "The bzip2 program is required for building QEMU"
>>> +fi
>>> =20
>>>  feature_not_found() {
>>>    feature=3D$1
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> I don't feel too strongly about this, but how about a different improveme=
nt:
>=20
> - keep the comment in this patch, but move it right before the "has
> bzip2" check
> - instead of "some firmware binaries", clearly state "edk2 blobs".
>=20
> Something like:
>=20
> +# Edk2 blobs are compressed with bzip2.
> +if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
> +  error_exit "The bzip2 program is required for building QEMU"
> +fi
>=20
> So... now we have three variants: the one posted by Phil (v2), the one
> recommended by Dan (as an update to v2), and the one I suggest above (as
> a different update to v2). For simplicity, I'm fine with any one of the
> three variants going in.

I'll add the two patches to my "qtest + misc" PULL request that I'm
planning to send out tomorrow - and use Laszlo's suggestion for moving
the comment. I hope that's fine for everybody, if not please complain.

 Thomas


