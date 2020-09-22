Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CFC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA2A239E5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwDH7uIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA2A239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcAe-00009n-0U
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKc6V-0004wv-ES
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:48:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKc6S-00034m-VE
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600757320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kfo12jbG6Em66ftrlz0h/CVFgHo0/Px79NiByqjZgc0=;
 b=RwDH7uIgaNHC9lxobx5g4gWFQHhjYCHs7L3t2eytDI2e75OdR5k87I6PiYuBaiqqp4JuDp
 is2ZH3dvx9F005rQ1p55tktOPkd/8dobh2r1JIWlajVLBBUGUfkXSbjoc/7d+KHxoRKdJV
 xnIq/DT7o7BduuuB9suUdd5g40jUl/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-E0KZzpd4NQC5offBSrYidg-1; Tue, 22 Sep 2020 02:48:34 -0400
X-MC-Unique: E0KZzpd4NQC5offBSrYidg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D57DE800470;
 Tue, 22 Sep 2020 06:48:33 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-122.ams2.redhat.com [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33F0C5DD99;
 Tue, 22 Sep 2020 06:48:31 +0000 (UTC)
Subject: Re: [PATCH 3/6] migration: Silence compiler warning in
 global_state_store_running()
To: Cleber Rosa <crosa@redhat.com>
References: <20200918103430.297167-1-thuth@redhat.com>
 <20200918103430.297167-4-thuth@redhat.com>
 <20200921203902.GA15763@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a1601662-9650-ecab-e61b-36b7d49c3d0d@redhat.com>
Date: Tue, 22 Sep 2020 08:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200921203902.GA15763@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IvtEZOvnApbkU2MsBJf8WJP0rbbRAM2IX"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IvtEZOvnApbkU2MsBJf8WJP0rbbRAM2IX
Content-Type: multipart/mixed; boundary="0t7wRjiCGYIvYaETlffrynT0fMZ8Q9MAM"

--0t7wRjiCGYIvYaETlffrynT0fMZ8Q9MAM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21/09/2020 22.39, Cleber Rosa wrote:
> On Fri, Sep 18, 2020 at 12:34:27PM +0200, Thomas Huth wrote:
>> GCC 9.3.0 on Ubuntu complains:
>>
>> In file included from /usr/include/string.h:495,
>>                  from /home/travis/build/huth/qemu/include/qemu/osdep.h:=
87,
>>                  from ../migration/global_state.c:13:
>> In function =E2=80=98strncpy=E2=80=99,
>>     inlined from =E2=80=98global_state_store_running=E2=80=99 at ../migr=
ation/global_state.c:47:5:
>> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:106:10: error:
>>  =E2=80=98__builtin_strncpy=E2=80=99 specified bound 100 equals destinat=
ion size [-Werror=3Dstringop-truncation]
>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (_=
_dest));
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
>>
>> ... but we apparently really want to do a strncpy here - the size is alr=
eady
>> checked with the assert() statement right in front of it. To silence the
>> warning, simply replace it with our strpadcpy() function.
>>
>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> (two years=
 ago)
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  migration/global_state.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/global_state.c b/migration/global_state.c
>> index 25311479a4..a33947ca32 100644
>> --- a/migration/global_state.c
>> +++ b/migration/global_state.c
>> @@ -44,8 +44,8 @@ void global_state_store_running(void)
>>  {
>>      const char *state =3D RunState_str(RUN_STATE_RUNNING);
>>      assert(strlen(state) < sizeof(global_state.runstate));
>> -    strncpy((char *)global_state.runstate,
>> -           state, sizeof(global_state.runstate));
>> +    strpadcpy((char *)global_state.runstate, sizeof(global_state.runsta=
te),
>> +              state, '\0');
>>  }
>> =20
>>  bool global_state_received(void)
>> --=20
>> 2.18.2
>>
>>
>=20
> Hi Thomas,
>=20
> FIY, I couldn't reproduce the complaint from GCC.  I've tested it on foca=
l,
> "gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0", with QEMU 5df6c87e8.

 Hi Cleber,

I've hit the error here:

 https://travis-ci.com/github/huth/qemu/jobs/385871010#L2930

It seems to use the very same compiler version as you did, so that's
kind of weird... Maybe it's related to the other compiler flags, either
--enable-gprof, --enable-gcov or --disable-pie ?

 Thomas


--0t7wRjiCGYIvYaETlffrynT0fMZ8Q9MAM--

--IvtEZOvnApbkU2MsBJf8WJP0rbbRAM2IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl9pnj4ACgkQLtnXdP5w
LbX5bA/9EfhOQRT1vdzwtlVbzWBesLh5TCyRyq05NKV7W0SPVKLI1uGGiOBneSTB
YsbXEsP5p+9ufTAjYxSeYCIIO110x9pmRzsNlJvZxxHre3doQpRQmzREtohkc4KC
s0Ff5LzvGm76u0TA5I1Tk/X+l7jGFDiuSlTHn3h/EuUemCQbf6aeHqLnxqjDAiWS
rzPdBrXHDBgpzHvcbmwZihD3d+QqR+EwANd2js+/ihjTZ5Oq/0yAYjg1sju9er4C
2trtzP/JQ4wO7cGnftMZl7i+0pm4enw9sk/u7OlNUnXOTMEeq7JizjTpUe1WuC7t
UFERK/Rxcqc3WG2xRiSKR+YV3TqndAGaPwdRon0XbQvKbUBcdgCi3EQ4pLTlFX+6
e1LaMVu3FoMyjV0lvUeek6GCNyDI+QX036H+b5j7cSypiwndCejWfeRap4eAShcU
si0gq4SzVMqgrSA2CNz2adI0tEFg47pn6+PGgarV3G/ByiU+xAcwAhmYn73mehX4
lYKzfHL+SqrHied0SWUEmLAUlBptr+BGe0xwk8pjmhePEuSLYDzW25pICeYXoz5d
8q24Z79g9WrVY6OK5XSmJ0jJpudOlh44Bvh3aU3eCkADOa9qSd+oalt1x8oQA1Uh
ADRdd2/ukB6DZgjrPawfuS4T5xCPx2HOCNhX6Bo/knI4VQsivs8=
=P/nE
-----END PGP SIGNATURE-----

--IvtEZOvnApbkU2MsBJf8WJP0rbbRAM2IX--


