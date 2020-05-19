Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE56FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7DA20756
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tuPLQW7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7DA20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jayKS-0004RL-RE
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jayJe-0003dm-0H; Tue, 19 May 2020 05:13:38 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:50018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jayJb-00026r-VX; Tue, 19 May 2020 05:13:37 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 61A2F2E08AD;
 Tue, 19 May 2020 12:13:32 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 RQTKa9yvxl-DSYGBxk8; Tue, 19 May 2020 12:13:32 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589879612; bh=UR17DxhJGsImtCX1AbVfD4kZ0NucogGtVot4AW6j6b0=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=tuPLQW7yIpS02VU6GxfsZ5KIWBTFQmX+UtAbubsiJLjNzFa1KY3xqKjywTwM1AA7O
 1GSClzZXsf2DXbNv5fkNbzV6n/Owg8pnA5+fBloP/2T7ozjqceEnVCJipcqFDJ7EQA
 FcgK108/aHHiBHfGvD5Wnt8gOMxsYcXLYtYmhSlk=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:302::1:a])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 9LdbBAURLA-DSWWQMqF; Tue, 19 May 2020 12:13:28 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 19 May 2020 12:13:27 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200519091319.GA17982@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <20200512093521.GA5363@dimastep-nix>
 <20200512235934-mutt-send-email-mst@kernel.org>
 <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 05:13:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, arei.gonglei@huawei.com,
 fengli@smartx.com, yc-core@yandex-team.ru, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, raphael.norwitz@nutanix.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 13, 2020 at 01:56:18PM +0800, Jason Wang wrote:
