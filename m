Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDA5C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B405420868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B405420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTqc-0004y8-0D
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:12:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hTTm3-0001b1-98
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hTTm1-0001SV-6a
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:07:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40874
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1hTTm1-0001MF-1E
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:07:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4MG1oS0081382
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 12:07:21 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sn8774vpj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 12:07:21 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 22 May 2019 17:07:20 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
	by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 22 May 2019 17:07:17 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4MG7GKQ24117726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 22 May 2019 16:07:16 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C10BBE056;
	Wed, 22 May 2019 16:07:16 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32815BE04F;
	Wed, 22 May 2019 16:07:16 +0000 (GMT)
Received: from localhost (unknown [9.86.26.96])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
	Wed, 22 May 2019 16:07:16 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, imammedo@redhat.com,
	david@gibson.dropbear.id.au, xiaoguangrong.eric@gmail.com, mst@redhat.com
In-Reply-To: <155773963257.49142.17067912880307967487.stgit@lep8c.aus.stglabs.ibm.com>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
	<155773963257.49142.17067912880307967487.stgit@lep8c.aus.stglabs.ibm.com>
Date: Wed, 22 May 2019 13:07:13 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052216-0036-0000-0000-00000AC1603F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011143; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01207037; UDB=6.00633871;
	IPR=6.00988012; 
	MB=3.00027006; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-22 16:07:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052216-0037-0000-0000-00004BE69428
Message-Id: <878suy5v7y.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-22_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905220113
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC v2 PATCH 2/3] spapr: Add NVDIMM device support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sbhat@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:

> +    /* Create DT entries for cold plugged NVDIMM devices */
> +    dimms = nvdimm_get_device_list();
> +    for (; dimms; dimms = dimms->next) {
> +        NVDIMMDevice *nvdimm = dimms->data;
> +
> +        spapr_populate_nvdimm_node(fdt, offset, nvdimm);
> +    }
> +    g_slist_free(dimms);

To free the whole list you'll need another variable in the loop above,
right?

Cheers


