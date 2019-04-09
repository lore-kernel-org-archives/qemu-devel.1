Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC7C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A1D920883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 05:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1D920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35741 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjmD-0002jK-Lc
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 01:58:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjlS-0002N8-2o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjlR-0003hm-4O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:57:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDjlQ-0003hV-S8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:57:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB1E430833B5;
	Tue,  9 Apr 2019 05:57:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45A1F5D9C9;
	Tue,  9 Apr 2019 05:57:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BFCD71138648; Tue,  9 Apr 2019 07:57:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
	<20190408222601.GR7238@habkost.net>
Date: Tue, 09 Apr 2019 07:57:39 +0200
In-Reply-To: <20190408222601.GR7238@habkost.net> (Eduardo Habkost's message of
	"Mon, 8 Apr 2019 19:26:01 -0300")
Message-ID: <87imvniuuk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 09 Apr 2019 05:57:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
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
Cc: Thomas Huth <thuth@redhat.com>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409055739.PMhD0UiPYUo9T1FqHREM24XaJYbTiE8qLG2m1fwAgk0@z>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Apr 08, 2019 at 05:06:49PM +0200, Thomas Huth wrote:
>> On 08/04/2019 15.45, Wei Yang wrote:
> [...]
>> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> > index 6077d27361..b11f3b15c1 100644
>> > --- a/hw/i386/pc.c
>> > +++ b/hw/i386/pc.c
>> > @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>> >      }
>> >  
>> >      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
>> > +    if (*errp) {
>> > +        return;
>> > +    }
>> 
>> Not sure, but I think you can not rely on the fact that the caller set
>> *errp = NULL already... that's why it is more common to use a local_err
>> variable and error_propagate() for such cases (which is what I did in my
>> patch).
>
> *errp can't be non-NULL (otherwise functions calling error_setg()
> would crash).  errp can be NULL, though, and that's why you need
> a local_err variable.

Correct.  The big comment in error.h advises:

 * Receive an error and pass it on to the caller:
 *     Error *err = NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *         error_propagate(errp, err);
 *     }
 * where Error **errp is a parameter, by convention the last one.
 *
 * Do *not* "optimize" this to
 *     foo(arg, errp);
 *     if (*errp) { // WRONG!
 *         handle the error...
 *     }
 * because errp may be NULL!
 *
 * But when all you do with the error is pass it on, please use
 *     foo(arg, errp);
 * for readability.

> I'd love to eliminate NULL errp from our codebase, but I couldn't
> find a way to do it that is safe and simple (i.e. not letting us
> pass NULL errp by mistake and not requiring a macro wrapping
> every `&local_err` expression).

Also, I'd prefer not not deviate even more from GError.

Apropos NULL, we often pass NULL where we really ought to pass
&error_abort.

