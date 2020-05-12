Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF40C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3ED20714
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="k3iLcOhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3ED20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYR9c-0006xT-MB
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jYR8a-0005go-U0; Tue, 12 May 2020 05:23:44 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:54320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jYR8W-0003XL-RI; Tue, 12 May 2020 05:23:42 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 6716C2E14DA;
 Tue, 12 May 2020 12:23:34 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Bwew7jnlv4-NUbiOuO9; Tue, 12 May 2020 12:23:34 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589275414; bh=DY1BqFJCwSnEgjFv/LFrbFZPk0yVBsx7TQ5OWBkBI7E=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=k3iLcOhxfyAXaHxs/GiTuq8k83fOpY/fVLKS5u9o8+bUhbkg1Z50YWHw4HyTSnYy2
 hV2OPB286/lwTSSfRQ5ffqOn2Sj5xhKbXVdgxD3Nh12MLEk0yP7vcAYOiDvwGsbtDa
 4UrBwSzS324MR8oJkV73AKMZZlrO09mvZmynVcRU=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:116::1:c])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 DaiUm2lzoU-NUWO72Wf; Tue, 12 May 2020 12:23:30 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 12 May 2020 12:23:28 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200512092328.GA5210@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <CAHckoCx1TE3mShp3eaV-oT2CKw6zFDyFgFgdo+9oc0+TqSAytg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHckoCx1TE3mShp3eaV-oT2CKw6zFDyFgFgdo+9oc0+TqSAytg@mail.gmail.com>
Received: from fastsrv.yandex-team.ru (iva3-f7de5090c8cd.qloud-c.yandex.net
 [2a02:6b8:c0c:4992:0:640:f7de:5090]) by mxbackcorp1j.mail.yandex.net with
 LMTP id crVGhkK9Um-X8EFKK04h8c1 for <dimastep@mail.yandex-team.ru>; Tue, 12
 May 2020 12:20:46 +0300
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 12, 2020 at 11:47:34AM +0800, Li Feng wrote:
> Hi, Dima.
> 
> If vhost_migration_log return < 0, then vhost_log_global_start will
> trigger a crash.
> Does your patch have process this abort?
> If a disconnect happens in the migration stage, the correct operation
> is to stop the migration, right?
> 
>  841 static void vhost_log_global_start(MemoryListener *listener)
>  842 {
>  843     int r;
>  844
>  845     r = vhost_migration_log(listener, true);
>  846     if (r < 0) {
>  847         abort();
>  848     }
>  849 }
Yes, my patch process it by not returning an error ). That is one of the
point we've talked about with Raphael and Michael in this thread. First
of all in my patches i'm still following the same logic which has been
already in upstream ./hw/virtio/vhost.c:vhost_migration_log():
  ...
  820     if (!dev->started) {
  821         dev->log_enabled = enable;
  822         return 0;
  823     }
  ...
It means, that if device not started, then continue migration without
returning any error. So i followed the same logic, if we got a
disconnect, then it will mean that device isn't started and we can
continue migration. As a result no error is returned and assert() isn't
hit.
Also there is a question from Raphael to Michael about it you can find
it in this thread, by i will add it also:
  > Subject: Re: [PATCH v2 5/5] vhost: add device started check in
  > migration set log

  > On Wed, May 06, 2020 at 06:08:34PM -0400, Raphael Norwitz wrote:
  >> In particular, we need to decide whether a migration should be
  >> allowed to continue if a device disconnects durning the migration
  >> stage.
  >>
  >> mst, any thoughts?

  > Why not? It can't change state while disconnected, so it just makes
  > things easier.

So it looks like a correct way to handle it. Also our internal tests
passed. Some words about our tests:
  - run src VM with vhost-usr-blk daemon used
  - run fio inside it
  - perform reconnect every X seconds (just kill and restart
    daemon), X is random
  - run dst VM
  - perform migration
  - fio should complete in dst VM
And we cycle this test like forever. At least for now we see no new
issues.

No other comments mixed in below.

