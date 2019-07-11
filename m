Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958DC74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010E621019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010E621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVE9-0005QC-2A
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hlVDR-0004vG-2R
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hlVDP-0001BI-CS
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hlVDP-00018Y-4G
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A8238665F;
 Thu, 11 Jul 2019 09:18:08 +0000 (UTC)
Received: from [10.72.12.56] (ovpn-12-56.pek2.redhat.com [10.72.12.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48F5B60148;
 Thu, 11 Jul 2019 09:18:04 +0000 (UTC)
To: "Zhang, Chen" <chen.zhang@intel.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-dev <qemu-devel@nongnu.org>
References: <20190704083647.30614-1-chen.zhang@intel.com>
 <ad2627e3-8198-42f2-a89d-8e6a5596ef20@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78061C2546@shsmsx102.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5cf779de-9d97-63f4-00d5-560202890af0@redhat.com>
Date: Thu, 11 Jul 2019 17:17:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D78061C2546@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 11 Jul 2019 09:18:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/7/10 =E4=B8=8B=E5=8D=883:50, Zhang, Chen wrote:
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Tuesday, July 9, 2019 10:48 PM
>> To: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian <lizhijian@cn.fujit=
su.com>;
>> Peter Maydell <peter.maydell@linaro.org>; qemu-dev <qemu-
>> devel@nongnu.org>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Subject: Re: [Qemu-devel] [PATCH V2] net/colo-compare.c: Fix memory le=
ak
>> and code style issue.
>>
>>
>> On 2019/7/4 =E4=B8=8B=E5=8D=884:36, Zhang Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> This patch to fix the origin "char *data" menory leak, code style
>>> issue and add necessary check here.
>>> Reported-by: Coverity (CID 1402785)
>>>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>> ---
>>>    net/colo-compare.c | 28 +++++++++++++++++++++-------
>>>    1 file changed, 21 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c index
>>> 909dd6c6eb..ed349f5f6a 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
>>>                                uint32_t vnet_hdr_len,
>>>                                bool notify_remote_frame);
>>>
>>> +static bool packet_matches_str(const char *str,
>>> +                               uint8_t *buf,
>>> +                               uint32_t packet_len) {
>>> +    if (packet_len <=3D strlen(str)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return !memcmp(str, buf, strlen(str) + 1);
>>
>> This assumes buf is NULL terminated (you pass notify_rs->buf) which is=
 not
>> correct I think?
> Yes, you are right.
> How about this:
>
> static bool packet_matches_str(const char *str,
>                                 uint8_t *buf,
>                                 uint32_t packet_len) {
>      if (packet_len !=3D strlen(str) || !buf) {
>          return false;
>      }


When can we hit !buf?

Thanks


>
>      return !memcmp(str, buf, strlen(str));
> }
>
> Thanks
> Zhang Chen
>
>
>> Thanks
>>
>>
>>> +}
>>> +
>>>    static void notify_remote_frame(CompareState *s)
>>>    {
>>>        char msg[] =3D "DO_CHECKPOINT";
>>> @@ -1008,21 +1019,24 @@ static void
>> compare_notify_rs_finalize(SocketReadState *notify_rs)
>>>    {
>>>        CompareState *s =3D container_of(notify_rs, CompareState,
>>> notify_rs);
>>>
>>> -    /* Get Xen colo-frame's notify and handle the message */
>>> -    char *data =3D g_memdup(notify_rs->buf, notify_rs->packet_len);
>>> -    char msg[] =3D "COLO_COMPARE_GET_XEN_INIT";
>>> +    const char msg[] =3D "COLO_COMPARE_GET_XEN_INIT";
>>>        int ret;
>>>
>>> -    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
>>> +    if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
>>> +                           notify_rs->buf,
>>> +                           notify_rs->packet_len)) {
>>>            ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0=
, true);
>>>            if (ret < 0) {
>>>                error_report("Notify Xen COLO-frame INIT failed");
>>>            }
>>> -    }
>>> -
>>> -    if (!strcmp(data, "COLO_CHECKPOINT")) {
>>> +    } else if (packet_matches_str("COLO_CHECKPOINT",
>>> +                                  notify_rs->buf,
>>> +                                  notify_rs->packet_len)) {
>>>            /* colo-compare do checkpoint, flush pri packet and remove=
 sec packet
>> */
>>>            g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>>> +    } else {
>>> +        error_report("COLO compare got unsupported instruction '%s'"=
,
>>> +                     (char *)notify_rs->buf);
>>>        }
>>>    }
>>>

