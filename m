Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD41C54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076BC206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="AoqiQTww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076BC206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4zZ-0004pM-6K
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jY4yY-0003IE-IY; Mon, 11 May 2020 05:43:54 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:34816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jY4yU-00029U-Ka; Mon, 11 May 2020 05:43:52 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 32CFC2E14F7;
 Mon, 11 May 2020 12:43:45 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net
 (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 XHhmEFbEK3-hfXqUqOA; Mon, 11 May 2020 12:43:44 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589190224; bh=7OaGrju1uwddudYEnnpPgfa9QBXeIychsE5NuAs1DTk=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=AoqiQTww61LS9ys2yRuEoHp7AbkOLi5sqUvv4GTgM+na07B/PP0BFxjNZhxihPahY
 rdhjbsEmSHUVnjnHaBLn1wn9m5NWyJ1TbgubG9QC9EMA/o1qpsY9nvDgUIcT/u+dM4
 L/MLTg+ocuqexI1/KD8ia71dp+/ecuRU88xo+Hiw=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7214::1:7])
 by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 GP2bZE9Lyl-heW4qljm; Mon, 11 May 2020 12:43:41 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 11 May 2020 12:43:39 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200511094337.GA27718@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
 <20200507153530.GA6808@dimastep-nix>
 <CAFubqFv_ZPXPBrZpQ=JU69BjJmRK4ePGd2ATtf0rpEUmXNVsKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFubqFv_ZPXPBrZpQ=JU69BjJmRK4ePGd2ATtf0rpEUmXNVsKA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 04:55:47
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 10, 2020 at 08:03:39PM -0400, Raphael Norwitz wrote:
> On Thu, May 7, 2020 at 11:35 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > What do you think?
> >
> 
> Apologies - I tripped over the if (dev->started && r < 0) check.
> Never-mind my point with race conditions and failing migrations.
> 
> Rather than modifying vhost_dev_set_log(), it may be clearer to put a
> check after vhost_dev_log_resize()? Something like:
> 
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -829,11 +829,22 @@ static int vhost_migration_log(MemoryListener
> *listener, int enable)
>          vhost_log_put(dev, false);
>      } else {
>          vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> +        /*
> +         * A device can be stopped because of backend disconnect inside
> +         * vhost_dev_log_resize(). In this case we should mark logging
> +         * enabled and return without attempting to set the backend
> +         * logging state.
> +         */
> +        if (!dev->started) {
> +            goto out_success;
> +        }
>          r = vhost_dev_set_log(dev, true);
>          if (r < 0) {
>              return r;
>          }
>      }
> +
> +out_success:
>      dev->log_enabled = enable;
>      return 0;
>  }
This patch will not fix all the issues. Consider the case than you will
hit disconnect inside vhost_dev_set_log. For instance for the 3rd
virtqueue, for the following call:
  vhost_virtqueue_set_addr(...)
Maybe i didn't explain very clearly the problem. The problem i've tried
to fix is only for the vhost-user-blk devices. This issue can be hit
during VHOST_USER commands "handshake". If we hit disconnect on any step
of this "handshake" then we will try to make clean up twice:
1. First during disconnect cleanup (unix socket backend).
2. Second as roll back for initialization.
If this is the case, then we shouldn't call p2, as everything was clean
up on p1. And the complicated thing is that there are several VHOST_USER
commands and we should consider the state after each. And even more,
initialization could fail because of some other reason and we hit
disconnect inside roll back clean up, in this case we should complete
clean up in the disconnect function and stop rolling back.

Hope it helps ).

> 
> This seems harmless enough to me, and I see how it fixes your
> particular crash, but I would still prefer we worked towards a more
> robust solution. In particular I think we could handle this inside
> vhost-user-blk if we let the device state persist between connections
> (i.e. call vhost_dev_cleanup() inside vhost_user_blk_connect() before
> vhost_dev_init() on reconnect). This should also fix some of the
> crashes Li Feng has hit, and probably others which haven’t been
> reported yet. What do you think?
Yes, this looks like a good direction. Because all my patches are only
workarounds and i believe there can be some other issues which haven't
been reported or will be introduced ).
I still think that these patches are good to submit and to think about
more complicated/refactoring solution as the next step.

> 
> If that’s unworkable I guess we will need to add these vhost level
> checks.
At least for now, i don't think its unworkable, i just think that it
will take some time to figure out how to refactor it properly. But the
SIGSEGV issue is real.

> In that case I would still prefer we add a “disconnected” flag
> in struct vhost_dev struct, and make sure it isn’t cleared by
> vhost_dev_cleanup(). That way we don’t conflate stopping a device with
> backend disconnect at the vhost level and potentially regress behavior
> for other device types.
It is also possible, but should be analyzed and properly tested. So as i
said it will take some time to figure out how to refactor it properly.

