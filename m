Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A7CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AF8222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lMmg6UMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AF8222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSnX-0006Pl-KW
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iLScy-0003wh-L8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iLScx-0005xb-Ap
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:49:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:40961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>)
 id 1iLScp-0005rP-PU; Fri, 18 Oct 2019 09:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1571406533;
 bh=nt/RoJYwyYzIZO/JkQGZ+giDzbvttTdZ/+Gs155OCO8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=lMmg6UMSJLagIqm3seEaOG/MiBKAqjFM/YUZgBPSIJ79LlplXGmc5GDyTYp2vnTUh
 4fGuZ8pFufkHUWEkPDUGjemjkAh48Hbqto+v/cUp1ZjiQgoAdFGkN0wBP1y5SLum+2
 TDuQmGelFD8QXZhG0sew7PiKARgSXFXc8PINVaxA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.45.31] ([195.50.164.66]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1psI-1iJGlY3tHc-002J5D; Fri, 18
 Oct 2019 15:48:53 +0200
Subject: Re: [PATCH v2] Do not use %m in common code to print error messages
To: Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20191018130716.25438-1-thuth@redhat.com>
 <20191018134215.u6psfffrrxlsa2ns@steredhat>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <1f36c112-fabb-df41-e01d-476e4c86186e@gmx.com>
Date: Fri, 18 Oct 2019 15:49:12 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191018134215.u6psfffrrxlsa2ns@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YAEvA3TIe76vGRwcjfX3aUZddXXz/7z005ESLA7VWztB4insLkV
 RBMEaIpNdXYviROb2f75OZhB6sfCPM/SiqslypN6GF6IhKLMcJM+nL0WeV4yAwgfkC9GRUR
 MAEU3sPUEm3gmV+ATbxnHjzYLreQ9U3BiAteEG3kWKucRfXPvvOntB6JY5BVxk1UXPNAMBw
 TZuuGjokJYVwPV5P0TIlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ISmWFCJIGzQ=:u1ueoWe+SeE6qcJhO0uw9f
 xz1ERxaEasgxF+CUgLAgK3aqgjDiQDAHxWrgxB/hkAsXlTVhvmAN9zay364skAeYnykvcJWyi
 vmMhZ7/YxP2XMLIUn4jnVUBq+VaHXJirMU/4TBzEbcD9wcjXQaE6QwKm7kF3VcgOtyU45Yn4E
 qEtDw+7vbgvbQ6eRzHjK9J7sCqQp9dEucboPH65soAb3/DCSu5ogsQIQ3s0FTIyoFzp2YNJsE
 qM1KgeqMfaeXBoCr81IEHkXOZUUiC9nGWJdIRKaXvuRSACCa1uKsELVIhaFFELBsEN1RNMg+k
 BbQxle463S98NWiSEzHHm/H+vN1FNIVcGY6Lqbq3+OkNsnRoVpkO+Gz0gi/pLS5/sE7D6SWFJ
 Hw87mf1nEQFW2Q+KUYVAGE6v3H/+Uc62hQ3TpINAr8uLeS4lukA0p2553/uET/q79iWOlYxyI
 f67G+o/VrseZJPCX90jUh3QUITjIampLEd8k3qSVNrFf/8fwloS8e7zQ8FL3Xf+z/nuHR0NcG
 wVQ60M/3OJ6iwdIeeHvRcznq7cBqwfQIFKujxHWn0FlJQfhlWXN/xr9jdaislDDV13z6HFCu/
 iwo/9iXcFWLvcRuMpzQB0BfNCkVkZU0xsI5dGpb2+8ixdI/55XfhiTPGlbZvM/YF5kY7y3j23
 r8MBxerBrTPhiBh9Ew6WV2OMNkYfUD2jrboExZFXcLilvxosZ05mgDb+A/+PM8+pMr3vn21Sb
 HX1slYG3luSpehA4a8iMkWIvL3oBAH80k+i8Fel74VqiR/JwRli9Pskf+9vFdDq84NxkoYEFO
 v8cgAnCG/PSks4MCTnbFjqe2lQA84kLbkdoaqbXnPlp2FIJAcf2ain9UAhOsVM6PAUCltUxJ5
 FQ9fgBNnCYxC9Wa9PJBp9yBwzhKDlgRdhK9shH/SeOqYhhNePLQNs62gnahMfUV+KfS/Etx87
 7BE2F3z/Sgbg6iWtptLb1vAZ9S48zghViJzBCd+pbEKkdu1ETt2f+1V/A8pU8L1s2lh3L23V8
 ampYHxGG1YOzt4h3VOplN1LdbN7cggUPqJYQkzlm69czLglTAIyWoOGK3R0C8824v4diT9Agx
 zq9M/zzZkcU7omM1JvVquwJSiIVPkjYnoUOn10zaqwt5W4X3YmttLx1ykcp5pqKMkcgYwwnYq
 XussEcpTdAkAQ15b3EFAwrBlIm3priqLDWn9faM9DM5/Yj/05oOGgBG7skIuCR5jAuF/XNrpY
 QTRE2il7c6IMK2XbEm0JAJb2rc/1hT8jaHW8fVA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, berrange@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18.10.2019 15:42, Stefano Garzarella wrote:
> On Fri, Oct 18, 2019 at 03:07:16PM +0200, Thomas Huth wrote:
>> The %m format specifier is an extension from glibc - and when compiling
>> QEMU for NetBSD, the compiler correctly complains, e.g.:
>>
>> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c: In function 'sigfd_ha=
ndler':
>> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c:64:13: warning: %m is =
only
>>  allowed in syslog(3) like functions [-Wformat=3D]
>>              printf("read from sigfd returned %zd: %m\n", len);
>>              ^
>> Let's use g_strerror() here instead, which is an easy-to-use wrapper
>> around the thread-safe strerror_r() function.
>>
>> While we're at it, also convert the "printf()" in main-loop.c into
>> the preferred "error_report()".
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Do not try to g_free() the strings
>>
>>  hw/misc/tmp421.c | 4 ++--
>>  util/main-loop.c | 3 ++-
>>  util/systemd.c   | 4 ++--
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> There are many uses of %m also in hw/vfio/ but that's Linux stuff.
> Should we change those too or it doesn't matter since it never really
> compiled on NetBSD?
>

It's a gnu (glibc) extension and linux can use alternative libc
implementations. Probably most of them capable to host qemu use %m.

> Anyway, this patch LGTM:
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Thanks,
> Stefano
>
>>
>> diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
>> index 9f044705fa..c0bc150bca 100644
>> --- a/hw/misc/tmp421.c
>> +++ b/hw/misc/tmp421.c
>> @@ -120,7 +120,7 @@ static void tmp421_get_temperature(Object *obj, Vis=
itor *v, const char *name,
>>      int tempid;
>>
>>      if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
>> -        error_setg(errp, "error reading %s: %m", name);
>> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errn=
o));
>>          return;
>>      }
>>
>> @@ -160,7 +160,7 @@ static void tmp421_set_temperature(Object *obj, Vis=
itor *v, const char *name,
>>      }
>>
>>      if (sscanf(name, "temperature%d", &tempid) !=3D 1) {
>> -        error_setg(errp, "error reading %s: %m", name);
>> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errn=
o));
>>          return;
>>      }
>>
>> diff --git a/util/main-loop.c b/util/main-loop.c
>> index e3eaa55866..eda63fe4e0 100644
>> --- a/util/main-loop.c
>> +++ b/util/main-loop.c
>> @@ -61,7 +61,8 @@ static void sigfd_handler(void *opaque)
>>          }
>>
>>          if (len !=3D sizeof(info)) {
>> -            printf("read from sigfd returned %zd: %m\n", len);
>> +            error_report("read from sigfd returned %zd: %s", len,
>> +                         g_strerror(errno));
>>              return;
>>          }
>>
>> diff --git a/util/systemd.c b/util/systemd.c
>> index d22e86c707..1dd0367d9a 100644
>> --- a/util/systemd.c
>> +++ b/util/systemd.c
>> @@ -60,8 +60,8 @@ unsigned int check_socket_activation(void)
>>               * and we should exit.
>>               */
>>              error_report("Socket activation failed: "
>> -                         "invalid file descriptor fd =3D %d: %m",
>> -                         fd);
>> +                         "invalid file descriptor fd =3D %d: %s",
>> +                         fd, g_strerror(errno));
>>              exit(EXIT_FAILURE);
>>          }
>>      }
>> --
>> 2.18.1
>>
>>
>


