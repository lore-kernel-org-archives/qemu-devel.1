Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB04C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3250920786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3250920786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Lau-0005Wi-Gj
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0LaH-00056F-Ut
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:07:41 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:47589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0LaF-0006OY-PI
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:07:41 -0400
Received: from player699.ha.ovh.net (unknown [10.110.208.124])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id B8BCC246887
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 11:07:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 10AF814BA7817;
 Tue, 28 Jul 2020 09:07:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00511f049d4-4040-4a9d-9273-ab7c05060d9e,96196EA346850768E7E70500A314E772A5EF2CEB)
 smtp.auth=groug@kaod.org
Date: Tue, 28 Jul 2020 11:07:26 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 for-5.2 1/2] spapr: Use error_append_hint() in
 spapr_caps.c
Message-ID: <20200728110726.5882b046@bahia.lan>
In-Reply-To: <87h7tsf6cv.fsf@dusky.pond.sub.org>
References: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
 <159491947184.188975.5055299566400098290.stgit@bahia.lan>
 <87mu3uciq4.fsf@dusky.pond.sub.org>
 <20200727150425.2c7562ed@bahia.lan>
 <87h7tsf6cv.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16922275603143563662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=91.121.62.11; envelope-from=groug@kaod.org;
 helo=15.mo4.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 05:07:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 09:26:08 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > On Mon, 20 Jul 2020 17:24:35 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> >> Greg Kurz <groug@kaod.org> writes:
> >> 
> >> > We have a dedicated error API for hints. Use it instead of embedding
> >> > the hint in the error message, as recommanded in the "qapi/error.h"
> >> > header file.
> >> >
> >> > Since spapr_caps_apply() passes &error_fatal, all functions must
> >> > also call the ERRP_GUARD() macro for error_append_hint() to be
> >> > functional.
> >> 
> >> This isn't a request for change in this patch, just an attempt to squash
> >> possible misunderstandings.
> >> 
> >> It's true that error_append_hint() without ERRP_GUARD() works as long as
> >> the caller doesn't pass certain errp arguments.  But the callee should
> >> work for all possible @errp arguments, not just the ones that get passed
> >> today.  That's why error.h wants you to guard *all* uses of
> >> error_append_hint(errp):
> >> 
> >>  * = Why, when and how to use ERRP_GUARD() =
> >>  *
> >>  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> >>  * - It must not be dereferenced, because it may be null.
> >>  * - It should not be passed to error_prepend() or
> >>  *   error_append_hint(), because that doesn't work with &error_fatal.
> >>  * ERRP_GUARD() lifts these restrictions.
> >> 
> >
> > Yeah, I just wanted to emphasize that we were precisely in the case
> > where we _really_ need to lift the restriction, but I'm perfectly fine
> > with dropping this sentence if you consider it useless.
> 
> I lean towards dropping it.
> 

David,

Do you want me to send an updated version of this patch or can you
fix this in your tree ?

> > BTW, should we have a way for CI to ensure that a patch that adds
> > error_prepend(errp, ...) or error_append_hint(errp, ...) also adds
> > ERRP_GUARD() ? Not sure that people read error.h that often...
> 
> I don't know.  Wait and see whether it's worth automating?  We didn't
> automate checking other Error API rules, like "no newlines in error
> messages".  That one can't crash, though.
> 
> The check would have to look beyond the patch, which checkpatch.pl
> doesn't do.
> 

<thinking aloud>
Maybe checkpatch.pl could be fed with an extended version of the patch
that has enough context, eg. git show -U$(wc -l ${file}) ${file} ?
</thinking aloud>

> >> No need to make an argument involving the possible arguments (pardon the
> >> pun).
> >> 
> >
> > :)
> >
> >> [...]
> >> 
> 


