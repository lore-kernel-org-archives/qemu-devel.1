Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9207EC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 20:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DC8206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 20:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NaljkcF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DC8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIewx-0002zu-GT
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 16:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iIewI-0002Yn-Tj
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 16:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iIewH-0007zl-FD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 16:21:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iIewH-0007yk-6B
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 16:21:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9AKIqpM171643;
 Thu, 10 Oct 2019 20:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=aMUkDkCw1kfIKk98PhnSEj2vjWLMa+bNr5G8UKKHJug=;
 b=NaljkcF5+IsuGpws90JI6HBlZI37/bex+5xEyr+kK/+uMv5YxmRC9N8CE31n2ZfFJl+8
 VWGK9jGRowResL2jniLmqqP9ZWVippQbAv97kXxXAujxlwt0dzgyuF0hQqqi4Dj/kIJF
 chQTlTqWKk0jdXBnoIY9Pt222YCgtQ7aqZzRRu0N3I4yNhF+2T0fAe5oea9VDMW5mrj8
 PrGFQJl1FFlSbg9xD4VQ46q44EzG8IAZ5d8vjSDuFJEaDNFI8DinNGUnkc40J08uq5qm
 TJF2MxxcNFI4yXjODIKWn1AuVwolq/SorzMVNHRSpN7wSi4A81RIR+m3C3rCldYIMcFY 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2vektrwaus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 20:21:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9AKJXUl040369;
 Thu, 10 Oct 2019 20:21:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2vh8k3m23a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2019 20:21:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9AKLFdo007468;
 Thu, 10 Oct 2019 20:21:15 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 10 Oct 2019 13:21:15 -0700
Subject: Re: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define
 proxy-link object
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
 <20190912153435.GM23174@stefanha-x1.localdomain>
 <20191009133724.GP5747@stefanha-x1.localdomain>
 <20191009175831.GA5214@heatpipe>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <1aabb120-0173-f4fe-250d-0688815e54a0@oracle.com>
Date: Thu, 10 Oct 2019 16:21:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191009175831.GA5214@heatpipe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100171
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, thuth@redhat.com,
 berrange@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/9/2019 1:58 PM, Elena Ufimtseva wrote:
> On Wed, Oct 09, 2019 at 02:37:24PM +0100, Stefan Hajnoczi wrote:
>> On Thu, Sep 12, 2019 at 05:34:35PM +0200, Stefan Hajnoczi wrote:
>>> On Tue, Sep 03, 2019 at 04:37:33PM -0400, Jagannathan Raman wrote:
>>>> +    msg->num_fds = 0;
>>>> +    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
>>>> +         chdr = CMSG_NXTHDR(&hdr, chdr)) {
>>>> +        if ((chdr->cmsg_level == SOL_SOCKET) &&
>>>> +            (chdr->cmsg_type == SCM_RIGHTS)) {
>>>> +            fdsize = chdr->cmsg_len - CMSG_LEN(0);
>>>> +            msg->num_fds = fdsize / sizeof(int);
>>>> +            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
>>>
>>> Please validate num_fds before memcpy to prevent the buffer overflow.
>>>
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (msg->size && msg->bytestream) {
>>>> +        msg->data2 = calloc(1, msg->size);
>>>> +        data = msg->data2;
>>>> +    } else {
>>>> +        data = (uint8_t *)&msg->data1;
>>>> +    }
>>>> +
>>>> +    if (msg->size) {
>>>> +        do {
>>>> +            rc = read(sock, data, msg->size);
>>>> +        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>>>> +    }
>>>
>>> Please validate size to prevent the buffer overflow.
>>
>> I didn't see a reply so I want to highlight that the effort to introduce
>> isolation between devices is pointless if the communications link is not
>> coded securely.
>>
>> Multi-process QEMU adds no security if one process can corrupt the
>> memory of another process by sending invalid inputs.  Please audit the
>> code.
>>
> 
> Hi Stefan
> 
> Sorry for not replyingi earlier. We have reviewed all the comments we received
> on the this patch series and working on the code improvements which are
> mostly done.
> We recognize the importance of the secure code and making efforts to
> eliminate as much as possible these mentioned unverified inputs along with other changes.
> 
> The changes will be in the next version of the patchset we are actively
> working on.
> 
> The other your suggestion about reducing the number of syscalls by
> stuffing all of the parts of the message in the io_vec and using one
> sendmsg/recvmsg cannot be done at this point with the way we have
> organized the messages structure. But we are looking into the
> adoption of shared ring buffer for communication channel instead of the
> current mechanism to reduce the number of syscalls.
> Though this change will not be a part of the next patchset as we are
> tinkering with live migration.
> But all other recommendations and comments will be taken into account.

Thanks Elena!

Hi Stefan,

I'd like to confirm that we are targeting Live Migration for next
version and we are also discussing another use case for this project.

The other use case we are discussing is testing emulated devices (as 
separate processes) with libfuzzer. We could test corner cases and the 
handling of error conditions on emulated devices using this approach.

Thanks!
--
Jag

> 
> Regards,
> Elena & Jag & JJ.
> 
> 
>> Stefan
> 
> 
> 

