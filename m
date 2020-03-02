Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA14AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7901C2084E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j8IWe79S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7901C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8n0v-0005bS-KF
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j8mzp-0004aY-Lu
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j8mzo-0003sm-1s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:28:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j8mzn-0003qI-P0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:28:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022FNoRR151686;
 Mon, 2 Mar 2020 15:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GyHF9sGu4Y4M5WC3md8JYypkcHsQEr8QtcWnGyDMkTM=;
 b=j8IWe79Ssupq30Xwhb8SspfH50Tpofu4FgOOOV/zohW2XZRF9ZuZqEXNAivMAPrHMJ2e
 fNfedhTn/UGiO3vtRi1pdNWmkEk5Fq5A9tNhJr4BxlWzuXOHutqEq/CeZwsICsCtjTrc
 4Re0+LOBPRVsJWPxAtiW8NdVrWi9xq1lxh3PeAEPRVOPTdO4tAB2hliu/EG5bkfo+4wr
 8bGfvTBQORGl6Qf7DyhOqY6/N9wxLDTGvakzK7ulAPxWBYQiMRvB4GeH+BubCaI/C8PW
 EBd/5cw9RimeSuCgMLlbrjRdf6QOe1YemrXesQuu5+GQE/yplAFUkn7g+fkzb9Eq3nEr sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2yffcu8ftb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 15:28:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022FRmYW037006;
 Mon, 2 Mar 2020 15:28:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yg1rfhuy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 15:28:05 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 022FS28G021970;
 Mon, 2 Mar 2020 15:28:03 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Mar 2020 07:28:02 -0800
Subject: Re: [PATCH v5 00/50] Initial support for multi-process qemu
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <8736as5lto.fsf@linaro.org>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <792aa6ff-3669-9e92-8d93-ec6d82e08df7@oracle.com>
Date: Mon, 2 Mar 2020 10:28:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8736as5lto.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020111
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 022FNoRR151686
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/1/2020 6:57 AM, Alex Benn=C3=A9e wrote:
>=20
> Jagannathan Raman <jag.raman@oracle.com> writes:
>=20
>> Hello
>>   =20
>> Started with the presentation in October 2017 made by Marc-Andre (Red =
Hat)
>> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum =
2018,
>> the multi-process project is now available and presented in this patch=
set.
>> This first series enables the emulation of lsi53c895a in a separate pr=
ocess.
>>
>> We posted the Proof Of Concept patches [2] before the BoF session in 2=
018.
>> Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5] and RFC v4 =
[6].
>>
>> John & Elena presented the status of this project in KVM Forum 2019. W=
e
>> appreciate the in-person and email feedback we received to improve thi=
s
>> patchset. We also received valuable feedback and direction on future
>> improvements from the bi-weekly KVM community conference. We have
>> incorporated all the feedback in the current version of the series, v5.
>>
>> Following people contributed to this patchset:
>>
>> John G Johnson <john.g.johnson@oracle.com>
>> Jagannathan Raman <jag.raman@oracle.com>
>> Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Kanth Ghatraju <kanth.ghatraju@oracle.com>
>> Konrad Wilk <konrad.wilk@oracle.com>
>>
>> For full concept writeup about QEMU disaggregation, refer to
>> docs/devel/qemu-multiprocess.rst. Please refer to
>> docs/qemu-multiprocess.txt for usage information.
>>
>> We are planning on making the following improvements in the future to =
the experimental
>> Qemu multi-process:
>>   - Asynchronous communication channel;
>>   - Performance improvements;
>>   - Libvirt support;
>>   - Enforcement of security policies and privileges control;
>>
>> We welcome all your ideas, concerns, and questions for this patchset.
>=20
> There seem to be quite a few CI failures with this series applied:
>=20
>    https://travis-ci.org/stsquad/qemu/builds/656432858
>    https://app.shippable.com/github/stsquad/qemu/runs/1275/summary/cons=
ole
>    https://gitlab.com/stsquad/qemu/pipelines/122030403
>    https://cirrus-ci.com/build/4577637150490624

Hi Alex,

Thanks for pointing it out.

"Patchew" also identified some errors which we are working on fixing for
the next version. Patchew summarized the errors in the following page:
https://patchew.org/QEMU/cover.1582576372.git.jag.raman@oracle.com/

To confirm we're compliant with Patchew, we are running docker tests
before sending the patches for review next time around.

We'll use the following wiki to trigger "travis-ci" tests before pushing
the branch for review next time around:
https://wiki.qemu.org/Testing/CI/Travis#Testing_Changes_to_Travis

Are shippable, stsquad & cirrus-ci redundant if travis-ci & docker tests
pass?

Thank you very much!
--
Jag

>=20

