Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3036AC04AAD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC315214AE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC315214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNw71-0000jf-7z
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:10:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hNw5O-0008Re-HD
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hNw5M-0005AR-MK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:08:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58366
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hNw5K-00054Q-GR
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:08:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x478wO3i047823
	for <qemu-devel@nongnu.org>; Tue, 7 May 2019 05:08:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sb62u32x1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:08:19 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 7 May 2019 10:08:18 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 7 May 2019 10:08:16 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4798E1i28180542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 7 May 2019 09:08:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C90A4676;
	Tue,  7 May 2019 09:08:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AC05A467B;
	Tue,  7 May 2019 09:08:14 +0000 (GMT)
Received: from [9.152.222.136] (unknown [9.152.222.136])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2019 09:08:13 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190507081251.24307-1-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 7 May 2019 11:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507081251.24307-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19050709-0016-0000-0000-000002791EB4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050709-0017-0000-0000-000032D5C75D
Message-Id: <ee335c4c-468a-3e70-fe7e-02d0d77ef9d1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-07_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905070059
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0b-001b2d01.pphosted.com id x478wO3i047823
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH RFC v2] s390/css: handle CCW_FLAG_SKIP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: pmorel@linux.ibm.com
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/2019 10:12, Cornelia Huck wrote:
> If a ccw has CCW_FLAG_SKIP set, and the command is of type
> read, read backwards, or sense, no data should be written
> to the guest for that command.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> v1 -> v2: fixed checks for command type [Eric]
>=20
> Still only lightly tested (it boots); I don't think I have a tool
> generating channel programs with the skip flag handy.
>=20
> ---
>   hw/s390x/css.c         | 22 ++++++++++++++++++----
>   include/hw/s390x/css.h |  1 +
>   2 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 8fc9e35ba5d3..080ac7e5bc0b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -830,8 +830,12 @@ static int ccw_dstream_rw_noflags(CcwDataStream *c=
ds, void *buff, int len,
>       if (op =3D=3D CDS_OP_A) {
>           goto incr;
>       }
> -    ret =3D address_space_rw(&address_space_memory, cds->cda,
> -                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
> +    if (!cds->do_skip) {
> +        ret =3D address_space_rw(&address_space_memory, cds->cda,
> +                               MEMTXATTRS_UNSPECIFIED, buff, len, op);
> +    } else {
> +        ret =3D 0;
> +    }
>       if (ret !=3D MEMTX_OK) {
>           cds->flags |=3D CDS_F_STREAM_BROKEN;
>           return -EINVAL;
> @@ -928,8 +932,13 @@ static int ccw_dstream_rw_ida(CcwDataStream *cds, =
void *buff, int len,
>       do {
>           iter_len =3D MIN(len, cont_left);
>           if (op !=3D CDS_OP_A) {
> -            ret =3D address_space_rw(&address_space_memory, cds->cda,
> -                                   MEMTXATTRS_UNSPECIFIED, buff, iter_=
len, op);
> +            if (!cds->do_skip) {
> +                ret =3D address_space_rw(&address_space_memory, cds->c=
da,
> +                                       MEMTXATTRS_UNSPECIFIED, buff, i=
ter_len,
> +                                       op);
> +            } else {
> +                ret =3D 0;
> +            }
>               if (ret !=3D MEMTX_OK) {
>                   /* assume inaccessible address */
>                   ret =3D -EINVAL; /* channel program check */
> @@ -968,6 +977,11 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 con=
st *ccw, ORB const *orb)
>  =20
>       cds->count =3D ccw->count;
>       cds->cda_orig =3D ccw->cda;
> +    /* skip is only effective for read, read backwards, or sense comma=
nds */
> +    cds->do_skip =3D (ccw->flags & CCW_FLAG_SKIP) &&
> +        ((ccw->cmd_code & CCW_CMD_BASIC_SENSE) =3D=3D CCW_CMD_BASIC_SE=
NSE ||
> +         (ccw->cmd_code & 0x02) =3D=3D 0x02 /* read */ ||
> +         (ccw->cmd_code & 0x0c) =3D=3D 0x0c /* read backwards */);

I think you should use masks like
((code & 0x3) =3D=3D 2) =3D> READ
((code & 0xf) =3D=3D 0xc) =3D> READ BACKWARD
((code & 0xf) =3D=3D 0x4) =3D> SENSE

Regards,
Pierre




>       ccw_dstream_rewind(cds);
>       if (!(cds->flags & CDS_F_IDA)) {
>           cds->op_handler =3D ccw_dstream_rw_noflags;
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index aae19c427229..7cc183ef4366 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -97,6 +97,7 @@ typedef struct CcwDataStream {
>       int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
>                         CcwDataStreamOp op);
>       hwaddr cda;
> +    bool do_skip;
>   } CcwDataStream;
>  =20
>   /*
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany


