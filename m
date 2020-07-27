Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EFDC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C60206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C60206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02pA-0000y4-NK
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k02o3-0007oJ-Uz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:04:39 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:50661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k02o1-0003pk-Gz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:04:39 -0400
Received: from player772.ha.ovh.net (unknown [10.110.171.148])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 06EF825D0AD
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 15:04:33 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id BE64D14C762E2;
 Mon, 27 Jul 2020 13:04:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001650db22f-f998-4adf-b0a7-c6389ec550e9,
 B7B50C960922AB26A7D550ED897AF9E452A9EBFF) smtp.auth=groug@kaod.org
Date: Mon, 27 Jul 2020 15:04:25 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 for-5.2 1/2] spapr: Use error_append_hint() in
 spapr_caps.c
Message-ID: <20200727150425.2c7562ed@bahia.lan>
In-Reply-To: <87mu3uciq4.fsf@dusky.pond.sub.org>
References: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
 <159491947184.188975.5055299566400098290.stgit@bahia.lan>
 <87mu3uciq4.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15051311431663327630
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedtgdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.178.36; envelope-from=groug@kaod.org;
 helo=5.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:04:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 17:24:35 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > We have a dedicated error API for hints. Use it instead of embedding
> > the hint in the error message, as recommanded in the "qapi/error.h"
> > header file.
> >
> > Since spapr_caps_apply() passes &error_fatal, all functions must
> > also call the ERRP_GUARD() macro for error_append_hint() to be
> > functional.
> 
> This isn't a request for change in this patch, just an attempt to squash
> possible misunderstandings.
> 
> It's true that error_append_hint() without ERRP_GUARD() works as long as
> the caller doesn't pass certain errp arguments.  But the callee should
> work for all possible @errp arguments, not just the ones that get passed
> today.  That's why error.h wants you to guard *all* uses of
> error_append_hint(errp):
> 
>  * = Why, when and how to use ERRP_GUARD() =
>  *
>  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>  * - It must not be dereferenced, because it may be null.
>  * - It should not be passed to error_prepend() or
>  *   error_append_hint(), because that doesn't work with &error_fatal.
>  * ERRP_GUARD() lifts these restrictions.
> 

Yeah, I just wanted to emphasize that we were precisely in the case
where we _really_ need to lift the restriction, but I'm perfectly fine
with dropping this sentence if you consider it useless.

BTW, should we have a way for CI to ensure that a patch that adds
error_prepend(errp, ...) or error_append_hint(errp, ...) also adds
ERRP_GUARD() ? Not sure that people read error.h that often...

> No need to make an argument involving the possible arguments (pardon the
> pun).
> 

:)

> [...]
> 


