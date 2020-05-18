Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00ACC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B256F207C4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLOC49I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B256F207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajw2-0007wt-VR
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jajvI-0007W0-Mv
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:51:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44646
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jajvH-00012N-KP
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589824290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=He7ThvcnFm2wFbjOrzbF25kFLSMHXWu9nMbLo5VMIV8=;
 b=QLOC49I121nEus4Gc50NJOcXEjNVM7leGJdQLlgpIgaTBRwEOT8aO2C06kE07Loo7dBgpi
 J1yiKrRNaVDLKF3BzGihQ3KQMgvf6b5BMmeK0xm3+rbljwPaEkaSfXjzVyp6Hnb8BwJyin
 a8WE/0+n0deB+HGa9+korvfhwfPQGCU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-rhahiRopOvq7LbUosYgXtw-1; Mon, 18 May 2020 13:51:11 -0400
X-MC-Unique: rhahiRopOvq7LbUosYgXtw-1
Received: by mail-wm1-f71.google.com with SMTP id t62so142594wmt.7
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=Ni+l8uD0+IG3ZAV/ih9DjnPhFlbQl6RVTLm/WDZ3TwM=;
 b=ltgciTETcrdoQxS0W+xGJbWaoDk8Ij5460CzTu+6wDookMw5b+yoCE4T1nj+aZYugx
 blQU4SoKYNGbpgagZ7XEaJXARTU4koZnmwOdmjju2UiPJQMgN7l0e9gForzeYsGYXlFA
 MUv19tDukLSwwcloUsW0daDEj7b4DhZx7aAf6y+wj5H+ofj7BqSum/MVuEWwpo21ywNH
 mliz3gyW4/9E/yBn4AcIaH/AgvOVRqw6M6DdOiZEgRM+5Q3ln1whKWZQn8LcvWbgNG+Z
 o8WFntG9Q/HYSSOROse5u3o46pY09Id/acdS5keLRkp0Paeb20AjuVfwo371W5wHjG6+
 NdkA==
X-Gm-Message-State: AOAM532iGCxT1q7YuS4EXtbnJr8abaay5i/WU1OtMs2L/yQvxu4k7rL9
 6kEunm8TJQFBz/4FygQtViRquh5DP+fy2cMPRdsjmqeG5SVulziegTwt+9MgZvFCEPUQozlPw2x
 I9hjLGPWhWDFQb78=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr498451wmj.101.1589824270801; 
 Mon, 18 May 2020 10:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw250m3kMpcp7dPmK97/Mzc5DoIhWBysCLsqkCO7IMcmugOhEMSSot0e72dnxmv7e7y9Pb3ng==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr498427wmj.101.1589824270525; 
 Mon, 18 May 2020 10:51:10 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c67b6.dip0.t-ipconnect.de. [91.12.103.182])
 by smtp.gmail.com with ESMTPSA id m3sm17421515wrn.96.2020.05.18.10.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 10:51:09 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Date: Mon, 18 May 2020 19:51:07 +0200
Message-Id: <9C8B45AB-1C4B-4BCE-8D0F-45CFCFEDEA4A@redhat.com>
References: <442b7d7a-84a8-9d29-8ccf-c533483840e8@linux.ibm.com>
In-Reply-To: <442b7d7a-84a8-9d29-8ccf-c533483840e8@linux.ibm.com>
To: Collin Walling <walling@linux.ibm.com>
X-Mailer: iPhone Mail (17E262)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 18.05.2020 um 19:34 schrieb Collin Walling <walling@linux.ibm.com>:
>=20
> =EF=BB=BFOn 5/16/20 2:41 AM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200515222032.18838-1-walling@lin=
ux.ibm.com/
>>=20
>>=20
>>=20
>> Hi,
>>=20
>> This series seems to have some coding style problems. See output below f=
or
>> more information:
>>=20
>> Message-id: 20200515222032.18838-1-walling@linux.ibm.com
>> Subject: [PATCH v2 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
>> Type: series
>>=20
>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>> #!/bin/bash
>> git rev-parse base > /dev/null || exit 0
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback base..
>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>=20
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Switched to a new branch 'test'
>> f8cb821 s390: guest support for diagnose 0x318
>> 6b87c59 s390/kvm: header sync for diag318
>> af06627 s390/sclp: add extended-length sccb support for kvm guest
>> 39b848c s390/sclp: use cpu offset to locate cpu entries
>> 1dd8e02 s390/sclp: read sccb from mem based on sccb length
>> aad956d s390/sclp: rework sclp boundary and length checks
>> 428b1e4 s390/sclp: check sccb len before filling in data
>> 850e1b8 s390/sclp: get machine once during read scp/cpu info
>>=20
>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>> 1/8 Checking commit 850e1b88729f (s390/sclp: get machine once during rea=
d scp/cpu info)
>> 2/8 Checking commit 428b1e46e016 (s390/sclp: check sccb len before filli=
ng in data)
>> WARNING: line over 80 characters
>> #23: FILE: hw/s390x/sclp.c:78:
>> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * s=
izeof(CPUEntry))) {
>>=20
>> ERROR: line over 90 characters
>> #48: FILE: hw/s390x/sclp.c:137:
>> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count =
* sizeof(CPUEntry))) {
>>=20
>> total: 1 errors, 1 warnings, 45 lines checked
>>=20
>> Patch 2/8 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>=20
>> 3/8 Checking commit aad956d5ac92 (s390/sclp: rework sclp boundary and le=
ngth checks)
>> 4/8 Checking commit 1dd8e02af7b2 (s390/sclp: read sccb from mem based on=
 sccb length)
>> 5/8 Checking commit 39b848c3be15 (s390/sclp: use cpu offset to locate cp=
u entries)
>> 6/8 Checking commit af06627cc5fb (s390/sclp: add extended-length sccb su=
pport for kvm guest)
>> WARNING: line over 80 characters
>> #91: FILE: hw/s390x/sclp.c:137:
>> +        warn_report("insufficient sccb size to store full read scp info=
 response");
>>=20
>> WARNING: line over 80 characters
>> #115: FILE: target/s390x/cpu_features_def.inc.h:100:
>> +DEF_FEAT(EXTENDED_LENGTH_SCCB, "els", STFL, 140, "Extended-length SCCB =
facility")
>>=20
>> total: 0 errors, 2 warnings, 76 lines checked
>>=20
>> Patch 6/8 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> 7/8 Checking commit 6b87c5992768 (s390/kvm: header sync for diag318)
>> 8/8 Checking commit f8cb821134a7 (s390: guest support for diagnose 0x318=
)
>> ERROR: line over 90 characters
>> #226: FILE: target/s390x/cpu_features_def.inc.h:125:
>> +/* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers rela=
tive to byte-134) */
>>=20
>> WARNING: line over 80 characters
>> #227: FILE: target/s390x/cpu_features_def.inc.h:126:
>> +DEF_FEAT(DIAG_318, "diag_318", SCLP_FAC134, 0, "Control program name an=
d version codes")
>>=20
>> total: 1 errors, 1 warnings, 262 lines checked
>>=20
>> Patch 8/8 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>=20
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>=20
>> Test command exited with code: 1
>>=20
>>=20
>> The full log is available at
>> http://patchew.org/logs/20200515222032.18838-1-walling@linux.ibm.com/tes=
ting.checkpatch/?type=3Dmessage.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>>=20
>=20
> I'll have these fixed for next round, but there's not much I can do with
> regards to the styling in cpu_features_def.inc.h :/

They are perfectly fine :)

>=20
> --=20
> Regards,
> Collin
>=20
> Stay safe and stay healthy
>=20


