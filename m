Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B674C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FFD20726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbSI5Cmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FFD20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izz53-0006C9-29
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izz4S-0005cW-Hr
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izz4Q-0001aZ-Iu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:33:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izz4Q-0001Zk-Ez
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581064380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhouSIuywyp1T6A41l00TmfPraaQ278VS05yKU/Nubo=;
 b=LbSI5CmrWB7llnIDN3WhYEGSXIYQuos1Q2uoa2Gsc684+waneAKUTsTTJ3qn+UzbU0wplY
 uwrfWfcZtXnBp8FAreCJLML3AM8XUz9pO6sq/Nn6NSkpAZyI5jlRftt4OxPMsWSIiIK+XR
 kFinGFxnslXr471l0iMvvyKVhvBno5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-UwlYKJnwN1yGU1kxmCj0Xw-1; Fri, 07 Feb 2020 03:32:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCD4107B76B;
 Fri,  7 Feb 2020 08:32:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FADD1BC6D;
 Fri,  7 Feb 2020 08:32:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 310E511386A7; Fri,  7 Feb 2020 09:32:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 06/29] qga/qapi-schema.json: minor format fixups for rST
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-7-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 09:32:50 +0100
In-Reply-To: <20200206173040.17337-7-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:17 +0000")
Message-ID: <871rr6vlu5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: UwlYKJnwN1yGU1kxmCj0Xw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> rST format requires a blank line before the start of a bulleted
> or enumerated list. Two places in qapi-schema.json were missing
> this blank line.
>
> Some places were using an indented line as a sort of single-item
> bulleted list, which in the texinfo output comes out all run
> onto a single line; use a real bulleted list instead.
>
> Some places unnecessarily indented lists, which confuses rST.
>
> guest-fstrim:minimum's documentation was indented the
> right amount to share a line with @minimum, but wasn't
> actually doing so.
>
> The indent on the bulleted list in the guest-set-vcpus
> Returns section meant rST misindented it.
>
> Changes to the generated texinfo are very minor (the new
> bulletted lists, and a few extra blank lines).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qga/qapi-schema.json | 86 +++++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 41 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 7661b2b3b45..0e3a00ee052 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -510,8 +510,7 @@
>  #
>  # Discard (or "trim") blocks which are not in use by the filesystem.
>  #
> -# @minimum:
> -#           Minimum contiguous free range to discard, in bytes. Free ran=
ges
> +# @minimum: Minimum contiguous free range to discard, in bytes. Free ran=
ges
>  #           smaller than this may be ignored (this is a hint and the gue=
st
>  #           may not respect it).  By increasing this value, the fstrim
>  #           operation will complete more quickly for filesystems with ba=
dly
> @@ -546,7 +545,8 @@
>  # (or set its status to "shutdown") due to other reasons.
>  #
>  # The following errors may be returned:
> -#          If suspend to disk is not supported, Unsupported
> +#
> +# - If suspend to disk is not supported, Unsupported
>  #
>  # Notes: It's strongly recommended to issue the guest-sync command befor=
e
>  #        sending commands when the guest resumes
> @@ -575,12 +575,14 @@
>  #
>  # This command does NOT return a response on success. There are two opti=
ons
>  # to check for success:
> -#   1. Wait for the SUSPEND QMP event from QEMU
> -#   2. Issue the query-status QMP command to confirm the VM status is
> -#      "suspended"
> +#
> +# 1. Wait for the SUSPEND QMP event from QEMU
> +# 2. Issue the query-status QMP command to confirm the VM status is
> +#    "suspended"
>  #
>  # The following errors may be returned:
> -#          If suspend to ram is not supported, Unsupported
> +#
> +# - If suspend to ram is not supported, Unsupported
>  #
>  # Notes: It's strongly recommended to issue the guest-sync command befor=
e
>  #        sending commands when the guest resumes
> @@ -607,12 +609,14 @@
>  #
>  # This command does NOT return a response on success. There are two opti=
ons
>  # to check for success:
> -#   1. Wait for the SUSPEND QMP event from QEMU
> -#   2. Issue the query-status QMP command to confirm the VM status is
> -#      "suspended"
> +#
> +# 1. Wait for the SUSPEND QMP event from QEMU
> +# 2. Issue the query-status QMP command to confirm the VM status is
> +#    "suspended"
>  #
>  # The following errors may be returned:
> -#          If hybrid suspend is not supported, Unsupported
> +#
> +# - If hybrid suspend is not supported, Unsupported
>  #
>  # Notes: It's strongly recommended to issue the guest-sync command befor=
e
>  #        sending commands when the guest resumes
> @@ -767,17 +771,17 @@
>  # Returns: The length of the initial sublist that has been successfully
>  #          processed. The guest agent maximizes this value. Possible cas=
es:
>  #
> -#          - 0:              if the @vcpus list was empty on input. Gues=
t state
> -#                            has not been changed. Otherwise,
> -#          - Error:          processing the first node of @vcpus failed =
for the
> -#                            reason returned. Guest state has not been c=
hanged.
> -#                            Otherwise,
> +#          - 0: if the @vcpus list was empty on input. Guest state
> +#            has not been changed. Otherwise,
> +#          - Error: processing the first node of @vcpus failed for the
> +#            reason returned. Guest state has not been changed.
> +#            Otherwise,
>  #          - < length(@vcpus): more than zero initial nodes have been pr=
ocessed,
> -#                            but not the entire @vcpus list. Guest state=
 has
