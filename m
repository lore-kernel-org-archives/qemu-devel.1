Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C60C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 06:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26109206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 06:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giPl46mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26109206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYkOM-0000IL-QM
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 01:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYkNm-0008EM-EX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 01:56:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39923
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYkNk-0008A3-V6
 for qemu-devel@nongnu.org; Wed, 13 May 2020 01:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589349398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+MrkgQJC8nhNIjn6kus6pAfC+ZHs+ILKZjFeARnJaY=;
 b=giPl46mLIcuXe3WNUEV062bNvNMTP1UIlEo9z7BonmV6YUjecoCtsTVohXlqQQ67g38XbD
 vrmfr+C/5hUnQbTtL+MMnjTR+H4pDks1bU9SmfRQ1PtATTE83Pz2oD8l7BRQQQ+8uWHekQ
 pE6dv2V00TI2TTMVO9ikCyDNkldXnv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-QYiClCgUMPStrfI5mo559A-1; Wed, 13 May 2020 01:56:36 -0400
X-MC-Unique: QYiClCgUMPStrfI5mo559A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBFD0184193E;
 Wed, 13 May 2020 05:56:34 +0000 (UTC)
Received: from [10.72.13.188] (ovpn-13-188.pek2.redhat.com [10.72.13.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 749175D9C5;
 Wed, 13 May 2020 05:56:20 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Dima Stepanov <dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <20200512093521.GA5363@dimastep-nix>
 <20200512235934-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
Date: Wed, 13 May 2020 13:56:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512235934-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com, qemu-devel@nongnu.org,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, raphael.norwitz@nutanix.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/13 下午12:15, Michael S. Tsirkin wrote:
> On Tue, May 12, 2020 at 12:35:30PM +0300, Dima Stepanov wrote:
>> On Tue, May 12, 2020 at 11:32:50AM +0800, Jason Wang wrote:
>>> On 2020/5/11 下午5:25, Dima Stepanov wrote:
>>>> On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
>>>>> On 2020/4/30 下午9:36, Dima Stepanov wrote:
>>>>>> If vhost-user daemon is used as a backend for the vhost device, then we
>>>>>> should consider a possibility of disconnect at any moment. If such
>>>>>> disconnect happened in the vhost_migration_log() routine the vhost
>>>>>> device structure will be clean up.
>>>>>> At the start of the vhost_migration_log() function there is a check:
>>>>>>    if (!dev->started) {
>>>>>>        dev->log_enabled = enable;
>>>>>>        return 0;
>>>>>>    }
>>>>>> To be consistent with this check add the same check after calling the
>>>>>> vhost_dev_set_log() routine. This in general help not to break a
>>>>>> migration due the assert() message. But it looks like that this code
>>>>>> should be revised to handle these errors more carefully.
>>>>>>
>>>>>> In case of vhost-user device backend the fail paths should consider the
>>>>>> state of the device. In this case we should skip some function calls
>>>>>> during rollback on the error paths, so not to get the NULL dereference
>>>>>> errors.
>>>>>>
>>>>>> Signed-off-by: Dima Stepanov<dimastep@yandex-team.ru>
>>>>>> ---
>>>>>>   hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
>>>>>>   1 file changed, 35 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>>>>> index 3ee50c4..d5ab96d 100644
>>>>>> --- a/hw/virtio/vhost.c
>>>>>> +++ b/hw/virtio/vhost.c
>>>>>> @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
>>>>>>   static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>>>>>>   {
>>>>>>       int r, i, idx;
>>>>>> +
>>>>>> +    if (!dev->started) {
>>>>>> +        /*
>>>>>> +         * If vhost-user daemon is used as a backend for the
>>>>>> +         * device and the connection is broken, then the vhost_dev
>>>>>> +         * structure will be reset all its values to 0.
>>>>>> +         * Add additional check for the device state.
>>>>>> +         */
>>>>>> +        return -1;
>>>>>> +    }
>>>>>> +
>>>>>>       r = vhost_dev_set_features(dev, enable_log);
>>>>>>       if (r < 0) {
>>>>>>           goto err_features;
>>>>>> @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>>>>>>       }
>>>>>>       return 0;
>>>>>>   err_vq:
>>>>>> -    for (; i >= 0; --i) {
>>>>>> +    /*
>>>>>> +     * Disconnect with the vhost-user daemon can lead to the
>>>>>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
>>>>>> +     * structure.
>>>>>> +     */
>>>>>> +    for (; dev->started && (i >= 0); --i) {
>>>>>>           idx = dev->vhost_ops->vhost_get_vq_index(
>>>>> Why need the check of dev->started here, can started be modified outside
>>>>> mainloop? If yes, I don't get the check of !dev->started in the beginning of
>>>>> this function.
>>>>>
>>>> No dev->started can't change outside the mainloop. The main problem is
>>>> only for the vhost_user_blk daemon. Consider the case when we
>>>> successfully pass the dev->started check at the beginning of the
>>>> function, but after it we hit the disconnect on the next call on the
>>>> second or third iteration:
>>>>       r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log);
>>>> The unix socket backend device will call the disconnect routine for this
>>>> device and reset the structure. So the structure will be reset (and
>>>> dev->started set to false) inside this set_addr() call.
>>> I still don't get here. I think the disconnect can not happen in the middle
>>> of vhost_dev_set_log() since both of them were running in mainloop. And even
>>> if it can, we probably need other synchronization mechanism other than
>>> simple check here.
>> Disconnect isn't happened in the separate thread it is happened in this
>> routine inside vhost_dev_set_log. When for instance vhost_user_write()
>> call failed:
>>    vhost_user_set_log_base()
>>      vhost_user_write()
>>        vhost_user_blk_disconnect()
>>          vhost_dev_cleanup()
>>            vhost_user_backend_cleanup()
>> So the point is that if we somehow got a disconnect with the
>> vhost-user-blk daemon before the vhost_user_write() call then it will
>> continue clean up by running vhost_user_blk_disconnect() function. I
>> wrote a more detailed backtrace stack in the separate thread, which is
>> pretty similar to what we have here:
>>    Re: [PATCH v2 4/5] vhost: check vring address before calling unmap
>> The places are different but the problem is pretty similar.
>>
>> So if vhost-user commands handshake then everything is fine and
>> reconnect will work as expected. The only problem is how to handle
>> reconnect properly between vhost-user command send/receive.
>
> So vhost net had this problem too.
>
> commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
> Author: Marc-André Lureau<marcandre.lureau@redhat.com>
> Date:   Mon Feb 27 14:49:56 2017 +0400
>
>      vhost-user: delay vhost_user_stop
>      
>      Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
>      may trigger a disconnect events, calling vhost_user_stop() and clearing
>      all the vhost_dev strutures holding data that vhost.c functions expect
>      to remain valid. Delay the cleanup to keep the vhost_dev structure
>      valid during the vhost.c functions.
>      
>      Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
>      Message-id:20170227104956.24729-1-marcandre.lureau@redhat.com
>      Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
>
> it now has this code to address this:
>
>
>      case CHR_EVENT_CLOSED:
>          /* a close event may happen during a read/write, but vhost
>           * code assumes the vhost_dev remains setup, so delay the
>           * stop & clear to idle.
>           * FIXME: better handle failure in vhost code, remove bh
>           */
>          if (s->watch) {
>              AioContext *ctx = qemu_get_current_aio_context();
>
>              g_source_remove(s->watch);
>              s->watch = 0;
>              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
>                                       NULL, NULL, false);
>
>              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
>          }
>          break;
>
> I think it's time we dropped the FIXME and moved the handling to common
> code. Jason? Marc-André?


I agree. Just to confirm, do you prefer bh or doing changes like what is 
done in this series? It looks to me bh can have more easier codes.

Thanks


>
>
>
>
>


