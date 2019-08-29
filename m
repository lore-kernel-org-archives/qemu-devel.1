Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E21C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E2120674
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E2120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3IL8-0001ut-Cn
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Zhe.He@windriver.com>) id 1i3IHO-0007hS-IX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Zhe.He@windriver.com>) id 1i3IHL-0001lj-VJ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:07:49 -0400
Received: from mail.windriver.com ([147.11.1.11]:46834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Zhe.He@windriver.com>)
 id 1i3IHL-0001ij-Jk
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:07:47 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7T9QsDO028955
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Thu, 29 Aug 2019 02:26:54 -0700 (PDT)
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Thu, 29 Aug 2019 02:26:53 -0700
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1567068782-371028-1-git-send-email-zhe.he@windriver.com>
 <20190829091505.GB17141@redhat.com>
From: He Zhe <zhe.he@windriver.com>
Message-ID: <7d3d9777-725c-7e27-515d-fc003351704f@windriver.com>
Date: Thu, 29 Aug 2019 17:26:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829091505.GB17141@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.windriver.com id
 x7T9QsDO028955
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 147.11.1.11
Subject: Re: [Qemu-devel] [PATCH] configure: Add pkg-config handling for
 libgcrypt
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
Cc: pbonzini@redhat.com, thuth@redhat.com, philmd@redhat.com, laurent@vivier.eu,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/29/19 5:15 PM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Aug 29, 2019 at 04:53:02PM +0800, zhe.he@windriver.com wrote:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> libgcrypt may also be controlled by pkg-config, this patch adds pkg-co=
nfig
>> handling for libgcrypt.
> Where are you seeing pkg-config files for libgcrypt ?
>
> The upstream project has (frustratingly) been hostile to any proposal t=
o
> add pkg-config support saying people should stick with their custom=20
> libgcrypt-config tool
>
>    https://dev.gnupg.org/T2037
>
> Even if this is something added by some distro downstream, what is the
> benefit in using it, compared with libgcrypt-confg which should already
> work & is portable.

IMHO, it could be easy for people to use pkg-config as a center to contro=
l
configurations for many different packages.

This is just an addition for qemu to be able to work in both cases. It do=
es not
remove libgcrypt-confg and can fall back to libgcrypt-confg when pkg-conf=
ig does
not work.

Zhe

>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  configure | 48 ++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/configure b/configure
>> index e44e454..0f362a7 100755
>> --- a/configure
>> +++ b/configure
>> @@ -2875,6 +2875,30 @@ has_libgcrypt() {
>>      return 0
>>  }
>> =20
>> +has_libgcrypt_pkgconfig() {
>> +    if ! has $pkg_config ; then
>> +        return 1
>> +    fi
>> +
>> +    if ! $pkg_config --list-all | grep libgcrypt > /dev/null 2>&1 ; t=
hen
>> +        return 1
>> +    fi
>> +
>> +    if test -n "$cross_prefix" ; then
>> +        host=3D$($pkg_config --variable=3Dhost libgcrypt)
>> +        if test "${host%-gnu}-" !=3D "${cross_prefix%-gnu}" ; then
>> +            print_error "host($host) does not match cross_prefix($cro=
ss_prefix)"
>> +            return 1
>> +        fi
>> +    fi
>> +
>> +    if ! $pkg_config --atleast-version=3D1.5.0 libgcrypt ; then
>> +        print_error "libgcrypt version is $($pkg_config --modversion =
libgcrypt)"
>> +        return 1
>> +    fi
>> +
>> +    return 0
>> +}
>> =20
>>  if test "$nettle" !=3D "no"; then
>>      pass=3D"no"
>> @@ -2902,7 +2926,14 @@ fi
>> =20
>>  if test "$gcrypt" !=3D "no"; then
>>      pass=3D"no"
>> -    if has_libgcrypt; then
>> +    if has_libgcrypt_pkgconfig; then
>> +        gcrypt_cflags=3D$($pkg_config --cflags libgcrypt)
>> +        if test "$static" =3D "yes" ; then
>> +            gcrypt_libs=3D$($pkg_config --libs --static libgcrypt)
>> +        else
>> +            gcrypt_libs=3D$($pkg_config --libs libgcrypt)
>> +        fi
>> +    elif has_libgcrypt; then
>>          gcrypt_cflags=3D$(libgcrypt-config --cflags)
>>          gcrypt_libs=3D$(libgcrypt-config --libs)
>>          # Debian has removed -lgpg-error from libgcrypt-config
>> @@ -2912,15 +2943,16 @@ if test "$gcrypt" !=3D "no"; then
>>          then
>>              gcrypt_libs=3D"$gcrypt_libs -lgpg-error"
>>          fi
>> +    fi
>> =20
>> -        # Link test to make sure the given libraries work (e.g for st=
atic).
>> -        write_c_skeleton
>> -        if compile_prog "" "$gcrypt_libs" ; then
>> -            LIBS=3D"$gcrypt_libs $LIBS"
>> -            QEMU_CFLAGS=3D"$QEMU_CFLAGS $gcrypt_cflags"
>> -            pass=3D"yes"
>> -        fi
>> +    # Link test to make sure the given libraries work (e.g for static=
).
>> +    write_c_skeleton
>> +    if compile_prog "" "$gcrypt_libs" ; then
>> +	    LIBS=3D"$gcrypt_libs $LIBS"
>> +	    QEMU_CFLAGS=3D"$QEMU_CFLAGS $gcrypt_cflags"
>> +	    pass=3D"yes"
>>      fi
>> +
>>      if test "$pass" =3D "yes"; then
>>          gcrypt=3D"yes"
>>          cat > $TMPC << EOF
>> --=20
>> 2.7.4
>>
> Regards,
> Daniel


