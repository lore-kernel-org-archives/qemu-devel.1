Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5837FC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C21B20879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56361 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9qu-0005mC-4U
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:14:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQ9q6-0005SL-DY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQ9q4-0001Lc-38
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQ9q3-0001LG-Rq
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C40FD7E427;
	Mon, 13 May 2019 12:13:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 75B0F19C67;
	Mon, 13 May 2019 12:13:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E4CDA11385E4; Mon, 13 May 2019 14:13:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190512142108-mutt-send-email-mst@kernel.org>
	<3779f01f-8a5b-0785-254b-d1a4cfdf593c@redhat.com>
	<20190513084945.GA15247@paraplu>
Date: Mon, 13 May 2019 14:13:46 +0200
In-Reply-To: <20190513084945.GA15247@paraplu> (Kashyap Chamarthy's message of
	"Mon, 13 May 2019 10:49:45 +0200")
Message-ID: <871s128scl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 13 May 2019 12:13:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/3] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	"Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kashyap Chamarthy <kchamart@redhat.com> writes:

> On Mon, May 13, 2019 at 08:36:23AM +0200, Laurent Vivier wrote:
>> On 12/05/2019 20:21, Michael S. Tsirkin wrote:
>
> [...]
>
>> > > Kashyap Chamarthy (1):
>> > >    VirtIO-RNG: Update default entropy source to `/dev/urandom`
>> > > 
>> > > Laurent Vivier (2):
>> > >    rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
>> > >    virtio-rng: change default backend to rng-builtin
>> > 
>> > 
>> > OK pls address Marku's comment on commit msg and I will merge.
>> 
>> Kashyap,
>> 
>> as this patch is from you, do you agree?
>
> Yes.
>
>> If so, I can update the message and send a new version of the series
>> (or you canr esend your patch alone if you prefer).
>
> Please go ahead and add it, the below is the text (from Dan/Markus):
>
>     What about other OSes?
>     ----------------------
>     
>     `/dev/urandom` exists and works on OS-X, FreeBSD, DragonFlyBSD, NetBSD
>     and OpenBSD, which cover all the non-Linux platforms we explicitly
>     support, aside from Windows.
>     
>     On Windows `/dev/random` doesn't work either so we don't regress.
>     This is actually another argument in favour of using the newly
>     proposed 'rng-builtin' backend by default, as that will work on
>     Windows.

Additionally, please insert "on Linux" into the first paragraph, like
this:

  When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
  source of entropy, and that source needs to be "non-blocking", like
  `/dev/urandom`.  However, currently QEMU defaults to the problematic
  `/dev/random`, which on Linux is "blocking" (as in, it waits until
  sufficient entropy is available).

