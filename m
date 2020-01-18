Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26D6C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8476624699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 14:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8476624699
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isopO-00076F-IK
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 09:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1isonM-0004Xm-Ct
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1isonJ-0000s3-7t
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:09:47 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53168 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
 id 1isonI-0000Ld-SM
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 09:09:45 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BD3A61A151E
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 15:08:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: by mail.rt-rk.com (Postfix, from userid 492)
 id 774301A1E96; Sat, 18 Jan 2020 15:08:37 +0100 (CET)
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
X-Forward: 127.0.0.1
content-type: multipart/alternative;
 boundary="----=_=-_OpenGroupware_org_NGMime-12874-1579356517.468211-3------"
date: Sat, 18 Jan 2020 15:08:37 +0100
subject: =?utf-8?q?=5BGSoC=2FOutreachy?= QEMU project =?utf-8?q?proposal=5D?= 
 Measure and Analyze QEMU Performance
MIME-Version: 1.0
to: qemu-devel@nongnu.org
message-id: <324a-5e231180-7-6946d180@169257031>
User-Agent: SOGoMail 2.3.10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_=-_OpenGroupware_org_NGMime-12874-1579356517.468211-3------
content-type: text/plain; charset=utf-8
content-length: 3077
content-transfer-encoding: quoted-printable


Hi, everybody.

I am going to propose several ideas for QEMU participation in GSoC/Outr=
eachy in next few days. This is the first one. Please feel free to give=
 an honest feedback.

Yours,
Aleksandar



Measure and Analyze Performance of
QEMU User and System Mode Emulation


PLANNED ACTIVITIES

PART I: (user mode)

=C2=A0=C2=A0 a) select around a dozen test programs (resembling compone=
nts of SPEC benchmark, but must be open source, and preferably license =
compatible with QEMU); test programs should be distributed like this: 4=
-5 FPU CPU-intensive, 4-5 non-FPU CPU intensive, 1-2 I/O intensive;
=C2=A0=C2=A0 b) measure execution time and other performance data in us=
er mode across all platforms for ToT:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - try to improve performance if th=
ere is an obvious bottleneck (but this is unlikely);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - develop tests that will be prote=
ction against performance regressions in future.
=C2=A0=C2=A0 c) measure execution time in user-mode for selected platfo=
rms for all QEMU versions in last 5 years:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - confirm performance improvements=
 and/or detect performance degradations.
=C2=A0=C2=A0 d) summarize all results in a comprehensive form, using al=
so graphics/data visualization.

PART II: (system mode)

=C2=A0=C2=A0 a) measure execution time and other performance data for b=
oot/shutdown cycle for selected machines for ToT:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - try to improve performance if th=
ere is an obvious bottleneck;
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - develop tests that will be prote=
ction against performance regressions in future.
=C2=A0=C2=A0 b) summarize all results in a comprehensive form.


DELIVERABLES

1) Each maintainer for target will be given a list of top 25 functions =
in terms of spent host time for each benchmark described in the previou=
s section. Additional information and observations will be also provide=
d, if the judgment is they are useful and relevant.

2) Each maintainer for machine (that has successful boot/shutdown cycle=
) will be given a list of top 25 functions in terms of spent host time =
during boot/shutdown cycle. Additional information and observations wil=
l be also provided, if the judgment is they are useful and relevant.

3) The community will be given all devised performance measurement meth=
ods in the form of easily reproducible step-by-step setup and execution=
 procedures.

(parts 1) and 2) will be, of course, published to everybody, maintainer=
s are simply singled out as main recipients and decision-makers on poss=
ible next action items)

Deliverable will be distributed over wide time interval (in other words=
, they will not be presented just at the end of project, but gradually =
during project execution).


Mentor: Aleksandar Markovic (myself) (but, I am perfectly fine if someb=
ody else wants to mentor the project, if interested)

Student: open


That would be all, feel free to ask for additional info and/or clarific=
ation.
=C2=A0

------=_=-_OpenGroupware_org_NGMime-12874-1579356517.468211-3------
content-type: text/html; charset=utf-8
content-length: 3635
content-transfer-encoding: quoted-printable

<html>Hi, everybody.<br /><br />I am going to propose several ideas for=
 QEMU participation in GSoC/Outreachy in next few days. This is the fir=
st one. Please feel free to give an honest feedback.<br /><br />Yours,<=
br />Aleksandar<br /><br /><br /><br /><span style=3D"font-size:16px;">=
<strong><span style=3D"font-size:20px;">Measure and Analyze Performance=
 of<br />QEMU User and System Mode Emulation</span></strong></span><br =
/><br /><br /><span style=3D"font-size:16px;"><u><em>PLANNED ACTIVITIES=
</em></u></span><br /><br />PART I: (user mode)<br /><br />&nbsp;&nbsp;=
 a) select around a dozen test programs (resembling components of SPEC =
benchmark, but must be open source, and preferably license compatible w=
ith QEMU); test programs should be distributed like this: 4-5 FPU CPU-i=
ntensive, 4-5 non-FPU CPU intensive, 1-2 I/O intensive;<br />&nbsp;&nbs=
p; b) measure execution time and other performance data in user mode ac=
ross all platforms for ToT:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -=
 try to improve performance if there is an obvious bottleneck (but this=
 is unlikely);<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - develop test=
s that will be protection against performance regressions in future.<br=
 />&nbsp;&nbsp; c) measure execution time in user-mode for selected pla=
tforms for all QEMU versions in last 5 years:<br />&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; - confirm performance improvements and/or detect perfo=
rmance degradations.<br />&nbsp;&nbsp; d) summarize all results in a co=
mprehensive form, using also graphics/data visualization.<br /><br />PA=
RT II: (system mode)<br /><br />&nbsp;&nbsp; a) measure execution time =
and other performance data for boot/shutdown cycle for selected machine=
s for ToT:<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - try to improve p=
erformance if there is an obvious bottleneck;<br />&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; - develop tests that will be protection against perfor=
mance regressions in future.<br />&nbsp;&nbsp; b) summarize all results=
 in a comprehensive form.<br /><br /><br /><span style=3D"font-size:16p=
x;"><em><u>DELIVERABLES</u></em></span><br /><br />1) Each maintainer f=
or target will be given a list of top 25 functions in terms of spent ho=
st time for each benchmark described in the previous section. Additiona=
l information and observations will be also provided, if the judgment i=
s they are useful and relevant.<br /><br />2) Each maintainer for machi=
ne (that has successful boot/shutdown cycle) will be given a list of to=
p 25 functions in terms of spent host time during boot/shutdown cycle. =
Additional information and observations will be also provided, if the j=
udgment is they are useful and relevant.<br /><br />3) The community wi=
ll be given all devised performance measurement methods in the form of =
easily reproducible step-by-step setup and execution procedures.<br /><=
br />(parts 1) and 2) will be, of course, published to everybody, maint=
ainers are simply singled out as main recipients and decision-makers on=
 possible next action items)<br /><br />Deliverable will be distributed=
 over wide time interval (in other words, they will not be presented ju=
st at the end of project, but gradually during project execution).<br /=
><br /><br /><em>Mentor:</em> Aleksandar Markovic (myself) (but, I am p=
erfectly fine if somebody else wants to mentor the project, if interest=
ed)<br /><br /><em>Student:</em> open<br /><br /><br />That would be al=
l, feel free to ask for additional info and/or clarification.<br />&nbs=
p;</html>

------=_=-_OpenGroupware_org_NGMime-12874-1579356517.468211-3--------


