Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F2C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458532189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458532189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hikZO-0000LY-J8
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 15:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hijlS-0003Jy-Ex
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hijlR-00042D-0E
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hijlO-0003rP-G4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 594B685A03;
 Wed,  3 Jul 2019 18:13:32 +0000 (UTC)
Received: from kaapi (ovpn-116-160.sin2.redhat.com [10.67.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB5A6090E;
 Wed,  3 Jul 2019 18:13:24 +0000 (UTC)
Date: Wed, 3 Jul 2019 23:43:21 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
In-Reply-To: <20190703163541.19520-1-berrange@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1907032325320.8490@xnncv>
References: <20190703163541.19520-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 18:13:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] doc: document that the monitor console
 is a privileged control interface
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Wed, 3 Jul 2019, Daniel P. Berrang=C3=A9 wrote --+
| A supposed exploit of QEMU was recently announced as CVE-2019-12928
| claiming that the monitor console was insecure because the "migrate"
| command enabled arbitrary command execution for a remote attacker.
|=20
| To be a security risk the user launching QEMU must have configured
| the monitor in a way that allows for other users to access it. The
| exploit report quoted use of the "tcp" character device backend for
| QMP.
|=20
| This would indeed allow any network user to connect to QEMU and
| execute arbitrary commands, however, this is not a flaw in QEMU.
| It is the normal expected behaviour of the monitor console and the
| commands it supports. Given a monitor connection, there are many
| ways to access host filesystem content besides the migrate command.

filesystem -> file system ?

| The reality is that the monitor console (whether QMP or HMP) is
| considered a privileged interface to QEMU and as such must only
| be made available to trusted users. IOW, making it available with
| no authentication over TCP is simply a, very serious, user
| configuration error not a security flaw in QEMU itself.
|=20
| The one thing this bogus security report highlights though is that
| we have not clearly documented the security implications around the
| use of the monitor. Add a few paragraphs of text to the security
| docs explaining why the monitor is a privileged interface and making
| a recommendation to only use the UNIX socket character device backend.
|=20
| Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
| Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
| ---
|=20
| Changed in v2:
|=20
|  - Addressed misc typos (Eric / Philippe)
|=20
|  docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
|  1 file changed, 36 insertions(+)
|=20
| diff --git a/docs/security.texi b/docs/security.texi
| index 927764f1e6..3f5d5e7adc 100644
| --- a/docs/security.texi
| +++ b/docs/security.texi
| @@ -129,3 +129,39 @@ those resources that were granted to it.
|  system calls that are not needed by QEMU, thereby reducing the host ke=
rnel
|  attack surface.
|  @end itemize
| +
| +@section Sensitive configurations
| +
| +There are aspects of QEMU that can have non-obvious security implicati=
ons
| +which users & management applications must be aware of.
| +
| +@subsection Monitor console (QMP and HMP)
| +
| +The monitor console (whether used with QMP or HMP) provides an RPC int=
erface
| +to dynamically control many aspects of QEMU's runtime operation. Many =
of the
| +commands exposed will instruct QEMU to access content on the host file=
sysystem

filesysystem -> file system ?

| +and/or trigger spawning of external processes.
| +
| +For example, the @code{migrate} command allows for the spawning of arb=
itrary
| +processes for the purpose of tunnelling the migration data stream. The
| +@code{blockdev-add} command instructs QEMU to open arbitrary files, ex=
posing
| +their content to the guest as a virtual disk.
| +
| +Unless QEMU is otherwise confined using technologies such as SELinux, =
AppArmor,
| +or Linux namespaces, the monitor console should be considered to have =
privileges
| +equivalent to those of the user account QEMU is running under.
| +
| +It is further important to consider the security of the character devi=
ce backend
| +over which the monitor console is exposed. It needs to have protection=
 against
| +malicious third parties which might try to make unauthorized connectio=
ns, or
| +perform man-in-the-middle attacks. Many of the character device backen=
ds do not
| +satisfy this requirement and so must not be used for the monitor conso=
le.
| +
| +The general recommendation is that the monitor console should be expos=
ed over
| +a UNIX domain socket backend to the local host only. Use of the TCP ba=
sed
| +character device backend is inappropriate unless configured to use bot=
h TLS
| +encryption and authorization control policy on client connections.
| +
| +In summary, the monitor console is considered a privileged control int=
erface to
| +QEMU and as such should only be made accessible to a trusted managemen=
t
| +application or user.

Excellent!

Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>


  -> https://nvd.nist.gov/vuln/detail/CVE-2019-12928
  -> https://nvd.nist.gov/vuln/detail/CVE-2019-12929

Both these CVEs have since been updated to the 'DISPUTED' state. IIUC it'=
s a=20
state before rejection.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
