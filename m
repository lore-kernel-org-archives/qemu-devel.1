Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 07:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61484206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 07:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfAU4cP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61484206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8Ot-0004Xk-Ev
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 03:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jZ8OC-0003fy-N2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:34:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jZ8OB-000608-Uc
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589441682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcOO00NHa30yx3yEfCTop2Shjn1UwfhmpAPx6kXzsLI=;
 b=HfAU4cP1r2WfNFgTsTRisXe3WmzV+rjq+p66aTcfJiqSOdG5KMJj/yy9sqqGTCnWjBSbWQ
 Ct96Mjsrr1hybMsu3ZD+dzxx0eL6rHPhI91eBEY5TyKI3nZCk7YIKiBzklNichK6rDGdE8
 ZwswhREqr1qHdd6BHwUaKKh/1Wi+2c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-IBharCGUM8ihmoLoopHrTw-1; Thu, 14 May 2020 03:34:40 -0400
X-MC-Unique: IBharCGUM8ihmoLoopHrTw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38AAC461;
 Thu, 14 May 2020 07:34:39 +0000 (UTC)
Received: from [10.72.12.133] (ovpn-12-133.pek2.redhat.com [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6224360BF1;
 Thu, 14 May 2020 07:34:26 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Dima Stepanov <dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <20200512093521.GA5363@dimastep-nix>
 <20200512235934-mutt-send-email-mst@kernel.org>
 <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
 <20200513094703.GA15906@dimastep-nix>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <722839b2-9412-b768-3ce6-d1b697d6d5dd@redhat.com>
Date: Thu, 14 May 2020 15:34:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513094703.GA15906@dimastep-nix>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, arei.gonglei@huawei.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/13 下午5:47, Dima Stepanov wrote:
>>>      case CHR_EVENT_CLOSED:
>>>          /* a close event may happen during a read/write, but vhost
>>>           * code assumes the vhost_dev remains setup, so delay the
>>>           * stop & clear to idle.
>>>           * FIXME: better handle failure in vhost code, remove bh
>>>           */
>>>          if (s->watch) {
>>>              AioContext *ctx = qemu_get_current_aio_context();
>>>
>>>              g_source_remove(s->watch);
>>>              s->watch = 0;
>>>              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
>>>                                       NULL, NULL, false);
>>>
>>>              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
>>>          }
>>>          break;
>>>
>>> I think it's time we dropped the FIXME and moved the handling to common
>>> code. Jason? Marc-André?
>> I agree. Just to confirm, do you prefer bh or doing changes like what is
>> done in this series? It looks to me bh can have more easier codes.
> Could it be a good idea just to make disconnect in the char device but
> postphone clean up in the vhost-user-blk (or any other vhost-user
> device) itself? So we are moving the postphone logic and decision from
> the char device to vhost-user device. One of the idea i have is as
> follows:
>    - Put ourself in the INITIALIZATION state
>    - Start these vhost-user "handshake" commands
>    - If we got a disconnect error, perform disconnect, but don't clean up
>      device (it will be clean up on the roll back). I can be done by
>      checking the state in vhost_user_..._disconnect routine or smth like it


Any issue you saw just using the aio bh as Michael posted above.

Then we don't need to deal with the silent vhost_dev_stop() and we will 
have codes that is much more easier to understand.

Thank


>    - vhost-user command returns error back to the _start() routine
>    - Rollback in one place in the start() routine, by calling this
>      postphoned clean up for the disconnect
>


