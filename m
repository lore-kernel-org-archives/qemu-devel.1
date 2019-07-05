Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C982BC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D49F21670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D49F21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIHR-0001Mm-JR
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjIFz-0000rz-Ol
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjIFy-0001m9-D9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hjIFy-0001lX-5J
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:03:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64E8E3071D7E;
 Fri,  5 Jul 2019 07:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E21D17DE22;
 Fri,  5 Jul 2019 07:03:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 695871132ABF; Fri,  5 Jul 2019 09:03:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190703135411.28436-1-berrange@redhat.com>
Date: Fri, 05 Jul 2019 09:03:31 +0200
In-Reply-To: <20190703135411.28436-1-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 3 Jul 2019 14:54:11
 +0100")
Message-ID: <8736jl6jzw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 05 Jul 2019 07:03:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] doc: document that the monitor console is
 a privileged control interface
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, P J P <ppandit@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> A supposed exploit of QEMU was recently announced as CVE-2019-12928
> claiming that the monitor console was insecure because the "migrate"
> comand enabled arbitrary command execution for a remote attacker.
>
> For this to be a flaw the user launching QEMU must have configured
> the monitor in a way that allows for other userrs to access it. The
> exploit report quoted use of the "tcp" character device backend for
> QMP.
>
> This would indeed allow any network user to connect to QEMU and
> execute arbitrary comamnds, however, this is not a flaw in QEMU.
> It is the normal expected behaviour of the monitor console and the
> commands it supports. Given a monitor connection, there are many
> ways to access host filesystem content besides the migrate command.
>
> The reality is that the monitor console (whether QMP or HMP) is
> considered a privileged interface to QEMU and as such must only
> be made available to trusted users. IOW, making it available with
> no authentication over TCP is simply a, very serious, user
> configuration error not a security flaw in QEMU itself.

https://xkcd.com/2166/

> The one thing this bogus security report highlights though is that
> we have not clearly documented the security implications around the
> use of the monitor. Add a few paragraphs of text to the security
> docs explaining why the monitor is a privileged interface and making
> a recommendation to only use the UNIX socket character device backend.

Good idea.

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/security.texi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/docs/security.texi b/docs/security.texi
> index 927764f1e6..5bff01449d 100644
> --- a/docs/security.texi
> +++ b/docs/security.texi
> @@ -129,3 +129,39 @@ those resources that were granted to it.
>  system calls that are not needed by QEMU, thereby reducing the host kern=
el
>  attack surface.
>  @end itemize
> +
> +@section Sensitive configurations
> +
> +There are aspects of QEMU that can have non-obvious security implications

Is calling the implications "non-obvious" useful?  One guy's
"non-obvious" can be the next guy's "trivial"...

> +which users & management applications must be aware of.
> +
> +@subsection Monitor console (QMP and HMP)
> +
> +The monitor console (whether used with QMP or HMP) provides an RPC inter=
face

"RPC" is unnecessary detail I find distracting (and not entirely fitting
besides).  Please scratch it.

> +to dynamically control many aspects of QEMU's runtime operation. Many of=
 the
> +commands exposed will instruct QEMU to access content on the host filesy=
system
> +and/or trigger spawning of external processes.
> +
> +For example, the @code{migrate} command allows for the spawning of arbit=
rary
> +processes for the purpose of tunnelling the migration data stream. The
> +@code{blockdev-add} command instructs QEMU to open arbitrary files, expo=
sing
> +their content to the guest as a virtual disk.
> +
> +Unless QEMU is otherwise confined using technologies such as SELinux, Ap=
pArmor,
> +or Linux namespaces, the monitor console should be considered to have pr=
ivileges
> +equivalent to those of the user account QEMU is running under.
> +
> +It is further important to consider the security of the character device=
 backend
> +over which the monitor console is exposed. It needs to have protection a=
gainst
> +malicious third parties which might try to make unauthorized connections=
, or
> +perform man-in-the-middle attacks. Many of the character device backends=
 do not
> +satisfy this requirement and so must not be used for the monitor console.
> +
> +The general recommendation is that the monitor console should be exposed=
 over
> +a UNIX domain socket backend to the local host only. Use of the TCP based
> +character device backend is inappropriate unless configured to use both =
TLS
> +encryption and authorization control policy on client connections.
> +
> +In summary the monitor console is considered a privileged control interf=
ace to
> +QEMU and as such should only be made accessible to a trusted management
> +application or user.

With "RPC" scratched:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

