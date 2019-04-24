Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10507C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE80218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lOcbLRVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE80218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJKwA-0000jo-4F
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 12:39:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hJKvO-0000OQ-3f
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hJKvM-0008F9-Nn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:39:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hJKvM-0008Ar-DM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:39:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OGO9tc174096; Wed, 24 Apr 2019 16:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=eDget3lWloOTyFqztDuvcyOhbTu0fqqxRC0vvPF/anY=;
	b=lOcbLRVlK5PkvG/vbCb/NuFEAER6isx3rhrc+rXxb+tkZVr0Y+1zoW8pqbVVS2o44jko
	RyHg2g/eWRE0OloqqOcBrouaGgtEFGbXFg7c4dL+pwXx0azTkjgn1vJUJL0fqNsGPsKd
	6hWJZFuSIKK224fLEF7sX2p6VgYhtGx3mw3ds7OHpThLWltBqTlyEG9tZ5+xKeFgAcGl
	9wBFxlFq6fI0F03nnbEMHA/t2zeLTe8Dj/w5VZBS9tDKB0w9XF+If3NGJStky8npTLWW
	3+JrV8zo6Mtj+//qj/j3o5I3ZpArTzNiiHmxWTfGCag4uXirMfypNsJ8zAHQWpryMnEr
	Ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rytut3kdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 16:39:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OGcQBC181395; Wed, 24 Apr 2019 16:39:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2s0f0w6cg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2019 16:39:02 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3OGd1vF026109;
	Wed, 24 Apr 2019 16:39:01 GMT
Received: from [192.168.14.112] (/79.180.238.6)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 24 Apr 2019 09:39:01 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190418094101.GA23876@stefanha-x1.localdomain>
Date: Wed, 24 Apr 2019 19:38:57 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=594
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904240124
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9237
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=618
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904240124
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
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
Cc: ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com, pbonzini@redhat.com,
	nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424163857.sIFGGNH8PkaWD-NPwmSCyDlAfYh1YFWVU3DAcoRqPj4@z>



> On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
>> Hi,
>>=20
>> This patch series aims to add supprot to migrate a VM with a =
vhost-scsi device.
>>=20
>> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi =
backend when a
>> VM is stopped (As happens on migratino pre-copy completion).
>>=20
>> The 2nd patch adds ability to save/load vhost-scsi device state in =
VMState.
>>=20
>> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin =
to specify
>> it's setup supports vhost-scsi migratino. For more detailed =
information on why
>> this is valid, see commit message of specific patch.
>>=20
>> Regards,
>> -Liran
>=20
> Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> with vhost-user-scsi.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Gentle Ping.

-Liran=

