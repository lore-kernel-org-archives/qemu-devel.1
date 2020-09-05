Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB1FC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 07:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9883F20760
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 07:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOwv2k8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9883F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kESco-0008JN-IE
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 03:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEScE-0007lQ-Nz
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 03:28:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kEScC-0001j4-VX
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 03:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599290879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCV3a/b1077OLMCLARhDYy7XnvZGT5FAn8uZVL2NTN8=;
 b=WOwv2k8NGrjoag/US6b/4WJBno+wF8rhJjfMoub8XZoJGif4Lny9L9vZU0Zpt3gc3C0eCE
 K8rjq33F7pg4RsiMSqXptyb+HloRhDvFlCdSbvodJVQwDxXqlyI/woPaPsbqHNJrAJCv+u
 A7IZZDa77LX+c37vKWhUzcT8p67Y1QQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-h5hSMPSvPt2HRFUYzalDeA-1; Sat, 05 Sep 2020 03:27:57 -0400
X-MC-Unique: h5hSMPSvPt2HRFUYzalDeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD2CC1005E76;
 Sat,  5 Sep 2020 07:27:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-27.ams2.redhat.com [10.36.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3399419C59;
 Sat,  5 Sep 2020 07:27:54 +0000 (UTC)
Subject: Re: [PATCH] stubs: Move qemu_timer_notify_cb() and remove
 qemu_notify_event() stub
To: luoyonggang@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20200902102433.304737-1-thuth@redhat.com>
 <cb02c4e8-6bc4-733e-ead9-bdbf5cd95b83@redhat.com>
 <CAE2XoE85TBKiKRzfaK_neTgJ9Shxi-5GZAwn7YRDw0Mcx3fkvA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c0449411-f3f7-3546-644f-04bfdef98b75@redhat.com>
Date: Sat, 5 Sep 2020 09:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE85TBKiKRzfaK_neTgJ9Shxi-5GZAwn7YRDw0Mcx3fkvA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 03:28:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/09/2020 08.05, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Wed, Sep 2, 2020 at 6:33 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
> 
>     On 02/09/20 12:24, Thomas Huth wrote:
>     > When cross-compiling with MinGW, there are sometimes some weird linker
>     > errors like:
>     >
>     > ibqemuutil.a(util_main-loop.c.obj): In function `qemu_notify_event':
>     > /builds/huth/qemu/build/../util/main-loop.c:139: multiple
>     definition of
>     >  `qemu_notify_event'
>     >
>     libqemuutil.a(stubs_notify-event.c.obj):/builds/huth/qemu/stubs/notify-event.c:5:
>     >  first defined here
>     > collect2: error: ld returned 1 exit status
>     > /builds/huth/qemu/rules.mak:88: recipe for target
>     'tests/test-timed-average.exe'
>     >  failed
>     >
>     > It seems like it works better when the qemu_timer_notify_cb() stub
>     (which
>     > calls qemu_notify_event()) is in a separate file - then we can
>     also even
>     > remove the qemu_notify_event() stub now.
>     >
>     > This patch is based on ideas from the patch "stubs: Remove
>     qemu_notify_event()"
>     > by Philippe Mathieu-Daudé and the patch "cpu-timers, icount: new
>     modules" from
>     > Claudio Fontana.
>     >
>     > Signed-off-by: Thomas Huth <thuth@redhat.com
>     <mailto:thuth@redhat.com>>
>     > ---
>     >  stubs/cpu-get-icount.c       | 5 -----
>     >  stubs/meson.build            | 2 +-
>     >  stubs/notify-event.c         | 6 ------
>     >  stubs/qemu-timer-notify-cb.c | 8 ++++++++
>     >  4 files changed, 9 insertions(+), 12 deletions(-)
>     >  delete mode 100644 stubs/notify-event.c
>     >  create mode 100644 stubs/qemu-timer-notify-cb.c
>     >
>     > diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
>     > index b35f844638..4001613240 100644
>     > --- a/stubs/cpu-get-icount.c
>     > +++ b/stubs/cpu-get-icount.c
>     > @@ -14,8 +14,3 @@ int64_t cpu_get_icount_raw(void)
>     >  {
>     >      abort();
>     >  }
>     > -
>     > -void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>     > -{
>     > -    qemu_notify_event();
>     > -}
>     > diff --git a/stubs/meson.build b/stubs/meson.build
>     > index 019bd79c7a..e2dfedc2a7 100644
>     > --- a/stubs/meson.build
>     > +++ b/stubs/meson.build
>     > @@ -24,9 +24,9 @@ stub_ss.add(files('machine-init-done.c'))
>     >  stub_ss.add(files('migr-blocker.c'))
>     >  stub_ss.add(files('monitor.c'))
>     >  stub_ss.add(files('monitor-core.c'))
>     > -stub_ss.add(files('notify-event.c'))
>     >  stub_ss.add(files('pci-bus.c'))
>     >  stub_ss.add(files('pci-host-piix.c'))
>     > +stub_ss.add(files('qemu-timer-notify-cb.c'))
>     >  stub_ss.add(files('qmp_memory_device.c'))
>     >  stub_ss.add(files('qtest.c'))
>     >  stub_ss.add(files('ram-block.c'))
>     > diff --git a/stubs/notify-event.c b/stubs/notify-event.c
>     > deleted file mode 100644
>     > index 827bb52d1a..0000000000
>     > --- a/stubs/notify-event.c
>     > +++ /dev/null
>     > @@ -1,6 +0,0 @@
>     > -#include "qemu/osdep.h"
>     > -#include "qemu/main-loop.h"
>     > -
>     > -void qemu_notify_event(void)
>     > -{
>     > -}
>     > diff --git a/stubs/qemu-timer-notify-cb.c
>     b/stubs/qemu-timer-notify-cb.c
>     > new file mode 100644
>     > index 0000000000..054b408b1c
>     > --- /dev/null
>     > +++ b/stubs/qemu-timer-notify-cb.c
>     > @@ -0,0 +1,8 @@
>     > +#include "qemu/osdep.h"
>     > +#include "sysemu/cpus.h"
>     > +#include "qemu/main-loop.h"
>     > +
>     > +void qemu_timer_notify_cb(void *opaque, QEMUClockType type)
>     > +{
>     > +    qemu_notify_event();
>     > +}
>     >
> 
>     Acked-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
> 
> LGTM, can you queue this patch,

Yes, I've got it in my queue for the patch series that enables
cross-compilers on gitlab. I just want to wait for Paolo's latest meson
series to hit the master branch before I send my pull request for the
cross-compiler series.

 Thomas


