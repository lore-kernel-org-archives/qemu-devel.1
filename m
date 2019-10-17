Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E06621835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E06621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8ik-00086u-UE
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iL843-0006iA-0H
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iL841-0008KG-0x
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:51:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iL840-0008J4-OG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:51:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3771588311;
 Thu, 17 Oct 2019 15:51:43 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-206.ams2.redhat.com
 [10.36.117.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F8E19C70;
 Thu, 17 Oct 2019 15:51:42 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 5B9483E044D; Thu, 17 Oct 2019 17:51:41 +0200 (CEST)
Date: Thu, 17 Oct 2019 17:51:41 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Call for Presentations] FOSDEM 2020 Virtualization & IaaS Devroom
Message-ID: <20191017155141.GA24417@paraplu>
References: <CAJSP0QWchnsEqCFiPr9-axrAx3rF6HxDBQ0HUgSg3WriVqSusw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QWchnsEqCFiPr9-axrAx3rF6HxDBQ0HUgSg3WriVqSusw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 17 Oct 2019 15:51:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 09:20:05AM +0100, Stefan Hajnoczi wrote:
> The FOSDEM open source developer conference is taking place in
> Brussels, Belgium on February 1st & 2nd, 2020.  The call for
> virtualization presentations has been posted:
>=20
> https://lists.fosdem.org/pipermail/fosdem/2019q4/002889.html
>=20
> I just wanted to forward this because the CfP only went to
> qemu-discuss where developers may have missed it.  Hope to see you at
> FOSDEM!

The formatting in the above link is really broken and unreadable and
seems to be missing some text (on "speaker mentoring program") .  I took
the liberty to reformat the text for readability; here it is:

-----------------------------------------------------------------------
We are excited to announce that the call for proposals is now open for
the Virtualization & IaaS devroom at the upcoming FOSDEM 2020, to be
hosted on February 1st 2020.

The year 2020 will mark FOSDEM=E2=80=99s 20th anniversary as one of the
longest-running free and open source software developer events,
attracting thousands of developers and users from all over the world.
FOSDEM will be held once again in Brussels, Belgium, on February 1st &
2nd, 2020.

This devroom is a collaborative effort, and is organized by dedicated
folks from projects such as OpenStack, Xen Project, oVirt, QEMU, KVM,
libvirt, Foreman, and virtualization-related projects. We would like to
invite all those who are involved in these fields to submit your
proposals by December 1st, 2019.


Important Dates
---------------

- Submission deadline: 1 December 2019
- Acceptance notifications: 10 December 2019
- Final schedule announcement: 15th December 2019
- Devroom is only on one day: 1st February 2020


About the Devroom
-----------------

The Virtualization & IaaS devroom will feature session topics such as ope=
n
source hypervisors and virtual machine managers such as Xen Project,
KVM, QEMU, bhyve, and VirtualBox, and Infrastructure-as-a-Service
projects such as KubeVirt, Apache CloudStack, OpenStack, oVirt, QEMU and
OpenNebula.

This devroom will host presentations that focus on topics of shared
interest, such as KVM; QEMU; libvirt; shared storage; virtualized
networking; cloud security; clustering and high availability;
interfacing with multiple hypervisors; hyperconverged deployments; and
scaling across hundreds or thousands of servers.

Presentations in this devroom will be aimed at developers working on
these platforms who are looking to collaborate and improve shared
infrastructure or solve common problems. We seek topics that encourage
dialog between projects and continued work post-FOSDEM.


Submit Your Proposal
--------------------

All submissions must be made via the Pentabarf event planning site[1]. If
you have not used Pentabarf before, you will need to create an account. I=
f
you submitted proposals for FOSDEM in previous years, you can use your
existing account.

After creating the account, select Create Event to start the submission
process. Make sure to select Virtualization and IaaS devroom from the Tra=
ck
list. Please fill out all the required fields, and provide a meaningful
abstract and description of your proposed session.


Submission Guidelines
---------------------

We expect more proposals than we can possibly accept, so it is vitally
important that you submit your proposal on or before the deadline. Late
submissions are unlikely to be considered.

All presentation slots are 30 minutes, with 20 minutes planned for
presentations, and 10 minutes for Q&A.

All presentations will be recorded and made available under Creative
Commons licenses. In the Submission notes field, please indicate that you
agree that your presentation will be licensed under the CC-By-SA-4.0 or
CC-By-4.0 license and that you agree to have your presentation recorded.

For example:

"If my presentation is accepted for FOSDEM, I hereby agree to license all
recordings, slides, and other associated materials under the Creative
Commons Attribution Share-Alike 4.0 International License. Sincerely,
<NAME>."

In the Submission notes field, please also confirm that if your talk is
accepted, you will be able to attend FOSDEM and deliver your presentation=
.
We will not consider proposals from prospective speakers who are unsure
whether they will be able to secure funds for travel and lodging to atten=
d
FOSDEM. (Sadly, we are not able to offer travel funding for prospective
speakers.)

Speaker Mentoring Program
-------------------------

As a part of the rising efforts to grow our communities and encourage a
diverse and inclusive conference ecosystem, we're happy to announce that
we'll be offering mentoring for new speakers. Our mentors can help you
with tasks such as reviewing your abstract, reviewing your presentation
outline or slides, or practicing your talk with you.

You may apply to the mentoring program as a newcomer speaker if you:

Never presented before or
Presented only lightning talks or
Presented full-length talks at small meetups (<50 ppl)

Mentored presentations will have 25-minute slots, where 20 minutes will
include the presentation and 5 minutes will be reserved for questions.
The number of newcomer session slots is limited, so we will probably not =
be
able to accept all applications.

You must submit your talk and abstract to apply for the mentoring program=
,
our mentors are volunteering their time and will happily provide feedback
but won't write your presentation for you!

If you are experiencing problems with Pentabarf, the proposal submission
interface, or have other questions, you can email our devroom mailing
list[2] and we will try to help you.


How to Apply
------------

In addition to agreeing to video recording and confirming that you can
attend FOSDEM in case your session is accepted, please write "speaker
mentoring program application" in the "Submission notes" field, and list
any prior speaking experience or other relevant information for your
application.


Code of Conduct
---------------

Following the release of the updated code of conduct for FOSDEM, we'd
like to remind all speakers and attendees that all of the presentations
and discussions in our devroom are held under the guidelines set in the
CoC and we expect attendees, speakers, and volunteers to follow the CoC
at all times.

If you submit a proposal and it is accepted, you will be required to
confirm that you accept the FOSDEM CoC. If you have any questions about
the CoC or wish to have one of the devroom organizers review your
presentation slides or any other content for CoC compliance, please
email us and we will do our best to assist you.


Call for Volunteers
-------------------

We are also looking for volunteers to help run the devroom. We need
assistance watching time for the speakers, and helping with video for the
devroom. Please contact devroom mailing list [2] for more information.


Questions?
----------

If you have any questions about this devroom, please send your questions
to our devroom mailing list. You can also subscribe to the list to
receive updates about important dates, session announcements, and to
connect with other attendees.

See you all at FOSDEM!
-----------------------------------------------------------------------

--=20
/kashyap

