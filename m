Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71FE3206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 16:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U0Oa4HE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FE3206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YIx-00041l-M9
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 12:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1YGO-0003CN-Ri
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:52:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1YGK-0003A7-Gy
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 12:52:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VGkxRl147622;
 Fri, 31 Jul 2020 16:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OwcAf4Z9O4jDlMvRbQKo+1Da4xiK8CCQUDi4UUnUxNA=;
 b=U0Oa4HE37PHdpRr6kg80FZyQxB1bcXqUl1wc17b9aiT5UpE84q5AAuC6J9wG7pULS6Er
 vpodZVrpafPrXC+0MxKTMeKVpwJKjAav9CyobOOcrdVmiG0A7eaBqz33eBsft2G2boJd
 hhZkS4ZpWBjhv3eyDADsgPYZlREnodqdg6XnOYqpngMEkOIdTkJSiU+M/vt8LGyqSPPF
 RajONUSU3edBGgl50E20SEb18FfRiKWtj5vqwYinrQZMStg4HuTvXH4Zj6qQZxa++7tV
 /NhtGKziQ6i+H+dZ05OkfxyWUJoyFfxnoPqI9Kn6/Q97hpNWLUaxTNXUVLjxK0zlkb3w 3A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1jt2m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 16:51:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VGgsbS127069;
 Fri, 31 Jul 2020 16:51:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 32hu605a1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 16:51:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VGpsYe003684;
 Fri, 31 Jul 2020 16:51:54 GMT
Received: from [10.39.235.87] (/10.39.235.87)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 09:51:54 -0700
Subject: Re: [PATCH V1 24/32] ui: save/restore vnc socket fds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-25-git-send-email-steven.sistare@oracle.com>
 <20200731090633.GC3518939@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <ad9f9ccf-729f-63e9-f074-ce7288de651a@oracle.com>
Date: Fri, 31 Jul 2020 12:51:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200731090633.GC3518939@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310125
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:51:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/2020 5:06 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 30, 2020 at 08:14:28AM -0700, Steve Sistare wrote:
>> From: Mark Kanda <mark.kanda@oracle.com>
>>
>> Iterate through the VNC displays and save/restore the socket fds.
> 
> This patch doesn't appear to do anything around the client state, so I
> can't see how this will work in general.  eg QEMU is 1/2 way through
> receiving a message from the client, and we trigger re-exec.
> 
> The new QEMU is going to startup considering the VNC client is in an
> idle state, and will then read the 2nd 1/2 of the message off the
> client socket. Everything will go rapidly downhill from there.
> Or the reverse, the server has sent a message, but this outbound
> message is still in the buffer and only been partially sent on the
> wire. We re'exec and now we've lost the unsent part of the buffer.

Yes.  For partial messages in qemu object buffers, we need to add a draining phase
between exec-requested and exec, and complete all partial messages.

For kernel socket buffers, we should be OK.  If we are accurately preserving vnc
server state (which is the intent), then we can correctly respond to any client
reqwuests that were sent to us pre-exec but read into qemu post-exec.

However, there is another icky issue with vnc.  It only works reliably with raw 
encoding.  Compressed streams accumulate state on the client side which ww cannot
match on the server when we create a new zlib stream after exec.  The vnc protocol
defines a per-stream reset flag in the compression control word, which sounds like it
should reset zlib state, but it does not for tigervnc.  I have not tried other clients.

vnc is one of the tricker patches in this series.  It may be wisest to close the connection 
and require the client to reconnect.  The virtual framebuffer is preserved, so the same content 
will be shown after reconnect.

- Steve


