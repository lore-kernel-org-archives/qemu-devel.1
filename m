Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E788C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA89222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOtY8pmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA89222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8oLk-0002ql-6y
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j8oKl-0002CJ-Iv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j8oKj-0001Tf-Ss
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:54:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j8oKj-0001TL-IP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:54:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022Gqu2A088987;
 Mon, 2 Mar 2020 16:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XRHVHFqWtKFRww8b4SdnTvLjCIXv10yU31VaqKd8eh0=;
 b=AOtY8pmboIU0Q7Vyr4ieT89/NR7IGkWZxEzqP5v9Nb5aB82MZNpAaMZ72pYD8/DWoMcH
 unFIedhlDxMhwQ2hilMmeXBSLtNfFKHZhpt5dnOYK3O3XMocqozjCqNb3u1Pz261cqN1
 5mcQJ+K3Klp+7F+AoNyi8xB2CrNatyMzYmhuuEfxVw2qNL56kyDLzyBp1bWerlFRgnOw
 rLFEKu50rXKMEFPWn7uVG7MJI4KLrhQ7tQ4rfpGAEjTNmxZb2s5Fb7HNt0xCSo0hexWu
 PFMJOnQQsYShhXlSVP/rG4kd6p4hRgDLRmDo7+WR/21z7FFugsFWnWuoHhKYANIK7/TY WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yghn2vv8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 16:54:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 022Gh9LW082873;
 Mon, 2 Mar 2020 16:54:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2yg1gvfncg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Mar 2020 16:54:00 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 022Grs5w008740;
 Mon, 2 Mar 2020 16:53:54 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 02 Mar 2020 08:53:54 -0800
Subject: Re: [PATCH v5 00/50] Initial support for multi-process qemu
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <8736as5lto.fsf@linaro.org> <792aa6ff-3669-9e92-8d93-ec6d82e08df7@oracle.com>
 <87imjm90un.fsf@linaro.org>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <742aa0fb-686d-5c5e-3a55-25d23e2e506a@oracle.com>
Date: Mon, 2 Mar 2020 11:53:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87imjm90un.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 022Gqu2A088987
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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



On 3/2/2020 11:29 AM, Alex Benn=C3=A9e wrote:
>=20
> Jag Raman <jag.raman@oracle.com> writes:
>=20
>> On 3/1/2020 6:57 AM, Alex Benn=C3=A9e wrote:
>>> Jagannathan Raman <jag.raman@oracle.com> writes:
>>>
>>>> Hello
>>>>     Started with the presentation in October 2017 made by Marc-Andre
>>>> (Red Hat)
>>>> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Foru=
m 2018,
>>>> the multi-process project is now available and presented in this pat=
chset.
>>>> This first series enables the emulation of lsi53c895a in a separate =
process.
>>>>
>>>> We posted the Proof Of Concept patches [2] before the BoF session in=
 2018.
>>>> Subsequently, we posted RFC v1 [3], RFC v2 [4], RFC v3 [5] and RFC v=
4 [6].
>>>>
>>>> John & Elena presented the status of this project in KVM Forum 2019.=
 We
>>>> appreciate the in-person and email feedback we received to improve t=
his
>>>> patchset. We also received valuable feedback and direction on future
>>>> improvements from the bi-weekly KVM community conference. We have
>>>> incorporated all the feedback in the current version of the series, =
v5.
>>>>
>>>> Following people contributed to this patchset:
>>>>
>>>> John G Johnson <john.g.johnson@oracle.com>
>>>> Jagannathan Raman <jag.raman@oracle.com>
>>>> Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>>> Kanth Ghatraju <kanth.ghatraju@oracle.com>
>>>> Konrad Wilk <konrad.wilk@oracle.com>
>>>>
>>>> For full concept writeup about QEMU disaggregation, refer to
>>>> docs/devel/qemu-multiprocess.rst. Please refer to
>>>> docs/qemu-multiprocess.txt for usage information.
>>>>
>>>> We are planning on making the following improvements in the future t=
o the experimental
>>>> Qemu multi-process:
>>>>    - Asynchronous communication channel;
>>>>    - Performance improvements;
>>>>    - Libvirt support;
>>>>    - Enforcement of security policies and privileges control;
>>>>
>>>> We welcome all your ideas, concerns, and questions for this patchset.
>>> There seem to be quite a few CI failures with this series applied:
>>>     https://travis-ci.org/stsquad/qemu/builds/656432858
>>>     https://app.shippable.com/github/stsquad/qemu/runs/1275/summary/c=
onsole
>>>     https://gitlab.com/stsquad/qemu/pipelines/122030403
>>>     https://cirrus-ci.com/build/4577637150490624
>>
>> Hi Alex,
>>
>> Thanks for pointing it out.
>>
>> "Patchew" also identified some errors which we are working on fixing f=
or
>> the next version. Patchew summarized the errors in the following page:
>> https://patchew.org/QEMU/cover.1582576372.git.jag.raman@oracle.com/
>>
>> To confirm we're compliant with Patchew, we are running docker tests
>> before sending the patches for review next time around.
>>
>> We'll use the following wiki to trigger "travis-ci" tests before pushi=
ng
>> the branch for review next time around:
>> https://wiki.qemu.org/Testing/CI/Travis#Testing_Changes_to_Travis
>>
>> Are shippable, stsquad & cirrus-ci redundant if travis-ci & docker
>> tests
>=20
> stsquad is just my user account, hopefully I'm not redundant ;-)

Sorry I didn't realize it's your account. :)

>=20
> They all test slightly different things but you should be able to
> replicate the tests locally.
>=20
> Travis basically tests a bunch of different configuration setups on
> mostly x86 hardware. Unless it's a weird library interaction issue this
> should replicate in your normal build environment.

We'll run Travis CI also before submitting patches next time. The qemu
wiki page for TravisCI says it tests MacOS. So this test should be
sufficient to cover MacOS build tests I suppose.

https://wiki.qemu.org/Testing/CI/Travis#Testing_Changes_to_Travis

>=20
> Shippable are cross compile tests. They use the existing docker
> infrastructure to cross compile for various target architectures. See
> "make docker" and the notes in docs/devel/testing.rst.

We're running these docker tests locally.

Thank you very much!
--
Jag

>=20
> CirrusCI tests MacOS and FreeBSD builds. You can build on the BSD's
> yourself, see "make vm-help". MacOSX is trickier unless you have a Mac
> yourself of course.
>=20
>> pass?
>>
>> Thank you very much!
>=20
>=20

