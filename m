Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5590C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0491214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0491214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNejL-0005CN-1W
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:36:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNehH-0003cz-Cj
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNehG-000431-1J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:34:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNehE-000425-MY
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:34:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E457C06647D;
	Mon,  6 May 2019 14:34:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 42FDC271BB;
	Mon,  6 May 2019 14:34:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AEF911132B35; Mon,  6 May 2019 16:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190425200051.19906-1-ehabkost@redhat.com>
Date: Mon, 06 May 2019 16:34:20 +0200
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Thu, 25 Apr 2019 17:00:47 -0300")
Message-ID: <87r29bps7n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 06 May 2019 14:34:23 +0000 (UTC)
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
	qemu-devel@nongnu.org, Like Xu <like.xu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

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
>     static void device_set_realized(Object *obj, bool value, Error **errp)
>     {
>         /* [...] */
>         if (!obj->parent) {
>             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
>
>             object_property_add_child(container_get(qdev_get_machine(),
>                                                     "/unattached"),
>                                       name, obj, &error_abort);
>             unattached_parent = true;
>             g_free(name);
>         }
>         /* [...] */
>     }
>
> This one is tricky because on system emulation mode it needs
> "/machine" to already exist, but in user-only mode it needs to
> implicitly create a "/machine" container.

The patches look good to me on a glance.  Looking forward to v2.