> 
> Thanks,
> 
> Feng Li
> 
> Jason Wang <jasowang@redhat.com> 于2020年5月12日周二 上午11:33写道：
> >
> >
> > On 2020/5/11 下午5:25, Dima Stepanov wrote:
> > > On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
> > >> On 2020/4/30 下午9:36, Dima Stepanov wrote:
> > >>> If vhost-user daemon is used as a backend for the vhost device, then we
> > >>> should consider a possibility of disconnect at any moment. If such
> > >>> disconnect happened in the vhost_migration_log() routine the vhost
> > >>> device structure will be clean up.
> > >>> At the start of the vhost_migration_log() function there is a check:
> > >>>    if (!dev->started) {
> > >>>        dev->log_enabled = enable;
> > >>>        return 0;
> > >>>    }
> > >>> To be consistent with this check add the same check after calling the
> > >>> vhost_dev_set_log() routine. This in general help not to break a
> > >>> migration due the assert() message. But it looks like that this code
> > >>> should be revised to handle these errors more carefully.
> > >>>
> > >>> In case of vhost-user device backend the fail paths should consider the
> > >>> state of the device. In this case we should skip some function calls
> > >>> during rollback on the error paths, so not to get the NULL dereference
> > >>> errors.
> > >>>
> > >>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > >>> ---
> > >>>   hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> > >>>   1 file changed, 35 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > >>> index 3ee50c4..d5ab96d 100644
> > >>> --- a/hw/virtio/vhost.c
> > >>> +++ b/hw/virtio/vhost.c
> > >>> @@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
> > >>>   static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> > >>>   {
> > >>>       int r, i, idx;
> > >>> +
> > >>> +    if (!dev->started) {
> > >>> +        /*
> > >>> +         * If vhost-user daemon is used as a backend for the
> > >>> +         * device and the connection is broken, then the vhost_dev
> > >>> +         * structure will be reset all its values to 0.
> > >>> +         * Add additional check for the device state.
> > >>> +         */
> > >>> +        return -1;
> > >>> +    }
> > >>> +
> > >>>       r = vhost_dev_set_features(dev, enable_log);
> > >>>       if (r < 0) {
> > >>>           goto err_features;
> > >>> @@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> > >>>       }
> > >>>       return 0;
> > >>>   err_vq:
> > >>> -    for (; i >= 0; --i) {
> > >>> +    /*
> > >>> +     * Disconnect with the vhost-user daemon can lead to the
> > >>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
> > >>> +     * structure.
> > >>> +     */
> > >>> +    for (; dev->started && (i >= 0); --i) {
> > >>>           idx = dev->vhost_ops->vhost_get_vq_index(
> > >>
> > >> Why need the check of dev->started here, can started be modified outside
> > >> mainloop? If yes, I don't get the check of !dev->started in the beginning of
> > >> this function.
> > >>
> > > No dev->started can't change outside the mainloop. The main problem is
> > > only for the vhost_user_blk daemon. Consider the case when we
> > > successfully pass the dev->started check at the beginning of the
> > > function, but after it we hit the disconnect on the next call on the
> > > second or third iteration:
> > >       r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log);
> > > The unix socket backend device will call the disconnect routine for this
> > > device and reset the structure. So the structure will be reset (and
> > > dev->started set to false) inside this set_addr() call.
> >
> >
> > I still don't get here. I think the disconnect can not happen in the
> > middle of vhost_dev_set_log() since both of them were running in
> > mainloop. And even if it can, we probably need other synchronization
> > mechanism other than simple check here.
> >
> >
> > >   So
> > > we shouldn't call the clean up calls because this virtqueues were clean
> > > up in the disconnect call. But we should protect these calls somehow, so
> > > it will not hit SIGSEGV and we will be able to pass migration.
> > >
> > > Just to summarize it:
> > > For the vhost-user-blk devices we ca hit clean up calls twice in case of
> > > vhost disconnect:
> > > 1. The first time during the disconnect process. The clean up is called
> > > inside it.
> > > 2. The second time during roll back clean up.
> > > So if it is the case we should skip p2.
> > >
> > >>> dev, dev->vq_index + i);
> > >>>           vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
> > >>>                                    dev->log_enabled);
> > >>>       }
> > >>> -    vhost_dev_set_features(dev, dev->log_enabled);
> > >>> +    if (dev->started) {
> > >>> +        vhost_dev_set_features(dev, dev->log_enabled);
> > >>> +    }
> > >>>   err_features:
> > >>>       return r;
> > >>>   }
> > >>> @@ -832,7 +850,15 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
> > >>>       } else {
> > >>>           vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> > >>>           r = vhost_dev_set_log(dev, true);
> > >>> -        if (r < 0) {
> > >>> +        /*
> > >>> +         * The dev log resize can fail, because of disconnect
> > >>> +         * with the vhost-user-blk daemon. Check the device
> > >>> +         * state before calling the vhost_dev_set_log()
> > >>> +         * function.
> > >>> +         * Don't return error if device isn't started to be
> > >>> +         * consistent with the check above.
> > >>> +         */
> > >>> +        if (dev->started && r < 0) {
> > >>>               return r;
> > >>>           }
> > >>>       }
> > >>> @@ -1739,7 +1765,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> > >>>   fail_log:
> > >>>       vhost_log_put(hdev, false);
> > >>>   fail_vq:
> > >>> -    while (--i >= 0) {
> > >>> +    /*
> > >>> +     * Disconnect with the vhost-user daemon can lead to the
> > >>> +     * vhost_dev_cleanup() call which will clean up vhost_dev
> > >>> +     * structure.
> > >>> +     */
> > >>> +    while ((--i >= 0) && (hdev->started)) {
> > >>>           vhost_virtqueue_stop(hdev,
> > >>>                                vdev,
> > >>>                                hdev->vqs + i,
> > >>
> > >> This should be a separate patch.
> > > Do you mean i should split this patch to two patches?
> >
> >
> > Yes.
> >
> > Thanks
> >
> >
> > >
> > > Thanks.
> > >
> > >> Thanks
> > >>
> >

