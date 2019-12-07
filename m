Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E35C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 16:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FAA2176D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 16:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FAA2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iddJO-0006m1-1A
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 11:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iddIZ-0006Lz-JA
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iddIY-0006Zp-BX
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:51:15 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:53909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iddIY-0006XM-5G
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 11:51:14 -0500
Received: from player758.ha.ovh.net (unknown [10.108.1.20])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3BD8A1EEF59
 for <qemu-devel@nongnu.org>; Sat,  7 Dec 2019 17:51:05 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id 7191AD0CB458;
 Sat,  7 Dec 2019 16:51:03 +0000 (UTC)
Date: Sat, 7 Dec 2019 17:51:01 +0100
From: Greg Kurz <groug@kaod.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] exec: Remove the duplicated check in parse_cpu_option()
Message-ID: <20191207175101.2653e7b4@bahia.w3ibm.bluemix.net>
In-Reply-To: <be362efe-0174-ec14-f16f-87ecfda4203a@redhat.com>
References: <20191206063337.39764-1-gshan@redhat.com>
 <20191206175840.06507c32@bahia.w3ibm.bluemix.net>
 <be362efe-0174-ec14-f16f-87ecfda4203a@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15598217311702784406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekhedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.139.208
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 7 Dec 2019 23:56:55 +1100
Gavin Shan <gshan@redhat.com> wrote:

> On 12/7/19 3:58 AM, Greg Kurz wrote:
> > On Fri,  6 Dec 2019 17:33:37 +1100
> > Gavin Shan <gshan@redhat.com> wrote:
> > 
> >> The @cpu_option shouldn't be NULL, otherwise assertion from g_strsplit()
> >> should be raised as below message indicates. So it's meaningless to validate
> >> @model_pices[0] in parse_cpu_option() as it shouldn't be NULL either.
> >>
> >>     qemu-system-aarch64: GLib: g_strsplit: assertion 'string != NULL' failed
> >>
> >> This just removes the check and unused message.
> >>
> > 
> > Hrm... the check isn't about @cpu_option being NULL. It is about filtering out
> > invalid syntaxes like:
> > 
> > -cpu ''
> > 
> > or
> > 
> > -cpu ,some-prop
> > 
> 
> Greg, Thanks for your review on this trivial patch.
> 
> @cpu_option[0] is NULL when we have "-cpu ''". We run into assertion raised
> by subsequent cpu_class_by_name(). However, @cpu_option[0] isn't NULL with
> something like "-cpu ,xxx", but the CPU model specific class can't be found
> at last.
> 

You're right, the case with a leading ',' is caught by the other check.

> So the validation mostly relies on cpu_class_by_name() if I'm correct. It's
> fine to remove the check. However, it provides explicit error message, which
> isn't bad though:
> 
>     error_report("-cpu option cannot be empty");
> 

It's definitely not fine to remove an error message that clearly explains
to the user what he has done wrong in favor of QEMU aborting and printing
something cryptic like:

    cpu_class_by_name: Assertion `cpu_model && cc->class_by_name' failed.

Assertions are for bugs, not for bad command line usage.

> >> Signed-off-by: Gavin Shan <gshan@redhat.com>
> >> ---
> >>   exec.c | 5 -----
> >>   1 file changed, 5 deletions(-)
> >>
> >> diff --git a/exec.c b/exec.c
> >> index ffdb518535..3cff459e43 100644
> >> --- a/exec.c
> >> +++ b/exec.c
> >> @@ -963,11 +963,6 @@ const char *parse_cpu_option(const char *cpu_option)
> >>       const char *cpu_type;
> >>   
> >>       model_pieces = g_strsplit(cpu_option, ",", 2);
> >> -    if (!model_pieces[0]) {
> >> -        error_report("-cpu option cannot be empty");
> >> -        exit(1);
> >> -    }
> >> -
> >>       oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
> >>       if (oc == NULL) {
> >>           error_report("unable to find CPU model '%s'", model_pieces[0]);
> > 
> 
> Regards,
> Gavin
> 

Cheers,

--
Greg

