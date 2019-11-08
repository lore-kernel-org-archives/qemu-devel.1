Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E342BFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9D72178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrEhmBtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9D72178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT8JC-0008Qs-ST
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iT8IZ-0007uN-Fn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iT8IY-0000ep-Eu
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:43:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iT8IY-0000eV-BZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573235029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpnJRWJE0qGmFpIo8tXqp6ZYbE2E1mdLJjO92tWc96Y=;
 b=SrEhmBtQ9Xeoq6ujGF/Xg46R2L65ee4996TIyGgw9NBPInZPztRE1hdJCLNd4SJtp3iVpl
 SrVDQzH9zARt+csWWV9nH02NZ5z8srCFsqpOEr/EZNHdET347Lll+OWNhA/1TALNkXYieU
 FsvaywZpP/72nF3eswwbLYHU53mC5wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-TLFB4pcLNUukvc4uyiSOsw-1; Fri, 08 Nov 2019 12:43:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3A6477;
 Fri,  8 Nov 2019 17:43:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-227.ams2.redhat.com
 [10.36.117.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC733D8C;
 Fri,  8 Nov 2019 17:43:38 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] configure: Check bzip2 is available
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-3-philmd@redhat.com>
 <20191108114847.GM182396@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bc9c15f1-bb3f-5b5e-6b25-53821c2264c5@redhat.com>
Date: Fri, 8 Nov 2019 18:43:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191108114847.GM182396@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TLFB4pcLNUukvc4uyiSOsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/08/19 12:48, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Nov 08, 2019 at 12:45:31PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> The bzip2 tool is not included in default installations.
>> On freshly installed systems, ./configure succeeds but 'make'
>> might fail later:
>>
>>     BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>   /bin/sh: bzip2: command not found
>>   make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>>   make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>>   make: *** Waiting for unfinished jobs....
>>
>> Add a check in ./configure to warn the user if bzip2 is missing.
>>
>> Fixes: 536d2173b2b
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> v2: use better English (Daniel)
>> (Not taking Daniel Reviewed-by because logic changed)
>> ---
>>  configure | 4 ++++
>>  1 file changed, 4 insertions(+)
>=20
>> diff --git a/configure b/configure
>> index 9b322284c3..2b419a8039 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2147,6 +2147,7 @@ case " $target_list " in
>>    ;;
>>  esac
>> =20
>> +# Some firmware binaries are compressed with bzip2
>=20
> Squash into previous patch
>=20
>>  for target in $target_list; do
>>    case "$target" in
>>      arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
>> @@ -2154,6 +2155,9 @@ for target in $target_list; do
>>        ;;
>>    esac
>>  done
>> +if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
>> +  error_exit "The bzip2 program is required for building QEMU"
>> +fi
>> =20
>>  feature_not_found() {
>>    feature=3D$1
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I don't feel too strongly about this, but how about a different improvement=
:

- keep the comment in this patch, but move it right before the "has
bzip2" check
- instead of "some firmware binaries", clearly state "edk2 blobs".

Something like:

+# Edk2 blobs are compressed with bzip2.
+if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
+  error_exit "The bzip2 program is required for building QEMU"
+fi

So... now we have three variants: the one posted by Phil (v2), the one
recommended by Dan (as an update to v2), and the one I suggest above (as
a different update to v2). For simplicity, I'm fine with any one of the
three variants going in.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo


