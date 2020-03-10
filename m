Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9760C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7FD20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7FD20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdeS-0002sP-T4
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jBdb7-0006Xo-5u
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jBdb1-0004ik-5e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3271 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jBdaz-0004Qq-3a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B0FC8A96B223C4310EE9;
 Tue, 10 Mar 2020 20:02:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 10 Mar 2020 20:02:32 +0800
Subject: Re: [PATCH RESEND 2/3] vhost: fix a null pointer reference of
 vhost_log
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-3-longpeng2@huawei.com>
 <20200310014623-mutt-send-email-mst@kernel.org>
 <7da2b8b6-afe7-7f1f-9252-925b6bc543d8@huawei.com>
 <20200310042017-mutt-send-email-mst@kernel.org>
From: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <6d5f2e31-cbf2-f7e5-adbd-7a3a03fb67ee@huawei.com>
Date: Tue, 10 Mar 2020 20:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200310042017-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="gbk"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: weifuqiang@huawei.com, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, arei.gonglei@huawei.com,
 huangzhichao@huawei.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D4=DA 2020/3/10 16:23, Michael S. Tsirkin =D0=B4=B5=C0:
> On Tue, Mar 10, 2020 at 04:04:35PM +0800, Longpeng (Mike, Cloud Infrast=
ructure Service Product Dept.) wrote:
>>
>>
>> On 2020/3/10 13:57, Michael S. Tsirkin wrote:
>>> On Mon, Feb 24, 2020 at 02:42:18PM +0800, Longpeng(Mike) wrote:
>>>> From: Longpeng <longpeng2@huawei.com>
>>>>
>>>> vhost_log_alloc() may fails and returned pointer of log is null.
>>>> However there're two places derefernce the return pointer without
>>>> check.
>>>>
[...]

>>>>  static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint=
64_t size)
>>>>  {
>>>> -    struct vhost_log *log =3D vhost_log_get(size, vhost_dev_log_is_=
shared(dev));
>>>> -    uint64_t log_base =3D (uintptr_t)log->log;
>>>> +    struct vhost_log *log;
>>>> +    uint64_t log_base;
>>>>      int r;
>>>> =20
>>>> +    log =3D vhost_log_get(size, vhost_dev_log_is_shared(dev));
>>>> +    if (!log) {
>>>> +        return;
>>>> +    }
>>>> +
>>>
>>> I'm not sure silently failing like this is safe. Callers assume
>>> log can be resized. What can be done? I suspect not much
>>> beside exiting ...
>>> Speaking of which, lots of other failures in log resizing
>>> path seem to be silently ignored.
>>> I guess we should propagate them, and fix callers to check
>>> the return code?
>>>
>> How about to let the callers treat the failure of log_resize as a fata=
l error ?
>>
[...]

>>
>> @@ -510,7 +525,9 @@ static void vhost_commit(MemoryListener *listener)
>>  #define VHOST_LOG_BUFFER (0x1000 / sizeof *dev->log)
>>      /* To log more, must increase log size before table update. */
>>      if (dev->log_size < log_size) {
>> -        vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER);
>> +        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < =
0) {
>> +            abort();
>> +        }
>>      }
>>      r =3D dev->vhost_ops->vhost_set_mem_table(dev, dev->mem);
>>      if (r < 0) {
>> @@ -518,7 +535,9 @@ static void vhost_commit(MemoryListener *listener)
>>      }
>>      /* To log less, can only decrease log size after table update. */
>>      if (dev->log_size > log_size + VHOST_LOG_BUFFER) {
>> -        vhost_dev_log_resize(dev, log_size);
>> +        if (vhost_dev_log_resize(dev, log_size + VHOST_LOG_BUFFER) < =
0) {
>> +            abort();
>> +        }
>>      }
>>
>>  out:
>=20
>=20
> I think the suggested handling is
> 	error_report() and exit().
> we also need to propagate errno. So how about passing in Error then?
>=20
vhost_dev_log_resize
  vhost_log_get
    vhost_log_alloc
      error_report_err (fail path, errno is in the errp)
  VHOST_OPS_DEBUG (if ->vhost_set_log_base fail)
      error_report (errno)

Um, it seems log_resize will report error with errno internal, do we need
error_report once more ?

>=20
>> @@ -818,7 +837,11 @@ static int vhost_migration_log(MemoryListener *li=
stener,
>> int enable)
>>          }
>>          vhost_log_put(dev, false);
>>      } else {
>> -        vhost_dev_log_resize(dev, vhost_get_log_size(dev));
>> +        r =3D vhost_dev_log_resize(dev, vhost_get_log_size(dev));
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +
>>          r =3D vhost_dev_set_log(dev, true);
>>          if (r < 0) {
>>              return r;
>>
>>
>>>
>>> .
>>>
>>
>> --=20
>> ---
>> Regards,
>> Longpeng(Mike)
>=20
>=20
> .
>=20


--=20
Regards,
Longpeng(Mike)


