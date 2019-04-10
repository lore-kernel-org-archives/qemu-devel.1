Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329BFC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 22:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA69720830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CxS63sxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA69720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hELyv-0002SG-MJ
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 18:46:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hELy2-0001x7-T5
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 18:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hELy1-0007dm-Lj
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 18:45:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hELy1-0007cO-8Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 18:45:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3AMhhRC126508; Wed, 10 Apr 2019 22:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=3hABHFdX/XGhHeoz+jYqwWTbvdPgNNNDHbB6OUNtkFk=;
	b=CxS63sxZ3vRKnQrz4EteNNRrL16CxtRcCUxJzmz4WzWz1c8cUv8hPN3Ws0bZlNDawIsK
	m9jgIKxISx4hFI0qsMpQ+zEbwerhsK41vkp2yardX0vhlwc0uCSN9eWbHcVuwzke5rn0
	li+oJ1V/Jv4VDaG1L1cIEhnYhbQ/xMJj7yYTh/17seF/yF3fCCYZfr/TpQSbvnVt4blV
	37EpA645zmw4UCzmGep2w1qlNBhURJShIQCaP7S1MFJUD4I+fwlxyDCMtUmva71vuBU9
	cHLoMGWB3STQE0uw+D+K96OCo4P0i1zse5ZudkNquu8NpSN8v3PimG6Tgj/vbVxKINOI
	/Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2rpmrqdnsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 22:45:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3AMiV9G138409; Wed, 10 Apr 2019 22:45:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 2rph7tf6uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2019 22:45:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3AMj9LM000537;
	Wed, 10 Apr 2019 22:45:09 GMT
Received: from [192.168.14.112] (/109.66.220.144)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 10 Apr 2019 15:45:09 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190409142925.GG16944@stefanha-x1.localdomain>
Date: Thu, 11 Apr 2019 01:45:06 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC01E2C2-1944-42C5-A944-220EE6F8A489@oracle.com>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<20190409142925.GG16944@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904100148
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9223
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904100148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
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
Cc: Nir Weiner <nir.weiner@oracle.com>, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410224506.4z08Fp-42VkDOTjmB70EG7elMd83RKSeV-tekJOwUgY@z>



> On 9 Apr 2019, at 17:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
>> Originally migration was not possible with vhost-scsi because
>> as part of migration, the source host target SCSI device state
>> needs to be saved and loaded into the destination host target SCSI
>> device. This cannot be done by QEMU.
>>=20
>> As this can be handled either by external orchestrator or by having
>> shared-storage (i.e. iSCSI), there is no reason to limit the
>> orchestrator from being able to explictly specify it wish to enable
>> migration even when VM have a vhost-scsi device.
>>=20
>> Liran Alon (1):
>>  vhost-scsi: Allow user to enable migration
>>=20
>> Nir Weiner (2):
>>  vhost-scsi: The vhost device should be stopped when the VM is not
>>    running
>>  vhost-scsi: Add vmstate descriptor
>>=20
>> hw/scsi/vhost-scsi.c                  | 57 =
++++++++++++++++++++++-----
>> include/hw/virtio/vhost-scsi-common.h |  1 +
>> 2 files changed, 48 insertions(+), 10 deletions(-)
>=20
> What happens when migration is attempted while there is in-flight I/O =
in
> the vring?
>=20
> Stefan

What do you define as =E2=80=9Cin-flight I/O=E2=80=9D? I think there is =
a need to separate the discussion here to multiple cases:

1) The I/O request was written to vring but guest have not yet written =
to doorbell:
This is the simplest case. No state is lost as the vring is migrated =
from source host to dest host as part of guest memory migration.
Also, the vring properties (E.g. Guest base address) is transferred from =
source host to dest host as part of vhost-scsi VMState.
(See patch 2/3 of series which adds VMSTATE_VIRTIO_DEVICE to vhost-scsi =
VMState which will cause virtio_save() to save vring on migration =
stream).

2) The I/O request was written to vring and the guest have written to =
doorbell:
The I/O request was submitted and processed by the vhost-scsi backend. =
Therefore, the I/O request was sent to the remote TGT server.
If the the TGT server has performed the write and returned ACK but the =
ACK was not received by guest, then guest is expected to initiate the =
write again.
(Similar to what happens for a momentary TGT server downtime / network =
downtime). So this isn=E2=80=99t suppose to be an issue.

An interesting case is what happens if there is an in-flight I/O write =
request (Request A) performed by source host that was sent already over =
the network to the TGT server.
But until it reaches the TGT server, the VM running on dest performs =
another I/O write request (Request B) to the same sector which results =
in Request B being handled by TGT server before Request A. In this case, =
it is possible that TGT server will actually overwrite data written by =
Request B with older request Request A that arrived to TGT later.
(This will be the result in case of using an iSCSI TGT).
But, there are various techniques that TGT server can implement to avoid =
this. For example, fencing-out requests from any older iSCSI connection =
than the most recent one.

In general, vhost-scsi migration shouldn=E2=80=99t be different than =
vhost-net or vhost-vsock migration.
The only thing that may be problematic in case of vhost-scsi is because =
the source host target SCSI device state may need to be saved and =
restored on dest host target SCSI device.
However, when using a shared-storage via iSCSI, this concern is =
irrelevant. Therefore, this patch series attempts to allow the admin to =
remove the migration-blocker limitation from vhost-scsi if it is using =
such a setup. As described in cover-letter.

-Liran









