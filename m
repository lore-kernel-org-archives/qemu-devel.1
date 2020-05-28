Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A466C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E079E20721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="sYf34wsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E079E20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRFX-00015v-Qx
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jeR7Y-0004zh-ME; Thu, 28 May 2020 18:35:28 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:54222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jeR7U-0008Un-JM; Thu, 28 May 2020 18:35:26 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id ACCCD2E0E4D;
 Fri, 29 May 2020 01:35:19 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 BuNyaWpDN3-ZFxKo312; Fri, 29 May 2020 01:35:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590705319; bh=8cadgulWOGNTQdBMKpVo058EzTWu105wWXqXNmDyI2Q=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=sYf34wspRvEm3uY0kJIMbV/vm1gg+TU5JxAbj4M8vapwXTBr32eWTdNBhLvq6bb6U
 Hod9ijXHn9stbImabjisBTH/JszZKMdPX4/OHYmcMAw6QWFoXs6gk20Vmsq0qf8rhQ
 eHr35kE05eJVjVk9Dj46B1n6R5mibG0sH1ks+Bh0=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1318::1:10])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 9jfGj8qT6B-ZFXuqeYQ; Fri, 29 May 2020 01:35:15 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Fri, 29 May 2020 01:35:14 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v7 4/8] qdev-properties: add size32 property type
Message-ID: <20200528223514.GA1255099@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200528213946.1636444-1-rvkagan@yandex-team.ru>
 <20200528213946.1636444-5-rvkagan@yandex-team.ru>
 <78e3587a-efea-970a-b47e-8d187464d955@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e3587a-efea-970a-b47e-8d187464d955@redhat.com>
Received-SPF: pass client-ip=5.45.199.163; envelope-from=rvkagan@yandex-team.ru;
 helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:40:21
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
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 xen-devel@lists.xenproject.org, John Snow <jsnow@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 04:45:19PM -0500, Eric Blake wrote:
> On 5/28/20 4:39 PM, Roman Kagan wrote:
> > Introduce size32 property type which handles size suffixes (k, m) just
> > like size property, but is uint32_t rather than uint64_t.
> 
> Does it handle 'g' as well? (even though the set of valid 32-bit sizes with
> a g suffix is rather small ;)
> 
> >  It's going to
> > be useful for properties that are byte sizes but are inherently 32bit,
> > like BlkConf.opt_io_size or .discard_granularity (they are switched to
> > this new property type in a followup commit).
> > 
> > The getter for size32 is left out for a separate patch as its benefit is
> > less obvious, and it affects test output; for now the regular uint32
> > getter is used.
> > 
> > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > ---
> > 
> 
> > +static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
> > +                       Error **errp)
> > +{
> > +    DeviceState *dev = DEVICE(obj);
> > +    Property *prop = opaque;
> > +    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
> > +    uint64_t value;
> > +    Error *local_err = NULL;
> > +
> > +    if (dev->realized) {
> > +        qdev_prop_set_after_realize(dev, name, errp);
> > +        return;
> > +    }
> > +
> > +    visit_type_size(v, name, &value, &local_err);
> 
> Yes, it does.
> 
> Whether or not the commit message is tweaked,
> Reviewed-by: Eric Blake <eblake@redhat.com>

I did this stupid stringify(UINT32_MAX) here too.  It's even uglier
here, with an 'U' appended to the number in the brackets, but somehow it
didn't strike me in the eye while testing.

So I'll fix this too in the respin, and drop the r-b.

Thanks,
Roman.

