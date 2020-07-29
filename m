Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4717DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E87D20FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E87D20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ohf-0005lr-Dj
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k0ogW-0004l7-8C
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:12:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49802
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1k0ogR-0002FX-Bt
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:12:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06TG2M3Z182991
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:11:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32jg24ckp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:11:56 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06TG2WFb183953
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:11:56 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32jg24cknf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2020 12:11:56 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TGB4JR018502;
 Wed, 29 Jul 2020 16:11:54 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma05fra.de.ibm.com with ESMTP id 32gcqk36uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2020 16:11:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06TGBpPI25559424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2020 16:11:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34FB1A405C;
 Wed, 29 Jul 2020 16:11:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB5BBA405B;
 Wed, 29 Jul 2020 16:11:50 +0000 (GMT)
Received: from marcibm (unknown [9.145.167.250])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 29 Jul 2020 16:11:50 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by the
 spec
In-Reply-To: <20200729101304-mutt-send-email-mst@kernel.org>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
 <20200721093942-mutt-send-email-mst@kernel.org>
 <20200721184456.1305ca0b.pasic@linux.ibm.com> <87lfj39ajo.fsf@linux.ibm.com>
 <20200729101304-mutt-send-email-mst@kernel.org>
Date: Wed, 29 Jul 2020 18:11:49 +0200
Message-ID: <87zh7is3lm.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-29_10:2020-07-29,
 2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290105
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 12:11:57
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 10:13 AM -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> On Tue, Jul 28, 2020 at 12:52:11PM +0200, Marc Hartmayer wrote:
>> On Tue, Jul 21, 2020 at 06:44 PM +0200, Halil Pasic <pasic@linux.ibm.com=
> wrote:
>> > On Tue, 21 Jul 2020 09:40:10 -0400
>> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >
>> >> On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:
>> >> > Since virtio existed even before it got standardized, the virtio
>> >> > standard defines the following types of virtio devices:
>> >> >=20
>> >> >  + legacy device (pre-virtio 1.0)
>> >> >  + non-legacy or VIRTIO 1.0 device
>> >> >  + transitional device (which can act both as legacy and non-legacy)
>> >> >=20
>> >> > Virtio 1.0 defines the fields of the virtqueues as little endian,
>> >> > while legacy uses guest's native endian [1]. Currently libvhost-user
>> >> > does not handle virtio endianness at all, i.e. it works only if the
>> >> > native endianness matches with whatever is actually needed. That me=
ans
>> >> > things break spectacularly on big-endian targets. Let us handle vir=
tio
>> >> > endianness for non-legacy as required by the virtio specification
>> >> > [1]. We will fence non-legacy virtio devices with the upcoming patc=
h.
>> >> >=20
>> >> > [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1=
-cs01.html#x1-210003
>> >> >=20
>> >> > Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> >> >=20
>> >> > ---
>> >> > Note: As we don't support legacy virtio devices=20=20
>> >>=20
>> >> Who's "we" in this sentence? vhost user supports legacy generally ...
>> >
>> > In that sentence "we" is the library "libvhost-user". I would like
>> > to avoid s390x being an oddball regarding this. Marc's previous
>> > version made an attempt at correct endianness handling for legacy
>> > and non-legacy. That spawned a discussion on how we don't want
>> > legacy devices in this context. This series makes what seemed to be the
>> > consensus reached in that discussion explicit: namely that libvhost-us=
er
>> > does not support legacy-virtio.
>>=20
>> Hi Michael,
>>=20
>> Polite ping - what=E2=80=99s your opinion? Thanks in advance.
>>=20
>> [=E2=80=A6snip]
>
> It's a reasonable limitation, but I also don't see anything
> that verifies that device is modern only.
> E.g. fail setting features if VIRTIO_F_VERSION_1 is not there?

That=E2=80=99s implemented in patch 3 to emphasize how the fencing is done.=
 For
the next series I=E2=80=99ll merge patch 2 and 3.

>
>
>> --=20
>> Kind regards / Beste Gr=C3=BC=C3=9Fe
>>    Marc Hartmayer
>>=20
>> IBM Deutschland Research & Development GmbH
>> Vorsitzender des Aufsichtsrats: Gregor Pillen=20
>> Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
>> Sitz der Gesellschaft: B=C3=B6blingen
>> Registergericht: Amtsgericht Stuttgart, HRB 243294
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

