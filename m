Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9371EC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 23:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559C8206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 23:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eeu4v806"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559C8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKA6z-0003Hy-7X
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 19:18:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hKA5j-0002Rj-Bs
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 19:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.d.li@oracle.com>) id 1hK9rE-0004c4-AX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 19:02:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.d.li@oracle.com>) id 1hK9rC-0004Pi-8g
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 19:02:14 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QMxGvK109576; Fri, 26 Apr 2019 23:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : subject : from
	: to : cc : message-id : references : in-reply-to : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=IicR6o7I/iKgcCT54m+bHBgwkUQWiO4WyykJf8HwDd8=;
	b=eeu4v806fcFb66kSRvDARkIypZoZuuuW+QY8eJ9OddEtEhzKgup97kioNFhYWtUi+g7L
	A7PgE3knQDdt81ewLyXy76BKri678WAxIGCD2JdadqysXRxG0WS9jMYsewzHkTZ6cI25
	u7A3zOkkns67Z0MdsD0VkQ6DrIkXe+n4jDGPmCG5ex/AESR3G+KPUcNK+91CwJtcsBjW
	BpSHkczrTE2wbcUF7aVvMjn/n/ATZ3qX7vWST7O3d0hxriCXIFSgd/ee/oxMuDTHCP7Q
	d4M2yhcFj+ionRZYMk/AB7HwdnCgYBxESXy4jt0KkeUiprkPQm3sNe6abm7cgFmraH6c
	nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 2ryrxdgnjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2019 23:02:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QN0VsF085004; Fri, 26 Apr 2019 23:02:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2s3y7nhyf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2019 23:02:03 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3QN23tO027628;
	Fri, 26 Apr 2019 23:02:03 GMT
Received: from [10.74.110.113] (/10.74.110.113)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 26 Apr 2019 16:02:02 -0700
User-Agent: Microsoft-MacOutlook/10.15.0.190115
Date: Fri, 26 Apr 2019 16:02:01 -0700
From: Wei Li <wei.d.li@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <7044D39A-8D7B-41F7-B8C3-DC2214E6826A@oracle.com>
Thread-Topic: [Qemu-devel] Following up questions related to QEMU and I/O
	Thread
References: <5FF901C1-0AA5-4308-A65C-C448D0A2BA63@oracle.com>
	<20190305172905.GD13806@stefanha-x1.localdomain>
	<2D7F11D0-4A02-4A0F-961D-854240376B17@oracle.com>
	<20190401090724.GA643@stefanha-x1.localdomain>
	<CC372DF3-1AC6-46B5-98A5-21159497034A@oracle.com>
	<60340EAF-4C85-4798-9999-34F1A37E2086@oracle.com>
	<898ef1d4-bfa2-9952-8ceb-f1282b85e29c@oracle.com>
	<20190416092042.GB32709@stefanha-x1.localdomain>
	<8E5AF770-69ED-4D44-8A25-B51344996D9E@oracle.com>
	<3F7E854A-3C1D-4204-8C35-893FC0614796@oracle.com>
	<20190423120453.GF32465@stefanha-x1.localdomain>
	<44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
In-Reply-To: <44520476-d6a8-2e3f-1602-388e2e1e874e@redhat.com>
Mime-version: 1.0
Content-type: text/plain; charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9239
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=904
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904260146
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9239
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=931
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904260147
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] Following up questions related to QEMU and I/O
 Thread
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
	Dongli Zhang <dongli.zhang@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426230201.X-KM2_oIWyPqdUAsi8e__X3PZwGEjJH4iI28Vuo7Hks@z>

Thanks Stefan and Paolo for your response and advice!

Hi Paolo,

As to the virtio-scsi batch I/O submission feature in QEMU which you mentio=
ned, is this feature turned on by default in QEMU 2.9 or there is a tunable =
parameters to turn on/off the feature?

Thanks,
Wei

=EF=BB=BFOn 4/26/19, 1:14 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:

    On 23/04/19 14:04, Stefan Hajnoczi wrote:
    >>In addition, does Virtio-scsi support Batch I/O Submission feature
    >>which may be able to increase the IOPS via reducing the number of
    >>system calls?
    >
    >I don't see obvious batching support in drivers/scsi/virtio_scsi.c.
    >The Linux block layer supports batching but I'm not sure if the SCSI
    >layer does.
   =20
    I think he's referring to QEMU, in which case yes, virtio-scsi does
    batch I/O submission.  See virtio_scsi_handle_cmd_req_prepare and
    virtio_scsi_handle_cmd_req_submit in hw/scsi/virtio-scsi.c, they do
    blk_io_plug and blk_io_unplug in order to batch I/O requests from QEMU
    to the host kernel.



