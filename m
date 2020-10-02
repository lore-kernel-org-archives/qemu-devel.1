Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A27AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D248D206C1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpeLcFlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D248D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODQ3-0004xD-TR
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kODNu-0003Co-GR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kODNs-00054r-Kg
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601615611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r/sqrDFxqtzzKsLRXkq0MVoi6bqs6Ltd2r+sHsuzdZk=;
 b=dpeLcFlMo9nXvsJPvyA94vWx0O6Ox/Y172qTsIF+WZn1i6kcsEAA0TIbDjqe6lXvFpYU8o
 G1TxOmepmiFCicsFgRdFrNZlh2L5sYmme/ENpK52nG6j+vLAAwq9zGKl2T/adcW5w3ltH8
 lZjaf/YJl7Zcy05M+dcblTN6TikphxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-CKzxBJx0Nw6wHS-amXL3DA-1; Fri, 02 Oct 2020 01:13:28 -0400
X-MC-Unique: CKzxBJx0Nw6wHS-amXL3DA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1658785C707;
 Fri,  2 Oct 2020 05:13:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAA3273693;
 Fri,  2 Oct 2020 05:13:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D7791132784; Fri,  2 Oct 2020 07:13:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 1/2] doc: more texi cleanup
References: <20201001162705.219-1-luoyonggang@gmail.com>
 <20201001162705.219-2-luoyonggang@gmail.com>
Date: Fri, 02 Oct 2020 07:13:25 +0200
In-Reply-To: <20201001162705.219-2-luoyonggang@gmail.com> (Yonggang Luo's
 message of "Fri, 2 Oct 2020 00:27:04 +0800")
Message-ID: <87k0w9tdl6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yonggang Luo <luoyonggang@gmail.com> writes:

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  qemu-img-cmds.hx  | 2 +-
>  target/i386/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index b89c019b76..cab8234235 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -1,5 +1,5 @@
>  HXCOMM Keep the list of subcommands sorted by name.
> -HXCOMM Use DEFHEADING() to define headings in both help text and texi
> +HXCOMM Use DEFHEADING() to define headings in both help text and rST
>  HXCOMM Text between SRST and ERST are copied to rST version and
>  HXCOMM discarded from C version
>  HXCOMM DEF(command, callback, arg_string) is used to construct
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f37eb7b675..f8231f56b6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4127,7 +4127,7 @@ static PropValue tcg_default_props[] = {
>   * We resolve CPU model aliases using -v1 when using "-machine
>   * none", but this is just for compatibility while libvirt isn't
>   * adapted to resolve CPU model versions before creating VMs.
> - * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi.
> + * See "Runnability guarantee of CPU models" at * deprecated.rst.
>   */
>  X86CPUVersion default_cpu_version = 1;

Duplicates my "[PATCH 0/2] Update leftover comments that mention
Texinfo", which Laurent has queued.


