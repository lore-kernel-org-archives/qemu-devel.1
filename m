Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B2C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27F320684
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27F320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJwea-00007t-4g
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 04:56:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hJwdl-0008BK-6F
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hJwdj-0002dS-Fx
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:55:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:40051)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hJwdh-0002YF-Id
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:55:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 01:55:21 -0700
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; d="scan'208";a="137633899"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.118])
	([10.239.196.118])
	by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES128-SHA;
	26 Apr 2019 01:55:19 -0700
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190425200051.19906-1-ehabkost@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <1428e157-aa6d-02fc-94c9-97e948e3654d@linux.intel.com>
Date: Fri, 26 Apr 2019 16:55:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH 0/4] Remove some qdev_get_machine() calls
 from CONFIG_USER_ONLY
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426085517.0j5JUja4BWOIsegm5FFDNGINyOEFJ88B60XPnYsD9FU@z>

On 2019/4/26 4:00, Eduardo Habkost wrote:
> This series moves some qdev code outside qdev.o, so it can be
> compiled only in CONFIG_SOFTMMU.
> 
> The code being moved includes two qdev_get_machine() calls, so
> this will make it easier to move qdev_get_machine() to
> CONFIG_SOFTMMU later.
> 
> After this series, there's one remaining qdev_get_machine() call
> that seems more difficult to remove:
> 
>      static void device_set_realized(Object *obj, bool value, Error **errp)
>      {
>          /* [...] */
>          if (!obj->parent) {
>              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
> 
>              object_property_add_child(container_get(qdev_get_machine(),
>                                                      "/unattached"),
>                                        name, obj, &error_abort);
>              unattached_parent = true;
>              g_free(name);
>          }
>          /* [...] */
>      }
> 

I may have an experimental patch to fix device_set_realized issue:

1. in qdev_get_machine():
replace
	dev = container_get(object_get_root(), "/machine");
with
	dev = object_resolve_path("/machine", NULL);

2. in device_set_realized():

Using
	Object *container = qdev_get_machine() ?
		qdev_get_machine() : object_get_root();
and pass it to
	object_property_add_child(
		container_get(container, "/unattached"),
		name, obj, &error_abort);

With this fix, we could say the qdev_get_machine() does
return the "/machine" object (or null) not a confused "/container".

We could continue to use qdev_get_machine() in system emulation mode,
getting rid of its surprising side effect as Markus said.

The return value of qdev_get_machine() in user-only mode
is the same object returned by object_get_root(),
so no semantic changes.


> This one is tricky because on system emulation mode it needs
> "/machine" to already exist, but in user-only mode it needs to
> implicitly create a "/machine" container.
> 
> Eduardo Habkost (4):
>    machine: Move gpio code to hw/core/gpio.c
>    move qdev hotplug code to qdev-hotplug.c
>    qdev: Don't compile hotplug code in user-mode emulation
>    qdev-hotplug: Don't check type of qdev_get_machine()
> 
>   hw/core/bus.c                |  11 --
>   hw/core/gpio.c               | 206 ++++++++++++++++++++++++++++++++
>   hw/core/qdev-hotplug-stubs.c |  44 +++++++
>   hw/core/qdev-hotplug.c       |  64 ++++++++++
>   hw/core/qdev.c               | 219 -----------------------------------
>   hw/core/Makefile.objs        |   5 +-
>   tests/Makefile.include       |   3 +-
>   7 files changed, 320 insertions(+), 232 deletions(-)
>   create mode 100644 hw/core/gpio.c
>   create mode 100644 hw/core/qdev-hotplug-stubs.c
>   create mode 100644 hw/core/qdev-hotplug.c
> 


