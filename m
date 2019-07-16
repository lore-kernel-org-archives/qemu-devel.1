Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71963C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487E6206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487E6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIHI-0002JY-Is
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hnIH7-0001oN-AD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hnIH6-0004XA-Bt
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:53:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13962
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hnIH6-0004Vf-6M
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:53:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6G7rEQn107599
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:53:21 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ts9a5k59q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 03:53:20 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Tue, 16 Jul 2019 08:53:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Jul 2019 08:53:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6G7rEqQ57606364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 07:53:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEABF4C04A;
 Tue, 16 Jul 2019 07:53:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E7BC4C046;
 Tue, 16 Jul 2019 07:53:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.75.211])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2019 07:53:12 +0000 (GMT)
To: Fabiano Rosas <farosas@linux.ibm.com>, imammedo@redhat.com,
 david@gibson.dropbear.id.au, xiaoguangrong.eric@gmail.com, mst@redhat.com
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
 <155773963257.49142.17067912880307967487.stgit@lep8c.aus.stglabs.ibm.com>
 <878suy5v7y.fsf@linux.ibm.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Tue, 16 Jul 2019 13:23:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <878suy5v7y.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071607-0020-0000-0000-00000353F5B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071607-0021-0000-0000-000021A7C06E
Message-Id: <0cbf52ee-5ba2-5851-0ae3-cc9d699b41ab@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160100
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x6G7rEQn107599
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC v2 PATCH 2/3] spapr: Add NVDIMM device support
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Fabiano,


On 05/22/2019 09:37 PM, Fabiano Rosas wrote:
> Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:
>
>> +    /* Create DT entries for cold plugged NVDIMM devices */
>> +    dimms =3D nvdimm_get_device_list();
>> +    for (; dimms; dimms =3D dimms->next) {
>> +        NVDIMMDevice *nvdimm =3D dimms->data;
>> +
>> +        spapr_populate_nvdimm_node(fdt, offset, nvdimm);
>> +    }
>> +    g_slist_free(dimms);
> To free the whole list you'll need another variable in the loop above,
> right?

Nope. The=C2=A0 g_slist_free() takes care of freeing the list node pointe=
rs.

As I am iterating using the original dimms variable, I would still not
be freeing the list here though, fixing that in next version.

Valgrind pointed out few more leaks in many places, will fix them all.

>
> Cheers


