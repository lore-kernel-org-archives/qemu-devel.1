Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10435C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C23F206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWgudUDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C23F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjIU-0000r7-P8
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLjHh-0008UH-3n
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLjHe-0005H0-Vb
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:08:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLjHe-0005GY-Qs
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586246913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5/AgJFQtgrpcBC7BIXUImGBvU/0Y8Jb3NuketvXNAM=;
 b=XWgudUDqdPIbAaBp9AGrUMKKNyHv2O6FmMuPM/8J91H+lBveQiXQnaECDi/N2UDhMUGFlW
 kQm+AU1hi6tCj562CtPn+yc5w3GocifnK+Al2SdtNzZKkmpaTrWBRfxyRCOKmO5pz1x61k
 jIT+AZ09qg/f0k9EZ981QMzvA2qoPcE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Wb3RojieOJ6WkDhDG6Kkbw-1; Tue, 07 Apr 2020 04:08:32 -0400
X-MC-Unique: Wb3RojieOJ6WkDhDG6Kkbw-1
Received: by mail-wm1-f72.google.com with SMTP id z24so374257wml.9
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6paSKhujgjlDNZkLLvmEGFeqa/GFA9bs9+4Yq06QIRc=;
 b=qC8xNDOwNwnfMKcqAWWECHrZbcTglHdeHImin9ecUaNqEg7vc8nhJ3wzKZPg8oE0GH
 WeJ9zes3tPG/JeIIaukwEOgE0kcoZ/zRi1ouUgPAdx+hP5qdM4wQI0KOS/ctPNxYJMYN
 2COyGiNqmGPWPfDeDypjkSnUEOaUJRQ9Do5YoaGVJOdGhnX32o/NIef9YYB93GQxgyjH
 ckrD6A8d7dB+J11LbM8VGv5+O1Fr7Di0Bnx3us8dvV/aVRdlCy6PCDLfrcNQdJafV1mI
 okylqGvVtaC1gGjGFLwc6+0g8BtlPSJh6bxj2GOLXufj7wTDJ+4O20AFo3TWoh4CeusJ
 e15w==
X-Gm-Message-State: AGi0PubK0bQuPvDHd8nv7dJia+b71YsRp1sfheJEwMGlJ4tqVGUv630Q
 Ed9I+ueyY2br50mkAV8p5hpO3+4HXrEe1GVQrMtJJQtpRBd/BmEF9G0chdStSgi/+KCBd7AAUa0
 hWVaSq7t2zrgW98s=
X-Received: by 2002:a05:600c:414b:: with SMTP id
 h11mr1084432wmm.9.1586246910913; 
 Tue, 07 Apr 2020 01:08:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypIaGzvTbPnpY5m8+lussMvu5J+rn5pQ4mUoB5Y3PPT0fEUk4RLnqHdxzeygJpXfMj4ElenMWg==
X-Received: by 2002:a05:600c:414b:: with SMTP id
 h11mr1084397wmm.9.1586246910490; 
 Tue, 07 Apr 2020 01:08:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:98c9:e86f:5fe7:54a5?
 ([2001:b07:6468:f312:98c9:e86f:5fe7:54a5])
 by smtp.gmail.com with ESMTPSA id f1sm31644608wrv.37.2020.04.07.01.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 01:08:30 -0700 (PDT)
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: "Liu, Jingqi" <jingqi.liu@intel.com>, Richard Henderson <rth@twiddle.net>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <2c45ec7c-f3ea-2962-47a6-9330f0a2f146@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64ba0e18-2fa3-f5bd-7711-1d91f1dc74da@redhat.com>
Date: Tue, 7 Apr 2020 10:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2c45ec7c-f3ea-2962-47a6-9330f0a2f146@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/04/20 09:29, Liu, Jingqi wrote:
> Ping.
>=20
> Any comments are appreciated.
>=20
> Hi Paolo, Richard,
>=20
> Any comments about this ?

I was hoping to get a review from someone else because I have no way to
test it.  But I've now queued the patch, thanks.

Paolo

>=20
> Thanks,
>=20
> Jingqi
>=20
> On 4/1/2020 11:13 AM, Liu, Jingqi wrote:
>> If the backend file is devdax pmem character device, the alignment
>> specified by the option 'align=3DNUM' in the '-object memory-backend-fil=
e'
>> needs to match the alignment requirement of the devdax pmem character
>> device.
>>
>> This patch fetches the devdax pmem file 'align', so that we can compare
>> it with the NUM of 'align=3DNUM'.
>> The NUM needs to be larger than or equal to the devdax pmem file 'align'=
.
>>
>> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
>> when the NUM of 'align=3DNUM' is less than the devdax pmem file 'align'.
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> ---
>> =C2=A0 exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>> =C2=A0 1 file changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/exec.c b/exec.c
>> index de9d949902..8221abffec 100644
>> --- a/exec.c
>> +++ b/exec.c
>> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
>> =C2=A0 }
>> =C2=A0 +static int64_t get_file_align(int fd)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int64_t align =3D -1;
>> +#if defined(__linux__)
>> +=C2=A0=C2=A0=C2=A0 struct stat st;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fstat(fd, &st) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Special handling for devdax character devices */
>> +=C2=A0=C2=A0=C2=A0 if (S_ISCHR(st.st_mode)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *subsystem_p=
ath =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *subsystem =
=3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subsystem_path =3D
>> g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 major(st.st_rdev),
>> minor(st.st_rdev));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subsystem =3D g_file_read_li=
nk(subsystem_path, NULL);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (subsystem && g_str_has_s=
uffix(subsystem, "/dax")) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_au=
tofree char *align_path =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_au=
tofree char *align_str =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 alig=
n_path =3D
>> g_strdup_printf("/sys/dev/char/%d:%d/device/align",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 major(st=
.st_rdev),
>> minor(st.st_rdev));
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
g_file_get_contents(align_path, &align_str, NULL,
>> NULL)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return g_ascii_strtoll(align_str, NULL, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +#endif /* defined(__linux__) */
>> +
>> +=C2=A0=C2=A0=C2=A0 return align;
>> +}
>> +
>> =C2=A0 static int file_ram_open(const char *path,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 const char *region_name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bool *created,
>> @@ -2275,7 +2311,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t
>> size, MemoryRegion *mr,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RAMBlock *new_block;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 int64_t file_size;
>> +=C2=A0=C2=A0=C2=A0 int64_t file_size, file_align;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Just support these ram flags by=
 now. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert((ram_flags & ~(RAM_SHARED | RAM_PM=
EM)) =3D=3D 0);
>> @@ -2311,6 +2347,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t
>> size, MemoryRegion *mr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 file_align =3D get_file_align(fd);
>> +=C2=A0=C2=A0=C2=A0 if (file_align > 0 && mr && file_align > mr->align) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "backing st=
ore align 0x%" PRIx64
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " is larger than 'align' option 0x"=
 RAM_ADDR_FMT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_align, mr->align);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_block =3D g_malloc0(sizeof(*new_block=
));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_block->mr =3D mr;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_block->used_length =3D size;
>=20


