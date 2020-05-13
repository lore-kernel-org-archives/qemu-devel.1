Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75649C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65C02065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y3yJ2kE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65C02065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxge-0003m5-DP
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYxg5-0003MS-Sg
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:08:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYxg3-0000y7-SY
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:08:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DK2fg6092578;
 Wed, 13 May 2020 20:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qT6LnDLnUFMDzV0WRXlel76oz3AGdTtarK7lXAbJhPo=;
 b=Y3yJ2kE6Eom1I5RP+UFvxSxHoPh7vfTmeT154RGWnb8WIjcZQfJqzjKAO0AiuNkDyJqY
 a/jjVLk9Q7a+911EQPmWcse6IPCyNLkPZF5In+S8NvVyUMcxS2QRbTK0CVunCKfqhSsV
 tsXAykbjyjP6Q65GaDve0Qw15uEsWWmGJnpwk5PjVCBOef0aGkG8HrmLZj3hnV2Rhu9M
 2m4kSAO/y8astvLL3u1Vad9LTqHmDEaxeVttamKsQLGqkU6XHJfinyYgwUjzf2DhVyVN
 bhXORdymSFDn3WW6XhztQIi0HeJjzsHTbQ0vPxUnoR5SZfwxaZZ3bEoGW9mq1Kc7218/ Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 3100yfxgeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 May 2020 20:08:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DK45eJ033664;
 Wed, 13 May 2020 20:08:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 3100yf95du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 20:08:12 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DK8AAO008633;
 Wed, 13 May 2020 20:08:10 GMT
Received: from dhcp-10-39-201-236.vpn.oracle.com (/10.39.201.236)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 May 2020 13:08:09 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200513172547.48d87447@redhat.com>
Date: Wed, 13 May 2020 16:08:06 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <C83E7EA9-7813-4C81-A635-E1A513902330@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512084855.GC1191162@redhat.com>
 <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
 <20200513084042.GA317907@stefanha-x1.localdomain>
 <20200513172547.48d87447@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=3 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=3 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130171
Received-SPF: pass client-ip=156.151.31.86; envelope-from=jag.raman@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:48:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 Daniel Berrange <berrange@redhat.com>, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 13, 2020, at 11:25 AM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>=20
> On Wed, 13 May 2020 09:40:42 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
>> On Tue, May 12, 2020 at 07:56:33AM -0400, Jag Raman wrote:
>>>=20
>>>=20
>>>> On May 12, 2020, at 4:48 AM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>>>>=20
>>>> On Wed, Apr 22, 2020 at 09:13:36PM -0700, =
elena.ufimtseva@oracle.com wrote: =20
>>>>> From: Jagannathan Raman <jag.raman@oracle.com>
>>>>>=20
>>>>> Allow RAM MemoryRegion to be created from an offset in a file, =
instead
>>>>> of allocating at offset of 0 by default. This is needed to =
synchronize
>>>>> RAM between QEMU & remote process. =20
>>>>=20
>>>> Can you elaborate on why remote processes require the RAM to be =
offset
>>>> from zero ? =20
>>>=20
>>> Hi Daniel,
>>>=20
>>> As it turns out, the RAM is scattered across the physical address =
space
>>> (system_memory) of QEMU. Therefore, the system memory is composed
>>> of multiple sections of RAM, and some sections start at a non-zero =
RAM
>>> offset.
>>>=20
>>> As a result, the remote process needs the ability to map these RAM
>>> sections into system_memory. =20
>>=20
>> To explain a bit more, my understanding is that the offset is
>> specifically for mmap(2). As Jag alluded to, multiple sections can =
use a
>> single backing RAM file. These sections have different offsets in the
>> file.
>>=20
>> Jag, maybe you can include a concrete explanation like the following =
in
>> the commit description:
>>=20
>> Launch QEMU like this:
>>=20
>>  qemu-system-x86_64 -mem-path /dev/shm -m 8G
>>=20
>> There is only one RAM file descriptor:
>>=20
>>  $ cat /proc/$(pidof qemu)/fd
>>  ...
>>  lrwx------. 1 stefanha stefanha 64 May 13 09:34 19 -> =
'/dev/shm/qemu_back_mem.pc.ram.7YAlqn (deleted)'
>>=20
>> But the memory tree shows that single file is split into multiple =
ranges
>> of guest physical address space:
>>=20
>>  (qemu) info mtree
>>  memory-region: system
>>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>    0000000000000000-00000000bfffffff (prio 0, i/o): alias =
ram-below-4g @pc.ram 0000000000000000-00000000bfffffff
>>    ...
>>    0000000100000000-000000023fffffff (prio 0, i/o): alias =
ram-above-4g @pc.ram 00000000c0000000-00000001ffffffff
>>=20
>> This means QEMU needs to send two regions to the remote device =
process.
>> They both mmap the same file but from different starting file =
offsets.
>=20
> are we talking here about GPA offests her or about host offsets in =
mmaped host file?
> If it's the later then above mtree doesn't show true picture (those =
entries are just aliases),
> main guest RAM is allocated as a single continuous chunk (so far) =
which belongs
> to a memory-backend.

Thanks for the info about =E2=80=98mtree=E2=80=99 QMP option. We=E2=80=99l=
l use that to better explain the need for offset
during memory allocation.

As we can observe from the =E2=80=98mtree=E2=80=99 output, different =
sections of system memory vector into the
RAM. Since we have only one file descriptor available for all of RAM, we =
need to mmap() these
sections at different offsets within the memory file.

Hey Igor, the offset passed into the mmap() syscall is the offset within =
host file. Thanks for
pointing out that these are aliases. I believe the mmap() operation is =
equivalent to the =E2=80=9Calias=E2=80=9D
operation within MemoryRegion framework. We are sending the =E2=80=98fd=E2=
=80=99, =E2=80=98offset=E2=80=99 within the fd and
the size of these RAM regions to the remote device over the unix socket. =
Hopefully, this looks
good to you.

Thanks!
--
Jag

>=20
>> Stefan
>=20
>=20


