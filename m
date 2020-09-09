Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97121C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EF62224E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EF62224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG16A-0006VV-0G
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kG15d-00064c-46
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:28:49 -0400
Received: from relay64.bu.edu ([128.197.228.104]:60252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kG15a-00051s-T8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:28:48 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 089ESGEG004376
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 9 Sep 2020 10:28:20 -0400
Date: Wed, 9 Sep 2020 10:28:16 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [RFC 1/4] memory: add memory_region_init_io_with_dev interface
Message-ID: <20200909142816.qd3cunwmpwxzf3dd@mozz.bu.edu>
References: <20200908164157.47108-1-liq3ea@163.com>
 <20200908164157.47108-2-liq3ea@163.com>
 <48a99ece-d808-f860-2551-0fec05ec5b01@redhat.com>
 <20200909044856.lvk77pcfvt567ub6@sirius.home.kraxel.org>
 <CAKXe6S+s-hV2dcK=xVd4jrfNEYH0DvwkAkj5ooyrutA-vGJsdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXe6S+s-hV2dcK=xVd4jrfNEYH0DvwkAkj5ooyrutA-vGJsdw@mail.gmail.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 10:28:45
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.768, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200909 1258, Li Qiang wrote:
> Gerd Hoffmann <kraxel@redhat.com> 于2020年9月9日周三 下午12:49写道：
> >
> > On Wed, Sep 09, 2020 at 10:15:47AM +0800, Jason Wang wrote:
> > >
> > > On 2020/9/9 上午12:41, Li Qiang wrote:
> > > > Currently the MR is not explicitly connecting with its device instead of
> > > > a opaque. In most situation this opaque is the deivce but it is not an
> > > > enforcement. This patch adds a DeviceState member of to MemoryRegion
> > > > we will use it in later patch.
> > >
> > >
> > > I don't have a deep investigation. But I wonder whether we could make sure
> > > of owner instead of adding a new field here.
> >
> > Should be possible.  There is object_dynamic_cast() which can be used to
> > figure whenever a given owner object is a device.
> >
> 
> I found most caller of 'memory_region_init_io' will set the owner to
> the device object.
> But some of them will just set it to NULL. Do will have a clear rule
> that the device's MR
> 'owner' should be the device object? If yes, we can use this field.
> 

Those seem to be devices that havent't been QOM-imfied yet?  Maybe those
devices are unlikely to be affected by these issues, though... 

For i386, it seems like parallel, port80, portF0, pckbd, and xen_pvdevice .. ?
I'm guessing none of these do DMA.

+CC Stefan, since he replied to the other thread.

> Thanks,
> Li Qiang
> 
> > take care,
> >   Gerd
> >

