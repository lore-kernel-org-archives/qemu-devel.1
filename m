Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57386C33C99
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D7A22CEA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPw/AqkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D7A22CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUuv0-0004AM-LG
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iUusR-00022O-3r
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iUusP-00028p-2w
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:48:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iUusO-00027L-QA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:48:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFZ9Bf160331;
 Wed, 13 Nov 2019 15:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=zal3IXDbm4zRvGavXFIFMsNlQA8ZSPkdl9eBrhPnbLc=;
 b=cPw/AqkFphFdd5/5foHPMOfMxBdth7Ib+cx72eQzsy7hpjADtB4vnwqUf3s9KWXnxrDb
 tJf3OlRhtTARqZx8WLDxEU6RPBIG/YDlOBExEjbWLAJArgRqcdLAIY2KymNu/9R+dN2C
 NCb2SE8Z3AFy05T50H2TQoXEw9dHfUrCutkK1ekAmKd56ZlNTMn8gdPOWXiAKDgOeM3S
 QvR3tPNNaOwP4Aa1e3IQk9M1Ysy65DOl/Uw0LDGS2WOOco8vuY3Q6VCpnMCZiqtHqVYZ
 ZcRp8/zaE2MY6myWEHsmNuR2qu1CTzfSMTL2l/uyUwmRUchdGJpdtpQ5lTXCs3uJ1F+m WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2w5mvtwc4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 15:48:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xADFcwsk137537;
 Wed, 13 Nov 2019 15:48:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2w7j07w3jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Nov 2019 15:48:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xADFm1TB027488;
 Wed, 13 Nov 2019 15:48:01 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 13 Nov 2019 07:48:01 -0800
Subject: Re: [RFC v4 PATCH 07/49] multi-process: define mpqemu-link object
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
 <20191111164105.GK402228@stefanha-x1.localdomain>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <6babb1f8-7a62-86a8-2045-c54a240097e0@oracle.com>
Date: Wed, 13 Nov 2019 10:47:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20191111164105.GK402228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911130143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911130143
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/11/2019 11:41 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 24, 2019 at 05:08:48AM -0400, Jagannathan Raman wrote:
>> +int mpqemu_msg_recv(MPQemuLinkState *s, MPQemuMsg *msg, MPQemuChannel *chan)
>> +{
>> +    int rc;
>> +    uint8_t *data;
>> +    union {
>> +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
>> +        struct cmsghdr align;
>> +    } u;
>> +    struct msghdr hdr;
>> +    struct cmsghdr *chdr;
>> +    size_t fdsize;
>> +    int sock = chan->sock;
>> +    QemuMutex *lock = &chan->recv_lock;
>> +
>> +    struct iovec iov = {
>> +        .iov_base = (char *) msg,
>> +        .iov_len = MPQEMU_MSG_HDR_SIZE,
>> +    };
>> +
>> +    memset(&hdr, 0, sizeof(hdr));
>> +    memset(&u, 0, sizeof(u));
>> +
>> +    hdr.msg_iov = &iov;
>> +    hdr.msg_iovlen = 1;
>> +    hdr.msg_control = &u;
>> +    hdr.msg_controllen = sizeof(u);
>> +
>> +    qemu_mutex_lock(lock);
>> +
>> +    do {
>> +        rc = recvmsg(sock, &hdr, 0);
>> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>> +
>> +    if (rc < 0) {
>> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is %d,"
>> +                      " sock %d\n", __func__, rc, errno, sock);
>> +        qemu_mutex_unlock(lock);
>> +        return rc;
>> +    }
>> +
>> +    msg->num_fds = 0;
>> +    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
>> +         chdr = CMSG_NXTHDR(&hdr, chdr)) {
>> +        if ((chdr->cmsg_level == SOL_SOCKET) &&
>> +            (chdr->cmsg_type == SCM_RIGHTS)) {
>> +            fdsize = chdr->cmsg_len - CMSG_LEN(0);
>> +            msg->num_fds = fdsize / sizeof(int);
>> +            if (msg->num_fds > REMOTE_MAX_FDS) {
>> +                /*
>> +                 * TODO: Security issue detected. Sender never sends more
>> +                 * than REMOTE_MAX_FDS. This condition should be signaled to
>> +                 * the admin
>> +                 */
>> +                qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
>> +                return -ERANGE;
>> +            }
>> +
>> +            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (msg->size && msg->bytestream) {
>> +        msg->data2 = calloc(1, msg->size);
>> +        data = msg->data2;
>> +    } else {
>> +        data = (uint8_t *)&msg->data1;
>> +    }
>> +
>> +    if (msg->size) {
>> +        do {
>> +            rc = read(sock, data, msg->size);
>> +        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
>> +    }
>> +
>> +    qemu_mutex_unlock(lock);
>> +
>> +    return rc;
>> +}
> 
> This code is still insecure.  Until the communication between processes
> is made secure this series does not meet its goal of providing process
> isolation.
> 
> 1. An attacker can overflow msg->data1 easily by setting msg->size but
>     not msg->bytestream.

We will add a check to ensure that msg->size is less than msg->data1 if
msg->bytestream is not set.

> 2. An attacker can allocate data2, all mpqemu_msg_recv() callers
>     need to free it to prevent memory leaks.

We will address this memory leak.

> 3. mpqemu_msg_recv() callers generally do not validate untrusted msg
>     fields.  All the code needs to be audited.

mpqemu_msg_recv() callers validate the num_fds field. But we will add
more fields for validation by the callers.

Thanks!
--
Jag

> 
> Stefan
> 

