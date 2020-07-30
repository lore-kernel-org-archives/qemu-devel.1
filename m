Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481E1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9BF2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 13:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9BF2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k18Q8-0004Zr-B8
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 09:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k18P0-0003GH-Tz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:15:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k18Oy-0004eJ-U9
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 09:15:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06UD2q58183957
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:15:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32krmbkjs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:15:13 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06UD2vKk184519
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 09:15:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32krmbkjqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 09:15:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06UCudPB028307;
 Thu, 30 Jul 2020 13:15:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma06ams.nl.ibm.com with ESMTP id 32gcqgp6s6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2020 13:15:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06UDF8wW15008020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 13:15:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9D81A405C;
 Thu, 30 Jul 2020 13:15:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50B7AA405B;
 Thu, 30 Jul 2020 13:15:07 +0000 (GMT)
Received: from marcibm (unknown [9.145.35.48])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 30 Jul 2020 13:15:07 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by the
 spec
In-Reply-To: <20200721124859.GF183198@stefanha-x1.localdomain>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
 <20200721124859.GF183198@stefanha-x1.localdomain>
Date: Thu, 30 Jul 2020 15:15:06 +0200
Message-ID: <87tuxp2lgl.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-30_09:2020-07-30,
 2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300093
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 07:28:21
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 01:48 PM +0100, Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
> On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:
>> Since virtio existed even before it got standardized, the virtio
>> standard defines the following types of virtio devices:
>>=20
>>  + legacy device (pre-virtio 1.0)
>>  + non-legacy or VIRTIO 1.0 device
>>  + transitional device (which can act both as legacy and non-legacy)
>>=20
>> Virtio 1.0 defines the fields of the virtqueues as little endian,
>> while legacy uses guest's native endian [1]. Currently libvhost-user
>> does not handle virtio endianness at all, i.e. it works only if the
>> native endianness matches with whatever is actually needed. That means
>> things break spectacularly on big-endian targets. Let us handle virtio
>> endianness for non-legacy as required by the virtio specification
>> [1]. We will fence non-legacy virtio devices with the upcoming patch.
>>=20
>> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01=
.html#x1-210003
>>=20
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>=20
>> ---
>> Note: As we don't support legacy virtio devices there is dead code in
>> libvhost-access.h that could be removed. But for the sake of
>> completeness, I left it in the code.
>
> Please remove the dead code. It is unlikely that legacy device support
> will be required in the future and it will just confuse people reading
> the code.

Done.

>
>> ---
>>  contrib/libvhost-user/libvhost-access.h |  61 ++++++++++++
>>  contrib/libvhost-user/libvhost-user.c   | 119 ++++++++++++------------
>>  2 files changed, 121 insertions(+), 59 deletions(-)
>>  create mode 100644 contrib/libvhost-user/libvhost-access.h
>>=20
>> diff --git a/contrib/libvhost-user/libvhost-access.h b/contrib/libvhost-=
user/libvhost-access.h
>> new file mode 100644
>> index 000000000000..868ba3e7bfb8
>> --- /dev/null
>> +++ b/contrib/libvhost-user/libvhost-access.h
>> @@ -0,0 +1,61 @@
>> +#ifndef LIBVHOST_ACCESS_H
>
> License/copyright header?

With the dead code removed there is no reason for having
libvhost-access.h so I=E2=80=99ve removed it.

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

