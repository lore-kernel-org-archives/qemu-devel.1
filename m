Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF5C2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF5C2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE6Y-0003HQ-Pp
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:35:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1hUE23-0007DD-LA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1hUDzn-0004WV-60
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:28:45 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38019 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1hUDzm-0003gr-S4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:28:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id CD3351A4172;
	Fri, 24 May 2019 19:27:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: by mail.rt-rk.com (Postfix, from userid 492)
	id 02AF81A4638; Fri, 24 May 2019 19:27:35 +0200 (CEST)
in-reply-to: <CAFEAcA_gW9PZFTB42LRXCPcD+aiWBdH3TQX7nHad_5=ioRm-ug@mail.gmail.com>
to: "Peter Maydell" <peter.maydell@linaro.org>
from: "Milos Stojanovic" <Milos.Stojanovic@rt-rk.com>
message-id: <71b2-5ce82980-b-635bde80@15751148>
X-Forward: 127.0.0.1
date: Fri, 24 May 2019 19:27:34 +0200
MIME-Version: 1.0
User-Agent: SOGoMail 2.3.10
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] 
 =?utf-8?b?Pz09P3V0Zi04P3E/ID89PT91dGYtOD9xPyBbUEFU?=
 =?utf-8?q?CH_0/5=5D=3F=3D=3D=3Futf-8=3Fq=3F_linux-user=3A_Support_signal_?=
 =?utf-8?q?passing_for_targets_having_more_signals_than_host?=
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
	Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hello, Peter.
For this implemenation rt=5Fsigqueueinfo()/rt=5Ftgsigqueueinfo() were u=
sed to multiplex signals that are out of the host range. This enabled t=
he use of a wider signal range with rt=5Fsigqueueinfo(), rt=5Ftgsigqueu=
einfo(), as well as kill() (for pid > 0) and tgkill(). A process can no=
w use these system calls to send a range of signals which weren't suppo=
reted before to itself or others threads or processes.

The tkill() system call and kill() with the argument pid <=3D 0 couldn'=
t be implemented simply using this method because it requires acquiring=
 information about, and sending simultaneous signals to multiple thread=
s or processes and these functionalities are out of the scope of rt=5Fs=
igqueueinfo()/rt=5Ftgsigqueueinfo().

This patch set was primarily focused on expanding the range of real-tim=
e signals and making them usable but some limitations still remain. For=
 example, the priority of those real-time signals, as defined by POSIX,=
 doesn't depend on the actual signal number but on the host signal nube=
r which is used for multiplexing.
As it now is, the functionaly is only enabled for signals that are high=
er-numbered then the host signals but I don't see a conceptual problem =
in expanding and testing the implenentation to include other signals (e=
.g. the signals that NPTL uses).

Regards,
Milo=C5=A1