> -#                            changed accordingly. To retrieve the error
> -#                            (assuming it persists), repeat the call wit=
h the
> -#                            successfully processed initial sublist remo=
ved.
> -#                            Otherwise,
> +#            but not the entire @vcpus list. Guest state has
> +#            changed accordingly. To retrieve the error
> +#            (assuming it persists), repeat the call with the
> +#            successfully processed initial sublist removed.
> +#            Otherwise,
>  #          - length(@vcpus): call successful.

Source readability suffers a bit here.

Can we break the line after the colon?

   #          - 0:
   #            if the @vcpus list was empty on input. Guest state has
   #            not been changed. Otherwise,

Or would a definition list be a better fit?

>  #
>  # Since: 1.5
> @@ -1182,35 +1186,35 @@
>  # @GuestOSInfo:
>  #
>  # @kernel-release:
> -#     * POSIX: release field returned by uname(2)
> -#     * Windows: build number of the OS
> +# * POSIX: release field returned by uname(2)
> +# * Windows: build number of the OS
>  # @kernel-version:
> -#     * POSIX: version field returned by uname(2)
> -#     * Windows: version number of the OS
> +# * POSIX: version field returned by uname(2)
> +# * Windows: version number of the OS
>  # @machine:
> -#     * POSIX: machine field returned by uname(2)
> -#     * Windows: one of x86, x86_64, arm, ia64
> +# * POSIX: machine field returned by uname(2)
> +# * Windows: one of x86, x86_64, arm, ia64
>  # @id:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: contains string "mswindows"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: contains string "mswindows"
>  # @name:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: contains string "Microsoft Windows"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: contains string "Microsoft Windows"
>  # @pretty-name:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
>  # @version:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: long version string, e.g. "Microsoft Windows Server 200=
8"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: long version string, e.g. "Microsoft Windows Server 2008"
>  # @version-id:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: short version identifier, e.g. "7" or "20012r2"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: short version identifier, e.g. "7" or "20012r2"
>  # @variant:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: contains string "server" or "client"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: contains string "server" or "client"
>  # @variant-id:
> -#     * POSIX: as defined by os-release(5)
> -#     * Windows: contains string "server" or "client"
> +# * POSIX: as defined by os-release(5)
> +# * Windows: contains string "server" or "client"
>  #
>  # Notes:
>  #

The use of bullets vs. dashes for lists seems a bit random, but that's
not this patch's fault.


