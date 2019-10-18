Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC9DCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FA121925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FA121925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTWF-0004jT-PE
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iLTUY-0003WD-BR
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iLTUX-0007fr-0Y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:44:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iLTUW-0007fa-Ow
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:44:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9IEbhAG027402
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vqd4fp6kn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:29 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Fri, 18 Oct 2019 15:44:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 18 Oct 2019 15:44:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9IEiNGu51445826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2019 14:44:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F4EFAE04D;
 Fri, 18 Oct 2019 14:44:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E47FEAE045;
 Fri, 18 Oct 2019 14:44:22 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.44])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2019 14:44:22 +0000 (GMT)
Subject: Re: Default CPU models on s390x and ppc64
To: David Hildenbrand <david@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, David Hildenbrand <dhildenb@redhat.com>,
 David Gibson <dgibson@redhat.com>
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Fri, 18 Oct 2019 16:44:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19101814-0016-0000-0000-000002B95019
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101814-0017-0000-0000-0000331A7E66
Message-Id: <dc2f8cce-1875-adfc-02e6-429191014f5e@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-18_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180137
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9IEbhAG027402
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 17.10.19 17:18, David Hildenbrand wrote:
> On 17.10.19 17:16, Jiri Denemark wrote:
>> Hi David and David,
>>
>> I'm working on libvirt's support [1] for query-machines'
>> default-cpu-type, which is supposed to return the type of the default
>> CPU model that QEMU uses for each machine type. Rather than hard codin=
g
>> the default in libvirt (which we currently do on x86), we ask QEMU for
>> the default CPU model and use it unless a user asks for a specific CPU
>> model explicitly.
>>
>> We use query-cpu-definitions for translating the default CPU type to t=
he
>> actual CPU model we need to pass to -cpu by looking up the CPU model
>> with matching typename.
>>
>> However, all this seems to work only with TCG on both s390x and ppc64.
>> The issues I met with KVM on each architecture are described below.
>>
>> On ppc64 the default CPU type reported by query-machines is
>> power*-powerpc64-cpu, while IIUC QEMU would effectively use -cpu host =
by
>> default. In fact -cpu power8 is mostly just a fancy alias to -cpu host
>> on a Power8 machine. But QEMU even rewrites typename of the current ho=
st
>> CPU model to host-powerpc64-cpu. Which means on a Power8 host the powe=
r8
>> CPU model would have typename=3Dhost-powerpc64-cpu while the default C=
PU
>> type would still use power8*-powerpc64-cpu. Thus we may just fail to
>> find any CPU model corresponding to the default CPU model.
>>
>> And to make it even worse, the default CPU model changes with machine
>> type. E.g., pseries-3.1 uses power8_v2.0-powerpc64-cpu while pseries-4=
.2
>> uses power9_v2.0-powerpc64-cpu. However, starting QEMU with pseries-4.=
2
>> machine type and the reported default -cpu power9 fails on any
>> non-Power9 host. That said QEMU just lies about the default CPU model.
>>
>> So for all combinations of (pseries-3.1, pseries-4.2) machine types an=
d
>> (Power8, Power9) hosts, one will get the following mixed results:
>>
>> - pseries-3.1 on Power8: no default CPU model will be detected, QEMU
>> =C2=A0=C2=A0 starts fine with it's own default
>> - pseries-4.2 on Power9: same as above
>> - pseries-3.1 on Power9: -cpu power8 (not sure if this works, though)
>> - pseries-4.2 on Power8: -cpu power9, QEMU doesn't start
>>
>>
>> This situation on s390x is not so complicated, but not really better.
>> The default CPU is said to be "qemu" for all machine types, which work=
s
>> fine for TCG domains, but it doesn't work on KVM because QEMU complain=
s
>> that some features requested in the CPU model are not available. In
>> other words the "qemu" CPU model is not runnable on KVM. This a bit
>> similar to what happens on x86_64, but QEMU just ignores missing
>> features and starts happily there.
>=20
> The default model under KVM is "host", under TCG it's "qemu". We should=
 not use "qemu" under KVM, although it might work on some setups ...
>=20
> Where/how is this default model detected?

I would prefer it libvirt would use the equivalent of mode=3Dhost-model b=
y
default. Is this what this series is all about?


