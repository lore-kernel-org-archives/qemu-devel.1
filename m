Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A3CC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1042B2469C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g//tgrds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042B2469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7PYn-0005tj-7c
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 15:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7PY8-0005Ra-Nj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7PY3-0003C8-6t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:14:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7PY3-00039x-1d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582834457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e58EiJdXwdqR4JY+penvnMeyQdyP0yt9g5CYbz3FE5M=;
 b=g//tgrdsaInDEbQMqKyb6lqhDpLo8O5ZKmaDjY2eE2lrCQnZ3LV58I8jERsU+U6krpJp8D
 drKxTJFEtBaMPn9UkceQugTj0WMQjMwt2cR+ZZQ/ukgAOZh9+EWf0/oaefm6caHf3B5e2b
 b7xcnGadVzAyPIlgxJ/qIHdJQrq+o68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-lFHfqDCBOoSBdomEFoHYJA-1; Thu, 27 Feb 2020 15:14:11 -0500
X-MC-Unique: lFHfqDCBOoSBdomEFoHYJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75BC1107ACC4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 20:14:10 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46FC65D9CD;
 Thu, 27 Feb 2020 20:14:10 +0000 (UTC)
Date: Thu, 27 Feb 2020 15:14:09 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
Message-ID: <20200227201409.GF4440@habkost.net>
References: <20200227134019.6218-1-philmd@redhat.com>
 <87tv3cozfw.fsf@dusky.pond.sub.org>
 <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
 <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com>
MIME-Version: 1.0
In-Reply-To: <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 04:21:56PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/27/20 3:55 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 2/27/20 3:52 PM, Markus Armbruster wrote:
> > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
> > >=20
> > > > This fixes when adding a 'Since' tag:
> > > >=20
> > > > =A0=A0 In file included from qapi/qapi-schema.json:105:
> > > > =A0=A0 qapi/machine.json:25:1: '@arch:' can't follow 'Notes' sectio=
n
> > >=20
> > > I'm confused.=A0 This error is detected in scripts/qapi/parser.py, an=
d it
> > > is fatal.=A0 Is the build broken for you?=A0 It isn't for me.=A0 More=
over,
> > > where is @arch?=A0 I can't see it anywhere close to the two spots the
> > > patch patches.
> >=20
> > I get the error after trying to fix what Eric commented here:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg682344.html
>=20
> Using:
> ---
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..40a36d6276 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -20,13 +20,15 @@
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
>  #
> +# @rx: since 5.0
> +#
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> ---
>=20
> or
>=20
> ---
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..4b59e87b6f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,12 +21,14 @@
>  #        is true even for "qemu-system-x86_64".
>  #
>  # Since: 3.0
> +#
> +# @rx: since 5.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> ---
>=20
> I get:
>=20
>   GEN     qapi-gen
>   GEN     rx-softmmu/config-devices.mak
> In file included from qapi/qapi-schema.json:105:
> qapi/machine.json:23:1: '@rx:' can't follow 'Notes' section
> make: *** [Makefile:645: qapi-gen-timestamp] Error 1
>=20
> This works however:
>=20
> ---
>  ##
>  # @SysEmuTarget:
>  #
>  # The comprehensive enumeration of QEMU system emulation ("softmmu")
>  # targets. Run "./configure --help" in the project root directory, and
>  # look for the *-softmmu targets near the "--target-list" option. The
>  # individual target constants are not documented here, for the time
>  # being.
>  #
> +# @rx: since 5.0
> +#
>  # Notes: The resulting QMP strings can be appended to the "qemu-system-"
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
>  #
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }

If this works, what exactly is the problem this patch is trying to fix?


--=20
Eduardo