> 
> On 2020/5/13 下午12:15, Michael S. Tsirkin wrote:
> >On Tue, May 12, 2020 at 12:35:30PM +0300, Dima Stepanov wrote:
> >>On Tue, May 12, 2020 at 11:32:50AM +0800, Jason Wang wrote:
> >>>On 2020/5/11 下午5:25, Dima Stepanov wrote:
> >>>>On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
> >>>>>On 2020/4/30 下午9:36, Dima Stepanov wrote:
> >>>>>>If vhost-user daemon is used as a backend for the vhost device, then we
> >>>>>>should consider a possibility of disconnect at any moment. If such
> >>>>>>disconnect happened in the vhost_migration_log() routine the vhost
> >>>>>>device structure will be clean up.
> >>>>>>At the start of the vhost_migration_log() function there is a check:
> >>>>>>   if (!dev->started) {
> >>>>>>       dev->log_enabled = enable;
> >>>>>>       return 0;
> >>>>>>   }
> >>>>>>To be consistent with this check add the same check after calling the
> >>>>>>vhost_dev_set_log() routine. This in general help not to break a
> >>>>>>migration due the assert() message. But it looks like that this code
> >>>>>>should be revised to handle these errors more carefully.
> >>>>>>
> >>>>>>In case of vhost-user device backend the fail paths should consider the
> >>>>>>state of the device. In this case we should skip some function calls
> >>>>>>during rollback on the error paths, so not to get the NULL dereference
> >>>>>>errors.
> >>>>>>
> >>>>>>Signed-off-by: Dima Stepanov<dimastep@yandex-team.ru>
> >>>>>>---
> >>>>>>  hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> >>>>>>  1 file changed, 35 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>>>>index 3ee50c4..d5ab96d 100644
> >>>>>>--- a/hw/virtio/vhost.c
> >>>>>>+++ b/hw/virtio/vhost.c
> >>>>>>@@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
> >>>>>>  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >>>>>>  {
> >>>>>>      int r, i, idx;
> >>>>>>+
> >>>>>>+    if (!dev->started) {
> >>>>>>+        /*
> >>>>>>+         * If vhost-user daemon is used as a backend for the
> >>>>>>+         * device and the connection is broken, then the vhost_dev
> >>>>>>+         * structure will be reset all its values to 0.
> >>>>>>+         * Add additional check for the device state.
> >>>>>>+         */
> >>>>>>+        return -1;
> >>>>>>+    }
> >>>>>>+
> >>>>>>      r = vhost_dev_set_features(dev, enable_log);
> >>>>>>      if (r < 0) {
> >>>>>>          goto err_features;
> >>>>>>@@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >>>>>>      }
> >>>>>>      return 0;
> >>>>>>  err_vq:
> >>>>>>-    for (; i >= 0; --i) {
> >>>>>>+    /*
> >>>>>>+     * Disconnect with the vhost-user daemon can lead to the
> >>>>>>+     * vhost_dev_cleanup() call which will clean up vhost_dev
> >>>>>>+     * structure.
> >>>>>>+     */
> >>>>>>+    for (; dev->started && (i >= 0); --i) {
> >>>>>>          idx = dev->vhost_ops->vhost_get_vq_index(
> >>>>>Why need the check of dev->started here, can started be modified outside
> >>>>>mainloop? If yes, I don't get the check of !dev->started in the beginning of
> >>>>>this function.
> >>>>>
> >>>>No dev->started can't change outside the mainloop. The main problem is
> >>>>only for the vhost_user_blk daemon. Consider the case when we
> >>>>successfully pass the dev->started check at the beginning of the
> >>>>function, but after it we hit the disconnect on the next call on the
> >>>>second or third iteration:
> >>>>      r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log);
> >>>>The unix socket backend device will call the disconnect routine for this
> >>>>device and reset the structure. So the structure will be reset (and
> >>>>dev->started set to false) inside this set_addr() call.
> >>>I still don't get here. I think the disconnect can not happen in the middle
> >>>of vhost_dev_set_log() since both of them were running in mainloop. And even
> >>>if it can, we probably need other synchronization mechanism other than
> >>>simple check here.
> >>Disconnect isn't happened in the separate thread it is happened in this
> >>routine inside vhost_dev_set_log. When for instance vhost_user_write()
> >>call failed:
> >>   vhost_user_set_log_base()
> >>     vhost_user_write()
> >>       vhost_user_blk_disconnect()
> >>         vhost_dev_cleanup()
> >>           vhost_user_backend_cleanup()
> >>So the point is that if we somehow got a disconnect with the
> >>vhost-user-blk daemon before the vhost_user_write() call then it will
> >>continue clean up by running vhost_user_blk_disconnect() function. I
> >>wrote a more detailed backtrace stack in the separate thread, which is
> >>pretty similar to what we have here:
> >>   Re: [PATCH v2 4/5] vhost: check vring address before calling unmap
> >>The places are different but the problem is pretty similar.
> >>
> >>So if vhost-user commands handshake then everything is fine and
> >>reconnect will work as expected. The only problem is how to handle
> >>reconnect properly between vhost-user command send/receive.
> >
> >So vhost net had this problem too.
> >
> >commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
> >Author: Marc-André Lureau<marcandre.lureau@redhat.com>
> >Date:   Mon Feb 27 14:49:56 2017 +0400
> >
> >     vhost-user: delay vhost_user_stop
> >     Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
> >     may trigger a disconnect events, calling vhost_user_stop() and clearing
> >     all the vhost_dev strutures holding data that vhost.c functions expect
> >     to remain valid. Delay the cleanup to keep the vhost_dev structure
> >     valid during the vhost.c functions.
> >     Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> >     Message-id:20170227104956.24729-1-marcandre.lureau@redhat.com
> >     Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> >
> >it now has this code to address this:
> >
> >
> >     case CHR_EVENT_CLOSED:
> >         /* a close event may happen during a read/write, but vhost
> >          * code assumes the vhost_dev remains setup, so delay the
> >          * stop & clear to idle.
> >          * FIXME: better handle failure in vhost code, remove bh
> >          */
> >         if (s->watch) {
> >             AioContext *ctx = qemu_get_current_aio_context();
> >
> >             g_source_remove(s->watch);
> >             s->watch = 0;
> >             qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
> >                                      NULL, NULL, false);
> >
> >             aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> >         }
> >         break;
> >
> >I think it's time we dropped the FIXME and moved the handling to common
> >code. Jason? Marc-André?
> 
> 
> I agree. Just to confirm, do you prefer bh or doing changes like what is
> done in this series? It looks to me bh can have more easier codes.
While we still having the discussion about migration and its states, i
think we can split this patchset. The first patchset will be about
fixing the vhost-usr-blk reconnect issues. And the follow up patchset
will be about migration if we decide to fix/workaround this abort() call
at the start of migration. I'll prepare v3 with this bh approach and
will send it for review. What do you think?

Thanks, Dima.

> 
> Thanks
> 
> 
> >
> >
> >
> >
> >
> 

