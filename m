Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7110C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93677206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="t02snKrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93677206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYRKr-0005fW-Je
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jYRKB-00055Y-VH; Tue, 12 May 2020 05:35:43 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jYRK8-0006aa-7G; Tue, 12 May 2020 05:35:41 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9D2822E14E5;
 Tue, 12 May 2020 12:35:35 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 XPzQ3C1VgW-ZVbuQHLF; Tue, 12 May 2020 12:35:35 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589276135; bh=HnYYBad5jtU5vRBs6ZAULiowVJML9aQlt9/HZJhlAiM=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=t02snKrWo8TaPCVyRWMFJmj9891RUwpVAXY6xYJydT1B2e7MkDvjKwRYa8MhJf+lT
 Fkx9NQiAJjblFCAJ9pC3CWKACmys7d//ybGFZCzBAm0mi8I1yIXVXIdMGCIOxVRvt4
 jlfklCLuT8tctkjwH5l4gnN37pNyDJj5WyVVpb6s=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:116::1:c])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ejSN6GCDFs-ZVX8Vtrb; Tue, 12 May 2020 12:35:31 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 12 May 2020 12:35:30 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200512093521.GA5363@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 05:35:36
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
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, arei.gonglei@huawei.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 raphael.norwitz@nutanix.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 11:32:50AM +0800, Jason Wang wrote:
> 
> On 2020/5/11 下午5:25, Dima Stepanov wrote:
> >On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
> >>On 2020/4/30 下午9:36, Dima Stepanov wrote:
> >>>If vhost-user daemon is used as a backend for the vhost device, then we
> >>>should consider a possibility of disconnect at any moment. If such
> >>>disconnect happened in the vhost_migration_log() routine the vhost
> >>>device structure will be clean up.
> >>>At the start of the vhost_migration_log() function there is a check:
> >>>   if (!dev->started) {
> >>>       dev->log_enabled = enable;
> >>>       return 0;
> >>>   }
> >>>To be consistent with this check add the same check after calling the
> >>>vhost_dev_set_log() routine. This in general help not to break a
> >>>migration due the assert() message. But it looks like that this code
> >>>should be revised to handle these errors more carefully.
> >>>
> >>>In case of vhost-user device backend the fail paths should consider the
> >>>state of the device. In this case we should skip some function calls
> >>>during rollback on the error paths, so not to get the NULL dereference
> >>>errors.
> >>>
> >>>Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >>>---
> >>>  hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> >>>  1 file changed, 35 insertions(+), 4 deletions(-)
> >>>
> >>>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>index 3ee50c4..d5ab96d 100644
> >>>--- a/hw/virtio/vhost.c
> >>>+++ b/hw/virtio/vhost.c
> >>>@@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
> >>>  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >>>  {
> >>>      int r, i, idx;
> >>>+
> >>>+    if (!dev->started) {
> >>>+        /*
> >>>+         * If vhost-user daemon is used as a backend for the
> >>>+         * device and the connection is broken, then the vhost_dev
> >>>+         * structure will be reset all its values to 0.
> >>>+         * Add additional check for the device state.
> >>>+         */
> >>>+        return -1;
> >>>+    }
> >>>+
> >>>      r = vhost_dev_set_features(dev, enable_log);
> >>>      if (r < 0) {
> >>>          goto err_features;
> >>>@@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >>>      }
> >>>      return 0;
> >>>  err_vq:
> >>>-    for (; i >= 0; --i) {
> >>>+    /*
> >>>+     * Disconnect with the vhost-user daemon can lead to the
> >>>+     * vhost_dev_cleanup() call which will clean up vhost_dev
> >>>+     * structure.
> >>>+     */
> >>>+    for (; dev->started && (i >= 0); --i) {
> >>>          idx = dev->vhost_ops->vhost_get_vq_index(
> >>
> >>Why need the check of dev->started here, can started be modified outside
> >>mainloop? If yes, I don't get the check of !dev->started in the beginning of
> >>this function.
> >>
> >No dev->started can't change outside the mainloop. The main problem is
> >only for the vhost_user_blk daemon. Consider the case when we
> >successfully pass the dev->started check at the beginning of the
> >function, but after it we hit the disconnect on the next call on the
> >second or third iteration:
> >      r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log);
> >The unix socket backend device will call the disconnect routine for this
> >device and reset the structure. So the structure will be reset (and
> >dev->started set to false) inside this set_addr() call.
> 
> 
> I still don't get here. I think the disconnect can not happen in the middle
> of vhost_dev_set_log() since both of them were running in mainloop. And even
> if it can, we probably need other synchronization mechanism other than
> simple check here.
Disconnect isn't happened in the separate thread it is happened in this
routine inside vhost_dev_set_log. When for instance vhost_user_write()
call failed:
  vhost_user_set_log_base()
    vhost_user_write()
      vhost_user_blk_disconnect()
        vhost_dev_cleanup()
          vhost_user_backend_cleanup()
So the point is that if we somehow got a disconnect with the
vhost-user-blk daemon before the vhost_user_write() call then it will
continue clean up by running vhost_user_blk_disconnect() function. I
wrote a more detailed backtrace stack in the separate thread, which is
pretty similar to what we have here:
  Re: [PATCH v2 4/5] vhost: check vring address before calling unmap
The places are different but the problem is pretty similar.

So if vhost-user commands handshake then everything is fine and
reconnect will work as expected. The only problem is how to handle
reconnect properly between vhost-user command send/receive.

As i wrote we have a test:
  - run src VM with vhost-usr-blk daemon used
  - run fio inside it
  - perform reconnect every X seconds (just kill and restart daemon),
    X is random
  - run dst VM
  - perform migration
  - fio should complete in dst VM
And we cycle this test like forever.
So it fails once per ~25 iteration. By adding some delays inside qemu we
were able to make the race window larger.

> 
> 
> >  So
> >we shouldn't call the clean up calls because this virtqueues were clean
> >up in the disconnect call. But we should protect these calls somehow, so
> >it will not hit SIGSEGV and we will be able to pass migration.
> >
> >Just to summarize it:
> >For the vhost-user-blk devices we ca hit clean up calls twice in case of
> >vhost disconnect:
> >1. The first time during the disconnect process. The clean up is called
> >inside it.
> >2. The second time during roll back clean up.
> >So if it is the case we should skip p2.
> >
> >>>dev, dev->vq_index + i);
> >>>          vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
> >>>                                   dev->log_enabled);
> >>>      }
> >>>-    vhost_dev_set_features(dev, dev->log_enabled);
> >>>+    if (dev->started) {
> >>>+        vhost_dev_set_features(dev, dev->log_enabled);
> >>>+    }
> >>>  err_features:
> >>>      return r;
> >>>  }
> >>>@@ -832,7 +850,15 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
> >>>      } else {
> >>>          vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> >>>          r = vhost_dev_set_log(dev, true);
> >>>-        if (r < 0) {
> >>>+        /*
> >>>+         * The dev log resize can fail, because of disconnect
> >>>+         * with the vhost-user-blk daemon. Check the device
> >>>+         * state before calling the vhost_dev_set_log()
> >>>+         * function.
> >>>+         * Don't return error if device isn't started to be
> >>>+         * consistent with the check above.
> >>>+         */
> >>>+        if (dev->started && r < 0) {
> >>>              return r;
> >>>          }
> >>>      }
> >>>@@ -1739,7 +1765,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>>  fail_log:
> >>>      vhost_log_put(hdev, false);
> >>>  fail_vq:
> >>>-    while (--i >= 0) {
> >>>+    /*
> >>>+     * Disconnect with the vhost-user daemon can lead to the
> >>>+     * vhost_dev_cleanup() call which will clean up vhost_dev
> >>>+     * structure.
> >>>+     */
> >>>+    while ((--i >= 0) && (hdev->started)) {
> >>>          vhost_virtqueue_stop(hdev,
> >>>                               vdev,
> >>>                               hdev->vqs + i,
> >>
> >>This should be a separate patch.
> >Do you mean i should split this patch to two patches?
> 
> 
> Yes.
> 
> Thanks

Got it. Will do it in v3.

No other comments mixed in below.

Thanks.

> 
> 
> >
> >Thanks.
> >
> >>Thanks
> >>
> 

