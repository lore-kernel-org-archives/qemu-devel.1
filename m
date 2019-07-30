Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5416DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9B3206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9B3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSPI-0008Lp-5S
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51571)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hsSOg-0007LI-Vb
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hsSOg-0007vR-1F
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hsSOb-0007sD-RS; Tue, 30 Jul 2019 09:42:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D27F3092647;
 Tue, 30 Jul 2019 13:42:28 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABFF25D9E2;
 Tue, 30 Jul 2019 13:42:11 +0000 (UTC)
Date: Tue, 30 Jul 2019 15:42:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190730154209.2049f10a.cohuck@redhat.com>
In-Reply-To: <20190729145654.14644-2-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 30 Jul 2019 13:42:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, berrange@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 16:56:22 +0200
Damien Hedde <damien.hedde@greensocs.com> wrote:

(...)

> +/*
> + * ResettableClass:
> + * Interface for resettable objects.
> + *
> + * The reset operation is divided in several phases each represented by a
> + * method.
> + *
> + * Each Ressetable must maintain a reset counter in its state, 3 methods allows
> + * to interact with it.
> + *
> + * @phases.init: should reset local state only. Takes a bool @cold argument
> + * specifying whether the reset is cold or warm. It must not do side-effect
> + * on others objects.

I'm having a hard time figuring out what a 'cold' or a 'warm' reset is
supposed to be... can you add a definition/guideline somewhere?

> + *
> + * @phases.hold: side-effects action on others objects due to staying in a
> + * resetting state.
> + *
> + * @phases.exit: leave the reset state, may do side-effects action on others
> + * objects.
> + *
> + * @set_cold: Set whether the current reset is cold or warm. Return the
> + * previous flag value. Return value has no meaning if @get_count returns
> + * a zero value.

Same here.

> + *
> + * @set_hold_needed: Set hold_needed flag. Return the previous flag value.
> + *
> + * @get_count: Get the current reset count
> + * @increment_count: Increment the reset count, returns the new count
> + * @decrement_count: decrement the reset count, returns the new count
> + *
> + * @foreach_child: Executes a given function on every Resettable child.
> + * A child is not a QOM child, but a child a reset meaning.
> + */

(...)

