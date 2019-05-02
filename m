Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E953DC04AAA
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 20:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0F620C01
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 20:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0F620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMIGr-0003oY-2S
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 16:25:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMIFq-0003EX-H2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMIFp-0004qI-Gj
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMIFp-0004ju-Ak
	for qemu-devel@nongnu.org; Thu, 02 May 2019 16:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2C203082E71;
	Thu,  2 May 2019 20:24:27 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF40608AB;
	Thu,  2 May 2019 20:24:26 +0000 (UTC)
Date: Thu, 2 May 2019 17:24:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190502202425.GO28722@habkost.net>
References: <20190425200051.19906-1-ehabkost@redhat.com>
	<1428e157-aa6d-02fc-94c9-97e948e3654d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1428e157-aa6d-02fc-94c9-97e948e3654d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 02 May 2019 20:24:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502202425.Tdk7R4pJKBmbe-QWwX7Q7pB0ZnEmUDKiWUr3jZtfVMw@z>

On Fri, Apr 26, 2019 at 04:55:17PM +0800, Like Xu wrote:
> On 2019/4/26 4:00, Eduardo Habkost wrote:
> > This series moves some qdev code outside qdev.o, so it can be
> > compiled only in CONFIG_SOFTMMU.
> > 
> > The code being moved includes two qdev_get_machine() calls, so
> > this will make it easier to move qdev_get_machine() to
> > CONFIG_SOFTMMU later.
> > 
> > After this series, there's one remaining qdev_get_machine() call
> > that seems more difficult to remove:
> > 
> >      static void device_set_realized(Object *obj, bool value, Error **errp)
> >      {
> >          /* [...] */
> >          if (!obj->parent) {
> >              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
> > 
> >              object_property_add_child(container_get(qdev_get_machine(),
> >                                                      "/unattached"),
> >                                        name, obj, &error_abort);
> >              unattached_parent = true;
> >              g_free(name);
> >          }
> >          /* [...] */
> >      }
> > 
> 
> I may have an experimental patch to fix device_set_realized issue:
> 
> 1. in qdev_get_machine():
> replace
> 	dev = container_get(object_get_root(), "/machine");
> with
> 	dev = object_resolve_path("/machine", NULL);
> 
> 2. in device_set_realized():
> 
> Using
> 	Object *container = qdev_get_machine() ?
> 		qdev_get_machine() : object_get_root();
> and pass it to
> 	object_property_add_child(
> 		container_get(container, "/unattached"),
> 		name, obj, &error_abort);

I wouldn't like to call qdev_get_machine() here (see below[1]),
but trying "/machine" first and falling back to object_get_root()
sounds good, for two reasons:

* It won't require "/machine" to exist at all, on *-user;
* It will allow machines to create unattached devices on
  instance_init without crashing (which is not possible today).

> 
> With this fix, we could say the qdev_get_machine() does
> return the "/machine" object (or null) not a confused "/container".
> 
> We could continue to use qdev_get_machine() in system emulation mode,
> getting rid of its surprising side effect as Markus said.
> 
> The return value of qdev_get_machine() in user-only mode
> is the same object returned by object_get_root(),
> so no semantic changes.

[1] I wouldn't like to have a different qdev_get_machine()
function in user-only mode.  I would like to simply not call
qdev_get_machine() at all unless we're in system emulation mode.

-- 
Eduardo

