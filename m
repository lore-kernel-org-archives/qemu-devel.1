Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F691C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D741321848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSuBeqby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D741321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4Uh-00005n-24
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iT4P0-0003ol-U7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:34:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iT4Oz-00048b-Oi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:34:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iT4Oz-000488-LS
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573220053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1pgzP1sjoEP3vwcv/m9Ktl+kNGJMEq2RHHceZLIUy0=;
 b=XSuBeqbyGtPd8FudpE48cjWsDrcAWsOvCplfyNL+qig9SEFsuhu857Ayk3hSMMZVpnP+bh
 HtR6TOwz0qJkxqkFx1b5Uzs6S4Le0tGZ0XPi+8wrJO4ucxUOo11Cv6tFmbD36iNJbfsvh0
 Z6pwluVIePD6r7fqTD2q5imeV8RHdjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-ESS0KT-RMkW2Kv-rplUTuQ-1; Fri, 08 Nov 2019 08:34:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B47800C72;
 Fri,  8 Nov 2019 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-3.gru2.redhat.com [10.97.116.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26DA41001938;
 Fri,  8 Nov 2019 13:34:01 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] configure: Check bzip2 is available
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-3-philmd@redhat.com>
 <20191108114847.GM182396@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <12864b59-a0ac-b2eb-d398-e57efde6fd7c@redhat.com>
Date: Fri, 8 Nov 2019 11:33:59 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191108114847.GM182396@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ESS0KT-RMkW2Kv-rplUTuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/8/19 9:48 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Nov 08, 2019 at 12:45:31PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> The bzip2 tool is not included in default installations.
>> On freshly installed systems, ./configure succeeds but 'make'
>> might fail later:
>>
>>      BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>    /bin/sh: bzip2: command not found
>>    make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>>    make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>>    make: *** Waiting for unfinished jobs....
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
>>   configure | 4 ++++
>>   1 file changed, 4 insertions(+)
>> diff --git a/configure b/configure
>> index 9b322284c3..2b419a8039 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2147,6 +2147,7 @@ case " $target_list " in
>>     ;;
>>   esac
>>  =20
>> +# Some firmware binaries are compressed with bzip2
> Squash into previous patch


Ditto.


>
>>   for target in $target_list; do
>>     case "$target" in
>>       arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
>> @@ -2154,6 +2155,9 @@ for target in $target_list; do
>>         ;;
>>     esac
>>   done
>> +if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
>> +  error_exit "The bzip2 program is required for building QEMU"
>> +fi
>>  =20
>>   feature_not_found() {
>>     feature=3D$1
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

- Wainer


>
>
> Regards,
> Daniel


